Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325B9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA53320779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0X7Gw+U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA53320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeI1Uux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:50:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35018 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Uuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:50:52 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so4312688iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ttfcI1Jw3Fk7rYzhbLiiVHUbpq5goSkUSyH1zVTPCfU=;
        b=0X7Gw+U6z0/ElyfjQCbaQVRTbuM1tfb3gt+qALmoIOMG+hsfqd3Pil0QEVONpzTvBq
         MkMbcb4OZ0gf1+JY+83f9WRnOHJ5Ftt7d9pYrc8yN4Ni+sz+Spq/JpTFe16Uzta9KbpT
         QMOUmKeZrs8D3y5cXKmEk8ZTmKIyLIVHBZcPfC1wZu81NyOPnwrbBn4VJ5PXrZuSt7wi
         LvSoFNy51oNQpdw5qG+QArXdzV9lGqJIP33j9gPQvOYOKXOzrmthWSg82hqiIFap2jxM
         DadxIQqMNpIlsPHm3+Oi0BGrphujXB2+4/8cbBCOi3pbNdpRpwVgi/nfvGOfp/awhGwF
         XDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttfcI1Jw3Fk7rYzhbLiiVHUbpq5goSkUSyH1zVTPCfU=;
        b=j8Bd/r0F4zeg8bJ/oUbxNx2fymyeePzsFMCduuxtYGjm4BJWEDD8Z29TRgYEndvXZ8
         st0qWoAWD/zb4HoYFgGF+YMl7IT8rV8rr9wqURBvQkY/WDQnHB+UHI//tGe4wQ/rtJSa
         WLg7a+w5oJn8U4DweY+DtqLZ+fsTXE+oiL+ZqbfRrmSPgwdO1+2PD+qiPUROIJX8xWPW
         Xx+foXjJ9c+SwanrlpX21+oI2+ogMx5rBAEgUVRsmBwoyTiw+2Mz2g2Hjva2laG5sO20
         3urcyux6a6RAcuVY7nAkAtKe1dTeuHM8bvo6bzPKtb+kuhYkfxSDGlMiyWWRJg98JGXa
         G7Cg==
X-Gm-Message-State: ABuFfoisi/3Eeh4NodMC4hG9EO0eWg7irEU//ZphJB6Mcb060Ko5FUKH
        rgFqXQQ3w6XinFTCaU2db8PGPg==
X-Google-Smtp-Source: ACcGV606MO9kCGJAld4TQ777yPUp9hVHBJSKFkZs4HFebJz21qhXiQeKj5CP4CNkaavlgBxQVvOVUw==
X-Received: by 2002:a6b:cb01:: with SMTP id b1-v6mr12646771iog.23.1538144809752;
        Fri, 28 Sep 2018 07:26:49 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z186-v6sm896852itd.43.2018.09.28.07.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:26:48 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Omar Sandoval <osandov@osandov.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <20180928111124.745bf2ef@canb.auug.org.au>
 <20180928064319.GD29754@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca2a5d5a-5330-53ce-2fc6-d2cfb44c3401@kernel.dk>
Date:   Fri, 28 Sep 2018 08:26:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180928064319.GD29754@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/18 12:43 AM, Omar Sandoval wrote:
> On Fri, Sep 28, 2018 at 11:11:24AM +1000, Stephen Rothwell wrote:
>> Hi Jens,
>>
>> After merging the block tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>>
>> block/kyber-iosched.c:84:22: warning: integer overflow in expression of type 'long int' results in '705032704' [-Woverflow]
>>   [KYBER_DISCARD] = 5 * NSEC_PER_SEC,
>>                       ^
>>
>> Introduced by commit
>>
>>   6e25cb01ea20 ("kyber: implement improved heuristics")
> 
> Ugh, thanks for the report. This should fix it:
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index 2b62e362fb36..eccac01a10b6 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -79,9 +79,9 @@ static const unsigned int kyber_depth[] = {
>   * Default latency targets for each scheduling domain.
>   */
>  static const u64 kyber_latency_targets[] = {
> -	[KYBER_READ] = 2 * NSEC_PER_MSEC,
> -	[KYBER_WRITE] = 10 * NSEC_PER_MSEC,
> -	[KYBER_DISCARD] = 5 * NSEC_PER_SEC,
> +	[KYBER_READ] = 2ULL * NSEC_PER_MSEC,
> +	[KYBER_WRITE] = 10ULL * NSEC_PER_MSEC,
> +	[KYBER_DISCARD] = 5ULL * NSEC_PER_SEC,
>  };
>  
>  /*
> 
> Jens, do you mind folding that in, or should I send it separately?

It's already applied, so please send it in separately. We only
really need it for the last one, NSEC_PER_SEC, but I agree let's do
all just in case it's changed later.

-- 
Jens Axboe

