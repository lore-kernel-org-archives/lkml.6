Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbeEAOnU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:43:20 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35747 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbeEAOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:43:17 -0400
X-Google-Smtp-Source: AB8JxZqR54Je/bzXRH+OwIprC4exHqWQUHziMb2gStbMthAmXRuPdyIlffNYtY/b8tgmKqRukpcDoA==
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode binding
Date: Tue, 01 May 2018 16:43:07 +0200
Message-ID: <2089055.mctyXeETjz@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.13.0-39-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180501124540.3icpjevaxp44ew2e@earth.universe>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180501124540.3icpjevaxp44ew2e@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41EhRng019091

On Tuesday, May 1, 2018 2:45:40 PM CEST Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Apr 27, 2018 at 06:03:02PM +0200, Paweł Chmiel wrote:
> > This patch adds devicetree bindings documentation for
> > battery charging controller as the subnode of MAX8998 PMIC.
> > It's based on current behavior of driver.
> > 
> > Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
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
> 
> What are those values? seconds?
> 
Honestly i don't know. I've just documented values accepted currently by charger driver,
so we can use it from devicetree.
I couldn't find any max8998 datasheet with this information (units, possible values etc for those properties).

If this is not acceptable, i can drop this patch.

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
