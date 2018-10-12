Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336C4C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89CC2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89CC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJMATM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:19:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46226 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJMATM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:19:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id o21so12944003otb.13;
        Fri, 12 Oct 2018 09:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOdOQoOF3EY30nKK7GOsyoQ41xfrtvxPwLzUDa6y3EU=;
        b=IvhSElLNkz5AcE5SbUov6nvhQvBYVIvKRL7H2CkWov6I1cDRIoOV03jwAEaOmPPXGp
         Hi38xoxQxKTIngzFWJTA/eBz6gLcANJrk/B8iLMNFv+EMEDzakVgmGEL6ILsqsImQu7p
         LLfunVjhkdJ2UcOB36Z6W+hA0jFu1rkfEJ4MVbtrbFhIDGjfL90hweAxu76VksNikkoe
         dMdndxJkKHI4Y2raJO5vqy4DKQlif3tI8eRNqEoU7HQVxf9kDqAFgse4AmxrxhkSPUDe
         UXvSYCLmn6Pa1GIEbicI0bKOR8qfXufTtYkVMhtViSqYlre0M+q4fUuMgOlWE7vHkyFh
         4xKA==
X-Gm-Message-State: ABuFfojyUDJAMCyo7VvdzR0NE8r9HmdaHK9e95VgYmK144JVPYKoW9gH
        tpXq7Z5ICH2xNu/kgC2KCA==
X-Google-Smtp-Source: ACcGV63JGFU1F2W1L/yVkB+Y35j5eKE7ZGIv0EadfC3gbxRWy77zdTUEz5b3KGnOiNGAq0voL4gryw==
X-Received: by 2002:a9d:4617:: with SMTP id y23mr4049801ote.300.1539362749750;
        Fri, 12 Oct 2018 09:45:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h72-v6sm444188oib.56.2018.10.12.09.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:45:49 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:45:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao.Pinto@synopsys.com, festevam@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [V2, 2/5] Documentation: dt-bindings: Document the Synopsys MIPI
 DPHY Rx bindings
Message-ID: <20181012164548.GA11873@bogus>
References: <20180920111648.27000-1-lolivei@synopsys.com>
 <20180920111648.27000-3-lolivei@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920111648.27000-3-lolivei@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:16:40PM +0200, Luis Oliveira wrote:
> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
> RX mode.

"dt-bindings: phy: ..." for the subject.

> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changelog
> v2:
> - no changes
> 
>  .../devicetree/bindings/phy/snps,dphy-rx.txt       | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> new file mode 100644
> index 0000000..9079f4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> @@ -0,0 +1,36 @@
> +Synopsys DesignWare MIPI Rx D-PHY block details
> +
> +Description
> +-----------
> +
> +The Synopsys MIPI D-PHY controller supports MIPI-DPHY in receiver mode.
> +Please refer to phy-bindings.txt for more information.
> +
> +Required properties:
> +- compatible		: Shall be "snps,dphy-rx".
> +- #phy-cells		: Must be 1.
> +- snps,dphy-frequency	: Output frequency of the D-PHY.
> +- snps,dphy-te-len	: Size of the communication interface (8 bits->8 or 12bits->12).
> +- reg			: Physical base address and size of the device memory mapped
> +		 	  registers;
> +
> +Optional properties:
> +- snps,compat-mode	: Compatibility mode control

type? values?

> +
> +The per-board settings:
> +- gpios 		: Synopsys testchip used as reference uses this to change setup
> +		  	  configurations.

Preferred to be named (e.g. foo-gpios). How many? What are their 
functions?

> +
> +Example:
> +
> +	mipi_dphy_rx1: dphy@3040 {
> +		compatible = "snps,dphy-rx";
> +		#phy-cells = <1>;
> +		snps,dphy-frequency = <300000>;
> +		snps,dphy-te-len = <12>;
> +		snps,compat-mode = <1>;
> +		reg = < 0x03040 0x20
> +			0x08000 0x100
> +			0x09000 0x100>;
> +	};
> +
> -- 
> 2.9.3
> 
