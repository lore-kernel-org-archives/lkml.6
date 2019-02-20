Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEDF2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHCkjkxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBTOoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:44:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42245 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfBTOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:44:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so6240689pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJK5yIX576Yw6BcwwuN0W6WxY6pV3PXWliV7QJkXoHI=;
        b=AHCkjkxhVhKRmUqz38rYdzk7U+c4+JouPyRBCaprPhRdh/ECEpRn5eSUwiKRKWiJEs
         lbmSdIob6nXPtUnUiwkyU9+ytQdabuf0j3B2U3TED4y7lJUmb+DlDu633/K9Ap8PN0TZ
         WHIygqBWHx69Ucv25jpp2ia/rn3086SE9rhnBVKWBCUUptLJK+U7PZquHxf700rj0xc+
         qPOiXHxIRuY6eyVq5sjO2zblGMKtThRMCqEzVWc27ffK30VeIBwhG/8O7H6y93nASADL
         tYT+asnvffxwvEtzoc0OcDnZo/ErIImAIyY16XH8GlFqV+iHHqOU3gl1YnBqnARQIUqy
         Yp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJK5yIX576Yw6BcwwuN0W6WxY6pV3PXWliV7QJkXoHI=;
        b=JUp+PLsibox0Pu+D42MOZpPvgrhgY0nBBZhmwHU2tTL7SpkuX0hzSTq14vicyHAml9
         bH6kkxNPhX1gdiGgeFbzBHLNlx6BzbCZKCOqmkL6wJfNWXCAAHEACmPhfhGSYs4aUw5z
         EFLjHSPjJ7jZTEe8i/rrp8ORJoixWffvLuchDYDLiaBJy1E58qIPfXQJ3fsrG0HOJrvW
         WwQAnY1/JD9OKOAv2HdYSqEEFkSNLrZXKkGVT9PR6+olWEOcviQ0+c8DmHonN0Fx8TeT
         kxhiz8S42lybRsK8b8I7GN2fUi8/mZpGmlyk+A8aMK2kpnYW1H+0DC58u3iUB6goGmwA
         yT2w==
X-Gm-Message-State: AHQUAuakG5KPY0rloMUizupIs0U6rMbUha7MPK8lHXDj9QYfv9/HNy8q
        2lMIdMXI1C9XbmOmmpLt3/Cb4YEsxWc3RUa4I288Vw==
X-Google-Smtp-Source: AHgI3IaE/2YhwsfCYmCAf1EMDiRalatPHnU8uswo5o6k8fryE12H8cFQrwmEMVxLEjtwoIf9IxrrCLQ6/kHr7Hn4e4Q=
X-Received: by 2002:a63:d80b:: with SMTP id b11mr29456597pgh.168.1550673868496;
 Wed, 20 Feb 2019 06:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de>
In-Reply-To: <20190219214940.391081-1-arnd@arndb.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 20 Feb 2019 15:44:16 +0100
Message-ID: <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> about overly large stack frames, the worst ones being:
>
> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size of 20224 bytes in function 'st7789v_prepare'
> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12: error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
> drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes in function 'max3421_spi_thread'
> drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes in function 'slic_ds26522_probe'
> drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in function 'ccp_run_cmd'
> drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840 bytes in function 'stv0367ter_algo'
>
> None of these happen with gcc today, and almost all of these are the result
> of a single known bug in llvm.  Hopefully it will eventually get fixed with the
> clang-9 release.
>
> In the meantime, the best idea I have is to turn off asan-stack for clang-8
> and earlier, so we can produce a kernel that is safe to run.

Hi Arnd,

I don't think it's good to disable KASAN stack instrumentation for the
whole kernel by default with clang. It makes more sense to disable
stack instrumentation only for these few drivers.

Thanks!


>
> I have posted three patches that address the frame overflow warnings that are
> not addressed by turning off asan-stack, so in combination with this change,
> we get much closer to a clean allmodconfig build, which in turn is necessary
> to do meaningful build regression testing.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Qian Cai <cai@lca.pw>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38809
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/Kconfig.kasan      | 13 +++++++++++++
>  scripts/Makefile.kasan |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 67d7d1309c52..219cddc913ac 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -103,6 +103,19 @@ config KASAN_INLINE
>
>  endchoice
>
> +config KASAN_STACK
> +       int
> +       default 0 if CC_IS_CLANG && (CLANG_VERSION < 90000)
> +       default 1
> +       help
> +         The LLVM stack address sanitizer has a know bug that
> +         causes excessive stack usage in a lot of functions, see
> +         https://bugs.llvm.org/show_bug.cgi?id=38809
> +         Disabling asan-stack makes it safe to run kernels build
> +         with clang-8 with KASAN enabled, though it loses some of
> +         the functionality.  We assume that clang-9 will have a fix,
> +         so the feature can be used.
> +
>  config KASAN_S390_4_LEVEL_PAGING
>         bool "KASan: use 4-level paging"
>         depends on KASAN && S390
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index f1fb8e502657..6410bd22fe38 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -26,7 +26,7 @@ else
>         CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
>          $(call cc-param,asan-globals=1) \
>          $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
> -        $(call cc-param,asan-stack=1) \
> +        $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
>          $(call cc-param,asan-instrument-allocas=1)
>  endif
>
> --
> 2.20.0
>
