Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FD6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513B82083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5KEn6pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513B82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeGQQgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:36:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39593 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbeGQQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:36:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so1651304eds.6;
        Tue, 17 Jul 2018 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ayu9Y6WtYmjZ9SPMFxsXDOIEGuYajd1FbCvfkhhdQ5I=;
        b=N5KEn6ptI6SmSxkesPRjMKN4Zu9/lcLQZX3D8h4tOEj1Z+rmhKVPUpYfRRygQvqqVq
         qNcd9rg9AHePMcoUh8w+xCzSIR4gxQZNNMYA8yKtZe8wKBi7BbT63u2wadUFP4TnYNOA
         +K/eTqC4kFalDbR9DFDNg1L0Djjwqp4VFXt8jf70bZVYraCguGiOgFYYwyhi8LLau7TI
         nHBzZfxsZn7+b0PYcrrNpZN9f0DHP6LO9TcaYOq052hF82onZXbPG25rvAZEzjEeuQkQ
         hMm07eTFAfGCSfLrwmGPwphZwZjPrhifn84aRjr6rAS6vvAK6h/lfhouM0TdArDSO4ak
         5/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ayu9Y6WtYmjZ9SPMFxsXDOIEGuYajd1FbCvfkhhdQ5I=;
        b=WuNXcwOU9wdM/WiGuxJcTKGXYzhizwG8DEqEnB40W1Ahgd4kNwAycXXH3D0lyEdbW5
         ihPn1oYV7kaHl4BlhbAQKVxYtosc8tGilkUxP8rUPhi2okPLSALqrT9s20KCue9ev4EV
         bpobgK2/FjGHgaNQWR1ISVx4Rxii8vdSLyWubFDatdn3zk7gH1sOK5vQolXdukRuyUHp
         2xW34nrlq7IFEVejflgDMvrztOCIpG1+reWIxCgdkdw4gZ/Zr5ufVNmCbEqmyZRq0bsF
         83WmBY9XvyKZTZpkIyI5WwYcvOFg7NETe78eOx6GMYb8xgP4mpCy45MRH5A+enaVgu9E
         xEWA==
X-Gm-Message-State: AOUpUlGJRwk5KzVGtnBV1NNkPrrZTOpse6c1Xq3ZGA7TIUSMA862w/FX
        LnMCBXxYAShSrrPr9GYCTgUd3zQtrSU=
X-Google-Smtp-Source: AAOMgpdYXQyu8zLFfwWNZ8zCkn7r1d4U7T1MA4e73w1PbsV6sULJHQxSVXYT7Qh9LS4eguBgEo88Vw==
X-Received: by 2002:a50:cdde:: with SMTP id h30-v6mr3077890edj.159.1531843394816;
        Tue, 17 Jul 2018 09:03:14 -0700 (PDT)
Received: from suzaku.dub.corp.google.com ([2620:0:1040:1d:bf5f:ba23:dd4e:c3cd])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1074846edm.25.2018.07.17.09.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 09:03:14 -0700 (PDT)
Subject: Re: [PATCH] ipv6: sr: fix useless rol32 call on hash
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180717155254.30367-1-colin.king@canonical.com>
From:   David Lebrun <dav.lebrun@gmail.com>
Message-ID: <6ab9af97-33b6-d5cc-d1e9-6e5fbd9158a8@gmail.com>
Date:   Tue, 17 Jul 2018 17:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180717155254.30367-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 04:52 PM, Colin King wrote:
> From: Colin Ian King<colin.king@canonical.com>
> 
> The rol32 call is currently rotating hash but the rol'd value is
> being discarded. I believe the current code is incorrect and hash
> should be assigned the rotated value returned from rol32.
> 
> Detected by CoverityScan, CID#1468411 ("Useless call")
> 
> Fixes: b5facfdba14c ("ipv6: sr: Compute flowlabel for outer IPv6 header of seg6 encap mode")
> Signed-off-by: Colin Ian King<colin.king@canonical.com>

Acked-by: dlebrun@google.com

Good catch, thanks !

In that case, the same issue is present in 
include/net/ipv6.h:ip6_make_flowlabel().
