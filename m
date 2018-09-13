Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C68C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9889920861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5MuehCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9889920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeIMUFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:05:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40250 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeIMUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:05:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so5065028lfi.7;
        Thu, 13 Sep 2018 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHC7jocNB5VwzVMuyx3gHStIv5oZcJrfTpisRkcD2zc=;
        b=e5MuehCGYsSpLexu3nvYxzxL+fTq2Eyw6yvGp8SwbI+8WCJi2zg8pHqobPKKMaPbZ/
         osZOPQpY/NON8r0zRRbKpv+Hf5i2743gjNMEzuGR5l9rSIPKncLnPSPwZ4A1peCuhmea
         iSKNMKUoEHi4+dAjXADY+jHoH9AIFxdvSqUbSYX/gbZEp6BxY9g1yLw7XvFSR+hSDTiS
         ODYvgK9Y7MSDwEvIT0sfbHexwRwtZ69vilV6/176S/Kf9JNdmn1V+kF8+a5zX9+7WNAn
         lEJmiu5+qlWWrzcnAxobv4jnyQ3m/+wegn7511NIQuz4fsQZNNw8pNarSUsEgNJo/7J3
         1QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZHC7jocNB5VwzVMuyx3gHStIv5oZcJrfTpisRkcD2zc=;
        b=eRbGUb9z4NlrUmyBNDvOAd8CelKNAoip57Ge8MxpiKJ4D7C2/IWJ89s+RzGzxUaY/z
         P38QiBL9WSJKL7fEADjn3fpqd9I8bxlLOvRuWvrpHsmo9jtOrFwII0sh5yEy6Veh0sTG
         N0a92DaXVzoEV/B8RVQJT6TydrhSmPNRX7IPFAlqNc+8gEhFWSYfWTa62ky553/Wlt/s
         ZJJA/4hXHDBpopqfXJw4i9GDpIhFOHJyOt+i4lufmPyK7goO48fBeiKZ3uW7DTkZ/BMR
         pdil4WPpXrRkXZBMmLJtlW5Dq0KikG0hU06PrvIee1Oe82+wo1QW1ChqW+tlLMFPJaNE
         gLZA==
X-Gm-Message-State: APzg51AP/fE61p8sYuwp+ERS8HMGLVC9FJ2WFusmMBfdNb+cAzTwIoni
        KhKOfniM/pGILgbufb4cRkQ=
X-Google-Smtp-Source: ANB0VdZ8apU6yKMcm89WUlMymJzT8nvI4Ag1Q4vYrcTElKQWkNEl7xbjb78W9v94/na3XEViiEBVvw==
X-Received: by 2002:a19:c143:: with SMTP id r64-v6mr5439721lff.59.1536850550174;
        Thu, 13 Sep 2018 07:55:50 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-171-82.play-internet.pl. [94.254.171.82])
        by smtp.gmail.com with ESMTPSA id z5-v6sm751415lfg.75.2018.09.13.07.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 07:55:49 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: max8998: Add charger subnode binding
Date:   Thu, 13 Sep 2018 16:55:48 +0200
Message-ID: <24790346.rcfynqLzho@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.15.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180807175741.GA30886@rob-hp-laptop>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180807175741.GA30886@rob-hp-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 7, 2018 11:57:42 AM CEST Rob Herring wrote:
> On Tue, Jul 17, 2018 at 06:05:09PM +0200, Pawe=C5=82 Chmiel wrote:
> > This patch adds devicetree bindings documentation for
> > battery charging controller as the subnode of MAX8998 PMIC.
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v2:
> >   - Make charge-restart-level-microvolt optional.
> >   - Make charge-timeout-hours optional.
> >=20
> > Changes from v1:
> >   - Removed unneeded Fixes tag
> >   - Correct description of all charger values
> >   - Added missing property unit
> > ---
> >  Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++++++++=
++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Docume=
ntation/devicetree/bindings/mfd/max8998.txt
> > index 23a3650ff2a2..264040f4ad15 100644
> > --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> > +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> > @@ -50,6 +50,24 @@ Additional properties required if max8998,pmic-buck2=
=2Ddvs-gpio is defined:
> >  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in micr=
ovolts
> >    for buck2 regulator that can be selected using dvs gpio.
> > =20
> > +Charger: Configuration for battery charging controller should be added
> > +inside a child node named 'charger'.
> > +  Required properties:
> > +  - max8998,charge-eoc-percent: Setup End of Charge Level.
>=20
> This should have a vendor prefix and max8998 is not a vendor. Don't=20
> continue that pattern even if we already have some properties like that.
>=20
> These seem like perhaps they should be common charger properties.
Where i could find such properties (or any other driver which is using thos=
e as an example) ?
Looking at few existing drivers, most of them have custom properties (that'=
s why i've followed the same pattern for max8998).

Thanks
>=20
> > +    If value equals 0, leave it unchanged.
> > +    Otherwise it should be value from 10 to 45 by 5 step.
> > +
> > +  Optional properties:
> > +  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
> > +    If property is not present, this will be disabled.
> > +    If value equals 0, leave it unchanged.
> > +    Otherwise it should be one of following values: 100, 150, 200.
> > +
> > +  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
> > +    If property is not present, this will be disabled.
> > +    If value equals 0, leave it unchanged.
> > +    Otherwise it should be one of following values: 5, 6, 7.
> > +
> >  Regulators: All the regulators of MAX8998 to be instantiated shall be
> >  listed in a child node named 'regulators'. Each regulator is represent=
ed
> >  by a child node of the 'regulators' node.
> > @@ -99,6 +117,13 @@ Example:
> >  		max8998,pmic-buck2-dvs-gpio =3D <&gpx0 0 3 0 0>; /* SET3 */
> >  		max8998,pmic-buck2-dvs-voltage =3D <1350000>, <1300000>;
> > =20
> > +		/* Charger configuration */
> > +		charger {
> > +			max8998,charge-eoc-percent =3D <0>;
> > +			max8998,charge-restart-level-microvolt =3D <100>;
> > +			max8998,charge-timeout-hours =3D <7>;
> > +		};
> > +
> >  		/* Regulators to instantiate */
> >  		regulators {
> >  			ldo2_reg: LDO2 {
>=20


