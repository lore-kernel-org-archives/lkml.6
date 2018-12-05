Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6962C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEDD2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cFGlfIH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEDD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeLEJEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:04:07 -0500
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:2784
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbeLEJEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toEQ+Ypw1VCWaM2l/Ek+/ES5nJRAjTdOj9Em6bVh0Xg=;
 b=cFGlfIH3wf1gzJEcfuUswMDHie/4P2Z/NyE7B/F7EaEqhLH/FtK4kNokHspk51S7aXw0TZkAzMXw91TY0tbmWfbD/hGdT5TFpkpUMYSve9aMrz35wY4PwnH01tBKbRVKoi+YMl78mgmVRXm1F4L2WyV8D3GLDai6JlvJDrxUVbI=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2031.jpnprd01.prod.outlook.com (52.133.179.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 09:04:00 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 09:04:00 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Jiada Wang <jiada_wang@mentor.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next v3 7/7] clk: renesas: Add binding document for
 ADG
Thread-Topic: [PATCH linux-next v3 7/7] clk: renesas: Add binding document for
 ADG
Thread-Index: AQHUjHl2rBzsA+UoK0aZ5TNC5haRsg==
Date:   Wed, 5 Dec 2018 09:04:00 +0000
Message-ID: <87tvjsbbgh.wl-kuninori.morimoto.gx@renesas.com>
References: <20181205074947.28151-1-jiada_wang@mentor.com>
In-Reply-To: <20181205074947.28151-1-jiada_wang@mentor.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAWPR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:402:c::24) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2031;20:tSmQwjcJUDa3PHDDjk76veHZ4QL6gJSezzhhW+FOojQjTSsYJFzmc/YL17GK1SWZaw0fzjdoEwm/U2uklrG8MvtR21JzAFURoil7kGOeonR0/ozxqycLGBBdGv+tnIgsSnZ8lXsDIY+Dqn0MMfh+4nlg1aDqy12FTCxpBDBwoRs=
x-ms-office365-filtering-correlation-id: 57590b06-f7cf-4a25-71de-08d65a9098e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2031;
x-ms-traffictypediagnostic: TYAPR01MB2031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-microsoft-antispam-prvs: <TYAPR01MB20310FC866D97637FA8519BBD4A80@TYAPR01MB2031.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2031;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2031;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(99286004)(97736004)(229853002)(478600001)(6246003)(486006)(39060400002)(3846002)(6116002)(6486002)(6916009)(71190400001)(71200400001)(81156014)(81166006)(8936002)(68736007)(11346002)(2616005)(476003)(446003)(66066001)(8676002)(2906002)(316002)(5660300001)(14454004)(86362001)(106356001)(54906003)(4326008)(36756003)(6436002)(7736002)(305945005)(105586002)(256004)(53936002)(186003)(52116002)(386003)(6506007)(26005)(102836004)(6512007)(25786009)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2031;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1OCD1Fe8+y9upokBCcPNl72NVsPBvOlJ/1n6K+MkYdhNDGPLijlaf6VcGu/n2AWEuPgHlRtO+n0BHAsXuKjqNOA4IfH1UIiXfQTZvnSSXB+ssVsOWbEiijBBO4yz8ETOKjqCW40qqLxURDd+8AzXohm0akSJCnPnWRbv/bMxaFDZj5tHkqhLHMALERoPHcaQnf6O/N2ZS7EW2Co0yfqgk4zTQnVjHMiGsfmr1GF8ybSYiQmEyHC8NuG2wt0Ig4DlYyzHe7RUzwWhG6/GqJy5zAfbhH9DzA4OQ77wONdAD5KRZV2NGok2E1+u2slt2ZuWfS3lVm3KUY4FETaPTKOe2Px4lPJwMLQpUfPK4f79mgc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8D42DA6DCBFCF47B978DD4AC916FAFD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57590b06-f7cf-4a25-71de-08d65a9098e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 09:04:00.8708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jiada

> Add device tree bindings for Audio Clock Generator (ADG)
> of R-Car Socs.
>=20
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  .../clock/renesas,rcar-adg-clocks.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-=
adg-clocks.txt

We want to have this document on rsnd.txt instead of
not-exist-driver file

	/Documentation/devicetree/bindings/sound/renesas,rsnd.txt   =20

Best regards
---
Kuninori Morimoto
