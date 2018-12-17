Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939FEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609FF21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545068610;
	bh=AGs8+igF3bvyZokL4gl3c6/Jwhjir7bOjYuxfmFyY5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KKpeUu8JdczS02+LT6hqCOGBnpLcEE5vkqDIkaSnczaSYI6tk8KwBc7+z9LLAkQ+r
	 eelMHkKMT6qD5pEKHtO7r2TyA/UGIugJMrMbLIITfnfzAtaYZZuy2yv0Gp0KfRHSkc
	 tmV6lrijm+2fE4WlYl584fCGH713Vqbs+KKfNrDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbeLQRn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:43:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40019 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLQRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:43:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so69424wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qBUTZX5TqEVR3IksZ37nMnFyv96dGt6ygYiZeoeaOfk=;
        b=Q4KLvt+V/wu+Q8Pw/AlpRF1qhfuVn8f388tImg45IgModPPGL8hPAWcG8rcdcQWeup
         FGRDmBW+GtMXDK2R4Zrr9wf1aKSv4c2HIQRV/VlzCzqTpkWBUP1m9BlbfmtplD9bwe9J
         SWqiymo2YHLQOmqrG6XrBazBqcA8FT79coSzkzZ1FL5CKNaFFZoiJ8S512DsH229aE39
         wheSK6ngP4zoqXESp4YNeD3iP+c4luYXOvyx2Z0CvEOU9KYIbgqFXtcC5Y/JsQMI7Bnj
         DLT4hThdJCCUdRxqsWCyXuoqBonq3G1BBrzbjpYxG9luKKYF25m0Eq3XfU2fqPnxQzc7
         74NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBUTZX5TqEVR3IksZ37nMnFyv96dGt6ygYiZeoeaOfk=;
        b=IKNeTjwdChaQeqrMXraDBzmZVJo3VVDnM0PxSa+0iyyt456wDBW17taPa/F4y2tBrZ
         Gy3aIk5Mmr5U017XmF0ueSIcrgtxEnQY/hS3xKR5UFPdPaTcv5h0J+MaVAM5odpCw8Ze
         6cSZ0/mrwWO6KxGclVc4pg8IM/TUeAOQXwNHfkOV6HhZPmbUZ1o5nopt+IxZWLXYmi1C
         WUUN1q5FmyEWzGhtw/mSbgBHw4LqZZfVhQcToHvQPsj2zbIzZKVAnTzPGkf0MTEXdicD
         jAoD2B2BCfYSCp3D5zPh95VgoqMCByL9nlhbOlzMCgfXHmKP/Mmz5R/dEwOt2b7EG9sR
         rRgA==
X-Gm-Message-State: AA+aEWYDW3SMymOApuXP8nJS1teKlIWjPi9IKZTKMmWt0xfcxt9M04bk
        FKcchps2Qo6LoeOXP8yBhvU=
X-Google-Smtp-Source: AFSGD/UPI/uNYgw8/bg8zaAWmXoHCenMDuUBphAkmcovYjdjcrRiw90PVjhnSSgc5wDZAht/8dw6Dg==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr97047wme.20.1545068607220;
        Mon, 17 Dec 2018 09:43:27 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v1sm1120264wrr.88.2018.12.17.09.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:43:26 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:43:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 5/5] x86/boot/KASLR: Limit KASLR to extracting kernel
 in immovable memory
Message-ID: <20181217174324.GE90818@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-6-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214093013.13370-6-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:

> KASLR randomly chooses some positions which may locate in movable
> memory regions. It will break memory hotplug feature and make the
> movable memory chosen by KASLR practically immovable.
> 
> The solution is to limit KASLR to choose memory regions in immovable
> node according to SRAT tables.
> When CONFIG_EARLY_PARSE_RSDP is enabled, walk through SRAT to get the
> information of immovable memory so that KASLR knows where should be
> chosen for randomization.
> 
> Rename process_mem_region() as __process_mem_region() and name new
> function as process_mem_region().
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 75 +++++++++++++++++++++++++++-----
>  1 file changed, 64 insertions(+), 11 deletions(-)

Ok, I like this basic approach of automatically detecing memory areas we 
should not KASLR into - it's far better than earlier iterations.

> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -97,6 +97,11 @@ static bool memmap_too_large;
>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>  static unsigned long long mem_limit = ULLONG_MAX;
>  
> +#ifdef CONFIG_EARLY_SRAT_PARSE
> +/* The immovable memory regions */
> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +#endif

What logic is the maximum size of this array based on?

Thanks,

	Ingo
