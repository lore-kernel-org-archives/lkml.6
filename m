Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B8ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02144214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="gk38FcmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02144214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbeISOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:55:45 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:12364 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730802AbeISOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:55:45 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 19 Sep 2018 18:18:44 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 45BA284DCE;
        Wed, 19 Sep 2018 18:18:44 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,393,1531753200"; 
   d="scan'208";a="292905887"
Received: from mail-ty1jpn01lp0179.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.179])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2018 18:18:44 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwOBWc2A3uNeS8ISih1/iH141i5uK4nneS5Rrx04RH4=;
 b=gk38FcmPcma2LmpG4my/LaRNMEYaUlje9NpHnLskYiJZP3uALtsP1j7s0IMTBLpqyJxgp+HKUgxVy0HXGCmb+A+xDpedHN+qYQEP6dofC0jKYGvoVtaII7D0XVP3+TJ4Himcwe5A4GGwYz1S9OOdDvNrVPnICZobzWD7GIQCHO0=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1102.jpnprd01.prod.outlook.com (10.174.225.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 09:18:41 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97%6]) with mapi id 15.20.1143.014; Wed, 19 Sep 2018
 09:18:41 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] ARM: dts: r9a06g032: Add pinctrl node
Thread-Topic: [PATCH v3 3/3] ARM: dts: r9a06g032: Add pinctrl node
Thread-Index: AQHUTqSnOZqOAaKgpEegzg3eDeimu6T3VU4AgAAAh5A=
Date:   Wed, 19 Sep 2018 09:18:41 +0000
Message-ID: <TY1PR01MB17690D4C023EB9B4A5164A2AF51C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20180917163609.30457-1-phil.edworthy@renesas.com>
 <20180917163609.30457-4-phil.edworthy@renesas.com>
 <20180919091524.rgbk4m6ht34idkpd@verge.net.au>
In-Reply-To: <20180919091524.rgbk4m6ht34idkpd@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1102;20:7BtBDcqrYf1Fym2PDC/im/otqeUatMQUV7++DHRrTUMan6/v6UH/bLuJX3gFNqzBu4Lc7VpjLEbKu94vuq1/M5TsLtkSQS+CMPa2GMrJjR0B5mVmkSOjtZOoPCLt/gcRuVTZG4PYGrSaZJHJkJ1U2+jFFFwW93+3sQTXwR2twhA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6157512d-1ec9-4ab1-dbd0-08d61e10e439
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1102;
x-ms-traffictypediagnostic: TY1PR01MB1102:
x-microsoft-antispam-prvs: <TY1PR01MB1102D1D5FDB099A304BB64D5F51C0@TY1PR01MB1102.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:TY1PR01MB1102;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1102;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(478600001)(81166006)(8676002)(97736004)(2900100001)(6116002)(25786009)(305945005)(74316002)(68736007)(14444005)(229853002)(3846002)(5660300001)(316002)(81156014)(2906002)(7736002)(66066001)(6436002)(4326008)(6246003)(256004)(5250100002)(446003)(53936002)(186003)(44832011)(486006)(476003)(55016002)(99286004)(9686003)(53546011)(6506007)(76176011)(7696005)(6916009)(54906003)(33656002)(26005)(11346002)(105586002)(102836004)(86362001)(106356001)(8936002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1102;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qdaMFEV/yNBG/JIp68Gv169csyH8Ih+gQRYC543qBxNc2ngBpsiumy4TDc8c0QVkeaEo2L1uxu4Wc5MWuR1DtuCNFwSewZlVigPUc/9vd0YaBqa6VZQRLH0cFBJ/SHU8WYNegNN+zOHpu9IH6BTj/Ng273ABXI6Rd5xLFwp8AABoJ57gwwE12UsMlZIF10jbWO507yrRevPekMnIul6KjyBc59so56N0H3vtBFY5K7S7TgxsJPUVrDQr8KBxoGYp0PICIH3p1xXgBFDDYb3nvqKERfgIAygm3CZz51hZXbXXA8qZ5Q33L9/CSQnor284HFWvlguO64uC1me0quXs69o5NwTwN1fJTrIbt97yxis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6157512d-1ec9-4ab1-dbd0-08d61e10e439
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 09:18:41.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 19 September 2018 10:15 Simon Horman wrote:
> On Mon, Sep 17, 2018 at 05:36:09PM +0100, Phil Edworthy wrote:
> > This provides a pinctrl driver for the Renesas R9A06G032 SoC
> >
> > Based on a patch originally written by Michel Pollet at Renesas.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> Thanks Phil, I will defer this patch pending acceptance of the bindings.
> Please continue to repost this patch with updates to the bindings or
> otherwise ping me once they have been accepted.
Thanks, however I will send a new version of this patch to remove the
clock-names prop as it is not needed.

Thanks
Phil


> > ---
> > v3:
> >  - No changes.
> > v2:
> >  - Add "renesas,rzn1-pinctrl" compatible fallback string
> >  - Register size corrected.
> > ---
> >  arch/arm/boot/dts/r9a06g032.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r9a06g032.dtsi
> > b/arch/arm/boot/dts/r9a06g032.dtsi
> > index eaf94976ed6d..2322268bc862 100644
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -165,6 +165,14 @@
> >  			status =3D "disabled";
> >  		};
> >
> > +		pinctrl: pin-controller@40067000 {
> > +			compatible =3D "renesas,r9a06g032-pinctrl",
> "renesas,rzn1-pinctrl";
> > +			reg =3D <0x40067000 0x1000>, <0x51000000 0x480>;
> > +			clocks =3D <&sysctrl R9A06G032_HCLK_PINCONFIG>;
> > +			clock-names =3D "bus";
> > +			status =3D "okay";
> > +		};
> > +
> >  		gic: gic@44101000 {
> >  			compatible =3D "arm,cortex-a7-gic", "arm,gic-400";
> >  			interrupt-controller;
> > --
> > 2.17.1
> >
