Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AIpwx48X0VQpq4um7atD3P03Vgg19e5n7TGaqRccqy81eBYFe5SSy3JGgVwDYfwhxisBRuI5t4od
ARC-Seal: i=1; a=rsa-sha256; t=1524680748; cv=none;
        d=google.com; s=arc-20160816;
        b=QmTe2w0pDhfV7a012NxZZ+8JFKOPXmBUQGRc2A/MjgvN14PZvQfyCggvMYjauKTuoh
         7qKZTSNvXcCUEnHWJ2Ka+Hs7Ryg7eW9yyzGCweLzJtHxDklIdowoh0NRJeZiEWtBGkOk
         WZvn+02bfRLk1v6MN7f0u6ESUvvKMmdzh3uLw4hVz2Q7MfDtxyjlE/gc1AcaqIrXkP+3
         MZgECCoHWPQSRGGyXeaEeuTjSiI+o4MgMWiSPA5P//hZDoWXycIWoU83n8qTDXPUt7aX
         sTj5TQXfgtoIT/vcqxMOeF/m6fzHnryWekJjt6+b+/IXHLiJJsI23ID/vYtnAJdNpwgk
         dFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=HbgTeYZMgT1BW2NyQfYOK1Y6Lppxa8rGpM0NMIMhZKg=;
        b=lBCBhT71mCYNPDiwaJlq/noZH3aGH51zMoJPiaetkEWNdQdC8GFxTRPJWfKI21RSsp
         Tr0AF2kAFcEV2/5leveAlo6JDjdAUTMzDQsls2HzrQUS8qcl+HCiV/1sxpoyfdZR64QZ
         koe2PF6GdDZuXxqUEqepx1uStWyte3SwIGp/TIBXiOMdW0Z/4LXhADL9V/d1C3fGhRUD
         WHnaRH0i6/yo8xHwognJctMh/mQ2xJDGGhPGmdVQ/J3RC07+Az0dJLAmD5C8+DaD+4Np
         h3i1HDATPrtfLPfvqHIef2Ol6ft667caw9SBv4K8jRxpUokLcmJ202ZtXMB7r5t20R8x
         nrIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D42217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180424163458.11947-7-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org> <20180424163458.11947-7-johan@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 25 Apr 2018 13:25:26 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nj9P5z=Ao=UbS-AKy+qeM98EFJiHmYgoniD_4N3Hr4w@mail.gmail.com>
Message-ID: <CAL_Jsq+nj9P5z=Ao=UbS-AKy+qeM98EFJiHmYgoniD_4N3Hr4w@mail.gmail.com>
Subject: Re: [PATCH 6/7] dt-bindings: gnss: add sirfstar binding
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647065272659964?=
X-GMAIL-MSGID: =?utf-8?q?1598743640315478976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 11:34 AM, Johan Hovold <johan@kernel.org> wrote:
> Add binding for SiRFstar-based GNSS receivers.
>
> Note that while four compatible-strings are initially added representing
> devices which differ in which I/O interfaces they support, they
> otherwise essentially share the same feature set.
>
> Pin and supply names (and some recommended timings) vary slightly, but
> the binding recommends using a common set of names.
>
> Note that the wakeup gpio is not intended to be as a wakeup source, but
> rather to detect the current power state of the device (active or
> hibernate).
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  .../devicetree/bindings/gnss/sirfstar.txt     | 38 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  3 ++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt

One nit below, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> new file mode 100644
> index 000000000000..5e6a02aec49a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> @@ -0,0 +1,38 @@
> +SiRFstar-based GNSS Receiver DT binding
> +
> +SiRFstar chipsets are used in GNSS-receiver modules produced by several
> +vendors and can use UART, SPI or I2C interfaces.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required Properties:
> +
> +- compatible   : Must be one of
> +
> +                       "fastrax,uc430"
> +                       "linx,r4"
> +                       "wi2wi,w2sg0008i"
> +                       "wi2wi,w2sg0084i"
> +
> +- vcc-supply   : Main voltage regulator (3V3_IN, VDD, VCC)
> +
> +Optional Properties:
> +
> +- enable-gpios : GPIO used to power on and off device (ON_OFF)
> +- wakeup-gpios : GPIO used to determine device power state (WAKEUP, RFPWRUP)
> +- timepulse-gpios      : Timepulse (e.g 1PPS) GPIO (1PPS, TM)
> +
> +Example:
> +
> +serial@1234 {
> +       compatible = "ns16550a";
> +
> +       gnss {
> +               compatible = "wi2wi,w2sg0084i";
> +
> +               vcc-supply = <&gnss_reg>;
> +               enable-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +               wakeup-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> +       };
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2128dfdf73f1..ddd81c82082d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -120,6 +120,7 @@ excito      Excito
>  ezchip EZchip Semiconductor
>  fairphone      Fairphone B.V.
>  faraday        Faraday Technology Corporation
> +fastrax        Fastrax Oy
>  fcs    Fairchild Semiconductor
>  firefly        Firefly
>  focaltech      FocalTech Systems Co.,Ltd
> @@ -197,6 +198,7 @@ licheepi    Lichee Pi
>  linaro Linaro Limited
>  linksys        Belkin International, Inc. (Linksys)
>  linux  Linux-specific binding
> +linx   Linx Technologies
>  lltc   Linear Technology Corporation
>  lsi    LSI Corp. (LSI Logic)
>  lwn    Liebherr-Werk Nenzing GmbH
> @@ -390,6 +392,7 @@ vivante     Vivante Corporation
>  vocore VoCore Studio
>  voipac Voipac Technologies s.r.o.
>  vot    Vision Optical Technology Co., Ltd.
> +wi2wi  Wi2Wi

Wrong spot.

>  wd     Western Digital Corp.
>  wetek  WeTek Electronics, limited.
>  wexler Wexler
> --
> 2.17.0
>
