Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F82B20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="nMDPJO76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F82B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeLKFQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:16:10 -0500
Received: from mail-eopbgr1400110.outbound.protection.outlook.com ([40.107.140.110]:20244
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbeLKFQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3HBODzkUch0ndlruiPywQzhmGdBhlsByinEQaBVXbg=;
 b=nMDPJO76hgAjxndcrPD0A0bA8mWFUlyKJSpRVxeobfEpTHia2huDnaG60ZUlJ/sTHEqzQT4EXySUKVvEKq7I0922dpPcsd3dIXR6aU2oqxe5ZlUer/ObztP0+6PFkIPqptTys0b8iJZkCZGN2dwyRhCUJEK45Odep5IFD0IUdjY=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2496.jpnprd01.prod.outlook.com (20.177.103.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 05:16:06 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 05:16:06 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Topic: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Index: AQHUkQH1op9va60uk066RGBQjI/oFw==
Date:   Tue, 11 Dec 2018 05:16:05 +0000
Message-ID: <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
In-Reply-To: <20181211045220.GI6707@atomide.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAWPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:402:b::15) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2496;20:a9QKuDyAx42SoU7TeBGLEDtEEHjCvvOmjs+TyVna8Ghx9vC/i1UzLaSSnMHJZh//5wOF6qNy6641vQnJbdNnWVNHAko9LMmgn7RqwQy8+NJioFTjNcENYu+95kfpM2Z28vV0mz5WufRFJy5Xbu8LOau3mNOF1GP1ksgte5wBJc8=
x-ms-office365-filtering-correlation-id: 69317574-ce93-4583-1da6-08d65f27bf31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2496;
x-ms-traffictypediagnostic: TYAPR01MB2496:
x-microsoft-antispam-prvs: <TYAPR01MB2496B94F0ED0C972EDD3653DD4A60@TYAPR01MB2496.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2496;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2496;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(2616005)(102836004)(86362001)(8936002)(81156014)(81166006)(8676002)(54906003)(256004)(14444005)(486006)(11346002)(5660300001)(446003)(6116002)(3846002)(68736007)(2906002)(476003)(36756003)(97736004)(229853002)(6512007)(99286004)(6246003)(53936002)(6436002)(4326008)(52116002)(76176011)(6486002)(316002)(71200400001)(6916009)(6506007)(71190400001)(305945005)(7736002)(105586002)(478600001)(386003)(25786009)(26005)(66066001)(186003)(14454004)(39060400002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2496;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 898RrcIRRDdYpsD/b/WSk3Emso7XSO6t48x1f++lNa+az0tUe/gkUeQpzOhBEdYR8htZyz6MGsn434e6hqDs2IKOiGL/0IG1dZSp28FygCIXnwazDWfNcAUqELrjDD2yrlKQgvUqlL49yPGtuTgVqnIxG9OktrBcyo6Jojj7zmO650rqCUBU8f+BXI+LrbT4fq3dtko19z4laNezbE0VEpH8vhnHyRZkGbRZJ6Yi8A87zlilDbqOT5gmak1eKj6sCcFAlkJg9WXzTOOqatXCsHIQnYv14+whHUMV4Ty624gxasLObnZhur8otBOl5mT+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E720891F15990429C3E7D1D654E040D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69317574-ce93-4583-1da6-08d65f27bf31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 05:16:05.8972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony

> > This looks a little bit strange for me.
> > Can you show me your DT for it ?
>=20
> Sure, adding also Sebastian to Cc. Here's what I currently have for droid=
 4
> dts with two codecs on I2S. Please just ignore the GNSS parts there..
>=20
> The TDM configuration is all done in the cpcap_audio_codec via set_tdm_sl=
ot().
> The modem voice call codec is a serdev driver :) I'll need some more time=
 to
> be able to post patches but it's basically working for voice calls.

Hmm... it seems strange...
I guess you are using "ti,omap4-mcbsp" driver (=3D linux/sound/soc/omap/oma=
p-mcbsp.c)
Is this correct ?

If so, your driver is registering component as

	ret =3D devm_snd_soc_register_component(&pdev->dev,
					      &omap_mcbsp_component,
					      &omap_mcbsp_dai, 1);

Your driver has only 1 DAI.

>  	mcbsp3_port: port {
> -		cpu_dai3: endpoint {
> +		cpu_dai3: endpoint@0 {
>  			dai-format =3D "dsp_a";
>  			frame-master =3D <&cpcap_audio_codec1>;
>  			bitclock-master =3D <&cpcap_audio_codec1>;
>  			remote-endpoint =3D <&cpcap_audio_codec1>;
>  		};
> +		cpu_dai_mdm: endpoint@1 {
> +			dai-format =3D "dsp_a";
> +			frame-master =3D <&cpcap_audio_codec1>;
> +			bitclock-master =3D <&cpcap_audio_codec1>;
> +			remote-endpoint =3D <&mot_mdm6600_audio_codec0>;
> +		};

And here, you have 1 port, 2 endpoint.
Then, asoc_simple_card_get_dai_id() should return 1.

And, your [2/2] patch,
I guess you are misunderstanding about "port" vs "endpoint",
or omap-mcbsp driver side need to update ?

Best regards
---
Kuninori Morimoto
