Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeD3O7z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:59:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39493 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754674AbeD3O7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:59:52 -0400
X-Google-Smtp-Source: AB8JxZrLQShyRQ1mTtkym74mUx/D0pdzjswbT/eRvGOCWd56S0GeyNRyejcQlST80Dh1VNJlAyg3uQ==
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode binding
Date: Mon, 30 Apr 2018 16:59:48 +0200
Message-ID: <2163655.V5BWH1NDss@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.13.0-39-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180430123036.GH5147@dell>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180430123036.GH5147@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3UExx2C030519

On Monday, April 30, 2018 1:30:36 PM CEST Lee Jones wrote:
> On Fri, 27 Apr 2018, Paweł Chmiel wrote:
> 
> > This patch adds devicetree bindings documentation for
> > battery charging controller as the subnode of MAX8998 PMIC.
> > It's based on current behavior of driver.
> > 
> > Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
> 
> Why is this here?  This patch doesn't look like a fix to me.
Hi
I though that if previous patch, which is adding missing device tree parsing into charger driver,
has fixes tag, this patch (which is documenting it), should also contain that tag.
If it shouldn't be here, i can fix this in v2.

Thanks for feedback (this is my second patchset for Linux Kernel)
> 
> > Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/max8998.txt | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> > index 23a3650ff2a2..f95610afb57f 100644
> > --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> > +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> > @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
> >  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
> >    for buck2 regulator that can be selected using dvs gpio.
> >  
> > +Charger: Configuration for battery charging controller should be added
> > +inside a child node named 'charger'.
> > +  Required properties:
> > +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
> > +    remain value set from bootloader or default value will be used.
> > +    Valid values: 0, 10 - 45
> > +
> > +  - max8998,charge-restart: Setup "Charge Restart Level". If value equals 0,
> > +    remain value set from bootloader or default value will be used.
> > +    Valid values: -1, 0, 100, 150, 200
> > +
> > +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value equals 0,
> > +    remain value set from bootloader or default value will be used.
> > +    Valid values: -1, 0, 5, 6, 7
> > +
> >  Regulators: All the regulators of MAX8998 to be instantiated shall be
> >  listed in a child node named 'regulators'. Each regulator is represented
> >  by a child node of the 'regulators' node.
> > @@ -99,6 +114,13 @@ Example:
> >  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
> >  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
> >  
> > +		/* Charger configuration */
> > +		charger {
> > +			max8998,charge-eoc = <0>;
> > +			max8998,charge-restart = <(-1)>;
> > +			max8998,charge-timeout = <7>;
> > +		};
> > +
> >  		/* Regulators to instantiate */
> >  		regulators {
> >  			ldo2_reg: LDO2 {
> 
> 
