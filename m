Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1130BC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E61218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXGtMnti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfAYBVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:21:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36540 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfAYBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:21:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so6133945edb.3;
        Thu, 24 Jan 2019 17:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u7Jk9Z17dFrCt7kIv0knTupUrZ6oToI0kGJABgTRWXk=;
        b=iXGtMntihgvs2zdUkCGM5Nl7t7GZeGSdXQkD/uuntDpx9HIF70UXQQydPrhbk5osWw
         Kem9fKm6W6pdYxx7yTDsKlTAJaXkkHUBONdhLXtf/bLCs0jp0gYx75Y6EtK78WkTVlV3
         YaIALBRN2DQqVo4xhqDDFuZsYGs89WWLaac3PCMXQ/xBTiki/1JecwwLsjMRjOAKWlmU
         LvsyJheIoUY1pb5uWHWj1OAKDvr0HHQURniyEyl2mc/5ncZp7xpyIwjZOb8PdLSKfm36
         zVX8hn0W7RK+jWbHNX7J5voV0vQXFcsvgCE/6EgkIKU0EfQlv3Xu7g5vtGxDcc37TwBJ
         OvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u7Jk9Z17dFrCt7kIv0knTupUrZ6oToI0kGJABgTRWXk=;
        b=hJCeU/2LXz1xjEo3Odj/+qbDF3cdxXBHAC6Nce8fC91TJyc/3ww68Aqq8vwa89FU7X
         tsqZ5E8SSergKaR+8MdY+iZ9qJKzlEGdIqusNjAvoXBvH382yyLH7A7jtMUHZByK6087
         bN5aaT6h3oZQH0ZTO4WOG9x0meqcaE/zFVX9SW5mXxJNUuiEII9dSSn8hTzaGbUUFk7F
         p+R2WY6QibR7nYeKbpKghiJ+598PQG6CNbY45I7PoFb2NagEXpe2zH+EL4J4K3mxGQj4
         kwjZi5vm35/iLIMk79Rj5dVorJ3Z0K3RJH6Pq57EcMupd6D/xfNNJLwt2xEUoVQDgHsH
         T+ZA==
X-Gm-Message-State: AJcUukfXGnBBrdG8rrOGYVFGvTabGeEkcRNCL5EmRYUzq3+gklMBSmEN
        IBRgQlR7Fc9Z/fAx0Gxz0HaEftDKj5mo2g==
X-Google-Smtp-Source: ALg8bN54qOxbSVHuW4PlJLCZlmQYXlZpto39Z1eRfvhkO3S3PPrdBBS0w6aJnUiThkZcgYPYswo2/Q==
X-Received: by 2002:a50:9b1d:: with SMTP id o29mr8260414edi.246.1548379266426;
        Thu, 24 Jan 2019 17:21:06 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id n10sm11155842edq.33.2019.01.24.17.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 17:21:05 -0800 (PST)
Date:   Thu, 24 Jan 2019 18:21:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     ndesaulniers@google.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, stable@vger.kernel.org,
        S@google.com, Shirish <Shirish.S@amd.com>,
        Matthias Kaehlcke <mka@google.com>,
        James Y Knight <jyknight@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Message-ID: <20190125012103.GA20106@archlinux-ryzen>
References: <20190125005304.183322-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125005304.183322-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:52:59PM -0800, ndesaulniers@google.com wrote:
> arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> on SSE2 to support emitting double precision floating point instructions
> rather than calls to non-existent (usually available from gcc_s or
> compiler_rt) floating point helper routines.
> 
> Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
> Link: https://github.com/ClangBuiltLinux/linux/issues/327
> Cc: stable@vger.kernel.org # 4.19
> Reported-by: S, Shirish <Shirish.S@amd.com>
> Reported-by: Matthias Kaehlcke <mka@google.com>
> Suggested-by: James Y Knight <jyknight@google.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index 95f332ee3e7e..dc85a3c088af 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
>  	cc_stack_align := -mstack-alignment=16
>  endif
>  
> -calcs_ccflags := -mhard-float -msse $(cc_stack_align)
> +calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
>  
>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index d97ca6528f9d..33c7d7588712 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
>  	cc_stack_align := -mstack-alignment=16
>  endif
>  
> -dml_ccflags := -mhard-float -msse $(cc_stack_align)
> +dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
>  
>  CFLAGS_display_mode_lib.o := $(dml_ccflags)
>  CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
> -- 
> 2.20.1.321.g9e740568ce-goog
> 
