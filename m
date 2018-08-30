Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E9AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B7820661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByfpIEaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B7820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeH3EmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:42:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33568 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeH3EmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:42:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id 60-v6so3053350ple.0;
        Wed, 29 Aug 2018 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95DS5Xl2lw4Vg7jq56jLmKCvVrENUipNuISI1oHlbSw=;
        b=ByfpIEaq1olorJZpVDo/ZRBNoppwB8fnX1x6Ls3GG1Cpe/k0mwp9x1x6A1FocB++Rr
         SkWxbzsEHHcHAiGCEhD76+0mefG9e5tFPwjIgFDMGNIj7MxC+xC3e8UZTPwSVEIZMoRl
         EKde85ZMMvdsqjJ6MlqjN1c+uymEawP5WqB8QLTJgE5sb/jZx8EWJkx3hjZIHeGybtuG
         fIug0Rk4jg/zmf69qYkOQoD1tQyhCSXh5/hALCzy2/2KqItUonuNQ1hsF7cQQtc6EFle
         9m7hosfY3B59VzqdvqxisY/+c4Sib5j5TmrBfmssmRYxhMdkhLP5mD6H9vyjwftjuMQE
         uDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95DS5Xl2lw4Vg7jq56jLmKCvVrENUipNuISI1oHlbSw=;
        b=t6GdnTtKi0WSD6pWW6hqSAY9yunRibpdzQAey3fILS5cpwSzvhfOmdD9RAVpU1g7a6
         OVvMZfZZ04QTflpHa6chlgiHtgiC2NbLsiUGonfdw6XNsnS7hcv4oUVNu3zfPZdETAME
         OmDcXH/hsxMQ+AXVynIz9dhM9O3Chm16Q34Zqd/VN0mKi3s4Gixeab7O80aSouPsZ8Py
         bBNimuBW0ChWvD6AWlS3Zldq7fL3OJjl/HfHGBKrYjvDjStb8aLyTUN7QYqZ/093LQiq
         CmKoJjgrDjjOihg+pVMqjBkO1f6li7bGUS8hoTX1VPryC18DFn7Zos6NMhLCEqNxuSMh
         NHAg==
X-Gm-Message-State: APzg51DG3furhUXBEiBWIhUCdKJSiu8ZXi7K7O/G2C2/zriFwS68o0WB
        GNWQR1fYnqqDs/fItL0On1bi0UK7
X-Google-Smtp-Source: ANB0VdZ3k7l7fAQoooO+Fn2xQtwboKKKHBzAl/tDdK/RkXcc69iovfjR4DPVqCeWTHP+jc/MOdhvjQ==
X-Received: by 2002:a17:902:28eb:: with SMTP id f98-v6mr7914178plb.149.1535589757396;
        Wed, 29 Aug 2018 17:42:37 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o62-v6sm6867676pfb.0.2018.08.29.17.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 17:42:36 -0700 (PDT)
Subject: Re: [GIT PULL] hwmon fixes for v4.19-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1535574760-11636-1-git-send-email-linux@roeck-us.net>
 <CA+55aFzUVOKJgXpfUEwC2eK7mNhhJktse=Dbrwh0x8AmUxwEcQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c8a7c16a-59bc-4e4c-4d2d-2cf8715257ff@roeck-us.net>
Date:   Wed, 29 Aug 2018 17:42:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFzUVOKJgXpfUEwC2eK7mNhhJktse=Dbrwh0x8AmUxwEcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 04:07 PM, Linus Torvalds wrote:
> On Wed, Aug 29, 2018 at 1:32 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Please pull hwmon fixes for Linux v4.19-rc2 from signed tag:
> 
> That actually isn't a signed tag at all, it's just a bare tag (ie just
> directly points to the commit).
> 

Oops, sorry.

> I guess I don't care *that* much, since it's from kernel.org, but you
> should check what happened to your workflow. *Normally* you do
> actually have signed tags.
> 

Nothing special, just busy tracking down build/boot failures and such.
I tag manually, and forgot the "-s".

Guenter
