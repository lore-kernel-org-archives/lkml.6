Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2310C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961DB20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VhWG3IyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961DB20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJITQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:16:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36530 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJITQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:16:26 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w99BxC5d031707;
        Tue, 9 Oct 2018 06:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539086352;
        bh=IwNa+1TnhCVLX42CgDNqqHC4xRsXgRi1vCPFardr5p8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VhWG3IyOJXLXEmcmORjWWOYrPM6bDfc6kVX9GZ+FN06oaTpai55wdQO53m0Af3GAa
         Dhzbod+Ieo7z0YAS0SeydsBZ64LLEvrIceVKhjc6MHl5fNEkbxe4DZxfwqwXrrW0FJ
         QV3mAuAHFnBnVMmDuLPlDq5qN3UVvUxA1cPvGNsw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99BxCul016873;
        Tue, 9 Oct 2018 06:59:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 06:59:12 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 06:59:12 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99Bx63W022342;
        Tue, 9 Oct 2018 06:59:07 -0500
Subject: Re: [PATCH 21/36] dt-bindings: arm: Convert TI davinci board/soc
 bindings to json-schema
To:     Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>
CC:     Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-22-robh@kernel.org>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <e8aeb321-9f9a-8636-2f1d-f5082e635fb1@ti.com>
Date:   Tue, 9 Oct 2018 17:29:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005165848.3474-22-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 October 2018 10:28 PM, Rob Herring wrote:
> Convert TI Davinci SoC bindings to DT schema format using json-schema.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/davinci.txt       | 25 ------------------
>  .../bindings/arm/ti/ti,davinci.yaml           | 26 +++++++++++++++++++
>  2 files changed, 26 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
> deleted file mode 100644
> index 715622c36260..000000000000
> --- a/Documentation/devicetree/bindings/arm/davinci.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Texas Instruments DaVinci Platforms Device Tree Bindings
> ---------------------------------------------------------
> -
> -DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
> -Required root node properties:
> -    - compatible = "ti,da850-evm", "ti,da850";
> -
> -DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
> -Required root node properties:
> -    - compatible = "ti,da850-lcdk", "ti,da850";
> -
> -EnBW AM1808 based CMC board
> -Required root node properties:
> -    - compatible = "enbw,cmc", "ti,da850;
> -
> -LEGO MINDSTORMS EV3 (AM1808 based)
> -Required root node properties:
> -    - compatible = "lego,ev3", "ti,da850";
> -
> -Generic DaVinci Boards
> -----------------------
> -
> -DA850/OMAP-L138/AM18x generic board
> -Required root node properties:
> -    - compatible = "ti,da850";
> diff --git a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
> new file mode 100644
> index 000000000000..2675cae91a60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: None
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/davinci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DaVinci Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Sekhar Nori <nsekhar@ti.com>
> +description: |
> +  DA850/OMAP-L138/AM18x based boards
> +
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,da850-evm
> +          - ti,da850-lcdk
> +          - enbw,cmc
> +          - lego,ev3

The boards had some reasonable human readable description earlier, which
has been lost now. Is there a way to bring that back?

Apart from that, looks good to me.

Thanks,
Sekhar

> +      - const: ti,da850
> +...
> -- 
> 2.17.1
> 

