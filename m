Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C98C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABE720855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QUMiXKcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABE720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeIBRXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:45 -0400
Received: from mail-dm3nam03on0118.outbound.protection.outlook.com ([104.47.41.118]:8192
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729446AbeIBRXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWsO78/rqAFrIuR/GAtgf3m/DB5UObxE1djap7PxbA4=;
 b=QUMiXKcTAVgbxLcoRB5EIBcVSydYJsZb0hpAjoIdqZyOAA9Szi6r6wwqF5c1R5WpkXJ50JLtK6UelBhqD901cl0xaDvCOPyBtxapF4umViIqQRSajvK1tz1oM2UQbU+GWKDfgNEvyrD1NO5hRk6jq42xIwhxXeh76DV/fBuAncY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 68/89] partitions/aix: append null character to
 print data from disk
Thread-Topic: [PATCH AUTOSEL 4.14 68/89] partitions/aix: append null character
 to print data from disk
Thread-Index: AQHUQr3px3QUxzVp/EeAxCLyNzFLvw==
Date:   Sun, 2 Sep 2018 13:07:32 +0000
Message-ID: <20180902064918.183387-68-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:b5ClIlhXWkeJQeZB+socY2biO4eTl/6VlQM7kPQWL7jJATVsee/0IPedcHTk6AzNIVkmao1w//mTfcaMh9xE3rg31pvggEd1ps5GxsU8Y8NLPXFatoEiQ7OiLwgr5oMVqymV36eizmE5I+k5geD8h20NI08dirhcVWBkeIaDxYJMroH8GnTqhbynq24b9iJ+uleHSNx1/vwf+KLNQDsdy7OUwnJ73C2/a4l9uAvQuS7iP15vU2bTZfjZpyZ/xbiBXBBt+APsVkXsm+xboTVrgyLVsf/1NlXIRYnwCQTdedz5o8PDNIMtJsiK3TgWvZ3zcRjwEFEih0QsQrb1UPvZlRLvguU3AVtMKKXmddfva/pSEMXpY0fFX5eWFKSHfCbO3iyASE3Y+WZbJr4ps7I1HE1+bOulo2wZozNRQTWkcTWqjpFX6EsSUukM7FCdrguspCYXLDKwgugiPAzPqUuyUQ==;5:wZFNWnM1MGt96xZF/693ugPZQIQAfcBigV2ulHV6jLlR0d4EQ35QJobd1n5p96dfBEBlETfstevZ/TFBezRXtaa7TdJy+Kvxe7HpMOHk2RUe18AK+F4yZ3tzO3fEYhxKjL6xLgUHEiGkcMWIU2oI3z+///Ey6lNPhs+NVprox3s=;7:nbqL4jdfo0tcLNcQr07YC9T4NOjruWolvCgHR5YB474heklwK22zlYrZvxJfOrn7skrO1GAFChgnbvDrwwK01yjPwVeRQWSTHzMf2j4XE3dbtxuoV3Zekb1K3lz8Kt6tyYJSLLyTKpegOhPBVerpNmyXe6t2qF48uZK1/zrx2G2h2pslCgwwuTXcBudZTiRcBpqJ440Hkb1yFPJhTeF8mC+O029jbsppLCAWyKO17GA1DMQdaZ8t+efASPnNPgdp
x-ms-office365-filtering-correlation-id: 74e3f075-c1ad-47ed-5f27-08d610d516cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB014927FBD0743732FECC14C0FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4NayIVtiL6ios4s8xvb2NzxKaHWIdmj6cWKnc92Bc9PB3xUiv4/FWiijYE687zlFQAd6fvJJC6bBO9UxxlnDIqvpqZfXkKs7pG2skUjuErcjYK1s43cPty5Jf3xJI8vMvhVxVVmNb8YHayQXlJgC4n6Yd/2jTn9yFaaJDKObzLCfPXUbLdnIKu1WWOoO+XOYNRapioAiu8XxZDPc5sNjIv2mVNmMDl2L5dadxGrOMgN6ZFYKjp9O2+o+4EVkTaJ54Ou7SPMLTU5SR1CwLVrScRDoKj4CaRSIeb/8g0bDr0uwyrs1mTf3dVCaEhNdnKUn3MXsJuARmZQIylRbk56GwH02VicIll+/JIbcHWgJtXM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e3f075-c1ad-47ed-5f27-08d610d516cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:32.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
