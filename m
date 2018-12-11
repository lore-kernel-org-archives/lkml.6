Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA41FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bsW8JaDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9A3205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeLKAZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:25:20 -0500
Received: from mail-eopbgr1410125.outbound.protection.outlook.com ([40.107.141.125]:4416
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727061AbeLKAZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKCYNyF/g445ImGhXkAZptQBUdUsu1iH1aI5a1sMlMI=;
 b=bsW8JaDcfq3z0fXv8pmoIu07CUaGCSfIQ4QK0Qt9dyw5WZrUfLr6Ep4OWVgmSzpoLu5rw97QHbj488Y0s14l5E96dWesOPlcSFBSsgIw3NFR04pJahlx5vco3wGnsOupoRWixfMm2NrjCYSJFeGSxVO48Ats9vQ1oIipZJO0GH8=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB4317.jpnprd01.prod.outlook.com (20.179.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 00:25:14 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 00:25:14 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: simple-card-utils: fix build warning without
 CONFIG_OF
Thread-Topic: [PATCH] ASoC: simple-card-utils: fix build warning without
 CONFIG_OF
Thread-Index: AQHUkOf8HehvJh12ZEeeCCZW1cZhqQ==
Date:   Tue, 11 Dec 2018 00:25:14 +0000
Message-ID: <87k1kgc415.wl-kuninori.morimoto.gx@renesas.com>
References: <20181210204640.2407929-1-arnd@arndb.de>
In-Reply-To: <20181210204640.2407929-1-arnd@arndb.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAWPR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:402:b::29) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB4317;20:3LQidstxzi80MPHqkcv37wggLf4KyWR1Q7N37F2WXwM6BnryLaSagsu+PlySKKpHqdKU1c9b+ag1ViQ59qVDqxHnF5zRoJhJN/h/Siwma2Ezc9EcTpbGosJMDhYpzGUL8q+selbMBDEJf3I4GwTUfAy7904ApfqfRujBO66BpDY=
x-ms-office365-filtering-correlation-id: e831ef90-030c-42ba-ecf9-08d65eff1e25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB4317;
x-ms-traffictypediagnostic: TYAPR01MB4317:
x-microsoft-antispam-prvs: <TYAPR01MB4317DED107DBEF76692FCE84D4A60@TYAPR01MB4317.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB4317;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB4317;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(52314003)(4326008)(86362001)(53936002)(39060400002)(7736002)(6246003)(81166006)(99286004)(8936002)(478600001)(6916009)(6486002)(81156014)(97736004)(229853002)(25786009)(8676002)(2906002)(14444005)(6512007)(305945005)(256004)(36756003)(386003)(5660300001)(446003)(6436002)(186003)(26005)(3846002)(6116002)(71200400001)(6506007)(102836004)(105586002)(66066001)(11346002)(316002)(54906003)(52116002)(68736007)(14454004)(2616005)(106356001)(486006)(476003)(76176011)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4317;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oimgT4RoLiSDVhGjRQSzl5f13y6nFVuxSLMNmvuosE1cEFcqGi4AMoCFPfQ5/qjTpiDBbNeefCvv4lqAm893UIcGC1s+jTqW1wXmEeCT8MFe4can6U3t2eNpNg7I2qNQRiakS0hdo62o3cDzK3j8K5UgEQd/uekfrKiLpB9cEdY9z2+SIySsGV/r9pG/Hhvz0gNq7Tjy/2gyubwbcjVIwYY+1Ci7AxiF3GGlziaebz285twcAnrAdT2gOBQj6JIVntdbKqjb8QVEIKpkUYuqNBuyph/32oOqhZZASycDZ7kxttXtYwSQOj8bpIBoAfoc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80F3DADD8AC5934BA270CB4584F12BFC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e831ef90-030c-42ba-ecf9-08d65eff1e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 00:25:14.6071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

> When CONFIG_OF is disabled, of_graph_parse_endpoint() does not
> initialize 'info', and gcc can see that:
>=20
> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_card_pars=
e_graph_dai':
> sound/soc/generic/simple-card-utils.c:284:13: error: 'info.port' may be u=
sed uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>=20
> It's probably best to check the return code anyway, and that also
> takes care of the warning.
>=20
> Fixes: b6f3fc005a2c ("ASoC: simple-card-utils: fixup asoc_simple_card_get=
_dai_id() counting")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

