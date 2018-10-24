Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87556ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCAB206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCAB206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJYCFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:05:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45897 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeJYCFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:05:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id e14-v6so1820055oie.12;
        Wed, 24 Oct 2018 10:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d64hI1gIKWrWvnc+gFORSVAr0THgqtaCwSwMdxY0EcM=;
        b=IitdF5hUUjbjnUQ5xwYi4XDHlsRMoupx25Kk9tpbUc5gnJgVRhL/TdzI2eXKhwbNad
         VK3+6xj3W2W8eOSWoQOSjOzoIFbmX/+RXaEK6PvQoRWSvY7n/8IK1S6SA0F6z0zpQM01
         5N8z735PSCiuUZyE39ReuitYwgH7lZCkqaMKPrFE8fwXh+ibRqBHKVk4bH/tD4Vyyl4x
         ZV3XizttpOVZ3sNMsR/5HPFdsud4OJhwXPCPUgXLzjaNpHhTbwshtMr4CbijBsM/pcim
         CSobjaPqpahC9pxEMOzMLdKXt5SW6/mleaWoTqoMqm5xA0Fnl55HdCU8mDkcI3tKiQ3u
         QD6g==
X-Gm-Message-State: AGRZ1gJHPLI9lEkMfAmi3KtnXCEkT90KpoDgAWVkBHbWgeaZvH98Oijt
        MWwXy3B02Fbxc5SPLrp2iA==
X-Google-Smtp-Source: AJdET5cIpjBDtMAMLDhYYGSrsJ6JpWwPSMka2bXH3y1rXziy3poHdzAEXLVQdOHIgC9hhGYWtWQQZA==
X-Received: by 2002:aca:a60d:: with SMTP id p13-v6mr1994012oie.358.1540402572884;
        Wed, 24 Oct 2018 10:36:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d131-v6sm2058952oih.4.2018.10.24.10.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:36:12 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:36:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luis Oliveira <luis.oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.pinto@synopsys.com, festevam@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [V3, 1/4] Documentation: dt-bindings: phy: Document the Synopsys
 MIPI DPHY Rx bindings
Message-ID: <20181024173611.GA30655@bogus>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
 <1539953556-35762-2-git-send-email-lolivei@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539953556-35762-2-git-send-email-lolivei@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:52:23PM +0200, Luis Oliveira wrote:
> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
> RX mode.
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changelog
> v2-V3
> - removed gpios reference - it was for a separated driver
> - changed address to show complete address
> 
>  .../devicetree/bindings/phy/snps,dphy-rx.txt       | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> new file mode 100644
> index 0000000..03d17ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> @@ -0,0 +1,28 @@
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

Needs a unit suffix (-hz).

> +- snps,dphy-te-len	: Size of the communication interface (8 bits->8 or 12bits->12).
> +- reg			: Physical base address and size of the device memory mapped
> +		 	  registers;

How many, what are they, and what order? Looks like 3 below.

Also, a tab after spaces error.

> +
> +Example:
> +
> +	mipi_dphy_rx1: dphy@d00003040 {
> +		compatible = "snps,dphy-rx";
> +		#phy-cells = <1>;
> +		snps,dphy-frequency = <300000>;
> +		snps,dphy-te-len = <12>;
> +		reg = < 0xd0003040 0x20
> +			0xd0008000 0x100
> +			0xd0009000 0x100>;
> +	};
> +
> --
> 2.7.4
> 
