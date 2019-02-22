Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1434A2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZIbVoGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfBVMsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:48:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37115 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfBVMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:48:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so1665106edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8YtSth0sIthWMM+2Nnc0gxJojWeBeoWBvh+OabLwxo=;
        b=MZIbVoGdjrSDc/xpAQ4btTJlBtpTUd1QN+QFNsgln8xBrlu1xUhIE/LkW1IMk36qFG
         ecFKYohPd7tQyeFJ+UD14/1yWfI6B6u3vw9aFoqtcAp9UQasxUMXjWypsGwHWsuYPxx1
         GyD1v8BPe3mGlWSphntkcdz9Ik4+Md4GRqDuGj2pv3QZ8/zjLV9EFyY1hdULXrD2U9rq
         pQPkT4CxeIJ0G7+fdmQhiVgNNH3zZHvHLSXe+0G4oHjRtV4H2n1zTGrEpROoVfq+RJna
         L38G6rLuqzARq+IzTdG+1chGkawXCndP4KWCtQjHx8d9jhZwy2sEqa2zTS/M3sYTEX0a
         Gi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8YtSth0sIthWMM+2Nnc0gxJojWeBeoWBvh+OabLwxo=;
        b=mymAGN/Yp1zGnnxI3M1OSiXuC0DwaSSmYrc0WEmnYUteoCVlTUg/SrK2bAK2BsNZwC
         i9tCi5R3xDWmpWhhIRLVa1bPEd5FOVtwPPyDP3pvzKAfgYqIr23B500Y7EwEZlEkIekJ
         xsIL9pYAofiSrstM8SOiMAFX+56/CIgTWj3XB3hJgNGHEVu+ncO1O6VgUx7qwEUTdr+/
         wR3oVfxAjyjeNXQpHGgzG6Y1tT3BHc158/lu4G8lxsRKqatrsWCKzMZUb3snt/5udrWz
         tqIxDC0ynttzG6fUNsg7PvJApljN/2IlcRLk/l8qAbuBwXLx8z4kN9hRfjZq4ApT7Idw
         1YBw==
X-Gm-Message-State: AHQUAuYD3Q49aHwDGoCrMXRJSyHIx/PAWkO8HHtrJnu38r+NzDgRiEEV
        cEiVSVaP2S02UQ5/GMb5nmab1z9Cc6A=
X-Google-Smtp-Source: AHgI3Ib+FEwA7G3lgmMprRCw0iUPERFLD1JwHjglJSGQZYVEIRDB1+79omBLSrYnrUIVRnrtLCKwoA==
X-Received: by 2002:a50:b6f4:: with SMTP id f49mr3173402ede.80.1550839728427;
        Fri, 22 Feb 2019 04:48:48 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id u21sm251131ejm.45.2019.02.22.04.48.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 04:48:47 -0800 (PST)
Date:   Fri, 22 Feb 2019 05:48:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by
 reference
Message-ID: <20190222124845.GA18614@archlinux-ryzen>
References: <20181210234201.4850-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210234201.4850-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:42:01PM -0700, Nathan Chancellor wrote:
> Clang warns when an expression that equals zero is used as a null
> pointer constant (in lieu of NULL):
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> warning: expression which evaluates to zero treated as a null pointer
> constant of type 'const enum color_transfer_func *'
> [-Wnon-literal-null-conversion]
>                 TRANSFER_FUNC_UNKNOWN,
>                 ^~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> state using drm VRR properties") and it could be solved by using NULL
> instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> pointer. However, after looking into it, there doesn't appear to be a
> good reason to pass app_tf by reference as it is never mutated along the
> way. This is the only code path in which app_tf is used:
> 
> mod_freesync_build_vrr_infopacket ->
>     build_vrr_infopacket_v2 ->
>         build_vrr_infopacket_fs2_data
> 
> Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> the value so we can avoid dereferencing anything by just passing in
> app_tf's value to mod_freesync_build_vrr_infopacket and
> build_vrr_infopacket_v2.
> 
> There is no functional change because build_vrr_infopacket_fs2_data
> doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> as not calling build_vrr_infopacket_fs2_data at all like before this
> change when NULL was used for app_tf.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
>  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 620a171620ee..520665a9d81a 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
>  
>  static void build_vrr_infopacket_v2(enum signal_type signal,
>  		const struct mod_vrr_params *vrr,
> -		const enum color_transfer_func *app_tf,
> +		enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket)
>  {
>  	unsigned int payload_size = 0;
> @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
>  	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
>  	build_vrr_infopacket_data(vrr, infopacket);
>  
> -	if (app_tf != NULL)
> -		build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> +	build_vrr_infopacket_fs2_data(app_tf, infopacket);
>  
>  	build_vrr_infopacket_checksum(&payload_size, infopacket);
>  
> @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>  		const struct dc_stream_state *stream,
>  		const struct mod_vrr_params *vrr,
>  		enum vrr_packet_type packet_type,
> -		const enum color_transfer_func *app_tf,
> +		enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket)
>  {
>  	/* SPD info packet for FreeSync */
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index 949a8b62aa98..063af6258fd9 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>  		const struct dc_stream_state *stream,
>  		const struct mod_vrr_params *vrr,
>  		enum vrr_packet_type packet_type,
> -		const enum color_transfer_func *app_tf,
> +		enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket);
>  
>  void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
> -- 
> 2.20.0
> 

Gentle ping on this patch, it would be nice to get this fixed and into
5.1!

Thanks,
Nathan
