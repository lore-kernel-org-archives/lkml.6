Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AIpwx4/pfuT7c+6havF2MQ2RMbkXQk88r8z1NZu4fnhcN0qyO/9PNasTbYcefxfppd/pE5uLP8Jr
ARC-Seal: i=1; a=rsa-sha256; t=1524154087; cv=none;
        d=google.com; s=arc-20160816;
        b=kWH/LbU3/eMGuuNGyTqJp+ZI0wDrw/3W8yecBdvh3QIWkAXn7Htn8ndf6Hs4nlI2fO
         f3inP+aesewkmd1L/aGUwl6OL8yX4IUxxy7iVZ22gj0Cp9CKfu+9njlisNgsE60yeoKO
         jlD/Be4ePLePTCM4F7Dm5QqHb/jObnATY2fCRAnQ1tZMwbdgzT9L0/6cOLnKCdlrHTKZ
         0JJGdQfmBsBZQYhwvOeSPYRfZrFkw1ityBjhwAJsxly0ha/JJeZbJ+KCDKkXiPds7Dlf
         +XiN/p/dWdjv6X/6kotJblX1odHBC6d1trIBHPGDfr4vjdILSacnkcUjt5HbbwJKMYjL
         XFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=yHWsX5oZRz/8Tb7GguR6vCd2JUvntecoOj+xJKJ3np0=;
        b=cpA5qM5FKw136yRvcwdCOweFU2N+AFhm+e5TfY5yUNIelLAevcuPaZisMzGu3liNTA
         If+KtlhOcdXOVuej0WYAiGRHtCfv/NtvY7y4ZDD3Atxnw6KIA3uu/cdqp2Taz2nR79zu
         lNrBEAAfpEgwY8ClAddss/Rtu3hze+txtMcEEof88gyuEmYpl/WVQN6/sPy/vo6WJzQB
         cF5RnekuxwguqYseO3TS9WP2lXWjsSxQWgqqaQgAaNkoWZAVJy21/f1wC0lHEE5rfV/q
         L483/9zixbBrm7etL1KkI8G672yjZ5Dxu0HnzDkyVlySrFLf4oTmO9ttiMKF4+LAI4Do
         vEgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64303217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <1524151019-82823-4-git-send-email-phil@raspberrypi.org>
References: <1524151019-82823-1-git-send-email-phil@raspberrypi.org> <1524151019-82823-4-git-send-email-phil@raspberrypi.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 19 Apr 2018 11:07:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+VyusAGtTPAF6f-t74GtVKnBcEAFQCtEq2ZQZBLzcTFw@mail.gmail.com>
Message-ID: <CAL_Jsq+VyusAGtTPAF6f-t74GtVKnBcEAFQCtEq2ZQZBLzcTFw@mail.gmail.com>
Subject: Re: [PATCH resend v3 3/3] dt-bindings: Document the DT bindings for lan78xx
To: Phil Elwell <phil@raspberrypi.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Mark Rutland <mark.rutland@arm.com>,
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598185373794294157?=
X-GMAIL-MSGID: =?utf-8?q?1598191397025626599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 10:16 AM, Phil Elwell <phil@raspberrypi.org> wrote:
> The Microchip LAN78XX family of devices are Ethernet controllers with
> a USB interface. Despite being discoverable devices it can be useful to
> be able to configure them from Device Tree, particularly in low-cost
> applications without an EEPROM or programmed OTP.
>
> Document the supported properties in a bindings file.
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> ---
>  .../devicetree/bindings/net/microchip,lan78xx.txt  | 54 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
> new file mode 100644
> index 0000000..a5d701b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
> @@ -0,0 +1,54 @@
> +Microchip LAN78xx Gigabit Ethernet controller
> +
> +The LAN78XX devices are usually configured by programming their OTP or with
> +an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
> +The Device Tree properties, if present, override the OTP and EEPROM.
> +
> +Required properties:
> +- compatible: Should be one of "usb424,7800", "usb424,7801" or "usb424,7850".
> +
> +Optional properties:
> +- local-mac-address:   see ethernet.txt
> +- mac-address:         see ethernet.txt
> +
> +Optional properties of the embedded PHY:
> +- microchip,led-modes: a 0..4 element vector, with each element configuring
> +  the operating mode of an LED. Omitted LEDs are turned off. Allowed values
> +  are defined in "include/dt-bindings/net/microchip-lan78xx.h".
> +
> +Example:
> +
> +/* Based on the configuration for a Raspberry Pi 3 B+ */
> +&usb {
> +       usb1@1 {

Same comments as in the dts file:

usb-port@1

> +               compatible = "usb424,2514";
> +               reg = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               usb1_1@1 {

usb-port@1

> +                       compatible = "usb424,2514";
> +                       reg = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       ethernet: usbether@1 {

ethernet@1

> +                               compatible = "usb424,7800";
> +                               reg = <1>;
> +                               local-mac-address = [ 00 11 22 33 44 55 ];
> +
> +                               mdio {
> +                                       #address-cells = <0x1>;
> +                                       #size-cells = <0x0>;
> +                                       eth_phy: ethernet-phy@1 {
> +                                               reg = <1>;
> +                                               microchip,led-modes = <
> +                                                       LAN78XX_LINK_1000_ACTIVITY
> +                                                       LAN78XX_LINK_10_100_ACTIVITY
> +                                               >;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23735d9..91cb961 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14572,6 +14572,7 @@ M:      Woojung Huh <woojung.huh@microchip.com>
>  M:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>  F:     drivers/net/usb/lan78xx.*
>  F:     include/dt-bindings/net/microchip-lan78xx.h
>
> --
> 2.7.4
>
