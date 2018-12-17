Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A597C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226D9214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bni42YmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbeLQRmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:42:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50631 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLQRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:42:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so93698wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHgL4UdnOpy77EV1tf+PwJUW7xiwZDXTyWHuuGcwaDQ=;
        b=bni42YmZYsEYoR5Aw5ulAeFPXk/ZhHYsRSine6QPSgu0x5V3O8WxH70nb7clz/dInr
         A/q525w+G5HVVXl6kvGN6n0R7YeRkfeDOmAIuAWi/4HltgKBmQh5qQfT0ecaIbvcBAwt
         SpQRgh3xWquMFz0X7E5rbg6DqcDc08cPEhLgyWukyFxBANdgoYm0uDva8GILqww6tflg
         oHEFmwxBLnLGSg+AA3b+FH2m8/8rRqf4Hl+j89fcnnkjzciz4C48LHtEjpJyMl8k/4vN
         7PtBGqgbNMCMF/aCtlGBSIyoEh7ghS/7WDShET31Y03lxmtDy/PfoyWuy8o4HeRRKm3J
         OE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHgL4UdnOpy77EV1tf+PwJUW7xiwZDXTyWHuuGcwaDQ=;
        b=lQh+h9MPcQzeOd3boaXjonFRQirM2k03fINwyueWcD3B7FXVj5e1qZWiqn8rQq8M4d
         1UG4/CKiSt3U4/RufsDbSAp+JghqVFRE/kLMWs+PIjI5RQVJi9VOYhGqubOjcskBbgSH
         rVgym2JYMfA8joiC408bZsyA6dkaMFE78gFQmmQp/O3TKvLfoZVnJIZSZQSS+xxet8BO
         +9v7dDAbQpirC1OfudS+NIvGL5ZWW804juBjS8KdY37knp835bzH9dSW/26xNrQ5Fis3
         BXBDCRdR5k7qwNtbI6tQUCTb3Vq3NM+OlYzkH5+wPZ3SJLVMynvNSc7V1PCuDKtSKVMK
         Yq9g==
X-Gm-Message-State: AA+aEWaEiqJ2ICDDV8QiHToDhE+QtW9IkqxfuFnfu7oAuqlxZ1flknju
        /xDcWzDCpNTtBIHq6G92Z+k=
X-Google-Smtp-Source: AFSGD/WP5htQxZWYIlFfcSdup+nQZiRd7zJ1kfAgRrkiS3fnovpOo8j4a0CJsT8NbFCv6M2kN1zLIg==
X-Received: by 2002:a1c:35ca:: with SMTP id c193mr66251wma.146.1545068517755;
        Mon, 17 Dec 2018 09:41:57 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id n127sm13549516wmd.20.2018.12.17.09.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:41:57 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:41:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] drm/i915: Disable -Wuninitialized for intel_breadcrumbs.o
Message-ID: <20181217174155.GA857@flashbox>
References: <20181025193601.11746-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025193601.11746-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:36:01PM -0700, Nathan Chancellor wrote:
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
> This warning looks to be a false positive given that init_waitqueue_head
> initializes name before it is used. Rather than disable the warning for
> the full folder like commit 46e2068081e9 ("drm/i915: Disable some extra
> clang warnings"), just disable it for the one problematic file because
> it could be a useful warning for other cases.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/220
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/i915/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 1c2857f13ad4..f36c420afb99 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -26,6 +26,7 @@ subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>  
>  # Fine grained warnings disable
>  CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
> +CFLAGS_intel_breadcrumbs.o = $(call cc-disable-warning, uninitialized)
>  CFLAGS_intel_fbdev.o = $(call cc-disable-warning, override-init)
>  
>  subdir-ccflags-y += \
> -- 
> 2.19.1
> 

Gentle ping for review.

Nathan
