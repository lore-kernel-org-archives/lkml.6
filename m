Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E49ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EBE214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iPPGcVJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EBE214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeIQI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:15 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbeIQI1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb4IJoQOPfRhx2q4SYG6PBWc6FcUBye7uVSe21CIWk8=;
 b=iPPGcVJTSRo0XaYcAkhhYDyqv1jtbLpsVZvKFs459mdJPCrOOvDtspdqoWa9oqvzH5PoIWPWGot2hBdOrX236CWM/9VVYuwocn5E31k5hHTsz1cbZszs4N1jazW0LgBP8mB8ke1KHbpndzxiERDIPpXxqllkMfx8U7rsmAPPRk0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 067/136] ALSA: snd-aoa: add of_node_put() in
 error path
Thread-Topic: [PATCH AUTOSEL 4.18 067/136] ALSA: snd-aoa: add of_node_put() in
 error path
Thread-Index: AQHUTjKmFjbOlQNZC0SS1VCDRQWQ1Q==
Date:   Mon, 17 Sep 2018 03:00:54 +0000
Message-ID: <20180917030006.245495-67-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:MvZzM1hXQ3aEvWWE/gw+j1pzCk4SxJXUcbdLI+w6jvnevhdbPKH3NsJAuQLhfJxIjAOhh1px5tTFwDR+ICIS0qTpBUDkHVtdd6k0jAjGeY1n0DJXi91h1ASpcDTXAdEpRAlrAUM6J9QBsuM+wt6IlZCARhHtj+6oG5zIS1YwhCT56DqrWSAHD93CeAPHfVuKubSOy6hfEKioY7dB/rQh5AgiuGU7ZURmjgFOGhaxI/b7A3NFRNRWsk+PkDeWuitAbbwdChI2Z0zQsjxOiDz/DToDtYo1+rAGzJwZrOaxUgzW7FRYJGCUkUA/hRSkFr9EcJJ+OHf0DEHkzaCSSHYusZKEIfx66II4XqykMj8490K7E26BYHvi/5tudDjcjuaiO2j4HG29NqL9LGxQeIep6TFCulRE0uhGy/K5gW7Gdh524rXbPJN7cYKTaF7Micgzd+qISzbl5Z7Tqy/YxsiHDw==;5:RJ7y8jO5osXSuxsINtNIUAT39YWuUHCZobkExpIgbw4/elV0A1y8VMJnQG2InuGguT5xPF7vYQH0D5t/ALdY1aIMmITvZyqik7fkBQwXbnFOAxZHe635nf66lnX7gSlQW1qKBsvHMu837aM3YU8r0+mViCxp3tJo1VyNpWeXa0A=;7:zC0TD9TugnxeCgz6pa2jmAYBnt2cwJs6PGSBXg4nZ+2sxqD/sEheqBxDWLoz+EtFOsSXknk0yNHChnE/GLoAeKJa+p6NDwTYva58ATVNijP0BZPFzWvVmopwJaVTi/Px7Qu6ZLDYMXqm8FZQTOG2wHrYWFiP/kdV7IxoIwIeBTfaXlMgxfWOcslWqqzs4w11GayNgCya48JurK96kpur357gNYoXKoWuVihY/9TW4plEp9aqIHxwPmneDRrOi1JJ
x-ms-office365-filtering-correlation-id: 821d95ae-3835-4007-b6fe-08d61c49ecc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB05023848C6C0D78DDE89429AFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qIYoZVyHxRtlUylCBB2NL1XnoPEbTopZ6heePdSkOflNU/yGHF3snUWyr5UgDNgPoClDqbTBLK08D9ZnRNQNum+a2SGtWQKZFJBdBbERGOXR7KFQeALr39IhWMndT014oSRtO78x2dGIS7oejCIwUkG0azR2Ta3XjpqE1Nj0ClTmg/YO21dFvRfrfG161COcAK8HZStWGn7anog3iqcXPCpgyp9RTRllYptUSyaOgl1tH4XoEgYQkWHb0Y8G1AlqKTiKvW59Zc4KGQOCCk0EfeouyFVdevp+BgFWG92XPMkSm9aR03SzfVKViIg3kwMbozRLfz6SX6DBYEA3OJD7UwGz5BnJyjxrtr1Fw4Pw8GU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821d95ae-3835-4007-b6fe-08d61c49ecc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:54.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
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
