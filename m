Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522103100; cv=none;
        d=google.com; s=arc-20160816;
        b=H0sngpKv/FQVEi7s41ksCarhFz7ARDZKKmgZvELuqheVnxtGQP6HJHZJJbt5aSijUv
         VAYvMXKyr9RaUwAM6ykp4dla722g1IVaRRLovLaDELAWK2B3KWAJ6+oRYy8PYlUjSF/e
         hLnZGUJpfSVR/LY2EIOWY8i3K6/mRR3+/+u/dyFzkUPhzk/M4g/gC7X3RxV0Fdg3P3t8
         lKSBe/XxE7e6DqRz7IjlYA+Lyul9/+2fJvX1wCn28j+tYNssUtgjEmyhSyA98o5Yj+qP
         JxsNq+GwWAVLX28E6z7cWfj5VBAhFOpu7To/iS8pS7+Oo1dEV+Opwpp9D+beebUzM60C
         yY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=B8hZ3Y/mgMEutXEFLyRJSVnTFfawATBS/W0bLZUIazI=;
        b=wtHEwEARH1v+CXjRJl/eAu3lOk05wiRMdQa/jsvBjJz8QVyaU6VCoMrgItFcsuwLAr
         LrRs87CCHQ7DrbKEyWOHNcN7jrr36Mboq//HHqqJkdC6NMedBGLKWHZlE490yAZZRn2r
         ZyfUk7hRIQCvfAIkEReiPdkHHBWdXV/boDETvQm9ut0c6++bGUCig+Kqjj8eMUba6HxL
         hv6Nu5gp9p74gDEZrlPEfB1gBxKVyQ9VZ+n6FQjnnjlTLnZq3+QbE3UvzNmTCcenb9wj
         TajTpbl59yLBSutVnSnzAgIXSHMubICjLodbeUK0mltLS1ffEfhW3rwzrYIuG4Q81rVf
         MYkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELudsv4MVf409JXOWWiNRnP5FiAxxLHlyI0zpuZOatXtBsTveTCcBT0iYai1CtW2WY0rhEdBTw==
Date: Mon, 26 Mar 2018 17:24:58 -0500
From: Rob Herring <robh@kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
Message-ID: <20180326071946.dtrhhxx3iwwymk73@rob-hp-laptop>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-6-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323110020.19080-6-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725932611927845?=
X-GMAIL-MSGID: =?utf-8?q?1596040780970432980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 12:00:14PM +0100, Boris Brezillon wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
> 
> Document this generic representation.

Mostly looks fine, a couple of clarifications below.

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Changes in v3:
> - Rename {i2c,i3c}-scl-frequency DT prop into {i2c,i3c}-scl-hz
> - Rework the way we expose the provisional ID and LVR information
> - Rename dynamic-address into assigned-address
> - Enforce the I3C master node name
> 
> Changes in v2:
> - Define how to describe I3C devices in the DT and when it should be
>   used. Note that the parsing of I3C devices is not yet implemented in
>   the framework. Will be added when someone really needs it.
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 140 ++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
> new file mode 100644
> index 000000000000..ed858228d26b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> @@ -0,0 +1,140 @@
> +Generic device tree bindings for I3C busses
> +===========================================
> +
> +This document describes generic bindings that should be used to describe I3C
> +busses in a device tree.
> +
> +Required properties
> +-------------------
> +
> +- #address-cells  - should be <3>. Read more about addresses below.
> +- #size-cells     - should be <0>.
> +- compatible      - name of the I3C master controller driving the I3C bus
> +
> +For other required properties e.g. to describe register sets,
> +clocks, etc. check the binding documentation of the specific driver.
> +The node describing an I3C bus should be named i3c-master.
> +
> +Optional properties
> +-------------------
> +
> +These properties may not be supported by all I3C master drivers. Each I3C
> +master bindings should specify which of them are supported.
> +
> +- i3c-scl-hz: frequency of the SCL signal used for I3C transfers.
> +	      When undefined the core sets it to 12.5MHz.
> +
> +- i2c-scl-hz: frequency of the SCL signal used for I2C transfers.
> +	      When undefined, the core looks at LVR (Legacy Virtual Register)
> +	      values of I2C devices described in the device tree to determine
> +	      the maximum I2C frequency.
> +
> +I2C devices
> +===========
> +
> +Each I2C device connected to the bus should be described in a subnode. All
> +properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> +valid here, but several new properties have been added.
> +
> +New constraint on existing properties:
> +--------------------------------------
> +- reg: contains 3 cells
> +  + first cell : still encoding the I2C address
> +
> +  + second cell: should have bit 31 set to 1 signify that this is an I2C
> +		 device. Bits 0 to 7 encode the I3C LVR (Legacy Virtual
> +		 Register):
> +
> +	bit[7:5]: I2C device index. Possible values
> +	* 0: I2C device has a 50 ns spike filter
> +	* 1: I2C device does not have a 50 ns spike filter but supports high
> +	     frequency on SCL
> +	* 2: I2C device does not have a 50 ns spike filter and is not tolerant
> +	     to high frequencies
> +	* 3-7: reserved
> +
> +	bit[4]: tell whether the device operates in FM (Fast Mode) or FM+ mode
> +	* 0: FM+ mode
> +	* 1: FM mode
> +
> +	bit[3:0]: device type
> +	* 0-15: reserved
> +
> +  + third cell: should be 0
> +
> +I3C devices
> +===========
> +
> +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> +are thus discoverable. So, by default, I3C devices do not have to be described
> +in the device tree.
> +This being said, one might want to attach extra resources to these devices,
> +and those resources may have to be described in the device tree, which in turn
> +means we have to describe I3C devices.
> +
> +Another use case for describing an I3C device in the device tree is when this
> +I3C device has a static address and we want to assign it a specific dynamic
> +address before the DAA takes place (so that other devices on the bus can't

static is I2C address and dynamic is an I3C address. That could be 
clearer throughout.

> +take this dynamic address).
> +
> +The I3C device should be names <device-type>@<static-address>,<i3c-pid>,

s/static-address/static-i2c-address/

> +where device-type is describing the type of device connected on the bus
> +(gpio-controller, sensor, ...).
> +
> +Required properties
> +-------------------
> +- reg: contains 3 cells
> +  + first cell : encodes the I2C address. Should be 0 if the device does not
> +		 have one (0 is not a valid I3C address).

Change here to "encodes the static I2C address". 

0 is not a valid I2C address?

> +
> +  + second and third cells: should encode the ProvisionalID. The second cell
> +			    contains the manufacturer ID left-shifted by 1.
> +			    The third cell contains ORing of the part ID
> +			    left-shifted by 16, the instance ID left-shifted
> +			    by 12 and the extra information. This encoding is
> +			    following the PID definition provided by the I3C
> +			    specification.
> +
> +Optional properties
> +-------------------
> +- assigned-address: dynamic address to be assigned to this device. This
> +		    property is only valid if the I3C device has a static
> +		    address (first cell of the reg property != 0).
> +
> +
> +Example:
> +
> +	i3c-master@d040000 {
> +		compatible = "cdns,i3c-master";
> +		clocks = <&coreclock>, <&i3csysclock>;
> +		clock-names = "pclk", "sysclk";
> +		interrupts = <3 0>;
> +		reg = <0x0d040000 0x1000>;
> +		#address-cells = <3>;
> +		#size-cells = <0>;
> +
> +		status = "okay";
> +		i2c-scl-frequency = <100000>;
> +
> +		/* I2C device. */
> +		nunchuk: nunchuk@52 {
> +			compatible = "nintendo,nunchuk";
> +			reg = <0x52 0x80000010 0x0>;
> +		};
> +
> +		/* I3C device with a static address. */
> +		thermal_sensor: sensor@68,39200144004 {
> +			reg = <0x68 0x392 0x144004>;
> +			assigned-address = <0xa>;
> +		};
> +
> +		/*
> +		 * I3C device without a static address but requiring resources
> +		 * described in the DT.
> +		 */
> +		sensor@0,39200154004 {
> +			reg = <0x0 0x392 0x154004>;
> +			clocks = <&clock_provider 0>;
> +		};
> +	};
> +
> -- 
> 2.14.1
> 
