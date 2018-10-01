Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E56FC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0012089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f6jatnUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0012089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeJAHOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:52 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbeJAHOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNVHa4L/nVyWk34by3qnElar4ldBkkBzd263FeFZjiI=;
 b=f6jatnUHfdnBcSAFGysFLFS0/ldylu1cli7L1SgP8XrKMMJS9B54PW5GTn5Sc++ZSikAzMwjPtjfW73650SD28/DuF/bVN4AUwd4DK2ZlzHyKTXH16zzkN3DwbFrSEc9M/UHx2rAcvM5tGNYoxvKZS7d/px5uGwTBp6Wvsg/wsE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Martin Willi <martin@strongswan.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/37] netfilter: xt_cluster: add dependency on
 conntrack module
Thread-Topic: [PATCH AUTOSEL 4.14 01/37] netfilter: xt_cluster: add dependency
 on conntrack module
Thread-Index: AQHUWR8h4hkdaUx4iUSmubCvAj8BpQ==
Date:   Mon, 1 Oct 2018 00:38:53 +0000
Message-ID: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:nsLSfDumOHFBa4TZQo/hEPyfLLrcwHCU8j71jacMMtxS6a9i+Nre+L5Sze8hsrloD5tFsmE6Fw/oT0ybVxVazS6vhtTThND/zzI634PuGwH0KNCGIOpb9aTHyVYnBZWTYIUZ6InQV89QFWRiem3VBb/him1DTX/zxBEccJWyGjTm9AbFH0Q5t/u97l84Lod3DR8HCiIYxVNWJNsJYCidWQzG7uLrqwH3cii8dwW0JWOr1lVGCl/H0FQgv6O41RABeQsPBrFpilEJWoAlyPwPeF5MtWdsyEniqIyTbsjxi60auW9FpRwvLyG6oXxZ8aYOHZwdkgBc6R30Tdin3e2o9jQY55BvOVh+DQA1ueVBGqIu+1wwsPRyFkz7SU6Bh6VeOnyp4dGPxYNu07i2eg13y1u5lmnYtCmJiFr4CB8BqAF06DbHP6qYGzXOBAcZ48SZae+3/83C5CQDWC61S04dRA==;5:L9wxV40SLARcQjzBRy2UuLBPNYQ+yw42Ssz1E6cYMPbwq6LT0ssbNAKvV0s3mrwGWsrFrhLUKEzKy5dah2bNlclwCpI32yVE56AeoLEhDIewL+hq76TU+u3hGvf7a1LKmoynQNFp08Pv/+JCMZfakIMdSd8n4r+LNJX/wiXNFU0=;7:vg5mZTIOicz2v5vhF/93Xdr13bX1NDdK9QDJcLNmmSYpNIbjuaOuZav+EdJ9wTCuYnxorvEZQHcpKoxKcov2eB0TTldyQtnej3FAJqZisdYMZPvXRHlLgg/SFv1BEBuq0k/c3y+2xZ1KVsKd2OeBTzeGL9NSl+E0jaSoWjrdIQY9WEQNUC6voBSiogJsaOK/du3kgkyOxYAG8T7PzYqJ0eiUePX88+giqWFJMgUfQQoeW0WkR/pmrcp1nXoH0NfN
x-ms-office365-filtering-correlation-id: d0e9b2c6-9853-4d58-1b44-08d627365e22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696D77EB49F66245619B852FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(6506007)(99286004)(26005)(86362001)(575784001)(36756003)(2501003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZFBjyq7CxeYVgzX3fGpdmxEGuaiGmMV4KotTwATcP6ZQHwdAnk7HWDveeJPM3+vovaJHvl9ZLq59MlBaZjXX0wDlRlpRy46dOquTsCIsqByLLtxGgszyihMD3xvX2XqLLh0fZduy2+71i3nFBBAdQpOIGWGLo0912SO1wQe2e82OR8WHkdd3z7K30cEQ60XzIIqgXlkrAwCIXZy0HpXdr7ITUxk5rkER6qiswBGmEXpA+F3ulHqqBzBXbyCNblqe9BrSweYJyo59cOPbMt5s9Ky8Kh9R9dPkMg34pm8rr3tM5omevK38kWkxVWyDizhCVPKjG5tvvRhoFkxogyyaDhAh2S7Bs8HWnLVrR9q/nRE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e9b2c6-9853-4d58-1b44-08d627365e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:53.3554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index 57ef175dfbfa..504d5f730f4e 100644
--- a/net/netfilter/xt_cluster.c
+++ b/net/netfilter/xt_cluster.c
@@ -133,6 +133,7 @@ xt_cluster_mt(const struct sk_buff *skb, struct xt_acti=
on_param *par)
 static int xt_cluster_mt_checkentry(const struct xt_mtchk_param *par)
 {
 	struct xt_cluster_match_info *info =3D par->matchinfo;
+	int ret;
=20
 	if (info->total_nodes > XT_CLUSTER_NODES_MAX) {
 		pr_info("you have exceeded the maximum "
@@ -145,7 +146,17 @@ static int xt_cluster_mt_checkentry(const struct xt_mt=
chk_param *par)
 			"higher than the total number of nodes\n");
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
@@ -154,6 +165,7 @@ static struct xt_match xt_cluster_match __read_mostly =
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
