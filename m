Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8092ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E73F214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ytaTz4oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E73F214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeIQRQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbeIQRQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:16:51 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBFB2214DC;
        Mon, 17 Sep 2018 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537184992;
        bh=hMUnOPDpZBaflHCBC3vF+dmSexZhP9Co+ss5gQ5G234=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ytaTz4oV56bZUOh9+9BLWfh99OXH+BLawSEhd+4wjoa72niDaVAz8u5KslZMVVAuy
         lSk66EXyh0lV0Jp9XEQQuSN8NUol7BU0ttrfFnvyfdv0VPjQdNcj8T0lIzu5SX3z3z
         u70C7jx6h9+sKqU5NLhlNypKZBQdsQl607p5SWLk=
Received: by mail-wr1-f50.google.com with SMTP id v17-v6so16958052wrr.9;
        Mon, 17 Sep 2018 04:49:51 -0700 (PDT)
X-Gm-Message-State: APzg51BtWrodTuZDRMZgyD58SY23oa7Kau+M1PNr8oKhOQ49/vxYv6Wd
        zZyzspKjeBevwA2NBED0Qq7dNLbHkcZQ4tGCje8=
X-Google-Smtp-Source: ANB0VdbSjpWzSmiXx95pIkI2EXlMCSYrO3o5f4VxyugPGghcZGtl+VuAocgBLlfz9HF+PMNGxPifyBq/fEQU34yrZJY=
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr18972811wra.100.1537184990330;
 Mon, 17 Sep 2018 04:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <20180807175741.GA30886@rob-hp-laptop> <24790346.rcfynqLzho@acerlaptop>
In-Reply-To: <24790346.rcfynqLzho@acerlaptop>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 17 Sep 2018 13:49:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeYt2EWcSpVbCZtoWA_bmF8egHW1EaUFe=YaboxLHbJvA@mail.gmail.com>
Message-ID: <CAJKOXPeYt2EWcSpVbCZtoWA_bmF8egHW1EaUFe=YaboxLHbJvA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: max8998: Add charger subnode binding
To:     pawel.mikolaj.chmiel@gmail.com
Cc:     robh@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 at 16:56, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> On Tuesday, August 7, 2018 11:57:42 AM CEST Rob Herring wrote:
> > On Tue, Jul 17, 2018 at 06:05:09PM +0200, Pawe=C5=82 Chmiel wrote:
> > > This patch adds devicetree bindings documentation for
> > > battery charging controller as the subnode of MAX8998 PMIC.
> > >
> > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > ---
> > > Changes from v2:
> > >   - Make charge-restart-level-microvolt optional.
> > >   - Make charge-timeout-hours optional.
> > >
> > > Changes from v1:
> > >   - Removed unneeded Fixes tag
> > >   - Correct description of all charger values
> > >   - Added missing property unit
> > > ---
> > >  Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++++++=
++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Docu=
mentation/devicetree/bindings/mfd/max8998.txt
> > > index 23a3650ff2a2..264040f4ad15 100644
> > > --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> > > @@ -50,6 +50,24 @@ Additional properties required if max8998,pmic-buc=
k2-dvs-gpio is defined:
> > >  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in mi=
crovolts
> > >    for buck2 regulator that can be selected using dvs gpio.
> > >
> > > +Charger: Configuration for battery charging controller should be add=
ed
> > > +inside a child node named 'charger'.
> > > +  Required properties:
> > > +  - max8998,charge-eoc-percent: Setup End of Charge Level.
> >
> > This should have a vendor prefix and max8998 is not a vendor. Don't
> > continue that pattern even if we already have some properties like that=
.
> >
> > These seem like perhaps they should be common charger properties.
> Where i could find such properties (or any other driver which is using th=
ose as an example) ?
> Looking at few existing drivers, most of them have custom properties (tha=
t's why i've followed the same pattern for max8998).

The common properties are now here:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bin=
dings/power/supply/battery.txt

The property "max8998,charge-eoc-percent" seems unusual - what does
"percent" mean in such case? Usually EOC should happen at 100% of
charge so what is the point to set it as 45%?

Have in mind that current driver is platform data only so you do not
have to maintain any backwards compatibility. If the driver now has
weird meaning of "eoc" in pdata, then you can change it. Also you do
not have to map the bindings one-to-one to existing platform data. If
needed you can translate them from something meaningful in DT to
values expected by driver.

Best regards,
Krzysztof
