Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9053DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FE120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544547518;
	bh=bYxvgYOBSwOSe0ZpRtqNnNn2RseC00i5nN637rwutQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O1VDY030CmKWD6uB3ebP5i74kB+J445N4p1gHViWvEsKf0ptBRaYM20SV4pB3iJ6V
	 gcKyA3i5XHj3RUVcPfKwQhlaDbypZ8Fj1jccAbxpF8/LC1LBnuMevxnz6kvtjfmIjg
	 GFBTSpb2FaqV1Ng9oQmdZ3L2izuoJ1NMvtaHUvnY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FE120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeLKQ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbeLKQ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:58:36 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4B020851;
        Tue, 11 Dec 2018 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544547515;
        bh=bYxvgYOBSwOSe0ZpRtqNnNn2RseC00i5nN637rwutQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JfrBeh+j8eEAPLvVSW6yJvUWkli7phF3BEr0DDuwm7XUfMOGS5Lu6RIlNlZX5TvSX
         DdwkQjBcHBhzlNgH3HGqq4NyzW5hl96S+gbrnknyEDnXAnE4Rz6ZXj3eR0qQPoTECu
         TGQOGn3vqfYSQ6PsYW25w2ptPxKIFisHxbNW59YQ=
Received: by mail-qk1-f178.google.com with SMTP id q70so9001317qkh.6;
        Tue, 11 Dec 2018 08:58:35 -0800 (PST)
X-Gm-Message-State: AA+aEWbZkICpmYP0o6IasulujqgugJh6rQhXrUUhYN6pytT/hUZEqJtV
        F+LaL8P4j8Ihlg6mQOLRkrT8GClPL5s/O6mHIg==
X-Google-Smtp-Source: AFSGD/V00bXWrg6CnLbWbb/ZNNU5UHouIAhgsI7YN0OZlNBnDMm8QwuZyoYDHvTrKHHE0ibF207knHklPq6ThEoGD4c=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr15556224qkg.147.1544547514495;
 Tue, 11 Dec 2018 08:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20181210132227.29262-1-narmstrong@baylibre.com> <20181210132227.29262-2-narmstrong@baylibre.com>
In-Reply-To: <20181210132227.29262-2-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Dec 2018 10:58:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK9nDaOOe3yjHAdaH92ds=_cudbq-wQee+YBPaCHEE-HQ@mail.gmail.com>
Message-ID: <CAL_JsqK9nDaOOe3yjHAdaH92ds=_cudbq-wQee+YBPaCHEE-HQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpu: mali-midgard: Add resets property
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 7:22 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic ARM Mali Midgard requires reset controls to power on and
> software reset the GPU, adds these as optional in the bindings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 18a2cde2e5f3..24d83ec952f1 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -37,6 +37,8 @@ Optional properties:
>  - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
>    for details.
>
> +- resets : Phandle to the reset controls for the Mali Midgard device.

How many? Sounds like 1, but the dts has 2. There's also a similar
patch for Allwinner[1]. I don't want to see a different number of
resets and different names for each vendor. So first figure out how
many resets the IP block has. You'll have to find someone with access
to the TRM.

Rob

[1] https://patchwork.ozlabs.org/patch/1003654/
