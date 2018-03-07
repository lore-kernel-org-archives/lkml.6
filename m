Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AG47ELuS4Bz3u6K7PC5saWYBn/oryQVulXeq1GVHUx5wekal/t2M3Nt8g/qZEDm0S2rTQRrYPfaS
ARC-Seal: i=1; a=rsa-sha256; t=1520452851; cv=none;
        d=google.com; s=arc-20160816;
        b=s20ENyv7/W8eX4V3LbU/1QFXbJ5f2t81pXrSjqT5kmiGO+ypoQ1jS9s7/WtQR1yLCZ
         VrjOAiRoXYyTsf7r/y5y9xuXSQ8L9hwhyeXD0au/lY81AzG0G5eL+f4Q0QUvcsLhloce
         rpgwxQqybwBLk6l6DyzsUbQ1q25rSt16vOau1P/5ZQ+I/st6vBhCQnzzEFSoxwcFfEmP
         DFITEjZFD2UU88iFYyLu4KzN38xVKy44jNvHbr1oTQznAMM4kME6jUj9d1cDHH1czgyz
         fyg/KY9lNnOFJF4PPgyTMbdvVtnvnb3ZQAJljEpMLdrbs17gCFBtVHcc7H1Ob/IWLRlV
         rMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=MU0S9tLqETEUTlDGVtpPb1Zi4Y9PTl2r1PO/qm7lDFg=;
        b=RIBPB2TmUAkx65J+eVbcMQHAgvO1vVNnCr/IJHalqnJA2ixhw+vyHWv1eHK6g7QSGP
         1FsL2HAOeWgjtgIoe3R8z3wxbIqhlvK4fZhfWWl0wKTT4gWfNYll98MNoccv49lEjEuc
         YUT1WcctWe6q5a8mpTJQCR2LQ3xFmpV9EGQSzAYCXnvdtP4iJ198fAe+S7PXA8LUOAA2
         I7RzCUUhhzMlhoX5kF8ZpfPJtwSGj+6IHZADszvvgzKjUY+b0BYJBbOJD9ouArbA0ktS
         Q0P1QBTgADRNlhphSYeaJ/zs5Ydx4Ztqz9Qe2CucFqk9n+2MZdzvF3VspN2Pm7hMr6Vc
         bVpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79902178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180307185716.17449-3-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net> <20180307185716.17449-3-eric@anholt.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 7 Mar 2018 14:00:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1-9-RGfzPimYwCokEZx1vef_PX5rkp-c8s6fUchg=ag@mail.gmail.com>
Message-ID: <CAL_Jsq+1-9-RGfzPimYwCokEZx1vef_PX5rkp-c8s6fUchg=ag@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services.
To: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306376933935522?=
X-GMAIL-MSGID: =?utf-8?q?1594310368616572265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 12:57 PM, Eric Anholt <eric@anholt.net> wrote:
> The VCHIQ communication channel can be provided by BCM283x and Capri
> SoCs, to communicate with the VPU-side OS services.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: dropped firmware property, added cache-line-size.
>
>  .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> new file mode 100644
> index 000000000000..cdef4abc5e47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> @@ -0,0 +1,28 @@
> +Broadcom VCHIQ firmware services
> +
> +Required properties:
> +
> +- compatible:  Should be "brcm,bcm2835-vchiq"
> +- reg:         Physical base address and length of the doorbell register pair
> +- interrupts:  The interrupt number
> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Optional properties:
> +
> +- cache-line-size:
> +               Size of L2 cache lines.  The VPU firmware detects
> +                 this property and overrides it with the actual L2
> +                 cache line size it's using when loading the
> +                 device-tree.  Determines the required alignment of
> +                 offsets/sizes of VCHIQ pagelists.  If missing, the
> +                 firmware assumes an older kernel using 32-byte
> +                 alignment.

How is this a VCHIQ property? This is a standard property for cache
nodes, but this is not a cache node.

Is it really a problem to just use a fixed maximum alignment? That
seems to be good enough for all the rest of the kernel.

> +
> +Example:
> +
> +vchiq@7e00b840 {

mailbox@...

> +       compatible = "brcm,bcm2835-vchiq";
> +       reg = <0x7e00b840 0xf>;
> +       interrupts = <0 2>;
> +       cache-line-size: <32>;
> +};
> --
> 2.16.2
>
