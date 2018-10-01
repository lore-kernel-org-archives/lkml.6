Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A35C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0035420666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OlzF9Pxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0035420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeJAHNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:11 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:52496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeJAHNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhcw3H9kmZK3csNVI1Zx4P2m7Xqsa1sKt/25AKLbj8s=;
 b=OlzF9Pxw/29mqf9fqTS3xa4+fAWu3aoP4NA5xYlXQAqQSgnLGtnBCWhBxJM9NYbVK03H0lAfoxCVkXAkX4ICU3xiX9K0EqNy0tlFkYlgNZrNl0JtfbI2xiC3MueIL6/bBGmb84TNXP9Qu5wS1MUSeMhpgduVWUqLPi8FVmimgXM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Martin Willi <martin@strongswan.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 01/65] netfilter: xt_cluster: add dependency on
 conntrack module
Thread-Topic: [PATCH AUTOSEL 4.18 01/65] netfilter: xt_cluster: add dependency
 on conntrack module
Thread-Index: AQHUWR8Ckkacs9MKu0O8y9QVXJ88vA==
Date:   Mon, 1 Oct 2018 00:38:02 +0000
Message-ID: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:MRyesJ6zMwPqB7l0kmri10QVFqkXPLy9cNAAZMyig43ksRPrdTf5hzriZE8yVi0K/YHrAzajUFQ0vhdtcdbCSlaPXKIblFX6NsJ1goN+o8xu1BY94urcRli0Ee9wiCAYLMrCIVl/8sm1TcOFVERxs6CLI7jbFSf2estwXcfWmC2lvmZSE2PV4Cbt47lVEduc4UJMyhbuvE+HvGVdzZFEedUS+mGzNNJyuIJbPZLmdd/IltyuyTTQiV2F3DHC9qwAKqVWCPgOjPAeqIaDuPWfLuvTD1jr7B+vGK/+V5zkHiN7ru5r7n2nicpWvKDfoAjYSly5o4TjfRvCLKg2XsQsyu5Y3fs5yJhC0KP1AEpSQ937f2/ruqb/1SR99UbLr45Yf8kzBoFePg31bsKdcPaQgcc6N/jNbVU+HLSM1kx7cjargMbt+rhLkcmgEbZpGIkf+cGoEwZJFrn0x1Aw/jdxkw==;5:81Eh11Q4ySG/Vv11LZ3wm7SqBlKN0twaLBzo8jTs7sug6S8VVTHOkaO9mTm0jSJybYgJYWXPlV5fHYw24OPLbC3/7GBo55gJ2YTY7YzmFwiWj174aWd+ABplpNvDR34qT2eRkqRJVJAxZELbXB/qPIuia2hv8T07d8qC2MjFDvU=;7:cOMz/aFChwlp11yqkE4Bft1WMOgkQO49NaO0NVibX02CbLdpOCAN+fwrbjobJ6v9e2L/3WUH5jHJabGws8L8Toti9nUzl4uBv2ChO9g0RH2Rem8WwkNPF735wB63xtTJdmJF1coVHVYDrKOGs+Nv5efn653IX5zh3tbzbFaXPsesszP0+ypRA/pj7D1NeIum0/30hVQLASI9A1SSHY3mHcH8T4mpvUMo1g+vprCdKd6JDax9mWxhbVRt9/pU5MhF
x-ms-office365-filtering-correlation-id: f285f201-6077-44cc-1c36-08d62736253f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469EF237267DBD924060D02FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(6506007)(2906002)(7736002)(86612001)(575784001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kutiqLyEeElWwS7F5pM/avBTgat9zJZl5Hnxt1x33UzsTBDLGYdEU6hz60saIoheVpZNCod7pabdYotbNf6FtfW1DHxzneHS6VaaaeM1V2GTpzXJqEkrRTjvhkIHhAb/fMyT257z7kbZ7Cuh4OHfoRocFT6ZSjGMGx4/9nYfDLBEPIHZl2DxjBsulxLcOwsdxn1mbc083LvW3V71MaBUvPX5EddLHKJY82ksd2wXYAVOUr1dC720+M5Fxb9sXMkbhLKxER8fjBgjoGuEQeOYVOaCBBtCv6SjwpruvcLctHS85CzXOgFCES3HzKremtJQ5rStrod6FJRVSFBIgVs72qrdOMZGJLhwjEZKS9ciXYc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f285f201-6077-44cc-1c36-08d62736253f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:02.4792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Willi <martin@strongswan.org>

[ Upstream commit c1dc2912059901f97345d9e10c96b841215fdc0f ]

The cluster match requires conntrack for matching packets. If the
netns does not have conntrack hooks registered, the match does not
work at all.

Implicitly load the conntrack hook for the family, exactly as many
other extensions do. This ensures that the match works even if the
hooks have not been registered by other means.

Signed-off-by: Martin Willi <martin@strongswan.org>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/xt_cluster.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_cluster.c b/net/netfilter/xt_cluster.c
index dfbdbb2fc0ed..51d0c257e7a5 100644
--- a/net/netfilter/xt_cluster.c
+++ b/net/netfilter/xt_cluster.c
@@ -125,6 +125,7 @@ xt_cluster_mt(const struct sk_buff *skb, struct xt_acti=
on_param *par)
 static int xt_cluster_mt_checkentry(const struct xt_mtchk_param *par)
 {
 	struct xt_cluster_match_info *info =3D par->matchinfo;
+	int ret;
=20
 	if (info->total_nodes > XT_CLUSTER_NODES_MAX) {
 		pr_info_ratelimited("you have exceeded the maximum number of cluster nod=
es (%u > %u)\n",
@@ -135,7 +136,17 @@ static int xt_cluster_mt_checkentry(const struct xt_mt=
chk_param *par)
 		pr_info_ratelimited("node mask cannot exceed total number of nodes\n");
 		return -EDOM;
 	}
-	return 0;
+
+	ret =3D nf_ct_netns_get(par->net, par->family);
+	if (ret < 0)
+		pr_info_ratelimited("cannot load conntrack support for proto=3D%u\n",
+				    par->family);
+	return ret;
+}
+
+static void xt_cluster_mt_destroy(const struct xt_mtdtor_param *par)
+{
+	nf_ct_netns_put(par->net, par->family);
 }
=20
 static struct xt_match xt_cluster_match __read_mostly =3D {
@@ -144,6 +155,7 @@ static struct xt_match xt_cluster_match __read_mostly =
=3D {
 	.match		=3D xt_cluster_mt,
 	.checkentry	=3D xt_cluster_mt_checkentry,
 	.matchsize	=3D sizeof(struct xt_cluster_match_info),
+	.destroy	=3D xt_cluster_mt_destroy,
 	.me		=3D THIS_MODULE,
 };
=20
--=20
2.17.1
