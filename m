Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CB620645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMzPCvuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeLQIIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:08:11 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40215 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbeLQIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:08:08 -0500
Received: by mail-vs1-f66.google.com with SMTP id z3so7151158vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqGNsNNTktZm8ZCgrBCB4pdC68D6xlkiRAqMELLxukw=;
        b=kMzPCvuC7ye0PRiLyB71mokAbLvax0KvUSyrQuo3/ebKy35lMFt4CLovF3zGHVeKp8
         lg/NiDskjW0hiC221y2x5LvCtQwu1au7CzI8f7vEpHI1aWZAKg+e4bmb71qzKiF0I7SN
         0FA83IbO3W2ImprIOKU2aV2sBoTCgfsjV2SlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqGNsNNTktZm8ZCgrBCB4pdC68D6xlkiRAqMELLxukw=;
        b=d3hnn81KfEE1O+f+aLdAUIyOPIba7lBMVmfq10k9xOfxkMsmI3Ou4Wa+WxLpT1fMKS
         EJOm6Kt7MLasrFbpKCwIbwB8uxbpGFeiexMkVdxH13QhoaZ7Uc/BzRN/iHqsF8K15AI3
         kVJa1uLgTfzc6VQ+tFZTWwCio4NE59WxQU5Kaw+8LaHJ58miXduEU4dHSiF2OIYZKUn4
         6VJFGPd95LsXlZE234o/vqsPO6XNHIQliIYjuuIJVGj796GA9rMs5daes/spThjgIIC5
         Anfnk+NrCQp9/++ttkeLAFEvraC+LSblajVxmqUp1H7TsJfPtMjOdVwHS3E6oAsPz2aD
         GCHg==
X-Gm-Message-State: AA+aEWYbchL9EEY9445vcujvoUgBZCMNYawZEiPWbgnVjgjaegbjErPL
        MdNYLK3OlV5PXNSLDReppbh+sntn4c3d6fm0uFSySA==
X-Google-Smtp-Source: AFSGD/Uo75RN0/J9HrSz15Do99XTDNS+USg37yjiocmoWYYDZ6pVO0T+jedho3vWkB0GF46uKC6goY2DqUtgDOoofC0=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr5794824vsi.191.1545034087773;
 Mon, 17 Dec 2018 00:08:07 -0800 (PST)
MIME-Version: 1.0
References: <1544732529-7003-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732529-7003-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Dec 2018 09:07:32 +0100
Message-ID: <CAPDyKFqE2zyCEOJfosqEh4ZE8tXAsHrVOXF9kVAR+O3yZeceNg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas_sdhi: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 21:22, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
>
> Document RZ/G2E (R8A774C0) SoC bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 27f2eab..4009adb 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -19,6 +19,7 @@ Required properties:
>                 "renesas,sdhi-r8a7744" - SDHI IP on R8A7744 SoC
>                 "renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
>                 "renesas,sdhi-r8a774a1" - SDHI IP on R8A774A1 SoC
> +               "renesas,sdhi-r8a774c0" - SDHI IP on R8A774C0 SoC
>                 "renesas,sdhi-r8a77470" - SDHI IP on R8A77470 SoC
>                 "renesas,sdhi-mmc-r8a77470" - SDHI/MMC IP on R8A77470 SoC
>                 "renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
> --
> 2.7.4
>
