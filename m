Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7FBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEDD20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PrcowEFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEDD20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeLCJEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:04:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52737 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLCJEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:04:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so4847944wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbnSiiPTo0rBRXWRA1YfNnwbcPdqPK3l2FuBoNPldeY=;
        b=PrcowEFGPNg0nmtcm9kzyAoF+QEPJ+QDUuYHeJS8NGcUtNVnjRmu+Y0QaKuOpqe870
         g0G1foHKRO1PWeNzBVI0bjh8G89ymUvWfER1vbB0/euDQrEqzEXRCK4AYKiz2uFXSC0v
         0xOtWoUwEdaFiDBJpbjQvG9ta1qNVpOSd5ix63paEn7yR1ytVsSjh81mgEnfYh+xHHBX
         54g4lu9p4ShOcJOUrq30+LCn+Q9mNU7tY2c1irWryh0fKw5DeASoVfBgFrWCk6JKuSSz
         J6JRin/WFiFilsaN08/zp+2gVvK7BRqbvjgMBC+OxrK6694X6gMgkJQYZiwquxWadP2T
         8mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbnSiiPTo0rBRXWRA1YfNnwbcPdqPK3l2FuBoNPldeY=;
        b=E09zDDFgiMGuovuYgx2YQmJqQ8z4Pqtx3FbCEx/iqguKD1CbJfeyYDeDinPMTjQqYs
         HOqvjgNmut64tcwJkSQp5mGJrCWbub34RXKe0GH3+xyzunxGFoh10EMpXYHkGhrN1mL8
         PkjtpCEesNPqxG8OuJLrcgXohrN7WtXvwobLH9bZigo6YoRTUXqSf4MFzCBMTRNSodWP
         jxUPNThoBZqzsC8TWwnbbvxxIk/KIhO5rHKWiAxIl9itwx43eFg5zBCEOrGUWKJxpYlh
         0J8Z/SXeZIxNUJ37Q1urZj6Zie5f+oDnk+MLXp4P7QlDoV75TZvuxaZW7OoLu2X6ozms
         5J8A==
X-Gm-Message-State: AA+aEWb+myi6KV3mblGba2x2zFsG0KbcSqrjzjCo53Y1yym4PJ1w3vWP
        qhnRJuwBL2lSdufrJtlxfq3AynTOYA58H68e5Vl8iUy+MKVgfg==
X-Google-Smtp-Source: AFSGD/W17aijUKSMWrK8NheWjHNT7aphL3KBMaR1qrlV92JKfqe8BFLyo+nld/HeoLoHcjlq1FnwaNI27mvU8+BVpMQ=
X-Received: by 2002:a1c:af89:: with SMTP id y131mr7335459wme.137.1543827856276;
 Mon, 03 Dec 2018 01:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20181128100734.6536-1-narmstrong@baylibre.com>
In-Reply-To: <20181128100734.6536-1-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 3 Dec 2018 10:04:05 +0100
Message-ID: <CAMO6nawdGnr2nPvsZGT4WcnuetdvN=-e7j0SNWbCRvDBFw8GJw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/meson: Fix an Alpha Primary Plane bug on Meson
 GXL/GXM SoCs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
On Wed, Nov 28, 2018 at 11:07 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic GXL & GXM SoCs, a bug occurs on the primary plane when
> alpha is used where the alpha is not aligned with the pixel content.
>
> The woraround Amlogic implemented is to reset the OSD1 plane hardware
> block each time the plane is (re)enabled, solving the issue.
>

typo: woraround -> workaround

> In the reset, we still need to save the content of 2 registers which
> depends on the status of the plane, in addition to reload the scaler
> conversion matrix at the same time.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Changes since v1 at [1]:
> - Fix flickering and shaking by moving reset when plane is disabled
>
> [1] https://patchwork.freedesktop.org/patch/263550/
>
>  drivers/gpu/drm/meson/meson_plane.c | 12 ++++++++++++
>  drivers/gpu/drm/meson/meson_viu.c   | 27 +++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_viu.h   |  1 +
>  3 files changed, 40 insertions(+)
>

I can confirm the fix works on GXL (aml-s905x-cc), tested with
LibreElec, 1080p resolution.

Anything using alpha on the primary plane used to be randomly
"shifted" with black patches, and this was particularly visible with
subtitles.

Things seem OK now. Thanks!

Tested-by: Maxime Jourdan <mjourdan@baylibre.com>
Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>
