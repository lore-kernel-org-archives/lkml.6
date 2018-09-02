Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C7C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542920857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YphB+rh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B542920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeIBRq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:46:26 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbeIBRVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWsO78/rqAFrIuR/GAtgf3m/DB5UObxE1djap7PxbA4=;
 b=YphB+rh+Zlm6E4ieA42Thj1L/EyoICrKJGO0WYWv3s5r6uHvbW2VzepPRqiNjjy/EG6MITg5OIr9WaifWxJGM+wl5A02kfA3sKreLo5JYJZiGIlrOVC1lH37YPF66tekK1nhbCj1ZsWhLnK+r9LwMywib5OrrNBwJeJJ40r7OnQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 097/131] partitions/aix: append null character to
 print data from disk
Thread-Topic: [PATCH AUTOSEL 4.18 097/131] partitions/aix: append null
 character to print data from disk
Thread-Index: AQHUQr2Rm/X+cuwVC0CrLUy3HHBP0w==
Date:   Sun, 2 Sep 2018 13:05:05 +0000
Message-ID: <20180902064601.183036-97-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:bl1f4U6P/ADkixe1P9TqlQwnB8zAUi5oyIy5IWrYStzpzH7QrHUrVJtUsEC/0jU6PxnredycIIEEghwy4gfZkQ5cZsgmqFpJraMqm69ic4WKRbrGVJB+FC2CQgGVAo0ZZb/Tp/fgdxkZqkDM9Ip20M40kDobqCn2pROvsAbKXcNCnlPsPxcv5TZD1NDnX9HiTVfWH3Ui/C4aVS1xsmbIpQ4Rn8NgMUCUjUkxT7FkSgPtu1OkXYCYpPyHymjpYXTCSkXs/EdRcUq+dFtg212EsLG9AK/Ww3kcnlpuRPhzE6BqoIbt8CK5TyMJP8PCdt2q6j7LgQM0xwxE4/dn1J88ee/A7R2qVNyRkC/kvpgdxNOVz/zmC1C/UnfXHPK60uH4gEhp6xlZmcVovYddjrQBnIoPkVYb9YxTv8zv7JzEd73s4cwqLuCU9GmJVgzXS0/1OtC27ib15Gw8yWWbl0mgyQ==;5:1Zqi4CC2Lmiw1iYsp+yBVrSZxGJFKEVWpsG7Alf/60GS+P1uuuuDyuj/QDo95NP8u/feQ5zNnJz6HWUvGjvDr9IDKFb36uMXDrBNlzBco9BjNWjCtN3xwU47HpQcvumqZTTM8WCwv/oFeDso3tCxLT0hETwlWYsF3TTBYoIWBEQ=;7:lhFblfBw0E0v1y50TW8AAAG917Rgqq82HU1B9yIZ55IlB8iN3NdsxuiXnNaarzQnKRl2F/VkvfxMygLOD6IxfAEAPOJsJdWkVMyPlYx7ai4Crqi7gxm9nCN7OcPALLmfLqOEPkBaxEu9hKaQKhiSIT8XA0/NAipgJP4LSfdOLXsb791IT/6ERDAnSWPyau1Zlx3czFYO93dbLExR5MfWeIC7BhAauh6v92WyFER+CAytC/gMBNk4+aIewAA0pleF
x-ms-office365-filtering-correlation-id: 5ebcd633-c398-4036-64ae-08d610d4c49d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184924882DD0C6E57AA1570FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aoL2bMySfx8Om25aChVx5ANpDIwgh4conXhP6yoGeAZKE56KbOL9YeAjaFXfiVILRUZqFYbZwo7NCUa7Dip418CR2RBeMEnBXDGYhs2ndlvS06xHFl1TpDdLoq7lwwyd2kxhhqZSDm+iswKnS1+89TpChp4rj3vdq0qiLrUyU8hUV8vues6pge9s9e8r1HvtF46JMW/n6pgoJBUfsAVbs7J5wS1vnKFFZkFA046iCN5q+Ojrl8V5OSMsTPL6iHLnsQ5nc2rMGCetrGpSbWYdzGbdUABMqOToAyA6wib2rU2qri3pUfFOmlK1vN+p7qHS+Bty0hJ6jvrm9UuoRGUjhE0LSLTUoH7vBSzlIthuys4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebcd633-c398-4036-64ae-08d610d4c49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:05.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit d43fdae7bac2def8c4314b5a49822cb7f08a45f1 ]

Even if properly initialized, the lvname array (i.e., strings)
is read from disk, and might contain corrupt data (e.g., lack
the null terminating character for strings).

So, make sure the partition name string used in pr_warn() has
the null terminating character.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Suggested-by: Daniel J. Axtens <daniel.axtens@canonical.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/partitions/aix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 007f95eea0e1..238aca56f552 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -282,10 +282,14 @@ int aix_partition(struct parsed_partitions *state)
 				next_lp_ix +=3D 1;
 		}
 		for (i =3D 0; i < state->limit; i +=3D 1)
-			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous)
+			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
+				char tmp[sizeof(n[i].name) + 1]; // null char
+
+				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
 				pr_warn("partition %s (%u pp's found) is "
 					"not contiguous\n",
-					n[i].name, lvip[i].pps_found);
+					tmp, lvip[i].pps_found);
+			}
 		kfree(pvd);
 	}
 	kfree(n);
--=20
2.17.1
