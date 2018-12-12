Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77192C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3127E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="dSwPgtaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3127E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLLCLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:11:15 -0500
Received: from mail-eopbgr1400115.outbound.protection.outlook.com ([40.107.140.115]:7680
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeLLCLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84WAXCSKZVjeQjZ9BZ2dhFxqEx34wyobX2YP9gpFh2I=;
 b=dSwPgtaNaWtrJkxZ+hznXBXHvkb951gNI3m/mh/Od9xyX190b7Dlbbq9qYvzIjamN+E0HAKu5iIQ4tQRIqKf2YbbNnso3URVJUn1MgSEauYhW0g0ORp2QZYcjBfuOUid55JXXvoycjTkpYCmnX/36beL7C9Li1c/PiA0xHBs5/c=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2685.jpnprd01.prod.outlook.com (20.177.102.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 02:11:10 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 02:11:10 +0000
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
Date:   Wed, 12 Dec 2018 02:11:10 +0000
Message-ID: <877egf33m9.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
        <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
        <20181211141649.GL6707@atomide.com>
        <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
        <20181212001950.GX6707@atomide.com>
In-Reply-To: <20181212001950.GX6707@atomide.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::27) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2685;20:KWQ1I7rWlNVcNSU6oSVllWnEsN0PIHCcXwG9N+f4VMHSXk1CH9LlP0yqO1stFT4I5f5aHCyR+NrAQSmXTvoI1f99IpniVHEOeM9RFMLR4cHdYJ21Kmw8q7KVt+yDI2edpjzsVeZoGmmciCLf/hKOSuhwJIrC68OvIQGSVq0PbPY=
x-ms-office365-filtering-correlation-id: 425fb644-8c20-42a0-8270-08d65fd71513
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2685;
x-ms-traffictypediagnostic: TYAPR01MB2685:
x-microsoft-antispam-prvs: <TYAPR01MB2685D815E26C68C992C33ADBD4A70@TYAPR01MB2685.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2685;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2685;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(229853002)(6436002)(446003)(36756003)(86362001)(6486002)(2616005)(476003)(99286004)(11346002)(486006)(105586002)(966005)(14444005)(256004)(14454004)(68736007)(97736004)(478600001)(71200400001)(66066001)(71190400001)(6506007)(93886005)(76176011)(39060400002)(2906002)(6916009)(3846002)(316002)(386003)(25786009)(6116002)(54906003)(81166006)(81156014)(53936002)(52116002)(106356001)(5660300001)(8676002)(186003)(6246003)(26005)(102836004)(305945005)(6512007)(8936002)(6306002)(7736002)(7416002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2685;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8036LYIroW8bqS9gDcBUmmFKkrNWfW/bnVs67Ebhs/O4AvH+g2LglAiHPrEZRlMD8OGyLLRtdLdE6wjTK3Cr37bZtbzBwtsrMzA+vrveUrYmHnh19OvgIhRudjqH0GFoEU3CjFsfaqVo8EByi0I5e67AGk0s6pHU/2FqUsutmxnti53J5p/OYlCoaVOLEDZW91qQ/E2K7EWgt5DsPX1wbzVUmpaqZpj13S2evhD5LbYktKBCYdTvAdKWH5WKyW2FF4WqF2JZcgkIMvrxjoanOOLbzU0ST0Wx5/QwVA7TeizNX2wp5tsCufPZoeueaXuc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BF58D36F053954BB8A90ABD68999A1D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425fb644-8c20-42a0-8270-08d65fd71513
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 02:11:10.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony

> > 	https://patchwork.kernel.org/patch/10712877/
>=20
> Hmm, so do you have multiple separate ports at the "&sound" node
> hardware? If so then yeah multiple ports make sense.
>
> But if you only a single physical (I2S?) port at the
> "&sound" node hardware, then IMO you should only have one
> port and multiple endpoints there according to the graph.txt
> binding doc.
>=20
> In my McBSP case there is only a single physical I2S port
> that can be TDM split into timeslots.

Mine has 4 DAIs. Each DAI can output 2ch.
These will be merged and wil be 8ch TDM and goes to Codec.
But hmm.. it is 4 DAIs, but 1 "physical" interface...

So, your patch seems correct, but will breaks DPCM...
I will confirm it.

Best regards
---
Kuninori Morimoto
