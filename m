Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeBEGNB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:13:01 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:47024 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeBEGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:42 -0500
X-Google-Smtp-Source: AH8x224kseughBvWp0PWK+Rbuoa5HBvcw9K1iP9iZY4iiY6GF2C2lQEU2ejIlr+8sV2/ZDaTuPsSaw==
Date: Mon, 5 Feb 2018 00:08:40 -0600
From: Rob Herring <robh@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: [PATCHv2] tlv320dac33: Add device tree bindings
Message-ID: <20180205060840.7yeld5sc67win2vd@rob-hp-laptop>
References: <20180129230539.GA18280@amd>
 <20180131190112.GA31608@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131190112.GA31608@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 08:01:12PM +0100, Pavel Machek wrote:
> 
> This adds device tree bindings for tlv320dac33.c.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> new file mode 100644
> index 0000000..7fdda95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> @@ -0,0 +1,32 @@
> +Texas Instruments - tlv320dac33 Codec module
> +
> +The tlv320dac33 serial control bus communicates through I2C protocols.
> +
> +Required properties:
> +
> +- compatible - "ti,tlv320dac33"
> +- reg - I2C slave address
> +
> +Optional properties:
> +
> +- reset-gpios - gpio pin to power the device, active low
> +
> +- interrupts       - The interrupt output from the device.
> +- interrupt-parent - The parent interrupt controller.
> +
> +- ti,keep-bclk 	- Keep the BCLK running in FIFO modes

space before tab ^

> +- ti,burst-bclkdiv - BCLK divider value in burst mode

What are valid values? What's the default?

> +
> +Example:
> +
> +tlv320dac33: audio-codec@19 {
> +	compatible = "ti,tlv320dac33";
> +	reg = <0x19>;
> +
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
> +	reset-gpios = <&gpio2 28 0>; /* gpio_60 */
> +
> +	ti,keep-bclk;
> +	ti,burst-bclkdiv = <3>;
> +};
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
