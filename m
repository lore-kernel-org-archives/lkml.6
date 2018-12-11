Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A98C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEE22084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="PJa8c7ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEE22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLKXQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:16:39 -0500
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:3872
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbeLKXQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezoz8QQpJu/XmhF8t8L4vxnASSqlA5qGQKgGglIbj7Y=;
 b=PJa8c7olEOVdMsO+pWwA9/WRRrHuReeDRclPKpnUp104EuV2LWILeGfgGJkfIdkohGPaJHTFJS98UMhOQ/7OYUmsL341YkhrxXZwi3Sr7YvS0NHA6A0/hJve2H+fvqoJUKY+DJMi67xBx0qOnfByW1sPhUofODjbedEInupHKtg=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB3727.jpnprd01.prod.outlook.com (20.178.138.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 23:16:33 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 23:16:33 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Mark Brown <broonie@kernel.org>,
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
Thread-Index: AQHUkQH1op9va60uk066RGBQjI/oFw==
Date:   Tue, 11 Dec 2018 23:16:33 +0000
Message-ID: <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
        <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
        <20181211141649.GL6707@atomide.com>
In-Reply-To: <20181211141649.GL6707@atomide.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0151.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::19) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB3727;20:Nja4oYwD5G69rB4hhSL3Jhom4hajAeprTEhcPFogtt86lcIkyGOknmzzuwbys+plzNqNHqsS3AcBOQdfotyT4w0YTDxSxWZeVIYupus3b8UN/Vmhl9hDupJPQn1bAFyjPOX4FjMlSE/v5LkjlgNWpCE1mIurfJ0cSqUIDJZAb6A=
x-ms-office365-filtering-correlation-id: fb838d11-1bc9-48d3-0562-08d65fbeb00e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB3727;
x-ms-traffictypediagnostic: TYAPR01MB3727:
x-microsoft-antispam-prvs: <TYAPR01MB372755EE2FCB4C5435631C63D4A60@TYAPR01MB3727.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB3727;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB3727;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39850400004)(189003)(199004)(486006)(2616005)(6436002)(4326008)(106356001)(7416002)(11346002)(93886005)(105586002)(305945005)(6916009)(316002)(476003)(446003)(966005)(186003)(7736002)(256004)(86362001)(66066001)(478600001)(68736007)(26005)(54906003)(6512007)(71200400001)(97736004)(6246003)(25786009)(14454004)(6306002)(6486002)(229853002)(71190400001)(5660300001)(76176011)(2906002)(53936002)(81156014)(6506007)(3846002)(36756003)(6116002)(39060400002)(52116002)(8676002)(102836004)(81166006)(386003)(8936002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3727;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JYa4aQrvnooyKB3p+ziJz9BduVR0y0aizdXBCGaqR79o6k3ilb63SSpJ/KKbIHfq5nh9464npCRtYB5wyZuxpghpS/CHl1WDc6a0sd3A3un67wnLV40CaDHOwFuVZoMeqe2lMXoMLP5/914yh5z5WCBSZh6ZRetPDsscVcX0s+Lf+mKhlC3/vpeBmzwmzWucKXmg1b2xFdJybTY+d5a9HwaZS4H6o/ysnEgDxLz24APHUotyYT/OxNtZPoxrm1SOT3WxquN4GVzwN+pv/jbrwG6JEb0IxPFHQnrmRQeVu9M9U6zT2VUdyNpS4LUjdRaT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E842C18E97DC84BBB6E2BD8AFE47627@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb838d11-1bc9-48d3-0562-08d65fbeb00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 23:16:33.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony

> The issue I have with that it does not then follow the binding doc :)
>=20
> See this part in Documentation/devicetree/bindings/graph.txt:
>=20
>  "If a single port is connected to more than one remote device, an
>  'endpoint' child node must be provided for each link."
>=20
> Isn't the I2C TDM case the same as "single port connecected to
> more than one remote device" rather than multiple ports?
>=20
> To me it seems we're currently only handling the multiple ports
> case, and not multiple endpoints for a port. Other than fixing
> that, things should work just as earlier with my two patches.
> That is unless I accidentally broke something.
>=20
> So just trying to correct the binding usage. Or am I missing
> something?

I'm not 100% sure your "I2C TDM case", but you can check
multi-endpoint sample on "Example: Multi DAI with DPCM" below.
"pcm3168a" is using multi-endpoint.
Does this help you ?

	https://patchwork.kernel.org/patch/10712877/


Best regards
---
Kuninori Morimoto
