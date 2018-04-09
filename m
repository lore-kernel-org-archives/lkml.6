Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523300249; cv=none;
        d=google.com; s=arc-20160816;
        b=pRkiV1qBKdwwtOcLw90IOpeCjwQWJ2BTbhXmIWQNqpvjRfV9K8mscFY7+Cp/qiMW8E
         n5DA0H5RyDSvATN4rGuncWTIfIEClYyUmK8rH7yqxndzDN6C1QexR+u37VsrbS76W2Pb
         VMPhtBGqXwGN0uisglqz58QTQkYs5pcFB6HIGNSqUV0XEUWb8lCS2u76GSZkGrRnEwu1
         oKABk/ZGmaWz2okEO/YEVuLHCwPcjIl4GXf+sZaPELK1gu7/eMIzKSfbbD/jjxspjl5p
         k1B1FvSHAc9DOvrtrEpWka9wa39gNLgUWmRfwyONctgElxbx6NgCdCt5Qnty3swlz7OW
         x33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OT3oa7OUIhHiDW3bxGafrmj6IbPKQ1uj86305gQEaBo=;
        b=NJv/Pj8SsQejAWFO5BJYmRayradd1FXiPvIHsV60XQxhIBDMp6alSBCii9GWTNP4Cx
         ICCZbkZ8gPpAfJTiwwYbAycpzNYi3d45fGN3Oi5ZpAuLJzhXYTFF56hU6s9UR8efJxHq
         C3S355s+3ginrO6JslFEXTv3TnIdsW0raIK/MenCoFA6QFfqH0+hETg/1s3lVqyPgEjP
         BxxkzXsWK7TTRsWLar7/6tHcvskW1qX6e2vhYvZlDQENI9WH/JTU1CmI478O23tvr3Su
         dmqDu6Aom1dH5sqlz831EGSEcC+Vdrh3LyBHBQtjLqnZtde+oNCpZThaPfTjWLOZ64TL
         V7wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4/oMKtx4TG4Z87G/83+wgVtMg5DLBA4sbP9xXVlvm7Vl90HTeq6oCe1VvD/EI4w0RQYy9Ow0w==
Date: Mon, 9 Apr 2018 13:57:27 -0500
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>, Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCHv2 1/3] dt-bindings: misc: achc: Make ezport
 distinguishable
Message-ID: <20180409185727.j4unhx5ig3fgm6ex@rob-hp-laptop>
References: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
 <20180327135259.30890-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327135259.30890-2-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596099171871027959?=
X-GMAIL-MSGID: =?utf-8?q?1597296082059929832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 03:52:57PM +0200, Sebastian Reichel wrote:
> This updates the GE ACHC binding, so that different compatible
> strings are used for the programming interface, which is the
> ezport interface from NXP MK20FN1M0VMD12 and the microcontroller's
> normal SPI interface.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/misc/ge-achc.txt | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Documentation/devicetree/bindings/misc/ge-achc.txt
> index 77df94d7a32f..6c6bd6568504 100644
> --- a/Documentation/devicetree/bindings/misc/ge-achc.txt
> +++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
> @@ -7,7 +7,13 @@ Note: This device does not expose the peripherals as USB devices.
>  
>  Required properties:
>  
> -- compatible : Should be "ge,achc"
> +- compatible : Should be
> +  "ge,achc" (normal interface)
> +  "ge,achc-ezport" (flashing interface)
> +
> +Required properties (flashing interface only):
> +
> +- reset-gpios: GPIO Specifier for the reset GPIO

Does the reset only affect the flashing interface and are the data pins 
shared? If not for both, then I think the correct thing to do here is 
just extend reg to support multiple values to represent multiple chip 
selects.

Rob
