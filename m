Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A0C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0145C20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go9AW4rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfAJNI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:08:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41639 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfAJNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:08:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so8239373lfj.8;
        Thu, 10 Jan 2019 05:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hm6YtTsdy1Gax4ICbiKU6dqVCaGN0mEopTFuCz3OZ98=;
        b=go9AW4rhzhpMvPdeZukj50ExQJbQRxE/v6/4g/jlT7+FV8+ugAhhm9zo/130AXgPaE
         tvHGaaaw9t0NKD70+/ouIPQMaf8m8Lrmglj0YBzCU3kG1VDHAMwVVuZJSECW2D6jDVkM
         y5YXd7xdloJ9IixMkzoOKb0Kum4WIlu3j0nV3vd3RtzJ8Dd5ZaZ8H2O0xfyAztLGhXNs
         THIKJk2RFoWaQpRAT+YEefghE48iXzvSffptxyNSMPMklqhDm7Pm+6kYse9gOYYkBQiR
         OTk40rEGsFOCEmumSAbOODkDDuyM08fawezWTnZuxr9h1iCqOX5nH+lfSHlRcanL7pQs
         Jw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hm6YtTsdy1Gax4ICbiKU6dqVCaGN0mEopTFuCz3OZ98=;
        b=jTahzgkDIJw/YMNbSC8spkDIvKLTiBYxCZnxUKgZhOWMZk4+dZmVRBRo/mZRYbCAk3
         XeSUztFa3Ek0+Qe+Ujji7bPMd4qaZy5ONkEqYVdUFFEgeMB3SgIp5F7QYolIU6YI0zhg
         tHP73Pgy1TSyul5aVGYN07ia/3MfH5gnC+CgoModFPtOhfHElhdu8om++YsWwI2ugZeG
         mUUGoBXVnCYp38Pzb4ThNQpCCu/V+bFhaiP5zgiE6mAT348aQbrW7DxrhiEID7OGjAV3
         lKgi/OrZ+qg3a5w+TsD/6cLTst0lm2utdnY6GoZQ5CSxOZwNAnaU0pCD6hBB2RdsGp1c
         MDNQ==
X-Gm-Message-State: AJcUukeCpHga0YNdFNU2KT/ezr7La7REM3YWW62PDQ7nbt1TZPPHBEpb
        Id1+VkPeEuWvU9Cif5P/uo0=
X-Google-Smtp-Source: ALg8bN51OZD+Daka9iaoG64YPaEDURZi6atLXSi+q49OwJUlqvS9/m58nHpgk9OFnh6Ojp+1nqS05Q==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr5589702lfj.12.1547125733386;
        Thu, 10 Jan 2019 05:08:53 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id e94sm14375780lfi.23.2019.01.10.05.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 05:08:52 -0800 (PST)
Message-ID: <1688637327c088be458662a86d384cc0f0d51f55.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] drm/fb-helper: Ignore the value of
 fb_var_screeninfo.pixclock
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Thu, 10 Jan 2019 18:08:49 +0500
In-Reply-To: <20190109155254.AA160206B6@mail.kernel.org>
References: <20190108072353.28078-3-mironov.ivan@gmail.com>
         <20190109155254.AA160206B6@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 15:52 +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 79e539453b34 DRM: i915: add mode setting support.
> 
> The bot has tested the following trees: v4.20.0, v4.19.13, v4.14.91, v4.9.148, v4.4.169, v3.18.131.
> 
> v4.20.0: Failed to apply! Possible dependencies:
>     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
>     9c71a6686bfa ("drm: fourcc: Convert drm_format_info kerneldoc to in-line member documentation")
> 
> v4.19.13: Failed to apply! Possible dependencies:
>     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
>     9c71a6686bfa ("drm: fourcc: Convert drm_format_info kerneldoc to in-line member documentation")
>     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
> 
> v4.14.91: Failed to apply! Possible dependencies:
>     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
>     4cc4e1b40f3f ("drm/fourcc: Add a alpha field to drm_format_info")
>     9c71a6686bfa ("drm: fourcc: Convert drm_format_info kerneldoc to in-line member documentation")
>     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
>     ce2d54619a10 ("drm/fourcc: Add is_yuv field to drm_format_info to denote if the format is yuv")
> 
> v4.9.148: Failed to apply! Possible dependencies:
>     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
>     05fc03217e08 ("drm/mm: Some doc polish")
>     06df8ac682e6 ("drm: kselftest for drm_mm_debug()")
>     14d7f96f90fb ("drm/fb_cma_helper: Add drm_fb_cma_prepare_fb() helper")
>     2bd966d106e3 ("drm: kselftest for drm_mm_replace_node()")
>     2fba0de0a9ec ("drm: kselftest for drm_mm_insert_node_in_range()")
>     393b50f30566 ("drm: kselftest for drm_mm_init()")
>     4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
>     50f0033d1a0f ("drm: Add some kselftests for the DRM range manager (struct drm_mm)")
>     5628648df755 ("drm/fb-cma-helper: Use drm_gem_framebuffer_helper")
>     5705670d0463 ("drm: Track drm_mm allocators and show leaks on shutdown")
>     6259a56ba0e1 ("drm: Add asserts to catch overflow in drm_mm_init() and drm_mm_init_scan()")
>     62a0d98a188c ("drm: allow to use mmuless SoC")
>     72a93e8dd52c ("drm: Take ownership of the dmabuf->obj when exporting")
>     7886692a5804 ("drm: kselftest for drm_mm_insert_node()")
>     900537dc3889 ("drm: kselftest for drm_mm_reserve_node()")
>     940eba2d58a7 ("drm/gem|prime|mm: Use recommened kerneldoc for struct member refs")
>     9a71e277888b ("drm: Extract struct drm_mm_scan from struct drm_mm")
>     9b26f2ed29f8 ("drm: kselftest for drm_mm and alignment")
>     b112481bb327 ("drm/cma-helper: simplify setup for drivers with ->dirty callbacks")
>     b3ee963fe41d ("drm: Compile time enabling for asserts in drm_mm")
>     ba004e39b199 ("drm: Fix kerneldoc for drm_mm_scan_remove_block()")
>     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
>     e6b62714e87c ("drm: Introduce drm_gem_object_{get,put}()")
> 
> v4.4.169: Failed to apply! Possible dependencies:
>     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
>     14d7f96f90fb ("drm/fb_cma_helper: Add drm_fb_cma_prepare_fb() helper")
>     199c77179c87 ("drm/fb-cma-helper: Add fb_deferred_io support")
>     1eb83451ba55 ("drm: Pass the user drm_mode_fb_cmd2 as const to .fb_create()")
>     4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
>     5628648df755 ("drm/fb-cma-helper: Use drm_gem_framebuffer_helper")
>     70c0616d5a84 ("drm/fb_cma_helper: remove duplicate const from drm_fb_cma_alloc")
>     b112481bb327 ("drm/cma-helper: simplify setup for drivers with ->dirty callbacks")
>     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
>     ce0c57576810 ("drm/fb_cma_helper: Implement fb_mmap callback")
>     fdce184609ee ("drm/fb-cma-helper: Use const for drm_framebuffer_funcs argument")
> 
> v3.18.131: Failed to apply! Possible dependencies:
>     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
>     14d7f96f90fb ("drm/fb_cma_helper: Add drm_fb_cma_prepare_fb() helper")
>     199c77179c87 ("drm/fb-cma-helper: Add fb_deferred_io support")
>     1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
>     1eb83451ba55 ("drm: Pass the user drm_mode_fb_cmd2 as const to .fb_create()")
>     2a8cb4894540 ("drm/exynos: merge exynos_drm_buf.c to exynos_drm_gem.c")
>     2b8376c803c4 ("drm/exynos: remove struct exynos_drm_encoder layer")
>     39a839f2e651 ("drm/exynos: s/exynos_gem_obj/obj in exynos_drm_fbdev.c")
>     421ee18d4e04 ("drm/exynos: fix null pointer dereference issue")
>     4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
>     4846e4520849 ("drm/exynos: clean up machine compatible string check")
>     5628648df755 ("drm/fb-cma-helper: Use drm_gem_framebuffer_helper")
>     5cbb37df378d ("drm/exynos: resolve infinite loop issue on multi-platform")
>     70c0616d5a84 ("drm/fb_cma_helper: remove duplicate const from drm_fb_cma_alloc")
>     7239067795dc ("drm/exynos: remove ifdeferry from initialization code")
>     7ded85885d49 ("drm/exynos: remove superfluous error messages")
>     813fd67b57ff ("drm/exynos: cleanup name of gem object for exynos_drm")
>     820687befec4 ("drm/exynos: move Exynos platform drivers registration to init")
>     94e30d93f936 ("drm/exynos: remove exynos_drm_fb_set_buf_cnt()")
>     96976c3d9aff ("drm/exynos: Add DECON driver")
>     b74ea6a97e82 ("drm/exynos: remove DRM_EXYNOS_DMABUF config")
>     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
>     ce0c57576810 ("drm/fb_cma_helper: Implement fb_mmap callback")
>     cf67cc9a29ac ("drm/exynos: remove struct exynos_drm_display")
>     d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>     d56125afcbdf ("drm/exynos: update exynos_drm_framebuffer_init() for multiple buffers")
>     e9fbdcb45a36 ("drm/exynos: fix possible infinite loop issue")
> 
> 
> How should we proceed with this patch?
> 
> --
> Thanks,
> Sasha

Hi,

I'm new to kernel development, so: what exactly I'm supposed to do in
such case? Rebase my patch on top of older versions and then resend
patches somewhere?

Just checked the v3.18.131. Apparently code in question was not changed
since then, so manual rebase would be trivial.

