Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E72ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3E32086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jKr54x/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3E32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeKHWE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:04:59 -0500
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:36310
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbeKHWE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMemXiVL78QL6/JaggLDwL/MJyjdPaFSOIf+E33Ps4k=;
 b=jKr54x/NKDASgsYJFQR7uR9HpKuXIZ/2fwC4caRcAaXflIokQ/OEoFusn98Mki/8uZJ2oEBA9xOWhul6z93SXbTnjqVe6oOtMqkieEY9xJl8GQ6i8VFmAKQrYhHYkrh+iFE0DTNz215fDLhzBrpZWEQGP1GTQsuf1ivyLqCWeY4=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3832.eurprd04.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 8 Nov 2018 12:29:39 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 12:29:39 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abelvesa@linux.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Thread-Topic: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Thread-Index: AQHUU/MOgX3H5GYYv0SLPnYITk0b36Uj/uoAgCB6iACAAHccAIAAF9kAgABA34CAAMxBAA==
Date:   Thu, 8 Nov 2018 12:29:39 +0000
Message-ID: <20181108122938.mnhu3ttnlztfeyot@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
 <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
 <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
In-Reply-To: <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3832;6:zjf/F3p167xOZpVauqJuCgGqyNWrFDd4qE4M265EflRhFQ3fp/G+GZIVoK+tt/bjWmT71/tBRHDlcPfHSyLc1UeOz5avBAj3TogXMs5qq9TgaWOhRPeS2JWzCO1tmrCG0OvjKxwtw0BKggQx2kI606I216ueTMEkCdFvVb2QTfVYSS468wTufjG9+EH6eORROV1DLf3DUsxtK0Hs17BZ7fRbUTmKoGUsjxv1v502wbzoN34aTVTB+dxxKtCszvdd3MFoMA6kAzlRwT600oSiYZLZDoZeG9p9m2DWZVg0e+vjzYeBiKzdSVOhflZgXzrXg9sBlkuSGZsJQLZa/ezGQqaIaZiCp60UEkUmEdEuQoBLlKh2ah+rOEd8rvZvN6ZGe+ystG0QJLHdyMPufPkIfxTvMjG+shoG4P/RMfX045NvZmjKapgLg6MaVZVlHV51Ra/VMhcAv3QuyzzI8IU0IQ==;5:ZVfiSW+vcC9qz8WewKGPqp79l9VkQeIr5Pjx2dtQIgkzZy27Kq5QrVQxnw1jwK2c4WetbldqA8eO3EkdFWqMD0SfJxH7amqhVClfDefIuYf0Iq/62nipDt1Nm/y3RFR4Kiraw9ADBjqHnL+qbAgSOJ2x0xhzqxR5Z6MS4mjqIx8=;7:bdDMSih8qcBhQpSqwh0VqDIT8m95/tuR67pSSWpYTeY6emOJcTRrCcGxsr4Pu51cK7pI145Jkehde3I0meF3qk2MRG0zLhWSR19LQjFEjT/Qc3KZx+MkN0L/sHD40iCXiRHe4HKQkGf5tFJxcsMNBQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c31013a7-470a-418d-42da-08d64575da4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3832;
x-ms-traffictypediagnostic: AM6PR0402MB3832:
x-microsoft-antispam-prvs: <AM6PR0402MB383295DD57A956E7AED3247EF6C50@AM6PR0402MB3832.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3832;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3832;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(51914003)(256004)(71190400001)(6506007)(71200400001)(102836004)(2900100001)(14454004)(33716001)(44832011)(486006)(11346002)(476003)(446003)(217873002)(305945005)(106356001)(186003)(97736004)(26005)(105586002)(7736002)(1076002)(6116002)(5660300001)(86362001)(478600001)(3846002)(6916009)(66066001)(99286004)(229853002)(6486002)(4326008)(54906003)(68736007)(93886005)(6436002)(316002)(33896004)(76176011)(7416002)(81156014)(39060400002)(2906002)(6246003)(81166006)(8936002)(53936002)(8676002)(9686003)(6512007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3832;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RRlXAL1t8qa0QpEzbpSWvijry+qJvKNFqmTv2yN3zcl/FosOuEJn0n4SrVH+STNnj9NH6izlv24qHjsKJFJRrR1X2tum948Wez5uJMNTMSuthZmzHSmoHw7BLq4D6jgn4zYvosatmDubZh456DBq9RQ+RdSoqExLQs1nSDfafsqglJP2UTvJlqom6orqvBkOO06TB+wi52OUXq1nvcCTSAylfD/TrF4lGg/dz+k+QkoFSih4quMCcVYEm/EjwS//9EjOXcoN39VGKzVH+pdUBTiE0Uj3EkUTNw7gCnA0EFjnFdHvk77jg4qVsnGBa0fEG6WaINfxUOXEhNx3RV9gzt83o74x8GB48zKsRCfIuTo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <279179CE358C664E8D247DB7B5735643@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31013a7-470a-418d-42da-08d64575da4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 12:29:39.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:18:35PM -0800, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-11-07 12:26:25)
> > On Wed, Nov 07, 2018 at 11:01:02AM -0800, Stephen Boyd wrote:
> > >=20
> > >=20
> > > What's the plan to clean it up?
> >=20
> > So I'm doing this in our internal tree first to make sure I don't break=
 the
> > other (newer) socs.
> >=20
> > I already have a prototype in testing but it's a long way to upstream i=
t.
> >=20
> > Basically, I'm replacing all of this with a single, more like a composi=
te,
> > more complex, clock type that does all the magic inside.
> >=20
> > One of the problems is the fact that the bypasses can have the same sou=
rces
> > and in my case, I'm implementing that as a list of parents name, but th=
e
> > parent names list doesn't work with duplicates, so I have to find some =
other
> > way to do it.
> >=20
> > Once I have something clean and tested enough I'll send it upstream.
>=20
> Ok. Thanks for the info.
>=20

Just to avoid any kind of confusion.

The whole refactoring of the SCCG clock will be done in a separate (later) =
change
and will not be part of this patchset.

I already sent the 12th version of this current patch series and I would re=
ally
like to get this in ASAP so that the booting up of imx8mq will not be delay=
ed.

Thanks
Abel

-- =
