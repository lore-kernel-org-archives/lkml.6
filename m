Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EECC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D262077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gIJ+TY5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D262077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeICGIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:08:44 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:62572
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeICGIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C8cxboLv0Vgr0hTTy/4dOc3Bo6bS9/KR/jbfha4Xik=;
 b=gIJ+TY5L6PlkKJiSPKAt0qcHxDbOLisJP72Nq0IsFUZ0SLQsQt6V1I8j9bcyajnhUG8s5UouuNeXBr4n+RgiCgIHte9aD4fdAeZKhBlHHgI5B2jIctcXz6W9zj2AzavUWk6vwWN3bTX3JrcJ5vJnc/dtqHh0BkJGgpxWgGcw4XQ=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3446.eurprd04.prod.outlook.com (52.133.19.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 3 Sep 2018 01:50:48 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::ccea:795:beb3:5637]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::ccea:795:beb3:5637%2]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 01:50:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] ARM: dts: imx7s: enable cpuidle driver
Thread-Topic: [PATCH 1/2] ARM: dts: imx7s: enable cpuidle driver
Thread-Index: AQHUP1XYMcXheLOq0kWyf3Mbjf5HqaTdyMwAgAAJc8A=
Date:   Mon, 3 Sep 2018 01:50:48 +0000
Message-ID: <AM6PR0402MB3911E04E1DF1CB7FE55B47CAF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
 <20180903011625.GZ3850@dragon>
In-Reply-To: <20180903011625.GZ3850@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3446;6:QGhjtv90warASKoUEOL2x14ocUxwTEjeRZXRVLvwK/6YAUKQljXTzy+ZuPUA9DIKUbdVjYipeRzxEoHReU2OHR4UGte9/NP0TKAewIxI+CeC5AzQ6gvWCvptn+jIzzyWUzvYFukb3K5XiDdcLrW04V5fM7Zs0Ltt1OibFZYze91GhnU8AlrhCTVXwm+5ByvV2zC7IViTJjvayDol24kMoLDlgeBnk9f2ZogiHNASbk+I7SvS/ON7dz2vVt1/L7ENNvLYPpp8hzdiI/ImPLXfiA/v6zBn2DAzqp5OuBCZo9OOEt4EkypsTsbM4Xqqc2PObHOxH4EzGBnqUwDcW5SyJN4hc79gZmWCgY4ux3FrZDAe7DFt9Vs/l0rTB7rX7BPSOwzy7WM8Qy/kU7ZRNlc58exEZisFKN8XOVNcmTHWS64KrUkq7aG0pN8Ob+Yo7ck9duhjII3AhK2T4zZafFcL2Q==;5:8i0hCbQoqNwyW+pSyodeNwpQb5GnORwTN0dVp0W7eaOjY9r4ANgjW23nzKvhsydb6QwBaCWD2I5yMlxpi+tdg3P0azv+65hI1FrQ+eGBrzbgdLaBCTPlAIll782lVoL8S6hRBJSAmBIJQfstpWNfGFciI7NzvQFyF0RcfSQpRDQ=;7:TPiK63MUQPBCwv3wZdI89OZzdJxXlcijf0rjAEwQbai9WGLRq2sl/lBwjFNvA6S38Bvb+05TQ2pMEMdVbvzxwizkOolyyM2jFsaIbrmqLyYH7B97TzKXpiR+dhPN2ACmQA+H4cAC5qSRfpO9kM+pdX6TAzGunOF+o7w25sWThDY6auySuITLfIShJ2TQc+FOSSNcNeEj5ApY4LeoUbjBl6BdjgVw9errMoa58koThmngRedqgbx5PSCh6mCoOoff
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 35270175-49ef-4f7a-f015-08d6113fac24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3446;
x-ms-traffictypediagnostic: AM6PR0402MB3446:
x-microsoft-antispam-prvs: <AM6PR0402MB34461F746DBCEB47BCE7237BF50C0@AM6PR0402MB3446.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR0402MB3446;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3446;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(13464003)(189003)(199004)(9686003)(2906002)(97736004)(76176011)(2900100001)(305945005)(53546011)(476003)(486006)(5250100002)(7696005)(6506007)(44832011)(8676002)(14444005)(7736002)(6246003)(6346003)(53936002)(74316002)(54906003)(8936002)(256004)(86362001)(68736007)(316002)(575784001)(6306002)(55016002)(26005)(106356001)(105586002)(229853002)(6916009)(14454004)(6436002)(4326008)(186003)(478600001)(5660300001)(66066001)(45080400002)(446003)(99286004)(81156014)(11346002)(25786009)(102836004)(81166006)(33656002)(966005)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3446;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: 046yPHfuIDygE7WqNn1xncO9LJ6PPZXFeuvAUYOs/wKLVQqml4b6LC2sbjq/hEk7Ca8AbV6SMy4C49lBYyoosj/RQcm2OfKE1xddts+oPMw51Y0xeqlIDsPMWcceShp/6mPNDjeXvtpaPkjrnvwuzRckHJHe9yEsTGOHFaLpZFWDt2Qo8bhJZw1lvhNPyI18yzo8MwNcMxyMntmK99qVc+0emL+pqQuDwLr6neCYTwfWLUKfV/o/aLmIezCsLD3nPmKvwGPa99TKMLKlH51wmya68uxcgqnAoOByWAO+Z6LODZ+6pBaFa6aJ5UkJ2XlwZTs3gJZAcbfy9y5BMoK6sNzg/zLL4+obqVSk08oCbxc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35270175-49ef-4f7a-f015-08d6113fac24
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 01:50:48.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Monday, September 3, 2018 9:16 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> linux@armlinux.org.uk; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH 1/2] ARM: dts: imx7s: enable cpuidle driver
>=20
> On Wed, Aug 29, 2018 at 01:00:46PM +0800, Anson Huang wrote:
> > Enable cpuidle for i.MX7S/D using generic ARM cpuidle driver, below 2
> > idle states enabled:
> >
> > 1. ARM WFI;
> > 2. SoC WAIT mode.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx7d.dtsi |  1 +
> >  arch/arm/boot/dts/imx7s.dtsi | 14 ++++++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d.dtsi
> > b/arch/arm/boot/dts/imx7d.dtsi index 7cbc2ff..4d0d0f6 100644
> > --- a/arch/arm/boot/dts/imx7d.dtsi
> > +++ b/arch/arm/boot/dts/imx7d.dtsi
> > @@ -20,6 +20,7 @@
> >  			reg =3D <1>;
> >  			clock-frequency =3D <996000000>;
> >  			operating-points-v2 =3D <&cpu0_opp_table>;
> > +			cpu-idle-states =3D <&CPU_SLEEP>;
> >  		};
> >  	};
> >
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi index 93884ce..cf5570b 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -54,6 +54,19 @@
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <0>;
> >
> > +		idle-states {
> > +			entry-method =3D "psci";
> > +
> > +			CPU_SLEEP: WAIT {
>=20
> I understand uppercase is allowed, but we conventionally use lowercase fo=
r
> label and node name.  Can we do something like below?
>=20
> 	cpu_sleep_wait: cpu-sleep-wait {
> 		...
> 	}
=20
Sure, please review V2 patch, thanks!

Anson

>=20
> Shawn
>=20
> > +				compatible =3D "arm,idle-state";
> > +				arm,psci-suspend-param =3D <0x0010000>;
> > +				local-timer-stop;
> > +				entry-latency-us =3D <100>;
> > +				exit-latency-us =3D <50>;
> > +				min-residency-us =3D <1000>;
> > +			};
> > +		};
> > +
> >  		cpu0: cpu@0 {
> >  			compatible =3D "arm,cortex-a7";
> >  			device_type =3D "cpu";
> > @@ -61,6 +74,7 @@
> >  			clock-frequency =3D <792000000>;
> >  			clock-latency =3D <61036>; /* two CLK32 periods */
> >  			clocks =3D <&clks IMX7D_CLK_ARM>;
> > +			cpu-idle-states =3D <&CPU_SLEEP>;
> >  		};
> >  	};
> >
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
t
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D02%7C
> >
> 01%7CAnson.Huang%40nxp.com%7C8ce1cddcac05444edc1408d6113b0a76%7
> C686ea1
> >
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636715342610651079&amp;sda
> ta=3Dx9l%
> >
> 2FrkV8Uo8CtSa0jJsBZ%2FXt2DE3ZRQ5TWXm5%2Fbwvag%3D&amp;reserved=3D
> 0
