Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F56C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17972083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mbiAaHax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17972083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeJAH0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:26:07 -0400
Received: from mail-eopbgr680139.outbound.protection.outlook.com ([40.107.68.139]:29328
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729159AbeJAHOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q//u/kycbfrdvjlSUo1WKEUtQcGnCw49BL38KvvNAq4=;
 b=mbiAaHaxISOfuz7tbB1DQGe4SMdP84dmxOcvTUhBEpscawe597spTvuZs5l1M+TYCw0/zZqF/V3MJLVx3/0E32CnFXXS6wjBeAuoa/5YH0RuTZPgui2wKkUTdYrVbbxoUmStSMHPyQQaYpsVN9pJ4tlL+TeFyKixX67nZJHg/eE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Cong Wang <xiyou.wangcong@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 51/65] netfilter: xt_hashlimit: use s->file
 instead of s->private
Thread-Topic: [PATCH AUTOSEL 4.18 51/65] netfilter: xt_hashlimit: use s->file
 instead of s->private
Thread-Index: AQHUWR8VxRaydUm8P0uGRK+jGdQt7w==
Date:   Mon, 1 Oct 2018 00:38:33 +0000
Message-ID: <20181001003754.146961-51-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:1WkEcDkVnNnF/jT1NNFruoH9NuGhagQpFlMHLZHTFmzeouxm7sceXpR3S+elQGkxhxgl5BErBT0MrRAs6wQoLSG6hdpo9CIxzGxit0c+r3peq9hfZlrnq9yy5YwVX+AcUdKLRY6ytz7kudyt2D3peNKaRUDqPUE2KmOY90Yz2N/ZEWFuh9hnrsZaZCKwPmMQj6x2XWm1nt0VHWffuu3Ec0Zbfp088aeJ+0PyDgbDmA4KaStgcS2h2L1nSgL4eUWtCDlv6YE1WcZ5PS5n6c26fg9m6QzODxNRueNRiUtjctVGCKsOVMhvZlS9MixMupjpbbrywVoOD3OwnW7LM3zvTu+I5HLGd2eIkv3XlCMkLdREmDAIaAmjMw6+h7SixaZrUgM7KrqVI3SfGunPCYbNkkxE6o/fIcN9K9NjFL4e4U1LaWyaQOKUu96mCtchjZSbHbDhNqWLgoHOr/coikiMqA==;5:HeyQ44GGBWZXV5qZfGvf11GOkRfOqBzmPZBhBsCRDdGHfWPZKPRpz8j6RJZu7K1ZxQb8VkCD3eypS39W7pYsa6KNS6ASqlKkKPL9ps/SohKUtoulzCCiWIW46grq+/3MDbGJoBNxKdtF4Eht9Xp15+d36iR89UL/rc7Xizpwbe0=;7:59C6tU/4+6dVC1FDMaifaFVKa6h1Cfka0KzY2yBKdjuh/fZ4u+/vISaXREw7IIACrblNlXIjH+9svdCQFEsND8Bn2sBINe05bvaDzFTTIUJxaVxrUfGjEh0DoZuvgurPBcbyo7e4S2KM5JmJ7KPod76c+Upf3THUIDXK70Zggce9nDYIFnwfDZa6h51/+Q5TNzI0IPccdymGlSDWRynEQ4BhJu2aVJr9KE646Jtt6d5AVYJn8SI43gF/QwIiIUWF
x-ms-office365-filtering-correlation-id: fbd5052e-0f3e-42d5-5ccb-08d627364909
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824D4849849DD8ADB274562FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(39060400002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zz8/IyAqwvrHzLiBIW2t5lWCJEgyAyNW83F0Uf0hRDaZ69ZH9s7NmP+Zye1fwHFcyIQpip9Hb/Y+ZnjxeQ43BbI/sLOK91sb2Y5QlrMbtmQ3IAXRMzPZx1Wz+BgHOLaIwA087kR2injpU+apWXCnq5ZbacvBC8ckmM72SPhf+h/ymwGUTnNRCnNDnvetg1xFcYYG/2EbicVmtzYIglZn/Q+ZaKcSNn2Nf5GCEnxd5eGYu4lW2/45kLcCb+ITFbou09MoVrsYGTpj9O1bV0rdhzGzzGNn1+OftiL/knX3SiG6Fqdlhpz10KEfGduXggow72Ff/+iKrQzzsR2Unhlfl4mk/2ITVRFR+77h39/2GuQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd5052e-0f3e-42d5-5ccb-08d627364909
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:33.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 1286df269f498165061e0cf8092ca212545dbb5a ]

After switching to the new procfs API, it is supposed to
retrieve the private pointer from PDE_DATA(file_inode(s->file)),
s->private is no longer referred.

Fixes: 1cd671827290 ("netfilter/x_tables: switch to proc_create_seq_private=
")
Reported-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/xt_hashlimit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 9b16402f29af..3e7d259e5d8d 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -1057,7 +1057,7 @@ static struct xt_match hashlimit_mt_reg[] __read_most=
ly =3D {
 static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 	__acquires(htable->lock)
 {
-	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->file));
 	unsigned int *bucket;
=20
 	spin_lock_bh(&htable->lock);
@@ -1074,7 +1074,7 @@ static void *dl_seq_start(struct seq_file *s, loff_t =
*pos)
=20
 static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->file));
 	unsigned int *bucket =3D v;
=20
 	*pos =3D ++(*bucket);
@@ -1088,7 +1088,7 @@ static void *dl_seq_next(struct seq_file *s, void *v,=
 loff_t *pos)
 static void dl_seq_stop(struct seq_file *s, void *v)
 	__releases(htable->lock)
 {
-	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->file));
 	unsigned int *bucket =3D v;
=20
 	if (!IS_ERR(bucket))
@@ -1130,7 +1130,7 @@ static void dl_seq_print(struct dsthash_ent *ent, u_i=
nt8_t family,
 static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *ht =3D PDE_DATA(file_inode(s->file));
=20
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1145,7 +1145,7 @@ static int dl_seq_real_show_v2(struct dsthash_ent *en=
t, u_int8_t family,
 static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *ht =3D PDE_DATA(file_inode(s->file));
=20
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1160,7 +1160,7 @@ static int dl_seq_real_show_v1(struct dsthash_ent *en=
t, u_int8_t family,
 static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 			    struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *ht =3D PDE_DATA(file_inode(s->file));
=20
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1174,7 +1174,7 @@ static int dl_seq_real_show(struct dsthash_ent *ent, =
u_int8_t family,
=20
 static int dl_seq_show_v2(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->file));
 	unsigned int *bucket =3D (unsigned int *)v;
 	struct dsthash_ent *ent;
=20
@@ -1188,7 +1188,7 @@ static int dl_seq_show_v2(struct seq_file *s, void *v=
)
=20
 static int dl_seq_show_v1(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->file));
 	unsigned int *bucket =3D v;
 	struct dsthash_ent *ent;
=20
@@ -1202,7 +1202,7 @@ static int dl_seq_show_v1(struct seq_file *s, void *v=
)
=20
 static int dl_seq_show(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable =3D PDE_DATA(file_inode(s->file));
 	unsigned int *bucket =3D v;
 	struct dsthash_ent *ent;
=20
--=20
2.17.1
