Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D900CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAD42085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HUc4JIKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAD42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJZW53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:57:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50206 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeJZW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:57:28 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so1716756ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zCMwBAm09F25IZwarKsjQDcRDxEIhwYjtSkPUkHv/s=;
        b=HUc4JIKiqQfJgYrtEWqe9AyPXO+cav146N/2ddXWCrR/9dItBi1h0KEI7p0KHRsdMF
         5PwweDmU34+Awtcx2727aR3RbUBibrUzp3sr8lT9nzhvWlZA8AdRj56tiNaPmR/6ZoxY
         UNCJMmxeKZAzuS5Q160C1aNIPpkMUCI4Dc78kpIdXNXvU7sn6E/DmAw1XC7JLZ7y8wYF
         DYR6Rnsql+nebdh5PorkigHwPKNz8WlsKFthExvsueRbjEdx0LPaAmd8zppriJlxRAuD
         LJfqnQVBLHGG7L463kuEXp6u5TDI+FNzTEk3JartFiQwFPDUJZ7rP8A1DtSPozAAnEpt
         f/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zCMwBAm09F25IZwarKsjQDcRDxEIhwYjtSkPUkHv/s=;
        b=Sp9/0XNmiOnkxlXiyRufQFask2u88mMvzv6Rdp2/Palm8rbaJfmvmaJPC5CGFDaMPv
         Cch0DouXn3pqModhJ3td5fyGoQF+/7zUpOu/QREs3/Pyref59rYMPpGP7nLeDl0+u3rO
         z1xN+GSCyTPkdXrIdjSSUN1M8HozahpTeXyNoV16+0ab5rHumDmwoHp3BAIcyRs6mKEK
         4GjLCuSRHFdyb3Kwx1S55enjFKipRXkl4uEzavyhLSwc4H6KRlHHWxO347BvHG9gyRgK
         66HMSbGz5V4/tdlgAQr+1RdSsxsk2aPNG/4Xe93KO+R8ZdInGZqgFvqtwcUeEPYpZTep
         49nQ==
X-Gm-Message-State: AGRZ1gLGufGUFFRL71LvkzEEr3TyATuB1dTyNZuP66U08kPTzTeXqrke
        yP9j9Z4kWq7/VIjhIWjhF2GmUA==
X-Google-Smtp-Source: AJdET5cPiPd5YYsBTPQaRKs8QdX27bn85o1VnKlQ7G1h3QJmRyOKRvklba7Kj6ztDYpBKayq7SE/iA==
X-Received: by 2002:a24:e20e:: with SMTP id q14-v6mr440669ith.55.1540563612674;
        Fri, 26 Oct 2018 07:20:12 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d21-v6sm3820526ioc.32.2018.10.26.07.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:20:10 -0700 (PDT)
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
 <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
 <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
 <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
 <CAEAjamu-MmtPF0_kqyPKJBcZSWz=SGi_1VjLq7z9MMm5-t7Oog@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9206bb2f-b11f-cd57-819a-81438b388124@kernel.dk>
Date:   Fri, 26 Oct 2018 08:20:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEAjamu-MmtPF0_kqyPKJBcZSWz=SGi_1VjLq7z9MMm5-t7Oog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 7:22 AM, Kyungtae Kim wrote:
> I corrected the patch as follows:

OK, we're getting there! Please resend as a separate email, so that
the subject line is the patch header, and just the commit message
in the body. I'd fix that up for this one, but you also need to
fix up:

> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index a8cfa01..41160a1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>                          */
>                 return -EINVAL;
> 
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> +         return -EINVAL;
> +

This needs to use tabs, not two spaces. Look at the surrounding
code - if yours looks differently, then you should correct that.

-- 
Jens Axboe

