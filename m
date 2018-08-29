Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04387C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC48620868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1ePMchv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC48620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeH2SFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeH2SF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:05:29 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4F020868;
        Wed, 29 Aug 2018 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535551701;
        bh=BrDeObB4j9LA48agD3/GkwOPoaRm+Js4fxoV1ME6j40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1ePMchvs2jCRkofACAthUG9AJoqJ9ObqqKzO4jJyebptWbhLp41HI4q+x3AhYOOA
         tbwU3bnkZNZbB5E4c7c+xfA7OAWRyB2bsY5IngSG9IWRMzXJRPrlN/G1JPifT4D33P
         pSDmm06Yb3nZuUbFwTJkILCuYDS1dsDIMInBcwp0=
Received: by mail-wm0-f51.google.com with SMTP id f21-v6so5442145wmc.5;
        Wed, 29 Aug 2018 07:08:21 -0700 (PDT)
X-Gm-Message-State: APzg51D/gE17SmidbuxvxOooumQxE3pdTD/gjp4lq8Ckccc71hKxBWR6
        iDnYTS0maRChg3bVMCpnIvhZk4CYmSCvrs99F3c=
X-Google-Smtp-Source: ANB0VdZ2GaYjL5YJYRtyyH8MLnVBo/HdjJ7YGZqXArBlvqVefXBgYq08bc83phm5pcivp+0JF75Cd6fzb/8YVT3cf7E=
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr4095105wmd.135.1535551700089;
 Wed, 29 Aug 2018 07:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
In-Reply-To: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 16:08:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd9-aLYFLBHwUyNecneHA6X+VbnZSK4paXsMcmvobnGhA@mail.gmail.com>
Message-ID: <CAJKOXPd9-aLYFLBHwUyNecneHA6X+VbnZSK4paXsMcmvobnGhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
To:     baolin.wang@linaro.org
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 at 11:04, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch adds the binding documentation for Spreadtrum SC2731 charger
> device.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../bindings/power/supply/sc2731_charger.txt       |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
> new file mode 100644
> index 0000000..02b616c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
> @@ -0,0 +1,14 @@
> +Spreadtrum SC2731 PMIC battery charger binding
> +
> +Required properties:
> + - compatible: Should be "sprd,sc2731-charger".
> + - reg: Address offset of charger register.
> + - phys: Contains a phandle to the USB phy.
> +
> +Example:
> +
> +       charger@0 {
> +               compatible = "sprd,sc2731-charger";
> +               reg = <0x0>;

Can you include also few lines of parent node? You use this "reg"
later as a base address so probably your parent node requires address
mapping. It would be nice to see it in example.

Best regards,
Krzysztof

> +               phys = <&ssphy>;
> +       };
> --
> 1.7.9.5
>
