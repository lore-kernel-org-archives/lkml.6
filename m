Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AG47ELtzcQRa4fHU2YiJa8DMFlbz3rad9nZeUXfXdC3vRZxeohqpxbFkIKsYRFSyN9DWxLPPtkYo
ARC-Seal: i=1; a=rsa-sha256; t=1520283107; cv=none;
        d=google.com; s=arc-20160816;
        b=fICtMaJ4GIfNC7WlG+EI8UaBCdU2yyBhoXkTkEQUiFPzsUzNC3SzpQJsn5dLRzlWaV
         bZQaSUcEFZfcPI7XPNK19kHw/Fl42Zfx+93Ld08qt1uchqXwxXTp1Px3xBNjo11CuYp3
         XcKl2EEqMjxT6mIFq6yYL3b59r6eZv1G3DUUIDfMJt0xO4bzdEAJMt37rbP3R4DBFjzM
         Sa2FOocP9C/xN4Hf5i7R9S+3FtAPrWaD71SZELDiY0f1m8cjbK5xOlKgQxrtUoj6nsLC
         Tdky0RNH4p93gjX+DyxgtuCDCas0IYgJAoYnwP7sqJDJprKj6WdDRUB6oRgPsyEVO347
         ejwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=roef3U5VPi8Y6+TOK9/PZnbceCDoIjVGtSqjTlsxUB4=;
        b=v6/fdAmvlgdNgIYtzghTOMqVWwztTOhOm1QxgZIBc1gKWN1xEY6Xxnul8B0zpjhrEn
         3exZh8KDoJUVbFP/nMACXK4Ky5uWLbzYpFfIwYAWI85eWLjqWX/lSgmVTnwbHk50DYRT
         c8Qc11wiyuYY7o7PmS++8z8hSr6bJX+ACPN69CZE1Yhxb4OZ70vI3oPhjm9tk8Qa23xj
         bIGrJZeNS/AyQd7el+xfL6dUgP0ycyxdaxov79nvmreN7K4WLsDfKreZMn+EbOncREFC
         VYjsFmXCL2R2AG/ShwY/wh+SXtDrDBHpiycO7wLY7R/5NWLfFCeZnhT1ul8Dk5YbyvPb
         F7wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51F42177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180305202806.21219-4-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net> <20180305202806.21219-4-eric@anholt.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 5 Mar 2018 14:51:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rEbghtLib4B-eQSLRtdODqeKVdXFJrPjb-JJbJgdpiA@mail.gmail.com>
Message-ID: <CAL_Jsq+rEbghtLib4B-eQSLRtdODqeKVdXFJrPjb-JJbJgdpiA@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: soc: Add a binding for the Broadcom VCHI services.
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
X-GMAIL-THRID: =?utf-8?q?1594130897690298629?=
X-GMAIL-MSGID: =?utf-8?q?1594132379050696872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 2:28 PM, Eric Anholt <eric@anholt.net> wrote:
> The VCHI communication channel can be provided by BCM283x and Capri

VCHI or VCHIQ?

> SoCs, to communicate with the VPU-side OS services.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> new file mode 100644
> index 000000000000..4055a8977f3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> @@ -0,0 +1,18 @@
> +Broadcom VCHIQ firmware services
> +
> +Required properties:
> +
> +- compatible:  Should be "brcm,bcm2835-vchiq"
> +- reg:         Physical base address and length of the doorbell register pair
> +- interrupts:  The interrupt number
> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +- firmware:    Reference to the RPi firmware device node

There's only one, just get it by compatible or path.

> +
> +Example:
> +
> +vchi@7e00b840 {
> +       compatible = "brcm,bcm2835-vchiq";
> +       reg = <0x7e00b840 0xf>;
> +       interrupts = <0 2>;
> +       firmware = <&firmware>;
> +};
> --
> 2.16.2
>
