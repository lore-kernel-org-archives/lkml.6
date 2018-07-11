Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAEBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99FE20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99FE20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbeGKPVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:21:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45480 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeGKPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:21:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so24339487oic.12;
        Wed, 11 Jul 2018 08:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z/S8ra/0PQ90wZXeqad/qfs2N2bRUagHXY9TbkwcYW4=;
        b=JrEl8l/5k3X70g6X8i+02YQm/7Q341IecEjQ0c+dk339MKfdIy16s3BKkIZGxshl2Y
         vwzK9jtWPek3U+N4sQ42wjK6rDHfLghcWbbrV3evwuuaOst88ArzrbpvGnBrIM12gbS6
         ehH1ZwoakZsBkoyQox2m0ek6cWFXNdRroqNJhmoIFYpu8h7FHWyGfS3wtMc+gIY05teH
         7r9S/Qi2XGU4QsaHAuZxiTGUnJEApkt0QpNWYjyIkv2X0a7+Xta44WknJst38jlbxcl0
         kBq3q1WlrE1B2Of+kh6mD0VG7/h4bsyNuPPCFsSdXaI2JtPCe2DgszSN87vRId2MVn/b
         ad8Q==
X-Gm-Message-State: APt69E1ZvSL6ePekB2CUe/728An8HfT8c2hGU5kjHExql3VqZ/c6Nkgn
        0YPlvtOcdJtjYyYaDGCIauE+bVw=
X-Google-Smtp-Source: AAOMgpfunLWWxp+T0C3Rvfg9TXe/xfZ4uNevA9U/fhuh2sWUlGxa4IRFuPgBpjbLit4otWcL/1SZWg==
X-Received: by 2002:aca:3d43:: with SMTP id k64-v6mr30858816oia.166.1531322183005;
        Wed, 11 Jul 2018 08:16:23 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id u144-v6sm13205880oie.14.2018.07.11.08.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:16:22 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:16:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Denis OSTERLAND <denis.osterland@diehl.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Message-ID: <20180711151621.GA4084@rob-hp-laptop>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
 <20180710090710.9066-6-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180710090710.9066-6-Denis.Osterland@diehl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 09:44:15AM +0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> The devicetree documentation for the ISL1219 device tree
> binding is added with an short example. It is not a trivial
> device, because it supports two interrupt souces.

s/souces/sources/

> 
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  .../devicetree/bindings/rtc/isil,isl1219.txt  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> new file mode 100644
> index 000000000000..f26f1e9d4bde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> @@ -0,0 +1,29 @@
> +Intersil ISL1219 I2C RTC/Alarm chip with event in
> +
> +ISL1219 has additional pins EVIN and #EVDET for tamper detection.
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be "isil,isl1219"
> + - "reg": I2C bus address of the device
> +
> +Optional properties:
> +
> + - "interrupt-names": list which may contains "irq" and "evdet"
> + - "interrupt-parent", "interrupts", "interrupts-extended":
> +   for passing the interrupt line of the SoC connected to #IRQ pin
> +   and #EVDET pin of the RTC chip.

Just list 'interrupts' and how many there are. interrupt-parent is 
implied and may be in a parent node. interrupts-extended is also 
implicitly allowed as needed.

> + - "isil,ev-evienb": if present bit can be set to disable event input pull-up
> +
> +
> +Example isl1219 node with #IRQ pin connected to SoC gpio1 pin12
> + and #EVDET pin connected to SoC gpio2 pin 24:
> +
> +	isl1219: rtc@68 {
> +		compatible = "isil,isl1219";
> +		reg = <0x68>;
> +		interrupt-names = "irq", "evdet";
> +		interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
> +			<&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> --
> 2.18.0
> 
> 
> 
> Diehl Connectivity Solutions GmbH
> Geschäftsführung: Horst Leonberger
> Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
> Nürnberg: HRB 32315
> ___________________________________________________________________________________________________
> 
> Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
> Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
> Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
> The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
> mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
