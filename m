Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D99C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993F920672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="axBvhIrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993F920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLLAMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:12:47 -0500
Received: from mail-eopbgr1410092.outbound.protection.outlook.com ([40.107.141.92]:1056
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbeLLAMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t49QCsvGf+wXGyEXuXixtByNf20Ljqf54ncByHCMNc=;
 b=axBvhIrYgdbPS5/DvGYgKKcU6yNBVMO4z9Ut+2ZWXXgagKSenZjFpH9A4SmDndt/AZY72uoexjKI39OItyj/B/NKAYhy7OA7ZpxqZsryGuyTxWRCiNOMW1Q1lAs2ef89tM1mFd+n2KFOX61ub4IDdgIDMo4GDKxy0ZgYGRJR8wY=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB3599.jpnprd01.prod.outlook.com (20.178.137.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 00:12:40 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 00:12:40 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Topic: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Index: AQHUkQH1op9va60uk066RGBQjI/oF6V6PMSA
Date:   Wed, 12 Dec 2018 00:12:40 +0000
Message-ID: <87efan393s.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
        <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
        <20181211141649.GL6707@atomide.com>
        <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:404:e2::34) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB3599;20:QmgfHpxBVT2JB+tn5a7usuVzsUujLtRmYu3OeDmGBCtKAAlAJY/IX50DWxXFvq5LilUqROE4zgE4Pyfq1OOUWiAlfMK3Guw1ruoBf+kh7IXV023H0VVwWoEcfgu75clMAP/qNaksFF+Pmcdh/3fzBsxljszTwjK21zOTCYD9ebs=
x-ms-office365-filtering-correlation-id: c1fbf81a-c18b-43d6-4e0e-08d65fc6870f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB3599;
x-ms-traffictypediagnostic: TYAPR01MB3599:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-microsoft-antispam-prvs: <TYAPR01MB3599B98B677F26239CFDCCD2D4A70@TYAPR01MB3599.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB3599;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB3599;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(105586002)(7416002)(6512007)(8676002)(11346002)(14454004)(81156014)(7049001)(53936002)(476003)(486006)(81166006)(93886005)(256004)(68736007)(305945005)(52116002)(6306002)(3846002)(316002)(6246003)(446003)(6116002)(6862004)(6436002)(54906003)(2616005)(76176011)(102836004)(37006003)(4326008)(36756003)(71190400001)(39060400002)(66066001)(2906002)(25786009)(71200400001)(229853002)(186003)(7736002)(97736004)(8936002)(6200100001)(6506007)(106356001)(386003)(86362001)(99286004)(5660300001)(6486002)(478600001)(26005)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3599;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4P0fgjBO4H3WCxjlQsAgvF6wVruPLEbETlVJ2MYnvV56jYAmvRITAlWSTNR0jQX1X14i6hz1TTSh99vXTRYv815HJv1DX3cBXxXs2BqFmZnlrA1WPLuUQhAuwllj2f78kzczmrL0kEHnhaKkQxNvglvf1Qoit6WDEmWd5QmxfRZ36I8NZPNZd/OUmi7Qw3ADpOJzQ+WIcPXpIBmpbzA+Yl+J2Imv7/iVe6KshZvTFBY5/aMZBblOBWXkD/02CExlWxK27nwR8/WCJMmLkzPISnNc0MH5n7lWqYNODKD8t4p9rfV9v5hNw8Xvkkw2vjAQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <764C8D5A4E9FFE4F944940B81F85EED6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fbf81a-c18b-43d6-4e0e-08d65fc6870f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 00:12:40.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony, again

> > The issue I have with that it does not then follow the binding doc :)
> >=20
> > See this part in Documentation/devicetree/bindings/graph.txt:
> >=20
> >  "If a single port is connected to more than one remote device, an
> >  'endpoint' child node must be provided for each link."

My understanding is that 1 "port" is for 1 "physical interface".
In sound case, it is 1 "DAI".
And, 1 "endpoint" is for 1 "connection".

	"If a single port is connected to more than one remote device, an
	'endpoint' child node must be provided for each link."

This meanns, "If 1 DAI (*1) is connected to multiple remote DAIs(*2),
this connection is indicated by multiple "endpoint"" or something like that=
.

(*2)
DAIA-endpoint---endpoint--\
DAIB-endpoint---endpoint-----DAI (*1)
DAIC-endpoint---endpoint--/

> > Isn't the I2C TDM case the same as "single port connecected to
> > more than one remote device" rather than multiple ports?

I re-checked https://lkml.org/lkml/2018/3/28/405.
Are MDM6600 / OMAP4 CPU portion, and are CPCAP / WL1285 Codec portion ?
Then, it is not yet supported (on ALSA SoC level?).
If my memory was correct, Lars-Peter had some idea for Mux,
But, not yet implemented I think.

audio-graph[-scu] / simple-card[-scu] are supporting DPCM,
but it is for multiple CPU - single Codec.

Best regards
---
Kuninori Morimoto
