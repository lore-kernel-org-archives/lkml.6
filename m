Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7B020862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7B020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbeKFFYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:24:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40352 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeKFFYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:24:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id u130-v6so8634087oie.7;
        Mon, 05 Nov 2018 12:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C9sG2KemDzFXTzVCEydyHJ9q9vQbvq4N2OSfBrV0/wc=;
        b=CfErFrujagdjAMG99Vovs7adT39GjAMWewVFDSYcpawEzrvcmGm4hOSOJozdHG0xq9
         WnhHy2i63X7q10TeBPasxiEPjifGqWpIBFzR/TXpycqaY6Q7FVzbMSaTYn0uDsSm2ijs
         m7Y7Dp+C4jwZXiAX7VWbH2VoU2RQRI9akNFyFZmkBvzUd5YF2GvkqzmvtAN5xYqYZsCw
         fAVWA47H78We+JwGD7PQoWfQed5sGiZqocE0PMP5uTfBlKZeFWfCWVElfjWtAmuAwDMv
         mKP0adaV3qRuDpXdtEzyGvYlImLfWZ5ZkXBgs+KNnH7fwuGv510VywEYqJEE9V1jqewn
         c6VQ==
X-Gm-Message-State: AGRZ1gLmv8MA0sZuqIs+RImgcj3INpE68BquYi3qKsROfB//bisPNZWX
        1fJKs/y1m1NOMrUrKZjYRw==
X-Google-Smtp-Source: AJdET5fgkM+dc2KZDhaDUN2j0lAErOQAnYtAo5jaGBTMDmtr/gcOpZGNMRkwwQuJ8wea+JHkRRP6Wg==
X-Received: by 2002:aca:ddc3:: with SMTP id u186-v6mr13070740oig.204.1541448160594;
        Mon, 05 Nov 2018 12:02:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m39sm4145156otd.72.2018.11.05.12.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:02:39 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:02:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, sakari.ailus@iki.fi,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: media: i2c: Add bindings for Maxim
 Integrated MAX9286
Message-ID: <20181105200238.GA12435@bogus>
References: <20181102154723.23662-1-kieran.bingham@ideasonboard.com>
 <20181102154723.23662-2-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102154723.23662-2-kieran.bingham@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 03:47:20PM +0000, Kieran Bingham wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> The MAX9286 deserializes video data received on up to 4 Gigabit
> Multimedia Serial Links (GMSL) and outputs them on a CSI-2 port using up
> to 4 data lanes.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> ---
> v3:
>  - Update binding descriptions
> 
> v4:
>  - Define the use of a CSI2 D-PHY
>  - Rename pwdn-gpios to enable-gpios (with inverted polarity)
>  - Remove clock-lanes mapping support
>  - rewrap text blocks
>  - Fix typos
> ---
>  .../bindings/media/i2c/maxim,max9286.txt      | 182 ++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt
> new file mode 100644
> index 000000000000..672f6a4d417d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt
> @@ -0,0 +1,182 @@
> +Maxim Integrated Quad GMSL Deserializer
> +---------------------------------------
> +
> +The MAX9286 deserializer receives video data on up to 4 Gigabit Multimedia
> +Serial Links (GMSL) and outputs them on a CSI-2 D-PHY port using up to 4 data
> +lanes.
> +
> +In addition to video data, the GMSL links carry a bidirectional control channel
> +that encapsulates I2C messages. The MAX9286 forwards all I2C traffic not
> +addressed to itself to the other side of the links, where a GMSL serializer
> +will output it on a local I2C bus. In the other direction all I2C traffic
> +received over GMSL by the MAX9286 is output on the local I2C bus.
> +
> +Required Properties:
> +
> +- compatible: Shall be "maxim,max9286"
> +- reg: I2C device address
> +
> +Optional Properties:
> +
> +- poc-supply: Regulator providing Power over Coax to the cameras
> +- enable-gpios: GPIO connected to the #PWDN pin with inverted polarity
> +
> +Required endpoint nodes:
> +-----------------------
> +
> +The connections to the MAX9286 GMSL and its endpoint nodes are modeled using
> +the OF graph bindings in accordance with the video interface bindings defined
> +in Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +The following table lists the port number corresponding to each device port.
> +
> +        Port            Description
> +        ----------------------------------------
> +        Port 0          GMSL Input 0
> +        Port 1          GMSL Input 1
> +        Port 2          GMSL Input 2
> +        Port 3          GMSL Input 3
> +        Port 4          CSI-2 Output
> +
> +Optional Endpoint Properties for GMSL Input Ports (Port [0-3]):
> +
> +- remote-endpoint: phandle to the remote GMSL source endpoint subnode in the
> +  remote node port.
> +
> +Required Endpoint Properties for CSI-2 Output Port (Port 4):
> +
> +- remote-endpoint: phandle to the remote CSI-2 sink endpoint node.
> +- data-lanes: array of physical CSI-2 data lane indexes.
> +
> +Required i2c-mux nodes:
> +----------------------
> +
> +Each GMSL link is modeled as a child bus of an i2c bus multiplexer/switch, in
> +accordance with bindings described in
> +Documentation/devicetree/bindings/i2c/i2c-mux.txt. The serializer device on the
> +remote end of the GMSL link shall be modelled as a child node of the
> +corresponding I2C bus.
> +
> +Required i2c child bus properties:
> +- all properties described as required i2c child bus nodes properties in
> +  Documentation/devicetree/bindings/i2c/i2c-mux.txt.
> +
> +Example:
> +-------
> +
> +	gmsl-deserializer@2c {
> +		compatible = "maxim,max9286";
> +		reg = <0x2c>;
> +		poc-supply = <&camera_poc_12v>;
> +		enable-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

> +
> +		i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

It's better to not have a mixture of nodes at a level with and without 
unit-addresses. So I'd move all the i2c nodes under an 'i2c-mux' node.

Rob
