Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A915C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5CD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="iJ1kujzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5CD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbeKTRqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:46:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37211 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbeKTRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:46:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so730979lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0rNKxF3OO85+ullvbdajsC+Ve2o21RfM+PJVBskyocI=;
        b=iJ1kujzEmU4B2N5dnAG094SAmoMT3pDNqUEb3nmidRVEyDaorGh7cYE9A17Xyb/ZIo
         giWySZlyx83nkLT/6asZE4QhIX+FKwX2iXwnS8fkQpC+CsUtHvgVy3FA8C/CNCQ1ES5z
         gW8Lld+5cI/8knZ9UGEAb7XKi0k8AvScg8Ryh2OCUeQnKaZv+ck6qgqyaYtOCpNwVY3P
         oa4KuTxKNY14VUF2Q1qG2OEckHULiZmiQ9YqCCbdJL3t3vLoCsgg7j4/NaxY6sQ2WoNT
         Bd7ysEVUoYPk1gLQ3xL472/EExGcXv64CVKcUCGIoDrkVEb4sM+RopaJE5kV6tTt+By6
         LL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0rNKxF3OO85+ullvbdajsC+Ve2o21RfM+PJVBskyocI=;
        b=k7siF0gVeO+JNzr3kWOr0gxC4R28S/R2Lo2W2EE70uUaTa+IJ7MeoFZwLbEZYCQ7O6
         /tH5iu++M1Jxdrcb6c1IimPS/fPi1A2KQb6RdW6Toj8KCLUJ7OxDEUHPx3YM+Sa2OiTG
         Y9mOSKAe1reyy5eij3FXy4PPJi/5pDOpS8KbHFTDA+tgzvNbFIUGpADHDYKA30kifoby
         3g3GTkN/YkPRZNb//OclxLHLWjTruNZ3FzUxr7MyRQPOrrCQ2pYJ7+zEN/bOLF1u+LrA
         UMvw5YhGoXUk3Y0uZJG3uV7NRQTvUUdQBDUz+2fKdtqAAhQOxasBHc6hsNe1tJIG57eb
         erlA==
X-Gm-Message-State: AA+aEWaW+4MkAlkcNOWcgfoF+ewUfe7AuO39sbJTU11V2Hc81+el5Adv
        hAl2PP4R5dlgUoGbvLUrelVBRDoSMpE=
X-Google-Smtp-Source: AFSGD/UvkpxdgBEx+Lb5OmETSFdzHU6AHZId3a9Wro6QDYNQkkb6MThS2dGsltyLNKB7iMbHt91E6w==
X-Received: by 2002:a2e:612:: with SMTP id 18-v6mr485561ljg.125.1542698319355;
        Mon, 19 Nov 2018 23:18:39 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id b128sm5997182lfe.91.2018.11.19.23.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 23:18:38 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: modify a comment
To:     suhua.tanke@gmail.com
Cc:     javier@cnexlabs.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181120071650.5379-1-suhua.tanke@gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <59ee9fcb-4b81-400b-116e-8a9fe7346a41@lightnvm.io>
Date:   Tue, 20 Nov 2018 08:18:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181120071650.5379-1-suhua.tanke@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 08:16 AM, Hua Su wrote:
> Does the code want to express that it should be like this?
> 
> Signed-off-by: Hua Su <suhua.tanke@gmail.com>
> ---
>   drivers/lightnvm/pblk-rb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index b1f4b51783f4..9f7fa0fe9c77 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -147,7 +147,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
>   
>   	/*
>   	 * Initialize rate-limiter, which controls access to the write buffer
> -	 * but user and GC I/O
> +	 * by user and GC I/O
>   	 */
>   	pblk_rl_init(&pblk->rl, rb->nr_entries);
>   
> 

Thanks Hue. Applied for 4.21.
