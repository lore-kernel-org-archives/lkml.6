Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC874C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AF22080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBN5Z/Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AF22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLLJUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:20:39 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36725 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeLLJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:20:39 -0500
Received: by mail-ua1-f68.google.com with SMTP id j3so6194674uap.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbhUWUR0Lk1xAJA9xAZ4ddDCxqiVB7n8gsJXRfNL7Uo=;
        b=jBN5Z/NkoihPpL3zQNvtY+RHGxa4cJzX2OJxY19o0sj+oTrjgnX/N//eLQ+snL/j2x
         mtUGJsJQKKjYSzaBzmjPy3a1ukv3WMFbCdSM5bXXRJoLz5/7J4a5s99NWjthjmQeHaTo
         ZpwcGm/cN4ndB7pMQD9r2cemhNmCnoRH37n7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbhUWUR0Lk1xAJA9xAZ4ddDCxqiVB7n8gsJXRfNL7Uo=;
        b=JwIBrXG9xozGHNinIbNRqQHlMCM41lXuyIVgt/Wmf9BtouIfY1RBP0trs85ej7rlKK
         HfQJgktrHSJjDRY4+jZlr5x5MRobbTXavevcjUs90ihDAlx+htkjEEqxPt1ZCYP3fprJ
         gv5J88ZDyuJoZTJBRe+UP8AZxwhSaRMYefT3inKNB9Xqf/xVkA8xB/lIpujbyPqD6ZRt
         eqpiC7puCpSZKrw0PwLNKIBSgvPKTCeLJnFrXszfrpPrGe2PDG2xpZx0FS/jmSJHea6+
         KNz80KfykzXrV1mZAxOUPwvmwK1IYeeiEISHxeznB57PSoQXOhEVz7WJLuqcrXgaOroh
         S2ZA==
X-Gm-Message-State: AA+aEWaZev0xMI85J+eA9K12eazRiJtfyfa9BUmMphzHjYEP4Bve67lU
        Ph4BxAp5Sk7WX1xMpUda7i1kyxNvHEmZevQWZw+K0A==
X-Google-Smtp-Source: AFSGD/XIhVSLKjQ8u8S3AjiDtAGkmea2p73VqKHc+CitlLOSCvxvspbQ6pKA45Du8RGy03MjkSKDZv2H5davFLH1aSA=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr1512175uar.39.1544606438066;
 Wed, 12 Dec 2018 01:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20181211142253.23747-1-faiz_abbas@ti.com> <20181211142253.23747-2-faiz_abbas@ti.com>
In-Reply-To: <20181211142253.23747-2-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Dec 2018 10:20:01 +0100
Message-ID: <CAPDyKFokQZ2402zvZ3_gO36B-zWUxzSTh2o=5QikXyQLW1sbVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sdhci-omap: Add note for cpu_thermal
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 at 15:20, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The driver fetches a thermal zone using the string "cpu_thermal" for
> tuning operation. Add a note for the same.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> index 393848c2138e..72c4dec7e1db 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -2,6 +2,8 @@
>
>  Refer to mmc.txt for standard MMC bindings.
>
> +For UHS devices which require tuning, the device tree should have a "cpu_thermal" node which maps to the appropriate thermal zone. This is used to get the temperature of the zone during tuning.
> +
>  Required properties:
>  - compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
>               Should be "ti,k2g-sdhci" for K2G
> --
> 2.19.2
>
