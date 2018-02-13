Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935381AbeBMN3j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:29:39 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:42429 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935174AbeBMN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:29:35 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: media: adv7604: Add support for i2c_new_secondary_device
Date: Tue, 13 Feb 2018 15:30:06 +0200
Message-ID: <52386641.uAENE5yG1n@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <e4d4e6ab-2f4b-27c3-f1ee-916e9bbad5ab@ideasonboard.com>
References: <1518473273-6333-1-git-send-email-kbingham@kernel.org> <84376496.fPaZ5qpN3E@avalon> <e4d4e6ab-2f4b-27c3-f1ee-916e9bbad5ab@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1DDTipE030171

Hi Kieran,

On Tuesday, 13 February 2018 15:14:43 EET Kieran Bingham wrote:
> On 13/02/18 12:06, Laurent Pinchart wrote:
> > On Tuesday, 13 February 2018 00:07:49 EET Kieran Bingham wrote:
> >> From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
> >> 
> >> The ADV7604 has thirteen 256-byte maps that can be accessed via the main
> >> I²C ports. Each map has it own I²C address and acts as a standard slave
> >> device on the I²C bus.
> >> 
> >> Extend the device tree node bindings to be able to override the default
> >> addresses so that address conflicts with other devices on the same bus
> >> may be resolved at the board description level.
> >> 
> >> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
> >> [Kieran: Re-adapted for mainline]
> >> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > Nitpicking, I might not mention i2c_new_secondary_device in the subject,
> > as this is a DT bindings change. I don't mind too much though, as long as
> > the bindings themselves don't contain Linux-specific information, and they
> > don't, so
> 
> How about: ... adv7604: Extend bindings to allow specifying slave map
> addresses

Sounds good to me.

> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Collected, thanks.
> 
> --
> Kieran
> 
> >> ---
> >> 
> >> Based upon the original posting :
> >>   https://lkml.org/lkml/2014/10/22/469
> >> 
> >> v2:
> >>  - DT Binding update separated from code change
> >>  - Minor reword to commit message to account for DT only change.
> >>  - Collected Rob's RB tag.
> >> 
> >> v3:
> >>  - Split map register addresses into individual declarations.
> >>  
> >>  .../devicetree/bindings/media/i2c/adv7604.txt          | 18
> >> 
> >> ++++++++++++++++-- 1 file changed, 16 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> >> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt index
> >> 9cbd92eb5d05..ebb5f070c05b 100644
> >> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> >> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> >> 
> >> @@ -13,7 +13,11 @@ Required Properties:
> >>      - "adi,adv7611" for the ADV7611
> >>      - "adi,adv7612" for the ADV7612
> >> 
> >> -  - reg: I2C slave address
> >> +  - reg: I2C slave addresses
> >> +    The ADV76xx has up to thirteen 256-byte maps that can be accessed
> >> via
> >> the +    main I²C ports. Each map has it own I²C address and acts as a
> >> standard +    slave device on the I²C bus. The main address is mandatory,
> >> others are +    optional and revert to defaults if not specified.
> >> 
> >>    - hpd-gpios: References to the GPIOs that control the HDMI hot-plug
> >>    
> >>      detection pins, one per HDMI input. The active flag indicates the
> >>      GPIO
> >> 
> >> @@ -35,6 +39,11 @@ Optional Properties:
> >>    - reset-gpios: Reference to the GPIO connected to the device's reset
> >>    pin.
> >> 
> >> - default-input: Select which input is selected after reset.
> >> +  - reg-names : Names of maps with programmable addresses.
> >> +		It can contain any map needing a non-default address.
> >> +		Possible maps names are :
> >> +		  "main", "avlink", "cec", "infoframe", "esdp", "dpp", "afe",
> >> +		  "rep", "edid", "hdmi", "test", "cp", "vdp"
> >> 
> >>  Optional Endpoint Properties:
> >> @@ -52,7 +61,12 @@ Example:
> >>  	hdmi_receiver@4c {
> >>  	
> >>  		compatible = "adi,adv7611";
> >> 
> >> -		reg = <0x4c>;
> >> +		/*
> >> +		 * The edid page will be accessible @ 0x66 on the i2c bus. All
> >> +		 * other maps will retain their default addresses.
> >> +		 */
> >> +		reg = <0x4c>, <0x66>;
> >> +		reg-names "main", "edid";
> >> 
> >>  		reset-gpios = <&ioexp 0 GPIO_ACTIVE_LOW>;
> >>  		hpd-gpios = <&ioexp 2 GPIO_ACTIVE_HIGH>;

-- 
Regards,

Laurent Pinchart
