Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 73232C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C3208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eegF28D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7C3208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbeFNGkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:40:35 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:57137 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeFNGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:40:32 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5E6e6dv001281;
        Thu, 14 Jun 2018 01:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528958406;
        bh=aB2Xx1laOzxEpFT7Sh9Jqutdum4y1FJenE8riGohEHE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=eegF28D+UroTcHakfhSxA7gOIA/cfzHXXXlDX4IY0KSTRLOq52cxvfzyZy6fFw7kG
         gYzd7UQFs+INIsrt1pTA76y75uveZAr5SeMjJx22i6RgzD6kuzhO2gNLD4uM4M++Cg
         Xyd0L1QQ8ZZt2jK6rI53WeN0Zi/7/jtdni2RiSqA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5E6e563005975;
        Thu, 14 Jun 2018 01:40:06 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 14
 Jun 2018 01:40:05 -0500
Received: from DFLE103.ent.ti.com ([fe80::7431:ea48:7659:dc14]) by
 DFLE103.ent.ti.com ([fe80::7431:ea48:7659:dc14%17]) with mapi id
 15.01.1466.003; Thu, 14 Jun 2018 01:40:05 -0500
From:   "Reizer, Eyal" <eyalr@ti.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
CC:     Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] arm64: dts: hikey: Define wl1835 power
   capabilities
Thread-Topic: [EXTERNAL] Re: [PATCH] arm64: dts: hikey: Define wl1835 power
   capabilities
Thread-Index: AQHUA0SMzeHUc1UEpk+teU5r0yB0eqReiSdNgAC9ofA=
Date:   Thu, 14 Jun 2018 06:40:05 +0000
Message-ID: <ae036763950c4c9e80ceccc8c61e78dd@ti.com>
References: <20180613151305.17240-1-ryan@edited.us>
        <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
 <87tvq6a577.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87tvq6a577.fsf@kamboji.qca.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.167.25.139]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> These properties are required for compatibility with runtime PM.
> >> Without these properties, MMC host controller will not be aware
> >> of power capabilities. When the wlcore driver attempts to power
> >> on the device, it will erroneously fail with -EACCES.
> >>
> >> Signed-off-by: Ryan Grachek <ryan@edited.us>
> >
> > Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
> > Tested-by: John Stultz <john.stultz@linaro.org>
> > Acked-by: John Stultz <john.stultz@linaro.org>
> >
> > Wei Xu: This fixes a functional regression with wifi on the HiKey
> > board that was introduced in 4.18-rc with commit 60f36637bbbd
> > ("wlcore: sdio: allow pm to handle sdio power").
> >
> > Could you please be sure to queue this for the 4.18-rc ?
>=20
> Adding linux-wireless so that wireless folks are aware of this wlcore
> regression fix as well.
>=20
Actually  "cap-power-off-card" is normally included with all .dts files sup=
porting wilink=20
So it should have been there from the start for this board as well.=20
It probably worked without it due to the explicit call to mmc_power_restore=
_host()
that was there as an old workaround for trying to control the power explici=
tly from the
driver which was actually causing other failures on suspend/resume as the m=
mc layer=20
already power the module on resume.
"keep-power-in-suspend" is needed in case of planning to use "WoWLAN":
Iw phy0 wowlan enable....

Best Regards,
Eyal
