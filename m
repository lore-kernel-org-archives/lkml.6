Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0363FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A39B206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dafJohrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeLOBeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 20:34:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40538 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLOBeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 20:34:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so3494470plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 17:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=12BDartp/N/fhthtkqWHvuZBmG3ZzMSCJQ7KYpTSSv8=;
        b=dafJohrM7IxoaF6u2Sjlrt6+ZOkKVEdSJTAfr6//Q0JcEF695bteBnrcO2DsNO9DVu
         Dm9v280xjpz+egFRjcsyWnmlIL6Wanem6eIiCp2X6n0IqfWW5vVPP9V0IMqAFVDdbORz
         QaPAUdHmhSl/9qSw2GOnrHWgnVMNxaixDXuwmgjrp9TmZCzd5TK+AvXF26kE0ItGcRII
         1e/BDu19KdqPYfDw9Mcpq4q5IIXZUpkcF0ApL0L3bKOQpj3dtIE2eShTbEt4uek71VQn
         twOyNfCpzQuUNYE3X9jQBxvizUoYzwGcF27YIehBDmotzoRTNPL3dQlYiIDT/gmzNbyE
         1wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=12BDartp/N/fhthtkqWHvuZBmG3ZzMSCJQ7KYpTSSv8=;
        b=DL3yKjgivGQLwK+lOIRi17MMIMxh/YvBLKC5ZQLUt2/HsO9aSFti8SZIzEDOb9g/LS
         s2BE83qkD2w8Xea7RJVdMlVp1MmBhwTK2rdM3BIVAF4QQcVzJtfx2qJkJL3wezk4eyx6
         kf/8b7RnCMJZ6b0DQtPzoMgH3c/Coe3+t5Qx2/tl2a2BddSBU8B9rBIIB7dHwpiNz9Gx
         5dNHUcxkAuw74DaZy/VLdRUBIgOAkfAKR/QwvdlvhzAVmXyMKiWiHAmO7oVID1uhj8nF
         RJZGIe2TS7Fgxl0Zot73UxrNvwmFDjWABEjFW/HZOPGlPpskcity0OD2eD7Bpy5s1lwW
         OvYw==
X-Gm-Message-State: AA+aEWaNHb4WDbPZ3qA/so4ykOjRlbNLDt+HY3ptaBlW517wpWKJEmmF
        TCdeA0dgkDbYe+Rebxto8wz9Ig==
X-Google-Smtp-Source: AFSGD/V1EddjMTkrRl5Y2tjiw3UeErXctGpxcGX8TT9RsFROw2NM3sGSYvqrcHLG02wt8jhATTRjjw==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr4757200plo.119.1544837644569;
        Fri, 14 Dec 2018 17:34:04 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 19sm11499939pfs.108.2018.12.14.17.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 17:34:03 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        broonie@kernel.org, matthew.hart@linaro.org,
        enric.balletbo@collabora.com
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: gtucker/kernelci-stable boot bisection: v4.19.9 on meson-gxbb-p200
In-Reply-To: <5c14545e.1c69fb81.d4568.5d80@mx.google.com>
References: <5c14545e.1c69fb81.d4568.5d80@mx.google.com>
Date:   Fri, 14 Dec 2018 17:34:03 -0800
Message-ID: <7hwooblgj8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> gtucker/kernelci-stable boot bisection: v4.19.9 on meson-gxbb-p200
>
> Summary:
>   Start:      be53d23e68c2 Linux 4.19.9
>   Details:    https://kernelci.org/boot/id/5c13e85d59b5144a340a819d
>   Plain log:  https://storage.kernelci.org//gtucker/kernelci-stable/v4.19.9/arm64/defconfig/lab-baylibre/boot-meson-gxbb-p200.txt
>   HTML log:   https://storage.kernelci.org//gtucker/kernelci-stable/v4.19.9/arm64/defconfig/lab-baylibre/boot-meson-gxbb-p200.html
>   Result:     be53d23e68c2 Linux 4.19.9
>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       gtucker
>   URL:        https://gitlab.collabora.com/gtucker/linux.git
>   Branch:     kernelci-stable
>   Target:     meson-gxbb-p200
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Config:     defconfig
>   Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit be53d23e68c29900da6b6ce486b5ab8507de94b1
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Thu Dec 13 09:16:23 2018 +0100
>
>     Linux 4.19.9
>
> diff --git a/Makefile b/Makefile
> index 34bc4c752c49..8717f34464d5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  VERSION = 4
>  PATCHLEVEL = 19
> -SUBLEVEL = 8
> +SUBLEVEL = 9
>  EXTRAVERSION =
>  NAME = "People's Front"
> -------------------------------------------------------------------------------

This is pretty clearly a bug in the automation toolling.

If this patch broke the kernel on that board (which I maintain, BTW) I
would be very impressed.

Kevin
