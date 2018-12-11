Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD55C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B036B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l/eqfK3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B036B20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLKNhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:37:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43059 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:37:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so6648035pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fjP9enHpTF7jjPVP9eVilGexD0F1F2Bw43zF4UQ+SeE=;
        b=l/eqfK3ct3J7jblDmBdl63ty4GXbHmOJzHHfYByih0jqFfwJJsRvFPvlJwu4r8kS65
         +kfsQJajSPyL+R89d/1Z22Unug8aJPVIYG9H2pBRTAQ/WdvDlu9aNsFDDJCAEbcPi1o/
         BFwp7SHXMsCkOs11tAJlqVPkPemF2FzC/3lHj/2nW11DDIGszFTz0mVDv65ZZUAT7+n3
         JUBZ9vpAQ4MHIv4CdxvYvcgJt/+9toN9U7UA3ySmLPnE4oXn+dhrtZ1T8fdpU41AVyBL
         hmhiczZspD1nsDBwCKypRXC++/S2zXxliqZnmzKOHB0H5p7BZNEhFFGkCDyspAx2iqsj
         EV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fjP9enHpTF7jjPVP9eVilGexD0F1F2Bw43zF4UQ+SeE=;
        b=NqgGRZT4CpwXcpFqNa9Khejd7Fc2mlGEc/ac+K0F3el8cG+HY6xDpBQQQSsL4j1omf
         Mnw4RQ1n1L4uNAKJsk1Y5nDny+XByfVfPQxOjLHIgWjeiPnZgjYy4wF1HIe//0BULOXo
         9kJgQ5/bl8TcxCit+XXxx8k8tVYo6AfBeNzVQkQxReuQSJYS8BcSFBE/j05MCmM+qnEo
         h6HlcM/yJoJuvF/WXq9b0G2N3gA/Ao46KPaF83bnxvbVb10rdswFZcAlrTHeUcEIs2HQ
         NRopcfiZqqS2eIkvMBOsRmquuPhpfrs1r5V8/eCC7KGJtx7vvpiHCdZIaytHsYbFAV54
         SRzA==
X-Gm-Message-State: AA+aEWZA1S9CkQ+J4N3Fn/1cFi6OaCUmxM63GgZxTZTFWmaRqEeNdIAf
        TkGkFOW9ExtYy64Qre/6pPTbFw==
X-Google-Smtp-Source: AFSGD/X/3mblaTvH19bP4JZ29TKTJysnrFOdooeZgfBUtBFXYNK6fZtDmIc0zzc47fZl4iv7vdwsjw==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr14593679pgo.14.1544535428081;
        Tue, 11 Dec 2018 05:37:08 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y12sm26323125pfk.70.2018.12.11.05.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:37:07 -0800 (PST)
Subject: Re: [PATCH 1/2] block: add bi_crypto_ctx variable in struct bio
To:     Parshuram Thombare <pthombar@cadence.com>, tj@kernel.org,
        jbacik@fb.com, michaelcallahan@fb.com, snitzer@redhat.com,
        osandov@fb.com, keith.busch@intel.com, ming.lei@redhat.com,
        shli@fb.com, dennisszhou@gmail.com, linux-kernel@vger.kernel.org
Cc:     adouglas@cadence.com, jank@cadence.com, rafalc@cadence.com
References: <20181211095001.GA32573@lvlogina.cadence.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62281c61-de73-a0a3-2ea2-eeea81778eea@kernel.dk>
Date:   Tue, 11 Dec 2018 06:37:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211095001.GA32573@lvlogina.cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 2:50 AM, Parshuram Thombare wrote:
> Add variable 'void *bi_crypt_ctx' in 'struct bio'. This will
> be used to associate bio with crypto configuration of controller
> supporting real time / inline encryption/decryption.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  include/linux/blk_types.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 1dcf652..bd77603 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -188,6 +188,10 @@ struct bio {
>  #endif
>  	};
>  
> +#ifdef CONFIG_BLK_DEV_HW_RT_ENCRYPTION
> +	void *bi_crypto_ctx;
> +#endif
> +
>  	unsigned short		bi_vcnt;	/* how many bio_vec's */
>  
>  	/*

Pretty sure I mentioned this last time, but in case I didn't, don't
add bio members for random drivers. Can you imagine how huge
this thing would be if we allowed that?

If you need per-io storage, put it in the payload for the blk-mq
request. That way you are only bloating your own IO related data
structures, not everyones.

-- 
Jens Axboe

