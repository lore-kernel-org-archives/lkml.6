Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A321ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010D62086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGPVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:43:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42357 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:43:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so77534053oib.9;
        Mon, 16 Jul 2018 14:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LU2LqsFNAEpFUP5kEdUX4g0JXqRSXceo6W2XcJQHPq0=;
        b=pXxSYj7dL7fIsnR7hicfgmLtr3QL0cYzFw9QKk4MNPjsT5fvXca1ByYI9+dnI0tXMS
         dFu49hdUVwhyfuuoUvZNbqyfjO1oxOQJjWm8NxBH3fz+PsRYelsTOspksTstLH6AFBw1
         +9Jnk6LLF2JK3M3S85bO6+aSXevt6EPqz6ImrBYEzxbrwkyEI2dm1rv131HpASE2OhvY
         F6o6w2JIgPSRRsCWSB/oG5SntjdlAXXxeykt61kxX2HrXrKQBEjUb9uI1ofyKQq3gkGp
         S2QoovSTro0PQwpnozNiKX7tBQr98tQtMRNco/ps999QghqR7A/klu5bbz1a4jDPncsW
         8hkQ==
X-Gm-Message-State: AOUpUlGppq5aDu5753uWlCYF5oyPk142DjmbjUzgLq4/ndmdMAtj8jHK
        kjkhEgL/GhzNgbZZVCEkLg==
X-Google-Smtp-Source: AAOMgpf68B5POwNtnH0YbMmF1e5z0xvSeAuRIGqq3U4nFBhsFRVZlIYUp2V6sCAnorvRXAkwT1IMpw==
X-Received: by 2002:aca:45c3:: with SMTP id s186-v6mr980637oia.289.1531775682879;
        Mon, 16 Jul 2018 14:14:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p4-v6sm51678587oig.43.2018.07.16.14.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:14:41 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, ltyrala@cadence.com,
        pgaj@cadence.com, stelford@cadence.com
Subject: Re: [PATCH 10/12] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings
Message-ID: <20180716211440.GA29964@rob-hp-laptop>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
 <1530612152-27555-11-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530612152-27555-11-git-send-email-dkos@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:02:21AM +0100, Damian Kos wrote:
> Document the bindings used for the Cadence MHDP DPI/DP bridge.
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.txt          |   39 ++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> new file mode 100644
> index 0000000..d872e26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> @@ -0,0 +1,39 @@
> +Cadence MHDP bridge
> +==========================
> +
> +The Cadence MHDP bridge is a DPI to DP bridge.
> +
> +Required properties:
> + - compatible: should be "cdns,mhdp",

Not very specific. Only 1 version of this block?

> + - reg: physical base address and length of the controller's registers,
> + - clocks: DP bridge clock, it's used by the IP to know how to translate
> +	   a number of clock cycles into a time (which is used to comply
> +	   with DP standard timings and delays),
> + - clock-names: must be "clk",

Not a useful name. With only 1 clock, you can just drop this.

> +
> +Required subnodes:
> + - ports: Ports as described in Documentation/devictree/bindings/graph.txt
> +   Currently contains a single input port at address 0 representing the DPI
> +   input.

Currently? You should have a port connecting to a connector node.

> +   Port 0 should be connected to a DPI encoder output.
> +
> +Example:
> +
> +	mhdp: mhdp@0xf0fb000000 {

dp-bridge@f0fb000000

> +		compatible = "cdns,mhdp";
> +		reg = <0xf0 0xfb000000 0x0 0x1000000>;
> +		clocks = <&mhdp_clock>;
> +		clock-names = "clk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				mhdp0_dpi_input: endpoint {
> +					remote-endpoint = <&xxx_dpi_output>;
> +				};
> +			};
> +		};
> +	};
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
