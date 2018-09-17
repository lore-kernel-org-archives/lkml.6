Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84ACECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534BD214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P9Pk+MAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534BD214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeIQIce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:34 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730359AbeIQIcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNqY2akM5m3F0PykNQXTFuK2qQFIAOFRnDaujIPeZto=;
 b=P9Pk+MAL9X7dNrCj1nbtkRaNGdvlbSM+FPoBenv5vbboKGmATn+t+XOUmI43g2pStPPF+dIsMCfN9KJpGWUWLxRX7smMJkJOvF5GIS7wGO69DRXxPYmU+/lDfB4+RaVJ+RiAD2rH7IXzjvoQUHaIRJtYfFYFFA+JgfqGQRbl544=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 24/43] ALSA: snd-aoa: add of_node_put() in error
 path
Thread-Topic: [PATCH AUTOSEL 4.4 24/43] ALSA: snd-aoa: add of_node_put() in
 error path
Thread-Index: AQHUTjM6BYxk602Uv0qCli0DFI/fJg==
Date:   Mon, 17 Sep 2018 03:05:03 +0000
Message-ID: <20180917030445.484-24-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:eH/pkJj/BjxdqxKQd9xjUoZ0vh+ANlax64ZCHwVh2l7LYboulM/UOGVQOBFcSstkKAgzq8fFKaVu9HwY7+sVEMsJk1AR7aea4ragTt/A00ZhQUFr0pMyKPm1zlEb29AVxekH8qo4C9+22XGBXrQ+dUQ+AMMAYNCVEti3N4GqEpyQ8WNN38ZLWNqttPjD5LqgDGExTm8tN2hL/Y7jCMXXJPB5nBvav2ydIVNktPH+4NJuuwBkkTB7hn+S2E8m0AbRWs+PbeLi5PLlX9PaOg6COM7bi0u1jSe5lGYvpp9rElNrEv4YrD0pr+rCobNzOv1B8BGQTjEpzA2P+4SDQsS3RqvQwhHYWpaQ4IEOo3+RXwunLjTpNoSi5POzSXdZGqR2jXUf4s06uG7p6Rnh6ly2An851tfHVYLIgLGyRt2vKM7SOWdbBa+1/E3C5ec5iO+9uJ4uT0wSHMKny4oSvwZuzQ==;5:MRimBHKGtp/fNrkqeqZ/MW+Uom7sCFI7J/l/ZcQLMVSxsSP+jpagCrNhvWkxy2JAw0w1LVDWMHIn4bM/dklA98BVAXrG5stiheS12Fmwo78z78LbIXbWGsQNqLfYrakUIOdDRwBeD1/W7GNnlZsk2ZOGy1Gg8er6007KY2UPnO0=;7:lr+JrNnKjsRH4637cZgBdt3LesvRxUaDb26Y6F0sxG0z0HV2TseWOn6tCJZs6csXyRg6I+0XRcr53xwIi2JTGMCrMVP83+JLPbVB4S/NL7KX/nKylKdak0/wnUpNT0ImaDPjBeY4t5Ri5ttQJZAzoWk7ZeVnWRnOVzwLqzwmlmAeWr78Ut8zni/jzOFcDYQRsqYNRfjZzL3kI0+gOFWRkAeNBkjM7Uy4uJnycF35iXvem7u41Sj67CwwP/nmaRDa
x-ms-office365-filtering-correlation-id: 60bbbe52-4fbc-4a4a-4c30-08d61c4aa8cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759DF481FF03E103396BABEFB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2OZIt7xdf3rLvKHBwbToIjZKnixOsv98XZBbTNHgIwasBCSqd3i6QabteG1rYVQqjgJBQ0FbQDJkUNhy4NBD7dxmMe8OOYUqc996z2j7VDAzslU5KPwi9wnn3USjZiVQ/tO1r0aDdN/YrDu3CD8am1eN7fofRBKuRm0/fyHgB58FKcXFAbwaWFfTI47b8nwcm9IzAie1Pv7EP9PlRlq5elrT/AnmaCPp71M4HBpdAN7hStMyUspG8zYvG8Z0wrRx7tZXF4rNd1q8wZbCtimbTKa11ydp6IL7qMErscuaWwWrqYQH6CXi2mKAxSxvfBhWRvrCGXJO8gKrdVaTBG38m3+ot6PJYLhZxPaMuRByEp8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bbbe52-4fbc-4a4a-4c30-08d61c4aa8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:03.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index f34153962d07..585b594bd838 100644
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
