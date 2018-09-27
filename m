Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B112C216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW6P1xw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B112C216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeI1A1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:27:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43231 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1A1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:27:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id z14-v6so3599873wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=flRR8F8OTkIYxE6BzPRv1OhgkiIEInLPjiA3JO1lvWo=;
        b=XW6P1xw++wewyLQcaRWr5E29CjWVT5J9cDQ+bKO5vKxmBn4+bpuW17VUUQR2pgwYZs
         Oq9nbzouyo9xeOSTDnAXsRIYqh+kh8LMB43mbHGwYR9YT71AgMf5h72qT2cr7PKYV3qs
         SXhiFEiF6eiaX8uJkDMPgWHJ5nj5is3eELOWtMHI5Z0YksnVo5jjIDUvZBvXRFt8J79S
         hN0Mh4zOWeZfhIjvZojBXcWCbf6TXjU0yo9+oRlgwY5ExPInYji3mQceq81j4gof9Ki4
         PvD5MvJBW6bEgXitzEgZjuBc5Mvuf9dq4+3vbjFuBTjOX+LUl7zfiOSlHT1RWKEvp892
         qqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=flRR8F8OTkIYxE6BzPRv1OhgkiIEInLPjiA3JO1lvWo=;
        b=EtrdCVfAk/Jg0qYKqrhOXV0o8osUCUuj+tM94le4Xxbp8JJlAwSVCn7ophIuEBEGBH
         mJIDOMYXImDyLW5uWs77lKuNyA4HCpVdtEqT+NEec0KWkLHSiTr21gszXUDaiGjPaoRG
         xoXQbAPQmr1gixhno185MpxtVgbetG6axd/WNkchvvjzdijaxAuNcPf9UmNR1UUHBaiq
         J1lM8nb/AgoeAOKiQcAgIxwMDpSeVEasmTS1DUbg/evVWESQvze5SlCtKpkjcFMbUoHf
         5Vg+p5rBICSPIWamZdTe62HtKNiHYWCSl3eyUNEe3b7HB/hOv0H8ZfLL++cUEDUu1XPN
         1IYQ==
X-Gm-Message-State: ABuFfoiLqvSk0n3i8rD7r2Wo51Xzaog/uFCToBtC7w9Oed3cneLQSeZj
        i4UMwHwInka5bWq78Mf+aTo=
X-Google-Smtp-Source: ACcGV60+n3zCSlP/JXg00fLgpHBRSL0iPqRWPA/PBLhjuP1u1I8oh9CJnhdXjdkNbe+ehSIg3ZNIUw==
X-Received: by 2002:adf:fccc:: with SMTP id f12-v6mr2538914wrs.166.1538071698177;
        Thu, 27 Sep 2018 11:08:18 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u23-v6sm3731846wrc.42.2018.09.27.11.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:08:17 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:08:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] drm/amd/display: Use proper enums in
 process_channel_reply
Message-ID: <20180927180816.GA12545@flashbox>
References: <20180921215505.14634-1-natechancellor@gmail.com>
 <20180927180632.11520-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927180632.11520-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:06:33AM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
> implicit conversion from enumeration type 'enum
> aux_channel_operation_result' to different enumeration type 'enum
> aux_transaction_reply' [-Wenum-conversion]
>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
> warning: implicit conversion from enumeration type 'enum
> aux_channel_operation_result' to different enumeration type 'enum
> aux_transaction_reply' [-Wenum-conversion]
>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The current enum is incorrect, it should be from aux_transaction_reply,
> so use AUX_TRANSACTION_REPLY_HPD_DISCON.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Rather than change status to an integer, use the proper enumerated
>   type from aux_transaction reply as suggested by Nick and confirmed
>   by Henry.

Sigh Harry, sorry...

> 
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c                    | 2 +-
>  .../gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 3f5b2e6f7553..aaeb7faac0c4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -312,7 +312,7 @@ static void process_channel_reply(
>  
>  	/* in case HPD is LOW, exit AUX transaction */
>  	if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
> -		reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> +		reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
>  		return;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
> index 8eee8ace1259..59c3ed43d609 100644
> --- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
> +++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
> @@ -346,7 +346,7 @@ static void process_channel_reply(
>  
>  	/* in case HPD is LOW, exit AUX transaction */
>  	if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
> -		reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> +		reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
>  		return;
>  	}
>  
> -- 
> 2.19.0
> 
