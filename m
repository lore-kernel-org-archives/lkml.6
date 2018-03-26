Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeCZWa4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:30:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38202 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbeCZWY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:26 -0400
X-Google-Smtp-Source: AG47ELtI5derd1yBBSVMuFwrm3Ky2dpa5J1E4EheHsrja6+4MEGCGK6eu9YXDd0R/AjbphI8+owqXg==
Date: Mon, 26 Mar 2018 17:24:25 -0500
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Add binding for RAVE SP EEPROM
 driver
Message-ID: <20180326222424.7vr2gmwwezqhiy6m@rob-hp-laptop>
References: <20180321134710.29757-1-andrew.smirnov@gmail.com>
 <20180321134710.29757-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321134710.29757-2-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 06:47:09AM -0700, Andrey Smirnov wrote:
> Add Device Tree bindings for RAVE SP EEPROM driver - an MFD cell of
> parent RAVE SP driver (documented in
> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).

I'd prefer to get all the child nodes at once rather than as you 
upstream the drivers. IOW, please completely describe the device. Then I 
may have opinions on whether you need these child nodes or not. 


> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Aleksander Morgado <aleksander@aleksander.es>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/nvmem/zii,rave-sp-eeprom.txt          | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
> new file mode 100644
> index 000000000000..556abfa70524
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
> @@ -0,0 +1,23 @@
> +Zodiac Inflight Innovations RAVE EEPROM Bindings
> +
> +RAVE SP EEPROM device is a "MFD cell" device exposing physical EEPROM
> +attached to RAVE Supervisory Processor. It is expected that its Device
> +Tree node is specified as a child of the node corresponding to the
> +parent RAVE SP device (as documented in
> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
> +
> +Required properties:
> +
> +- compatible: Should be "zii,rave-sp-eeprom"
> +
> +Example:
> +
> +	rave-sp {
> +		compatible = "zii,rave-sp-rdu1";
> +		current-speed = <38400>;
> +
> +		dds-eeprom {
> +			compatible = "zii,rave-sp-eeprom";
> +			reg = <0xA3 0x2000>;

Child nodes? #nvmem-cells? I assume you have some data in this you need. 
If not, you don't really need a child node here.

Rob
