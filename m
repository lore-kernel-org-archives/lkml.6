Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962DC20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962DC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeIKB0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:26:50 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36866 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeIKB0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:26:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id p84-v6so42847888oic.4;
        Mon, 10 Sep 2018 13:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l0ovmDhBk+O75fjG/1SVkXgGD/R1dZjprjunyN7MmoU=;
        b=mA5MIo8zGfsaLjiYX7VFowSM1MB2vBbjz9hzVfnEO8olKhtM+sEtmjTFqjiVRlLyY1
         5wRqUzP9o2lBwpzQgNWvoUky9uCwhncB71seLvK7djRt1p6Uwd9h1k9aSuZTSzQlz2mi
         4bt5+W/q0UG6kdhg5lP6W1AI7Z7cjqxqHjfp5hVzhgdq3S7G71asW/m/WWomG3SXFHVg
         ABR+y+rlv0J11PsxQR9YfvQ5ufF2LLCvGC8aMkrbFYAN8XPshsVwh6XA80ZHbO+hfRr+
         dBiwvQFla66eQTRROTwpaAEWBoAXQYv2oZ15sZzgqVX+sabtuz9cl2zMqw9esavTEx54
         qoQg==
X-Gm-Message-State: APzg51CjjwsLZR46MfpR6tWdK4qLUveQMC0+RcKhHEQIhpvpK360Zjdi
        RmNAnsL7acZmJy4Jjej+fw==
X-Google-Smtp-Source: ANB0VdZP0W6MMwWmm9yCJH/sGp3b+LRr36rqN1i3/y72nIv3gtfKQA4i3FmEE3m8VaN5iU3H9ZefAA==
X-Received: by 2002:aca:5e42:: with SMTP id s63-v6mr21844068oib.134.1536611460415;
        Mon, 10 Sep 2018 13:31:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i204-v6sm24633072oia.41.2018.09.10.13.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:30:59 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:30:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc:     kishon@ti.com, michal.simek@xilinx.com, mark.rutland@arm.com,
        vivek.gautam@codeaurora.org, v.anuragkumar@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Message-ID: <20180910203059.GA7055@bogus>
References: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536165747-6405-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536165747-6405-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:12:27PM +0530, Anurag Kumar Vulisha wrote:
> This patch adds the document describing dt bindings for ZynqMP
> phy. ZynqMP SOC has a High Speed Processing System Gigabit
> Transceiver which provides PHY capabilties to USB, SATA,
> PCIE, Display Port and Ehernet SGMII controllers.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>  Changes in v3:
> 	1. Corrected the Documentation as suggested by Vivek Gautam
> 
>  Changes in v2:
> 	1. None
>  .../devicetree/bindings/phy/phy-zynqmp.txt         | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
> new file mode 100644
> index 0000000..65007c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
> @@ -0,0 +1,104 @@
> +Xilinx ZynqMP PHY binding
> +
> +This binding describes a ZynqMP PHY device that is used to control ZynqMP
> +High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
> +and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
> +
> +Phy provider node
> +=================
> +
> +Required properties:
> +- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
> +
> +- reg           : Address and length of register sets for each device in
> +                  "reg-names"
> +
> +- reg-names     : The names of the register addresses corresponding to the
> +		  registers filled in "reg":
> +			- serdes: SERDES block register set
> +			- siou: SIOU block register set
> +
> +Optional properties:
> +- xlnx,tx_termination_fix : Include this for fixing functional issue with the

s/_/-/

> +		  TX termination resistance in GT, which can be out of spec for
> +		  the XCZU9EG silicon version. This property is not required for
> +		  "xlnx,zynqmp-psgtr-v1.1"
> +
> +Required nodes	:  A sub-node is required for each lane the controller
> +		   provides.
> +
> +Phy sub-nodes
> +=============
> +
> +Required properties:
> +lane0:

lane0 or lane@0? If you need or care about numbering then add a reg 
property.

> +- #phy-cells	: Should be 4
> +
> +lane1:
> +- #phy-cells	: Should be 4
> +
> +lane2:
> +- #phy-cells	: Should be 4
> +
> +lane3:
> +- #phy-cells	: Should be 4
> +
> +Example:
> +	zynqmp_phy: phy@fd400000 {
> +		compatible = "xlnx,zynqmp-psgtr-v1.1";
> +		status = "okay";
> +		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
> +		reg-names = "serdes", "siou";
> +
> +		lane0: lane@0 {
> +			#phy-cells = <4>;
> +		};
> +		lane1: lane@1 {
> +			#phy-cells = <4>;
> +		};
> +		lane2: lane@2 {
> +			#phy-cells = <4>;
> +		};
> +		lane3: lane@3 {
> +			#phy-cells = <4>;
> +		};
> +	};
> +
> +Specifying phy control of devices
> +=================================
> +
> +Device nodes should specify the configuration required in their "phys"
> +property, containing a phandle to the phy port node and a device type.
> +
> +phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_NUM LANE_FREQ>;
> +
> +PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
> +CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
> +			  or PHY_TYPE_DP or PHY_TYPE_SGMII
> +CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
> +				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
> +				PHY_TYPE_SATA : 0 or 1
> +				PHY_TYPE_USB  : 0 or 1
> +				PHY_TYPE_DP   : 0 or 1
> +				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
> +LANE_NUM                = Depends on which lane clock is used as ref clk, can be
> +			  0 or 1 or 2 or 3

I'm not really clear about what this is.

> +LANE_FREQ               = Frequency that controller can operate, can be any of
> +			  19.2Mhz,20Mhz,24Mhz,26Mhz,27Mhz,28.4Mhz,40Mhz,52Mhz,
> +			  100Mhz,108Mhz,125Mhz,135Mhz,150Mhz

This can't be implied by the mode/type? I wouldn't expect any frequency 
can be used for each mode.

> +
> +Example:
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +	usb@fe200000 {
> +		...
> +		phys	  = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
> +		...
> +	};
> +
> +	ahci@fd0c0000 {
> +		...
> +		phys	  = <&lane3 PHY_TYPE_SATA 1 1 125000000>;
> +		...
> +	};

What if you are doing multiple lanes for 1 device? That would be more 
useful 2nd example if that's supported.

> -- 
> 2.1.1
> 
