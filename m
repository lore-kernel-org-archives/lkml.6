Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4EFC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C671D20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C671D20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJaBiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:38:12 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:49903 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeJaBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:38:12 -0400
Received: from [109.168.11.45] (port=36334 helo=[192.168.101.125])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1gHX7S-00ASpD-0N; Tue, 30 Oct 2018 17:43:54 +0100
Subject: Re: [PATCH 2/7] dt-bindings: mfd: ds90ux9xx: add description of TI
 DS90Ux9xx I2C bridge
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-3-vz@mleia.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <b9a617da-1712-2d28-d25c-e3c413a4e9f0@lucaceresoli.net>
Date:   Tue, 30 Oct 2018 17:43:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181008211205.2900-3-vz@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 08/10/18 23:12, Vladimir Zapolskiy wrote:
> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> 
> TI DS90Ux9xx de-/serializers are capable to route I2C messages to
> I2C slave devices connected to a remote de-/serializer in a pair,
> the change adds description of device tree bindings of the subcontroller
> to configure and enable this functionality.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  .../bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt
> new file mode 100644
> index 000000000000..4169e382073a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt
> @@ -0,0 +1,61 @@
> +TI DS90Ux9xx de-/serializer I2C bridge subcontroller
> +
> +Required properties:
> +- compatible: Must contain a generic "ti,ds90ux9xx-i2c-bridge" value and
> +	may contain one more specific value from the list:
> +	"ti,ds90ux925-i2c-bridge",
> +	"ti,ds90ux926-i2c-bridge",
> +	"ti,ds90ux927-i2c-bridge",
> +	"ti,ds90ux928-i2c-bridge",
> +	"ti,ds90ux940-i2c-bridge".
> +
> +Required properties of a de-/serializer device connected to a local I2C bus:
> +- ti,i2c-bridges: List of phandles to remote de-/serializer devices with
> +	two arguments: id of a local de-/serializer FPD link and an assigned
> +	I2C address of a remote de-/serializer to be accessed on a local
> +	I2C bus.
> +
> +Optional properties of a de-/serializer device connected to a local I2C bus:
> +- ti,i2c-bridge-maps: List of 3-cell values:
> +	- the first argument is id of a local de-/serializer FPD link,
> +	- the second argument is an I2C address of a device connected to
> +	  a remote de-/serializer IC,
> +	- the third argument is an I2C address of the remote I2C device
> +	  for access on a local I2C bus.

BTW I usually use names "remove slave" address and "alias" for bullets 2
and 3. These are the names from the datasheets, and are clearer IMO.

Now to the big stuff.

I find a static map in the "local" chip DT node is a limit. You might
have to support multiple models of remote device, where you'll know the
model only when after it gets connected. Think Beaglebone capes, but
over FPD-Link 3. This scenario opens several issues, but specifically
for I2C address mapping I addressed it by adding in the "local" chip's
DT node a pool of I2C aliases it can use. The DT author is responsible
to pick addresses that are not used on the same I2C bus, which cannot be
done at runtime reliably.

Here's my current draft on a dual/quad port deserializer:

&i2c0 {
    serializer@3d {
        reg = <0x3d>;
        ...

        /* Guaranteed not physically present on i2c0 */
        i2c-alias-pool = /bits/ 8 <0x20 0x21 0x22 0x23 0x24 0x25>;

        rxports {
            #address-cells = <1>;
            #size-cells = <0>;

            rxport@0 {
                reg = <0>;
                remote-i2c-bus { /* The proxied I2C bus on rxport 0 */
                    #address-cells = <1>;
                    #size-cells = <0>;

                    eeprom@51 {
                        reg = <0x51>;
                        compatible = "at,24c02";
                    };
                };

            rxport@1 {
                reg = <1>;
                remote-i2c-bus { /* The proxied I2C bus on rxport 1 */
                    #address-cells = <1>;
                    #size-cells = <0>;

                    eeprom@51 {
                        reg = <0x51>;
                        compatible = "at,24c02";
                    };
                };
            };
        };
    };
};

At probe time the serializer driver instantiates one new i2c_adapter for
each rxport. Any remote device is added (removed) to that adapter, then
the driver finds an available alias and maps (unmaps) it. The
transactions are handled in a way similar to i2c-mux, i.e. the ds90*
i2c_adapter has a master_xfer callback that changes the remote slave
address to the corresponding alias, then calls parent->algo->master_xfer().

Note how both eeproms in the example have the same physical address.
They will be given two different aliases.

> +- ti,i2c-bridge-auto-ack: Enables AUTO ACK mode.

It this useful other than for debugging? And, as Laurent noted, this
should not be in DT: it doesn't describe the hardware.

> +- ti,i2c-bridge-pass-all: Enables PASS ALL mode, remote I2C slave devices
> +	are accessible on a local (host) I2C bus without I2C address
> +	remappings.

It should be clear from the DT docs that either ti,i2c-bridge-pass-all
is enabled or the alias map/pool is used, but not both.

Bye,
-- 
Luca
