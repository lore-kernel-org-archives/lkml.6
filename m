Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64250C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BFD20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="SPxZClEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BFD20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeLKGO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:14:28 -0500
Received: from mail-eopbgr1410134.outbound.protection.outlook.com ([40.107.141.134]:4524
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728833AbeLKGO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNsT4pKYkpoR9I6ft+ZgfBFe6SniZ5Xoihajmnorg8Q=;
 b=SPxZClEfBlGDSiJGWn8aq1Z0c8rOwjxdeTHGIn+IGoY+TdvoPckssnlw8JAKC6LYX6rVT0ddEJRRkqAu44HF+PfpcpAu3geG/KxYbNhvYOUHFRX7AFFmQaMMVY0Bpfm580ZhMz6eSjafV3jxlu1FFxSRUX26mlJgvc7rKp0c/+A=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2957.jpnprd01.prod.outlook.com (20.177.101.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 06:14:23 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 06:14:23 +0000
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
Date:   Tue, 11 Dec 2018 06:14:23 +0000
Message-ID: <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
In-Reply-To: <20181211053536.GJ6707@atomide.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYXPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:403:a::32) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2957;20:dkoeaQqBUYyFfsCW6QxOawQdscHTZ98Vol4PMPPOllw6jBW54l5mReGNvmYtkFR10npLanEX7axTT4fDvIPafjcC6ky3rou7xzcWNE4JGuLMtZeoSx3GZ2DJIXaXTdZeKobZb6TRySH8sYKs8wEQS63C/C4oVtctuBlKD2v208I=
x-ms-office365-filtering-correlation-id: 34b37c55-12ad-47e5-0524-08d65f2fe4f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2957;
x-ms-traffictypediagnostic: TYAPR01MB2957:
x-microsoft-antispam-prvs: <TYAPR01MB2957600B4C87C8A3B5E626E1D4A60@TYAPR01MB2957.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2957;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2957;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(6116002)(97736004)(26005)(3846002)(186003)(386003)(6506007)(5660300001)(25786009)(102836004)(2616005)(476003)(4326008)(93886005)(36756003)(7736002)(305945005)(229853002)(446003)(486006)(478600001)(11346002)(14454004)(2906002)(54906003)(105586002)(99286004)(71190400001)(7416002)(52116002)(66066001)(53936002)(106356001)(71200400001)(256004)(14444005)(81156014)(39060400002)(81166006)(76176011)(316002)(68736007)(8936002)(6246003)(6486002)(6916009)(8676002)(6436002)(86362001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2957;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yo422hyrLKX2Wk7S21Dw4fmfrEqOq02JLQYfX6HOabxI8llwIuToLl/bEff7EVNxliP15KDOyYTQWrXBWMRFTAs9EE57lPVDFhadt1T2pW1v+1Lw5RzS2TzDZSN8wYHPd/0NmKyY6FXgKV9K9Uq9QjUOSvyWXaFlEXonTq64HUy9NwY73sXgXMvTRWm3f5Ax7VmSt7HE7LLJ3jW6WIU4Jc+7A/vqYa3iOTxerZb0snmfg28ChBcqjERfjeu9nq6lFHO4w0Gpx1grojUiknp8ZzCG1AVaLkatnJF1ZxGvkygTsSXAODozNcp351h6hnbt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B63FC647395F304C83C6BE3AD100530D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b37c55-12ad-47e5-0524-08d65f2fe4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 06:14:23.2033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony

> > And, your [2/2] patch,
> > I guess you are misunderstanding about "port" vs "endpoint",
> > or omap-mcbsp driver side need to update ?
>=20
> Yes omap-mcbsp driver needs to be updated for multiple endpoints.
>=20
> Adding Jarkko and Peter also to Cc, below is the WIP patch that I'm
> currently using for omap-mcbsp to add more DAIs.
>=20
> So far nothing else to do in the omap-mcbsp as it's the cpcap hardware
> that configures the TDM timeslots. And I'm currently assuming the
> first instance is the master, I guess that should be parsed from the
> the frame-master dts property instead.
(snip)
> +	if (np)
> +		mcbsp->dai_count =3D of_graph_get_endpoint_count(np);

OK, you have multi DAI.
Then, you need to count is "port", not "endpoint".

So, your DT will be below.
You want to have is *1 for asoc_simple_card_get_dai_id().
You want to double check is *2 (maybe).

	ports {
		mcbsp3_port0: port@0 {
*1			reg =3D <0>;
			cpu_dai3: endpoint {
	 			dai-format =3D "dsp_a";
 				frame-master =3D <&cpcap_audio_codec1>;
 				bitclock-master =3D <&cpcap_audio_codec1>;
 				remote-endpoint =3D <&cpcap_audio_codec1>;
	 		};
		};
		mcbsp3_port1: port@1 {
*1			reg =3D <1>;
			cpu_dai_mdm: endpoint {
				dai-format =3D "dsp_a";
*2				frame-master =3D <&cpcap_audio_codec1>;
*2				bitclock-master =3D <&cpcap_audio_codec1>;
				remote-endpoint =3D <&mot_mdm6600_audio_codec0>;
			};
	 	};
	};


Best regards
---
Kuninori Morimoto
