Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B709C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C805B218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARzJt+eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfAZHR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 02:17:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36368 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfAZHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 02:17:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so9080961edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 23:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I+CVU/4ovJ142nVuQBxiCY9SzGT5NLLn6Bz7juh1WB4=;
        b=ARzJt+eo0UUeMzjiGkRDw6pAnNneTphUISizb91vZ+ilkVqFJrAGaIWi/y92TqQXD+
         itiNEUJ/wvfg1/30JSZbBYosFkwHPw7QP68LG/TOPaMFGrPMBILX/a8s0yiXRv8XGV+q
         4CZvtCDjYxqQntFIpFDh8189k5PCk12Xpu7GDgK3ymKMTuSgCGEK73TNuLdJc82anFT+
         ik2oXDaAZeyhJdVUbrh4UQ57PnThP45Cn6yxgj0CbE249uCIUpSWjuHB5UzA45mDKQUE
         5QfalrvuD82p8SAmhxt/6elQSKK8YPLXOF4h7Shl+vJt6wehfxttfmJaeJNLBn/JP86o
         5NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I+CVU/4ovJ142nVuQBxiCY9SzGT5NLLn6Bz7juh1WB4=;
        b=NFb7WQv2pawph8UkZbt1QpwTOdK76c+mBBTMM8eSX5pVBXXHMU1ViPaaNHMVR9P1xR
         PY0UWxLBDvW9Pgo5Kt2NF7IXYcDebOYV2TbGvH3+0Ez6vGOLrAqtxjtr+Jc6Mw/CnBsg
         d9kFrPtlNABemojTJh27yoF/xIXRX5PoImLyvbRNTL442CtaKf0V+Ny7WQ2rM0VBUP9Q
         jj0dP2/ZO935QT08iSwn/G5xWF1X6Xz/1uHhKAzJLAxRxuNFWSmuyi8LImLiKzYb5sir
         JPT6JUpKPKemQAVS2WywpSnPJ16j8EUMq+WzgpOH02vb2gmlPknOphKF+8X47TqJE5vi
         mKHg==
X-Gm-Message-State: AJcUukcZOXDaQpSbV45hpthc9HVDLmKsO5sAldsm3CZGW9y6rRRzm5O6
        W1a2a52UZC7tM5dShkJ3Wjo=
X-Google-Smtp-Source: ALg8bN7OfEZuKZRs4X84soPvDtrk2BzXPJqVj4BGq5SSQeQCQybK0D42ZXz044eLFrg23mYl4NKb3g==
X-Received: by 2002:a50:d84d:: with SMTP id v13mr13448296edj.103.1548487045727;
        Fri, 25 Jan 2019 23:17:25 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id y16sm12219251edb.41.2019.01.25.23.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 23:17:25 -0800 (PST)
Date:   Sat, 26 Jan 2019 00:17:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2] drm/i915: Disable -Wuninitialized
Message-ID: <20190126071723.GA24759@archlinux-ryzen>
References: <20190126071122.24557-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126071122.24557-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 12:11:23AM -0700, Nathan Chancellor wrote:
> This warning is disabled by default in scripts/Makefile.extrawarn when
> W= is not provided but this Makefile adds -Wall after this warning is
> disabled so it shows up in the build when it shouldn't:
> 
> In file included from drivers/gpu/drm/i915/intel_breadcrumbs.c:895:
> drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c:350:34: error:
> variable 'wq' is uninitialized when used within its own initialization
> [-Werror,-Wuninitialized]
>         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>                                         ^~
> ./include/linux/wait.h:74:63: note: expanded from macro
> 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
>         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
>                                ~~~~                                  ^~~~
> ./include/linux/wait.h:72:33: note: expanded from macro
> '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
>         ({ init_waitqueue_head(&name); name; })
>                                        ^~~~
> 1 error generated.
> 
> Explicitly disable the warning like commit 46e2068081e9 ("drm/i915:
> Disable some extra clang warnings").
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/220
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Rather than disable the warning for the problematic folder, disable it
>   for the entire folder like Matthias's commit.
> 

Link to v1: https://lore.kernel.org/lkml/20181025193601.11746-1-natechancellor@gmail.com/

Since I forgot '--in-reply-to' :(

>  drivers/gpu/drm/i915/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 8300efe60fe1..210d0e8777b6 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -22,6 +22,7 @@ subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
>  subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
>  subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
>  subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
> +subdir-ccflags-y += $(call cc-disable-warning, uninitialized)
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>  
>  # Fine grained warnings disable
> -- 
> 2.20.1
> 
