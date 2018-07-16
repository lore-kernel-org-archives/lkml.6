Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B277BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650A8208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUXxyqoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650A8208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeGPT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:28:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39327 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeGPT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:28:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so10736483lji.6;
        Mon, 16 Jul 2018 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3uIkz76EDm9W6BvIgahNVHn3FFTrrwcxghTLyVYzto=;
        b=TUXxyqohJWOqfT8dGST9KjG4Si+BKbiCZIqvISmafO8+3J/cpTFXd8vBSLakhb+335
         4ab/7FWKcgGtwBaHByvPas8iWFFX65WUBS1kh7G2IPQdO5lYvdCY+I/GlE7qoB52NyAu
         ItUsrmcmMUT/HxB+lBr+Vc9V6jDT/SqFqUqxT/d4Hf5Wb5xfocwzjRMj0KSUtsfLQg4s
         R1YKbgoQuaxH4CVTZSgXXfQ0KyJIwX7lmdKImAJSZLTqXUBtPHfF9SThvqKAoEBxPBQG
         6xyZgqn1QqMv6lluCyTrgGmzLg4XyotVSso2Szt6k6uSSTPVBjeElxoeczze0mjS6Lfq
         1iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=G3uIkz76EDm9W6BvIgahNVHn3FFTrrwcxghTLyVYzto=;
        b=X5tYuaO1vsUbf04fCrmRZPdEMUc/bgDq8f1TvpnQ762esYH9J3M/lSYelPG/HPRO69
         OYTchARloo1NOsIXdWFjINKeOR2RCsHFsDLfDZl2ACCmhKKwqf++lw22nJawmIpdb1PD
         D/a2wq7z9Jc7QHdbgJu4PPHzbERsU3abOE4F3Va8F0hR31sEBQt3Ac1DBb36uLlg61f/
         gB7NUbi6hqE656wFzfAtdoyT0fdWlE4YVm8B9SxkEDkEpNbHt8u3SUs/zhXXJ7waM+mo
         wU025RV6GTU3X/OdUAnXwe/QXXCfpt0aDfylZb/It7uv0rnIVc+kkc4YVS06YRjShPLu
         CbIg==
X-Gm-Message-State: AOUpUlGQZPfaetQTOTW4bH1s+6enuAwhQNHw1cE269x+xfipb/HMnjju
        qDoJKYVNUYCW6sYP+I+jluM=
X-Google-Smtp-Source: AAOMgpebU1efcQtm7/u/T/DT3g30VJwkH6DuTrrNeXsOpubwNaiZWAC1YkkFPzP3cA7+KUhx9sLQnA==
X-Received: by 2002:a2e:1b03:: with SMTP id b3-v6mr11595367ljb.24.1531767562152;
        Mon, 16 Jul 2018 11:59:22 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.gmail.com with ESMTPSA id h40-v6sm3238864lfi.84.2018.07.16.11.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 11:59:21 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: max8998: Add charger subnode binding
Date:   Mon, 16 Jul 2018 20:59:20 +0200
Message-ID: <2652044.7dgYAUSR2v@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.15.0-24-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180716180003.GA16037@rob-hp-laptop>
References: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1531571213-30593-4-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180716180003.GA16037@rob-hp-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 16, 2018 12:00:03 PM CEST Rob Herring wrote:
> On Sat, Jul 14, 2018 at 02:26:53PM +0200, Pawe=C5=82 Chmiel wrote:
> > This patch adds devicetree bindings documentation for
> > battery charging controller as the subnode of MAX8998 PMIC.
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v1:
> >   - Removed unneeded Fixes tag
> >   - Correct description of all charger values
> >   - Added missing property unit
> > ---
> >  Documentation/devicetree/bindings/mfd/max8998.txt | 24 +++++++++++++++=
++++++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Docume=
ntation/devicetree/bindings/mfd/max8998.txt
> > index 23a3650ff2a2..196e50097a36 100644
> > --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> > +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> > @@ -50,6 +50,23 @@ Additional properties required if max8998,pmic-buck2=
=2Ddvs-gpio is defined:
> >  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in micr=
ovolts
> >    for buck2 regulator that can be selected using dvs gpio.
> > =20
> > +Charger: Configuration for battery charging controller should be added
> > +inside a child node named 'charger'.
> > +  Required properties:
> > +  - max8998,charge-eoc-percent: Setup End of Charge Level.
> > +    If value equals 0, leave it unchanged.
> > +    Otherwise it should be value from 10 to 45 by 5 step.
> > +
> > +  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
> > +    If value equals 0, leave it unchanged.
> > +    If value equals -1, it will be disabled.
>=20
> -1 is a bit strange. Why not 'not present' is disabled?
I wanted to make it work the same way, as it was in case of using it from p=
latform_data.=20
But this is good idea, to change it a bit.
So we would have:
=2D 0 -> leave unchanged
=2D property not present in devicetree -> disabled (and set to -1 - driver =
is expecting it)
=2D value from 10-45 or (5,6,7 in case of second property)
I'll update both documentation and driver parsing code (for both properties=
 - restart level and full timeout) and send v3 version.

Thanks for suggestion.
>=20
> > +    Otherwise it should be one of following values: 100, 150, 200.
> > +
> > +  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
> > +    If value equals 0, leave it unchanged.
> > +    If value equals -1, it will be disabled.
> > +    Otherwise it should be one of following values: 5, 6, 7.
> > +
> >  Regulators: All the regulators of MAX8998 to be instantiated shall be
> >  listed in a child node named 'regulators'. Each regulator is represent=
ed
> >  by a child node of the 'regulators' node.
> > @@ -99,6 +116,13 @@ Example:
> >  		max8998,pmic-buck2-dvs-gpio =3D <&gpx0 0 3 0 0>; /* SET3 */
> >  		max8998,pmic-buck2-dvs-voltage =3D <1350000>, <1300000>;
> > =20
> > +		/* Charger configuration */
> > +		charger {
> > +			max8998,charge-eoc-percent =3D <0>;
> > +			max8998,charge-restart-level-microvolt =3D <(-1)>;
> > +			max8998,charge-timeout-hours =3D <7>;
> > +		};
> > +
> >  		/* Regulators to instantiate */
> >  		regulators {
> >  			ldo2_reg: LDO2 {
>=20


