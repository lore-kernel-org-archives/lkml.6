Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD10DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F45820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZ6aG/Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfANK02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:26:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45115 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:26:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so10132504pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CzcCJxnbl0LzIdopm5qsKPZ2eNi80mOCKExFL5bi0I4=;
        b=RZ6aG/UeMLc3x/q1qXUBTiBXPAG9jUV8ZsjANH7ne9PfWJm7eymoitG4SLWwykixmv
         nxLvDlwa1no0v2S/OkZmEuBqoaUoMWsBR+otVwZPPAMNYPDnHTwLh700Xw91pV0Usc6y
         Fu0e4uOJFyUXzbD83A5/+LZM7p1XrhIIgNVM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CzcCJxnbl0LzIdopm5qsKPZ2eNi80mOCKExFL5bi0I4=;
        b=AYmWDkGUhOqyYt0bLSVyEejNksXBjqNW4hBk2ARPikEKqx0maOfGR1tdDnDkHsb6T4
         yVLmIkSd0vap70nVFCUGJtP17P/XUuF69CMcwouta/tzVQB2qMjxnBv3mxd/bbKsinoA
         RNeXWozu04/lPAYCNiGQZyPT0V64cTtD8I0l3C/cnBwqxkYuXrk507HCghlwS2rug6nA
         DnZagPPMSi54wvIDcKh/LqDeZutMM0bwsv7OP6yA1TExBNKMGfUQeMlsZoxZprRG8Z8K
         UkcEna3szTCEp/W3JGaK4RvS/b5OT18G1+Upv3hFSqo58LQO7LU0O5wP6kbo2lfWWBiI
         ihgQ==
X-Gm-Message-State: AJcUukdvDGI4xIWgYw6sVw1rmif/pH/V9DIlsvDDO5kRXqTYC4RrGjG5
        KRWmk4dUblcGJp8vm/95W1yQ
X-Google-Smtp-Source: ALg8bN5E/GLwEsy8uAR2BAL7TYdCum31eDVFue3S1vnmVsc49NhDEiiFgLqKF2MzXd1Yh1KAwuN/sQ==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr24930399pfb.66.1547461586717;
        Mon, 14 Jan 2019 02:26:26 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
        by smtp.gmail.com with ESMTPSA id l185sm114470pfl.54.2019.01.14.02.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:26:26 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:56:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     afaerber@suse.de
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 10/34] dt-bindings: arm: Convert Actions Semi bindings
 to jsonschema
Message-ID: <20190114102614.GC13162@Mani-XPS-13-9360>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203213223.16986-11-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:31:59PM -0600, Rob Herring wrote:
> Convert Actions Semi SoC bindings to DT schema format using json-schema.
> 

Andreas,

Shall I just apply this patch to Actions sub-tree?

Thanks,
Mani

> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
>  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
>  2 files changed, 38 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
> deleted file mode 100644
> index d54f33c4e0da..000000000000
> --- a/Documentation/devicetree/bindings/arm/actions.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Actions Semi platforms device tree bindings
> --------------------------------------------
> -
> -
> -S500 SoC
> -========
> -
> -Required root node properties:
> -
> - - compatible :  must contain "actions,s500"
> -
> -
> -Modules:
> -
> -Root node property compatible must contain, depending on module:
> -
> - - LeMaker Guitar: "lemaker,guitar"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Allo.com Sparky: "allo,sparky"
> - - Cubietech CubieBoard6: "cubietech,cubieboard6"
> - - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
> -
> -
> -S700 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s700"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Cubietech CubieBoard7: "cubietech,cubieboard7"
> -
> -
> -S900 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s900"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> new file mode 100644
> index 000000000000..60abd371e474
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/actions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi platforms device tree bindings
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
> +      - items:
> +          - enum:
> +              - allo,sparky # Allo.com Sparky
> +              - cubietech,cubieboard6 # Cubietech CubieBoard6
> +          - const: actions,s500
> +      - items:
> +          - enum:
> +              - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
> +          - const: lemaker,guitar
> +          - const: actions,s500
> +
> +      # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
> +      - items:
> +          - enum:
> +              - cubietech,cubieboard7 # Cubietech CubieBoard7
> +          - const: actions,s700
> +
> +      # The Actions Semi S900 is a quad-core ARM Cortex-A53 SoC.
> +      - items:
> +          - enum:
> +              - ucrobotics,bubblegum-96 # uCRobotics Bubblegum-96
> +          - const: actions,s900
> -- 
> 2.19.1
> 
