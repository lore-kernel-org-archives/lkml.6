Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A178C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2084C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ppPV+yCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2084C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeLKFaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:30:30 -0500
Received: from mail-eopbgr1410101.outbound.protection.outlook.com ([40.107.141.101]:13568
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbeLKFaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmA1q+2wLUhJxisaMibNWCJJ1yvEFOEaVYqWZs6/WpA=;
 b=ppPV+yCVytTN5nK4HN+xBUSz8Q03cmvIiwpzcVaaL2Zy/CEib0XDPzuujUerFUwBwGubmy355W92zUCwCCmFRTIspOlNehaPkcpBUDZTHHbniyROWk5rbPGNe1KohrtPfDekvgIeIXqrt95pKkMexilkZINGG1/C8oSjUrq2rqQ=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB3149.jpnprd01.prod.outlook.com (20.177.104.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 05:30:22 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 05:30:22 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Topic: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Index: AQHUkQH1op9va60uk066RGBQjI/oF6V5AzOA
Date:   Tue, 11 Dec 2018 05:30:22 +0000
Message-ID: <87zhtcabc0.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::24) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB3149;20:qL9XX87rBqDxTv/OGJ+9RmoGDCnNwPDrgIRvB7tvoAtYR+gJw4T5CLtkJa8EaQITfRCIE8ObD2NfBmPLmSK4ic6wu5LKhM9sIvB1nD3B9GZPMm9KxI0AhRbMKyCvPS/OgqsEPOcER2ipUdquA9y4bTIAbVr2nLS42o1RzoZ3PLY=
x-ms-office365-filtering-correlation-id: 584abdeb-f8d5-4a2b-c220-08d65f29be81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB3149;
x-ms-traffictypediagnostic: TYAPR01MB3149:
x-microsoft-antispam-prvs: <TYAPR01MB314952D4A0F6D5EF2B55F325D4A60@TYAPR01MB3149.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB3149;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB3149;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(186003)(6246003)(11346002)(2616005)(53936002)(476003)(6116002)(71190400001)(3846002)(71200400001)(7049001)(86362001)(66066001)(486006)(7736002)(93886005)(305945005)(68736007)(6436002)(36756003)(81156014)(316002)(37006003)(14454004)(8936002)(229853002)(478600001)(6506007)(8676002)(256004)(446003)(54906003)(25786009)(6486002)(99286004)(81166006)(76176011)(6862004)(106356001)(26005)(4326008)(102836004)(39060400002)(105586002)(386003)(52116002)(2906002)(97736004)(6200100001)(5660300001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3149;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jp5HclysJDDxUxJl9guzNj1mSJeSvac/sec8/Z8zLMZwlCpZaGX0mxTWaOFRUrxlhxTegzYvKb4Um3ab/U2s741+d7RP6AVBFy839ClH06uY4D1T+3HHKGr26N/hlUAx2FrlDUmxoC7tHiJJ/QA7Lz0azzkeQsEs3VTUrebxgI6FTyopKwZafqzrZcNt6o6we+2YoesMESpeVW9nrKXFHUWMk/2CbwSl8/ccVkCQt/hxDBGub7aAGp1S3woRya9WMkbxBr6BKKGtSVpGWjegS/MnzLYorK4QNA+BLxF5cKmLyZeDAdzw6meoCpl553sK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A47DDBBB932B94D8EDEDA2314739F32@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584abdeb-f8d5-4a2b-c220-08d65f29be81
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 05:30:22.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony, again

> >  	mcbsp3_port: port {
> > -		cpu_dai3: endpoint {
> > +		cpu_dai3: endpoint@0 {
> >  			dai-format =3D "dsp_a";
> >  			frame-master =3D <&cpcap_audio_codec1>;
> >  			bitclock-master =3D <&cpcap_audio_codec1>;
> >  			remote-endpoint =3D <&cpcap_audio_codec1>;
> >  		};
> > +		cpu_dai_mdm: endpoint@1 {
> > +			dai-format =3D "dsp_a";
> > +			frame-master =3D <&cpcap_audio_codec1>;
> > +			bitclock-master =3D <&cpcap_audio_codec1>;
> > +			remote-endpoint =3D <&mot_mdm6600_audio_codec0>;
> > +		};

audio-graph-scu-card and my posting merged audio-graph-card
are assuming multi-endpoint will be used for DPCM purpose.

But, above endpoint connection seems you want to is
not DPCM (?), I'm not sure.

Best regards
---
Kuninori Morimoto
