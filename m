Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45197C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0485720833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0485720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeGYS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:56:13 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33866 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbeGYS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:56:13 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so173458ith.1;
        Wed, 25 Jul 2018 10:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Co1uVhQcAIA6+uW9qeJuz8WQG2UdhfdSXjPOvVCJ3Ck=;
        b=XpHE6eyjvcb/cmnnb+tXGiGrViIY07lxQs+bDGlqBX1pxnyiPUDgmyXLIGNu29OUml
         AW2xWYqEsVk55G06bnIERUHt3Vgz0QyPi67GYFuH7IUsrD5OYdpkEDgRcLm0SLINWeJP
         uy8Zw2Kn+GCJaGn1WCn4/xg+knB8TttrE5x1dEC6zEpcz5HAIf4XVutmi/JGSYBV45Ma
         5ePnpAcV06sb7T0igNf2ou02qXZg3Ts8PqxSRSOskKtz/vmknf2IFZrQdBFjdNGoDbE3
         XQIgYJXqpJSFwmyvejpLkit59JYb3lhftew+D/Vr55OFjgf3kzDxhcOLuGabQ7Jjfw0y
         55dQ==
X-Gm-Message-State: AOUpUlHEglQQlNqkxwWNSu8g9+mAJUt8Dg838q5thRUBEM8cCE9Y42ZV
        XCVokXx/QIgQVgIMpH73eg==
X-Google-Smtp-Source: AAOMgpcewPFJD/s7LJj8wH/6pL9ySdMiggH17/346A/5uidGlGN2Y6lybFLzQYvBQ/A3PrATZRkXww==
X-Received: by 2002:a02:9c54:: with SMTP id h20-v6mr20968086jal.49.1532540611775;
        Wed, 25 Jul 2018 10:43:31 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u12-v6sm3024171ita.1.2018.07.25.10.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:43:31 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:43:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, pgaj@cadence.com,
        ltyrala@cadence.com, stelford@cadence.com
Subject: Re: [PATCH v2 4/5] dt-bindings: drm/bridge Document Cadence MHDP
 DPI/DP bridge bindings
Message-ID: <20180725174330.GA31540@rob-hp-laptop>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
 <1532430824-23477-5-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532430824-23477-5-git-send-email-dkos@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:13:35PM +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> new file mode 100644
> index 000000000000..dc7be7590048
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> @@ -0,0 +1,43 @@
> +Cadence MHDP bridge
> +==========================
> +
> +The Cadence MHDP bridge is a DPI to DP bridge.
> +
> +Required properties:
> +- compatible: should be "cdns,mhdp8546",
> +- reg: physical base address and length of the controller's registers,
> +- clocks: DP bridge clock, it's used by the IP to know how to translate
> +	a number of clock cycles into a time (which is used to comply
> +	with DP standard timings and delays),
> +
> +Required subnodes:
> +- ports: Ports as described in Documentation/devictree/bindings/graph.txt
> +	Port 0 - input port representing the VGA bridge input
> +	Port 1 - output port representing the VGA bridge output

VGA?

> +
> +Example:
> +
> +	mhdp: dp-bridge@f0fb000000 {
> +		compatible = "cdns,mhdp8546";
> +		reg = <0xf0 0xfb000000 0x0 0x1000000>;
> +		clocks = <&mhdp_clock>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				vga_bridge_input: endpoint {
> +					remote-endpoint = <&xxx_dpi_output>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				vga_bridge_output: endpoint {
> +					remote-endpoint = <&xxx_vga_connector_input>;

vga?

> +				};
> +			};
> +		};
> +	};
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
