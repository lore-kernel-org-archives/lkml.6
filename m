Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19623ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8EA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LhmlbBs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8EA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeIQI0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:08 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbeIQIZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyf1Ohj5fTYZH19TlcJmBrPG6y8rSCtqS9ro8xA7ytM=;
 b=LhmlbBs1az2MZBVVZMUk/TbW+BeXBAgG9IX0dLythfTXMuJoCpzxE5xYdQFteKG/4UIuSzcYXeNB7IdCLJZME44k167/o1/k4vj9N89LSQG2oMsGX5d5GSbvPXC8gPPfK4c3vrKw24GaUEfAA7DZ9iF1fMbHU2BGflxRS9GyXmY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 027/136] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Topic: [PATCH AUTOSEL 4.18 027/136] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Index: AQHUTjKWR4ISFby+REy/XBLdb3wopg==
Date:   Mon, 17 Sep 2018 03:00:28 +0000
Message-ID: <20180917030006.245495-27-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:OQgL1fc4s530ZliRT/77TNa2zUyN9V9qlPDbb9uUKZvZI4CdBpeOCJ+SMhPpFMZfnYlPOJBnC0NRjm57qjgep/AutvCYYa2iEb10kQ2wNYmTOCocZ5SX9LgE1DGRS70rxEpYerHKbEkxhL5X8NG36E8ntCZGbuYmvL8NR4FK82DZHILN7o/1emkJz7JSOPqgu1Gg6ANhsxSlOEx2Avy9swpWAz43rkx9cw1NRSnWf5djPeoV7jrnbGD3ukqepiG9AF+ctp9CTJy+xsFCkKF/oLEvgp3FPcOZ6uZTcozfpxo8s3Ybma4m4dDETLZoDlDtdlWYA34f7unuCHuW8oYkctzG6352tWInNkTTvachr6cVp0dCrDAXT74yFv6Vin1mqzWj4YMPCx13H2vsiGYy84qBzxZoqjlEb/Ku3ieZlR0wWQbgt5XRJH+u/QXUHsX/J5bxR5wCVZw5ZHuzzeCfTA==;5:pyyUvhSU62AhSTRxZ9gxE4BIZDD0xqWO10bnLyZ6+UwTnP0BZAopMgZ8epvj8th91FQJPDT+p+N2RaEtCjIvJTFg3qqkc3d8eyi8Ol7s+td5F/4SV4Gtk2FqvH7lIjCFshdvsoVjNjKYOvfAeqAfd78W+2xXUh+dR1HKkgUweLU=;7:rR6ViZQ5d5ETMVLpxH6EjuctPKef8iGoLs3csAXMw0qQ+a88ji4h4823pu0c5h91baUCW5D6qqdQ2Yh5jrS3TQLlgcP2ErooCwXu9SEWEYqh1vi2DWu5F72FUym3u31okDJsNgD/mZLqMaV65b/4VBFUWUtHiy/QKvVQnBUswDZaaOI2EVmng7WZJROgVsWxWpr2GM+bcOfE+4WPsOcf9b2BDeQjgR1gbrBQgiSLdZ4ZcaQgpO/UDgch/4GmPnxd
x-ms-office365-filtering-correlation-id: 79a2a473-1e89-46fd-2c30-08d61c49b93c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277C83C35DB057BC8A18055FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(15650500001)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fTqSX0scSxX/uu894v/J6wnmeClcidr8i2ff/DWvl0W/4VRve/zvletxVwavXxezI4biX978Yt8udXvpv4qh/VbryRgBT1C9jVK+iuqHNeGLlfTZ+6Z1Nifx/AJ9+8JSbYKcQO2aRj2fUyme1hAJ5+2EVZNhkacMULg8f+AfRTr33ibDJhtfVKY8UU1VMFspgkuZd9AkRxxLKQN5nvGIIvQc9D1Gi9cg03tDeR8fR59sUqi3fBCdcANJEUBSRUpVc1+Yy2cGeWih74XBmieakjfWdmcUNb2/grrGqLJqp1OawZGCCCFloeRQUHaKErBmDODNGxXg+WJyhzb0apzpcTSvqjNvUk1wecN4EnB25RQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a2a473-1e89-46fd-2c30-08d61c49b93c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:28.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit 010228e4a932ca1e8365e3b58c8e1e44c16ff793 ]

When one node leaves cluster or stops the resyncing
(resync or recovery) array, then other nodes need to
call recover_bitmaps to continue the unfinished task.

But we need to clear suspend_area later after other
nodes copy the resync information to their bitmap
(by call bitmap_copy_from_slot). Otherwise, all nodes
could write to the suspend_area even the suspend_area
is not handled by any node, because area_resyncing
returns 0 at the beginning of raid1_write_request.
Which means one node could write suspend_area while
another node is resyncing the same area, then data
could be inconsistent.

So let's clear suspend_area later to avoid above issue
with the protection of bm lock. Also it is straightforward
to clear suspend_area after nodes have copied the resync
info to bitmap.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/md-cluster.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 021cbf9ef1bf..1ac945f7a3c2 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -304,15 +304,6 @@ static void recover_bitmaps(struct md_thread *thread)
 	while (cinfo->recovery_map) {
 		slot =3D fls64((u64)cinfo->recovery_map) - 1;
=20
-		/* Clear suspend_area associated with the bitmap */
-		spin_lock_irq(&cinfo->suspend_lock);
-		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
-			if (slot =3D=3D s->slot) {
-				list_del(&s->list);
-				kfree(s);
-			}
-		spin_unlock_irq(&cinfo->suspend_lock);
-
 		snprintf(str, 64, "bitmap%04d", slot);
 		bm_lockres =3D lockres_init(mddev, str, NULL, 1);
 		if (!bm_lockres) {
@@ -331,6 +322,16 @@ static void recover_bitmaps(struct md_thread *thread)
 			pr_err("md-cluster: Could not copy data from bitmap %d\n", slot);
 			goto clear_bit;
 		}
+
+		/* Clear suspend_area associated with the bitmap */
+		spin_lock_irq(&cinfo->suspend_lock);
+		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
+			if (slot =3D=3D s->slot) {
+				list_del(&s->list);
+				kfree(s);
+			}
+		spin_unlock_irq(&cinfo->suspend_lock);
+
 		if (hi > 0) {
 			if (lo < mddev->recovery_cp)
 				mddev->recovery_cp =3D lo;
--=20
2.17.1
