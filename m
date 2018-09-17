Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38254ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA23214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mFYEJda4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA23214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbeIQIrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:47:14 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729100AbeIQI3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb4IJoQOPfRhx2q4SYG6PBWc6FcUBye7uVSe21CIWk8=;
 b=mFYEJda4zLjFOPI1mnhgwp1g+cQiSM0uoi42/1JDcLbz8ZPQ3XiSp8wsIm3Zd4c7rGhNlTqoBGwIx/MmKrVLdanlESCXF7XB79JHhb8P4+YvWvgbyg+BOPuNeTHrsrB8Zh2lTtVUGgjvhVjWHuvL9A/bKjdMe9wRbvFFZRj6GNg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 51/87] ALSA: snd-aoa: add of_node_put() in error
 path
Thread-Topic: [PATCH AUTOSEL 4.14 51/87] ALSA: snd-aoa: add of_node_put() in
 error path
Thread-Index: AQHUTjLutptkpidiF0i+WroQL009kQ==
Date:   Mon, 17 Sep 2018 03:02:55 +0000
Message-ID: <20180917030220.245686-51-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:1jEjwPhuufL/oiiKf3tnmLzfJ3YhERzBdp+JjU3jFCO1u89xBS+h8c0FBwARU4nVIZUKJDV3DYGZxhPiN1pcLFEA9/trV/Wa8SCoVpRjSGdRSyx8n5I8G3gXTxLpMWioXAY6yXdLZv/NK/N/IK4gIk1ZiTsB8uj+r5UYP0vvfTGMv41Oi9/qSOhIduRfyWxUiLmtqHaHpOMNp4R26MyJDng52bumgsDJsXXI9YngPetRSAksQsJVqrGihLruFx8LjXQyMYYhfpZb+Dp2qycLb95OWrCkolL/BPtphdAycNvs5xyiU78sOFYauHVG0s9xz/cOshXKXcjP07baONJ7SQgRC95qebIeKJmghIJZIzy3Mu7QQmXOuxjlqDrHJmiTfSaLACV5VCR3rX9t2lozuXWgIBXWwdtMmGLudHFxJiN3ItkJ5HLU+eXFZsdC/Ex9iT2H19gQOGH7n0Hl4uATBA==;5:y8cpXraIo84SAByKWwst4kIvdirRUAS//TXbxW8RzaqZ/ngQHoSDlDBLLWzdflLW0vu9itFezI5K90s6g7XwRxqnVP9ksnbZTGnai3amVNDvA1XDqkksfxSoZhmDDJTDpSI979fR5o8F+jp46fvELzU+ydbN1bBt2dykv9uZnKk=;7:3Gm89u2aZkjeMaGAOof0Bs1js9PkgWNH1AHQv6rikInX7qrJ9NckSs1jwMmXdo/JcOx2OeiszZhHi/ZaYSJgAycN3RUiM4QpcRbYAf37Gqg8VoO3LztrARLoEatAa4ulljGxaMsPslhMas/VND5hndIbubAMqLOsXzUh3hcbtoPqvjJpX0B8GH5/X7E+3soLeorriuYdgJUWMCEPEXqKNarG7ALZMnLXVDxjCgo2koJq/QhBZpfpPeULD8tKwqHB
x-ms-office365-filtering-correlation-id: 8e62a364-9c09-463f-c789-08d61c4a4305
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774C08622632285EB27C955FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: j1p32+quvKmez4PphOtp4lOk0eRrYBpmpnhtyWWxLi9M0CWhP4kLwuAis5L/DlcS7Mk35g6vBgCZBmfJhVk5e0mM4aEkfdziJmTG7TNdu+Q0av69QdKkSll/bnqgITpYp6UsuaHmOqqe20NeMSyLJmNRAQCImLbg0BzekpRkybc54ka9WR5WRGlqUQWIgn6gq7M21XYyGLhX78quQPc3m+bLggY66/wzfsIdEe9sm8nivk8L+YFQgTnckt9Bu9eOuIhhnzctdTGQCmtqsKXJC9+80M55uJbHekehBtOfDWB0MlJMB035ws5t/2OxwU8SLTddlovdwuDNnGnWq0LVLCPg2QHvlaYQlzQXjyrP4I4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e62a364-9c09-463f-c789-08d61c4a4305
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:55.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 222bce5eb88d1af656419db04bcd84b2419fb900 ]

 Both calls to of_find_node_by_name() and of_get_next_child() return a
node pointer with refcount incremented thus it must be explicidly
decremented here after the last usage. As we are assured to have a
refcounted  np  either from the initial
of_find_node_by_name(NULL, name); or from the of_get_next_child(gpio, np)
in the while loop if we reached the error code path below, an
x of_node_put(np) is needed.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/aoa/core/gpio-feature.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 71960089e207..65557421fe0b 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -88,8 +88,10 @@ static struct device_node *get_gpio(char *name,
 	}
=20
 	reg =3D of_get_property(np, "reg", NULL);
-	if (!reg)
+	if (!reg) {
+		of_node_put(np);
 		return NULL;
+	}
=20
 	*gpioptr =3D *reg;
=20
--=20
2.17.1
