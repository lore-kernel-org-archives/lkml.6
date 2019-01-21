Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE404C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3782085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548084920;
	bh=ExXlEW24wz0NFmV+KxPa/5xWP+6cUNY+xmBLx9cudHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T1VFHh43/aZdBRhrdTHM22kE5Qv9Elw+m2fQUngSxv5VXB85EhVsf4K1Vlv4RADVQ
	 wct/DKlYSDSRgGO8LoNv2UUnVue1BQdBvyJQcmuQKGkqkL11OJZRPva1wvBpJPUWvl
	 mwWswSWQy9ZGAMxD/UDFKLNH72empkldy5steEHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfAUPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbfAUPfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:35:15 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F29720880;
        Mon, 21 Jan 2019 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548084915;
        bh=ExXlEW24wz0NFmV+KxPa/5xWP+6cUNY+xmBLx9cudHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KSDT8S/DMHQN4c/i+BLV9DiLWmjoXNIO+fjIqeFewqsV22ftTxrWlzjYdsIBzQIST
         shNrC2sfwymXKRPuozGh0u4wxb6ii3ZulKFLdA6SBsrP+TyYht3mFn4ACNmx3b6BKv
         lSVWUKWrx7LyXn4YP8M/+Shj3tA5Nntu1DlwzfBI=
Received: by mail-qt1-f172.google.com with SMTP id v11so24024865qtc.2;
        Mon, 21 Jan 2019 07:35:15 -0800 (PST)
X-Gm-Message-State: AJcUukc8T+A/gWdAFCxmZbjyrAeVmEPNqjkIjU/yNEJuwJFeKHCclr5w
        FUyKwUB3Dc8GTDbrE4U6q4LlBlxxlY4sfiOqKw==
X-Google-Smtp-Source: ALg8bN6x0qxVSSuY0JHehLiL62uxqTqmQlkBsHFDiHd0p0ALv9oyvjCVVX8BqnT5V93mehEI1x0Uy7mxVoRVRnw3kiw=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr26171728qvb.218.1548084914262;
 Mon, 21 Jan 2019 07:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20190120172534.24617-1-lkundrak@v3.sk> <20190120172534.24617-5-lkundrak@v3.sk>
In-Reply-To: <20190120172534.24617-5-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jan 2019 09:35:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
Message-ID: <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem binding
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The Marvell Armada DRM master device is a virtual device needed to list all
> nodes that comprise the graphics subsystem.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> index de4cca9432c8..3dbfa8047f0b 100644
> --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> @@ -1,3 +1,27 @@
> +Marvell Armada DRM master device
> +================================
> +
> +The Marvell Armada DRM master device is a virtual device needed to list all
> +nodes that comprise the graphics subsystem.
> +
> +Required properties:
> +
> + - compatible: value should be "marvell,dove-display-subsystem",
> +   "marvell,armada-display-subsystem"
> + - ports: a list of phandles pointing to display interface ports of CRTC
> +   devices
> + - memory-region: phandle to a node describing memory to be used for the
> +   framebuffer
> +
> +Example:
> +
> +       display-subsystem {
> +               compatible = "marvell,dove-display-subsystem",
> +                            "marvell,armada-display-subsystem";
> +               memory-region = <&display_reserved>;
> +               ports = <&lcd0_port>;

If there is only one device, you don't need this virtual node.


> +       };
> +
>  Marvell Armada LCD controller
>  =============================
>
> --
> 2.20.1
>
