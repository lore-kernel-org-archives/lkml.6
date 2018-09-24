Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B46ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DAC2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1lJ790A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DAC2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbeIYBZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:25:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52530 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbeIYBZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:25:00 -0400
Received: by mail-it1-f196.google.com with SMTP id h3-v6so12168725ita.2;
        Mon, 24 Sep 2018 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cvUqa3TPohGPYqnxh6FE0UKZREDWuGizqnxBQq1Ktdc=;
        b=p1lJ790ABoxf1qaC8yQFtRZe0wP8awEVTdwEIKVNf2p1VDGrbawzpuFMmoze1N097o
         /Rw9ew0/pDw2wApKAfnlDFQPOKKgcqiVqcFcP8wKtB9X5OsbIcZ7bdQnrDokP3BXFf5T
         a75siIsu1lPIAYzEy1cEY3+hnHZOXnJKRmlpFWRdl1UrKudItAC3nOTtyuyOhN12NtNW
         0id32CZDoYC9+17xcwtQC5Yf5aqg/P189Afl3T4ROX+s9stwz4yqH7SdxBzx9gjrXkg2
         kczR+Mve8h68GWl9Yqhn/SGrxib0sEN32cSmY/m6VFsDKLpylAqnL0Kn4R/Aa//uKZOB
         ZiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cvUqa3TPohGPYqnxh6FE0UKZREDWuGizqnxBQq1Ktdc=;
        b=Wa3n//wYHcLx/4pK+UTxg88sEeGg9kl/AUg2Vd3jIvr34BiKud5C1TWb3qpzovmtjq
         Z1O6GHNdfdhHDgGsU3Id4mD+gCDcdzOemdMvtRKSjwb0+LKJjeGOvHo3CpmiGeqIjGzb
         N1ENy6Ykqnu345ZTyKNQ43HWrmfUlbqZW2P9BKxjAOU3dJGmeo7p7l08d4scV6YjJ96u
         IYggcOPxmG106IosscfYSfLgF4VGSoOqA+7BkMppjSUk4m8ezdxv1622jbBKHfOVRcCZ
         zJsOIeuCHdM6f4EXEBrLBq/ZEaF6XzE/DwIVxFfPpl3f7E5q2btOm9WRAhQeEIJ5amLv
         d+Hw==
X-Gm-Message-State: ABuFfohsQHV+IJh4F0QMozwESWKPOnhFU5ZyK6muwqUekHj5ADefcQL1
        yZN65odsTKy7yF58yUGhyHQHVNPkbqTpgSBTNps=
X-Google-Smtp-Source: ACcGV60bmX5DngUME8Kd+dCbvgauqks2+IfQ7B4u4iCr/fxyO5uPyRDB30/xL9F+ozXDgTjm91j6NRLLfgve6+tygMc=
X-Received: by 2002:a24:3b0e:: with SMTP id c14-v6mr8658668ita.42.1537816880927;
 Mon, 24 Sep 2018 12:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20170309141443.20564-1-george.mccollister@gmail.com>
In-Reply-To: <20170309141443.20564-1-george.mccollister@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 24 Sep 2018 14:21:09 -0500
Message-ID: <CAHCN7xLEHw4vN8gud+vPkVBX3tSsBM1HTnRCi6fF3VxYiQYfmA@mail.gmail.com>
Subject: Re: [PATCH] regulator: pfuze100-regulator: add coin support
To:     george.mccollister@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2017 at 8:17 AM George McCollister
<george.mccollister@gmail.com> wrote:
>
> Add support for PF0200 coin cell/super capacitor charger which works as
> a current limited voltage source via the LICELL pin. When VIN goes below
> a certain threshold LICELL is used to provide power for VSNVS which is
> usually used to hold up secure non-volatile storage and the real-time
> clock on the SoC.
>

I know this is patch is an old thread by now, but is there something
precluding this from being added the pfuze100 as well?

[snip]

I am trying to add:

@@ -324,6 +324,7 @@ static struct pfuze_regulator pfuze100_regulators[] =3D=
 {
        PFUZE100_VGEN_REG(PFUZE100, VGEN4, PFUZE100_VGEN4VOL, 1800000,
3300000, 100000),
        PFUZE100_VGEN_REG(PFUZE100, VGEN5, PFUZE100_VGEN5VOL, 1800000,
3300000, 100000),
        PFUZE100_VGEN_REG(PFUZE100, VGEN6, PFUZE100_VGEN6VOL, 1800000,
3300000, 100000),
+       PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_c=
oin),
 };

 static struct pfuze_regulator pfuze200_regulators[] =3D {
@@ -377,6 +378,7 @@ static struct of_regulator_match pfuze100_matches[] =3D=
 {
        { .name =3D "vgen4",      },
        { .name =3D "vgen5",      },
        { .name =3D "vgen6",      },
+       { .name =3D "coin",       },
 };

but I am getting bulid errors:

drivers/regulator/pfuze100-regulator.c:327:20: error: =E2=80=98PFUZE100_COI=
N=E2=80=99
undeclared here (not in a function); did you mean =E2=80=98PFUZE200_COIN=E2=
=80=99?
  PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
                    ^~~~~~~~
drivers/regulator/pfuze100-regulator.c:240:3: note: in definition of
macro =E2=80=98PFUZE100_COIN_REG=E2=80=99
  [_chip ## _ ##  _name] =3D { \
   ^~~~~
drivers/regulator/pfuze100-regulator.c:327:20: error: array index in
initializer not of integer type
  PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
                    ^~~~~~~~
drivers/regulator/pfuze100-regulator.c:240:3: note: in definition of
macro =E2=80=98PFUZE100_COIN_REG=E2=80=99
  [_chip ## _ ##  _name] =3D { \
   ^~~~~
drivers/regulator/pfuze100-regulator.c:327:20: note: (near
initialization for =E2=80=98pfuze100_regulators=E2=80=99)
  PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
                    ^~~~~~~~
drivers/regulator/pfuze100-regulator.c:240:3: note: in definition of
macro =E2=80=98PFUZE100_COIN_REG=E2=80=99
  [_chip ## _ ##  _name] =3D { \
   ^~~~~

I am not entirely understanding how the macro is supposed to work.
Any suggestions?

thanks,

adam


> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
