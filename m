Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A9EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D590E223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D590E223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeKLTJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:09:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41225 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeKLTJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:09:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 400B32072C; Mon, 12 Nov 2018 10:17:15 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6333A2039F;
        Mon, 12 Nov 2018 10:17:04 +0100 (CET)
Date:   Mon, 12 Nov 2018 10:17:03 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vitor soares <vitor.soares@synopsys.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, psroka@cadence.com, agolec@cadence.com,
        adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com,
        alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com,
        rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com
Subject: Re: [PATCH v3 2/3] dt-bindings: i3c: Document Synopsys DesignWare
 I3C master bindings
Message-ID: <20181112101703.024ba1f3@bbrezillon>
In-Reply-To: <1541697251-20392-3-git-send-email-soares@synopsys.com>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
        <1541697251-20392-3-git-send-email-soares@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 17:14:10 +0000
Vitor soares <vitor.soares@synopsys.com> wrote:

> Document Synopsys DesignWare I3C master module
> 
> Signed-off-by: Vitor soares <soares@synopsys.com>
> ---
> Changes in v3:
> - Remove dummy characters
> 
> Changes in v2:
> - Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
> - Add controller version on compatible string
> 
>  .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> new file mode 100644
> index 0000000..b930c09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> @@ -0,0 +1,42 @@
> +Bindings for Synopsys DesignWare I3C master block
> +=================================================
> +
> +Required properties:
> +--------------------
> +- compatible: shall be "snps,dw-i3c-master-1.00a"
> +- clocks: shall reference the core_clk

Are you sure this IP only requires only one clock? If you're unsure,
you'd better have a clock-names prop.

> +- interrupts: the interrupt line connected to this I3C master
> +- reg: Offset and length of I3C master registers
> +
> +Mandatory properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- #address-cells: shall be set to 3
> +- #size-cells: shall be set to 0
> +
> +Optional properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- i2c-scl-hz
> +- i3c-scl-hz
> +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +	i3c-master@2000 {
> +		compatible = "snps,dw-i3c-master-1.00a";
> +		#address-cells = <3>;
> +		#size-cells = <0>;
> +		reg = <0x02000 0x1000>;
> +		interrupts = <0>;
> +		clocks = <&i3cclk>;
> +
> +		eeprom@57{
> +			compatible = "atmel,24c01";
> +			reg = < 0x57 0x0 0x10>;

			       ^ remove this white space.

> +			pagesize = <0x8>;
> +		};
> +	};
> +

