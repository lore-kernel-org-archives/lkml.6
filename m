Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07132083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWp0Y/Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07132083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbeKGGXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388208AbeKGGXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:23:12 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D802A2083D;
        Tue,  6 Nov 2018 20:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541537766;
        bh=aL+CTRK4kbTb1vjOMTK4/s7gQmcIosOQr5Iz1wfEd30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JWp0Y/Yia5yjpTl1lK207lMI2+6fBJhcixhEVRBmCj0SX0kI8bqu3f2V99FRjWcWf
         Ck8igVihuGyv8Nxlc/zOrFOP+78P6BwDtSqFJEBRW4hDTH8X8LQjJt/w2gSKRYs7Zs
         mwfGATcrLFAQCxO05KFz7HW310lqvJiwknxw0cNE=
Received: by mail-qk1-f178.google.com with SMTP id 189so19325946qkj.8;
        Tue, 06 Nov 2018 12:56:05 -0800 (PST)
X-Gm-Message-State: AGRZ1gLVJPUtaQNy64jgef9LopYN1NnJBfJiLXLsDevhIzR5NZPPRkDd
        7PGPoBIyToficW1JXdLuUzOvE2thfCM0DEMy9Q==
X-Google-Smtp-Source: AJdET5eBrOqMPVIp+eXzvmwFvYiFHRu9pOaiiSci7GPQMHn0EnROG5lPkEPbwoXtbrW+AmY9SFltgOAB5OElCXU81uE=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr26655502qkg.147.1541537765086;
 Tue, 06 Nov 2018 12:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20181102192616.28291-1-faiz_abbas@ti.com> <20181102192616.28291-3-faiz_abbas@ti.com>
In-Reply-To: <20181102192616.28291-3-faiz_abbas@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Nov 2018 14:55:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tMKb6e69dfz9B1g3yy+a+sPTM0edJ51x6+hWEMAu8CA@mail.gmail.com>
Message-ID: <CAL_Jsq+tMKb6e69dfz9B1g3yy+a+sPTM0edJ51x6+hWEMAu8CA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: phy: phy-of-simple: Document new binding
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 2:23 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add documentation for the generic simple phy implementation.

We don't do 'simple' or 'generic' bindings.

> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  .../devicetree/bindings/phy/phy-of-simple.txt | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-of-simple.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-of-simple.txt b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
> new file mode 100644
> index 000000000000..696f2763395c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
> @@ -0,0 +1,29 @@
> +Generic simple phy device tree binding
> +--------------------------------------
> +
> +A good number of phy implementations merely read dts properties,
> +enable clocks, regulators or do resets without having a dedicated register
> +map. This binding implements a generic phy driver which can be used for
> +such simple implementations and avoid boilerplate code duplication.

Sure, but then latter some needs certain timing/ordering of those
controls or some other DT additions. 'generic' or 'simple' never work
out for bindings. By all means though, write a simple/generic phy
driver. Just make it understand an explicit list of compatible
strings. Then when a phy turns out to be not so simple, we can write a
driver for it with changing the DT.

> +Required Properties:
> +-  compatible  : must be "simple-phy"
> +-  phy-cells    : must be 0

#phy-cells

> +
> +Optional Properties:
> +-  bus-width   : generic bus-width. Must be positive.
> +-  max-bitrate : generic max-bitrate. Must be positive.
> +-  pwr         : phandle to phy pwr regulator node.

That's not the regulator binding.

> +
> +Example:
> +
> +The following example is a can transceiver implemented as a generic phy.
> +It has a max-bitrate property and a pwr regulator.
> +
> +
> +transceiver1: can-transceiver {
> +       compatible = "simple-phy";
> +       max-bitrate = <5000000>;
> +       pwr-supply = <&transceiver1_fixed>;
> +       #phy-cells = <0>;
> +};
> --
> 2.18.0
>
