Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C5AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40EB2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lqDSsZqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40EB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJZXey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:34:54 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33272 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeJZXey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:34:54 -0400
Received: by mail-it1-f195.google.com with SMTP id h6-v6so4782544ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8WNJ1WCzcuv3ym1hd8anZzmT5Pn3aPGCYG9Td20mwzU=;
        b=lqDSsZqQIAEeN9+d0kXIudX1iAzXXRIFq8lqu560LoWdv3bHZZ3AXF44IRqcuVJvM0
         19ngKqOPwqmBnUhlW/56wkVdLalf10CNWLUMU+FseB9D8dwd7DmPGhPzneB1bEcd6hMy
         0ujNPJxgFZCFlgASMRnTISwLS45EkwK09zqnM2c083qvAsAdg3vH/DX0/1m34Tf8NJI+
         GPEGFuqQQNKhu3TAFxis7panl97W2zy9wRdQLJ286yDmBGfVSgg04UATRL1CRKXreRYx
         CB5bPPkhJnn+Rnw8PF1tn3X93NVmcd9M2fpscdWzMqBWNYruMCG0zhjcWVag8pI8WzG9
         Q/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8WNJ1WCzcuv3ym1hd8anZzmT5Pn3aPGCYG9Td20mwzU=;
        b=YOJcP/YiamoVZe/VK3yogkfEmTFbYMZNlsBuiepVEHYzJ1Dh7CvarW3G6yH9mRuUBi
         9xBisSmp6pQAVqgyxr1T0KaW/oC9gySb6VGa3Zytk9QJuEwiI56Xe+XftRlftB2gDiQu
         mfL0wuogrNNlB6jQF08uixCTMUM/q0vdszw2/6dF5oNqihVuyV5djBaOktZz9U1LJPzw
         l9i/UDnyna14hJlwTDiPbPXHDYNcDX3EGCDInk+qDqxRzUalJq0GVzzyOPn2ZaP1IulN
         B7vMA37GNf+Qkk8/5K7njEaSL3hHQ6xtTcDtt9pOT0mlWU6L9WTmerCm7SC/vUOZwSTg
         /t3w==
X-Gm-Message-State: AGRZ1gJTopHy5eD5YpCzVBDmQ5stOHRrCBCNvAAcBGhGYHYOCR8skwCW
        gxuMzXQI01/7wtWPpN0q5gS2MPL/o1w=
X-Google-Smtp-Source: AJdET5eL9L4zY+1Hae1xCXvoAQELQkSXv7odJRGoxya4wqB/X+0Evvj0Sl1LomthfgE0+jDzUo7GLw==
X-Received: by 2002:a02:2a8f:: with SMTP id w137-v6mr2878919jaw.17.1540565849672;
        Fri, 26 Oct 2018 07:57:29 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t199-v6sm2300053itb.2.2018.10.26.07.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:57:28 -0700 (PDT)
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in
 setup_rw_floppy()
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
 <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f679738-3106-78e0-dd16-2335c4f369aa@kernel.dk>
Date:   Fri, 26 Oct 2018 08:57:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 8:51 AM, Kyungtae Kim wrote:
> Do you mean mail client?? Well, I'm currently using gmail.

Yes, email client. I've never sent patches with gmail, so can't
say if that works or not. OK, just checked

Documentation/process/email-clients.rst

and is states that:

"Gmail (Web GUI)
***************
 
Does not work for sending patches.

Gmail web client converts tabs to spaces automatically."

so I guess that won't work for you. You can use git send-email
with gmail smtp, that's what I do. Or read the above file to figure out
what will work the best for you.

-- 
Jens Axboe

