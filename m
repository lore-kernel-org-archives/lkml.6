Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeDZNqi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754847AbeDZNqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:46:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3B421836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx4/r89DB4CnWTFdrekDVfQP2wX/EAvoWCLhvNdhB22lAcu0JJO9C54UNKzpY8v04dhadCsPzwtdUiIygp7Z8JbE=
MIME-Version: 1.0
In-Reply-To: <95F51F4B902CAC40AF459205F6322F01B83109E5B1@BMK019S01.emtrion.local>
References: <20171220134710.64479-2-jan.tuerk@emtrion.com> <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180420125108.14197-6-jan.tuerk@emtrion.com> <20180423084454.GZ25429@dragon>
 <95F51F4B902CAC40AF459205F6322F01B83109E5B1@BMK019S01.emtrion.local>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 26 Apr 2018 08:46:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ8TO+FadZraUNcCH6swTmwpWjdP5jV2JcoJT1Uf5Sw8g@mail.gmail.com>
Message-ID: <CAL_JsqJ8TO+FadZraUNcCH6swTmwpWjdP5jV2JcoJT1Uf5Sw8g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6 series
To: =?UTF-8?B?VMO8cmssIEphbg==?= <Jan.Tuerk@emtrion.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LinuxArmKernelMailingListe <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 3:32 AM, Türk, Jan <Jan.Tuerk@emtrion.de> wrote:
>> -----Ursprüngliche Nachricht-----
>> Von: Shawn Guo Gesendet: Montag, 23. April 2018 10:45
>> Re: [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6 series
>>
>> On Fri, Apr 20, 2018 at 02:50:52PM +0200, jan.tuerk@emtrion.com wrote:
>> > From: Jan Tuerk <jan.tuerk@emtrion.com>
>> >
>> > This patch adds support for the emtrion GmbH emCON-MX6 modules.
>> > They are available with imx.6 Solo, Dual-Lite, Dual and Quad equipped
>> > with Memory from 512MB to 2GB (configured by U-Boot).
>> >
>> > Our default developer-Kit ships with the Avari baseboard and the EDT
>> > ETM0700G0BDH6 Display (imx6[q|dl]-emcon-avari).
>> >
>> > The devicetree is split into the common part providing all module
>> > components and the basic support for all SoC versions
>> > (imx6qdl-emcon.dtsi) and parts which are i.mx6 S|DL and D|Q relevant.
>> > Finally the support for the avari baseboard in the developer-kit
>> > configuration is provided by the emcon-avari dts files.
>> >
>> > Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
>> > ---
>> >  Documentation/devicetree/bindings/arm/emtrion.txt |  13 +
>>
>> It's better to have a separate patch for bindings doc, which needs to be
>> acknowledged by DT maintainers.
>
> I can change that, but nobody complained in the first 2 revisions of the patch.

Well, sometimes I forget to mention what is step 1 in
Documentation/devicetree/bindings/submitting-patches.txt.

> Also I though having the documentation is required for merging new bindings?

Yes, so binding patches come first (step 3).

>> >  arch/arm/boot/dts/Makefile                        |   2 +
>> >  arch/arm/boot/dts/imx6dl-emcon-avari.dts          | 224 ++++++
>> >  arch/arm/boot/dts/imx6dl-emcon.dtsi               |  27 +
>> >  arch/arm/boot/dts/imx6q-emcon-avari.dts           | 224 ++++++
>> >  arch/arm/boot/dts/imx6q-emcon.dtsi                |  27 +
>> >  arch/arm/boot/dts/imx6qdl-emcon.dtsi              | 838
>> ++++++++++++++++++++++
>> >  7 files changed, 1355 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
>> >  create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
>> >  create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
>> >  create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
>> >  create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
>> >  create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

[...]

>> > +   };
>> > +
>> > +   boardID: pca8754a@3a {
>>
>> Please find a more generic node name for it.
>
> you mean boardID@3a?

No. "gpio@3a" as it is a gpio controller.

> This chip identifies the baseboard type for the bootloader.
>
>>
>> > +           compatible = "nxp,pca8574";
>> > +           reg = <0x3a>;
>> > +           gpio-controller;
>> > +           #gpio-cells = <1>;
>> > +   };
