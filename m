Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474506-2-884918104512812050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474506; b=nyxHB/3Jof/faL8ZhGyFtJVqI0E7ly32RKLQuxF9ycfRTg5
    YiNTlzOscaO0jPchCuIzGKwakZgdW65Onxs4Ta3rUyFhuYm1/HPmS8nSK98DeTp1
    gHOOh2HTV9PGLViTgxyOZ8IgG7PY4yqP5oTZrJ69ZJEruHyUmM0zFNdQIuD3LKX+
    R3BuX0cEJb147UwCUMhLskrjUVr3Tp7Xh3uTIzl9LIg9bSEgdEhaWDaJK/hg3MwD
    JRQNmg9TP7oq1adLGxSfOG0saVGseY+Kqz0cx8jS4ETbEN/tnqDy2KIwtnVdaP+d
    38regYizgZDgaQhbvAH1lnegtwASdj1c9kpXVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474506; bh=MjdxzN
    c3lRsjmmVsYX+gB24bN/8aiuYPLt+To00oX2E=; b=wH6WLqXEWC42Ha1eEgeHgh
    dMvjOI6i1MZfwF7fOuIZZ+kNT/QbMZZsVo1xA1LYwNNWqEYhPgn9FBCxYoSHYdIG
    1rxqQ6DKei2osqXEi3G5AdwvRhs4zcJsKrTNlG5x1+Vblcw47Ew+nCY6jHxf/UfV
    vRka1xXmVk3SL9SsR6IQUuFd108sCghmfUNH9u1ZfTm5p5XXeWRedSYMEtG+nx+9
    w5ecEKGrnpkgNEq3tkp9/9QCQVYbLzQE7rUG9Sj2Z+ovW9kVD55A66i/mZ6jv0m4
    ELSOJUqwEMUUJmFJCFbDPliqTk0qOiBN/YPvawRsfLzKXnBi4sOQmDGqATvEEw+Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bkc3AISz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeggedvnecuvehluhhsthgvrhfuihiivgepvdeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bkc3AISz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeggedvnecuvehluhhsthgvrhfuihiivgepvdeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933681AbeCSPsU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:48:20 -0400
Received: from mail-by2nam01on0135.outbound.protection.outlook.com ([104.47.34.135]:31072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933725AbeCSPsJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: oulijun <oulijun@huawei.com>, Yixian Liu <liuyixian@huawei.com>,
        Wei Hu <xavier.huwei@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 041/124] RDMA/hns: Update the usage of sr_max
 and rr_max field
Thread-Topic: [PATCH AUTOSEL for 4.15 041/124] RDMA/hns: Update the usage of
 sr_max and rr_max field
Thread-Index: AQHTv5mdJBti566d80CimudfNCq1fQ==
Date: Mon, 19 Mar 2018 15:47:42 +0000
Message-ID: <20180319154645.11350-41-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:nQUW17ezKlwHRKSfZOiiziG7NepgcCEE88E5zFML83evmYK7Lj/H3EOCpK5jM3g7kxfbrFB0SsyYnyZPxbSxtncM0FgafhBOysPWjv7NDdwFUsq5/XW1YLSqRuCdXYihfaLsr2xrrp3uZkLG+8aM69KtvFB7g7vhMeiQgKEoKG8azYeFK7F7/vMukOEC1EcrqvI4y6L4l0IjMvTsRKHOpNFCntT9zq3OciyBgrDMuWB2fPYT1R743/7GzWhdxTIb;20:EeKnPX6ycJoV+FNvTTPFkvSFS4wtZS3156Zkh/fZQFOWq+UifPqGA0ZbDDWHhBXBy5cI6qN0+lw0ruhWCeUc6dz2akH4lClrfUjpkvAtkgPlwVpFdRfJgzK/JMhDnfUGf63FWR0bCIGC+WafIw7UkAlY69+EA6hNVubiWQHzV9M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d41698a9-efb9-4386-1ba1-08d58db0cf4b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031E6D22072C1F4FAC7AD0DFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: btJXscBYB9m36wpOjiVkD0tbNkLUFh9UzzdrShKarVjkWZ+LGEGiqT0rVocO0HP23nGPNyZtd4WgmUvBOhrMXyXon5+tDVfrbKusfIUTGs769RAdrD3SH+Dn96afhQhXc8kQpkArgCjovUWmrbftqDyXxFZ04MI5jsTyb8NJh6osxRzTcmV08c51NpucKGc7gQSA46jm2FxLexb8hdU42gbD7AmqZ7L/TzWRUd8qzWu49DxVtOAgELyEkf2abLrHBij26gUXE5kPWf5ibyQMDshbGa4l7xGd8jI53/uYqYF4JDixWNDKfj9A514cV1q2cwHLWkcTjutCq0CAGrY9Fw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41698a9-efb9-4386-1ba1-08d58db0cf4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:42.0802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: oulijun <oulijun@huawei.com>

[ Upstream commit 4f3f7a704b3bff9e4eb322ab3c989b505f7562eb ]

This patch fixes the usage with sr_max filed and rr_max of qp
context when modify qp. Its modifications include:
1. Adjust location of filling sr_max filed of qpc
2. Only assign the number of responder resource if
   IB_QP_MAX_DEST_RD_ATOMIC bit is set
3. Only assign the number of outstanding resource if
   IB_QP_MAX_QP_RD_ATOMIC
4. Fix the assgin algorithms for the field of sr_max
   and rr_max of qp context

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 27 ++++++++++++++++----------=
-
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniban=
d/hw/hns/hns_roce_hw_v2.c
index 8e18445714a9..0d925b3d3d47 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2463,11 +2463,14 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp=
,
 		roce_set_bit(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_LBI_S, 0);
 	}
=20
-	roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
-		       V2_QPC_BYTE_140_RR_MAX_S,
-		       ilog2((unsigned int)attr->max_dest_rd_atomic));
-	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
-		       V2_QPC_BYTE_140_RR_MAX_S, 0);
+	if ((attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) &&
+	     attr->max_dest_rd_atomic) {
+		roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
+			       V2_QPC_BYTE_140_RR_MAX_S,
+			       fls(attr->max_dest_rd_atomic - 1));
+		roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
+			       V2_QPC_BYTE_140_RR_MAX_S, 0);
+	}
=20
 	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_DQPN_M,
 		       V2_QPC_BYTE_56_DQPN_S, attr->dest_qp_num);
@@ -2557,12 +2560,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_168_LP_SGEN_INI_M,
 		       V2_QPC_BYTE_168_LP_SGEN_INI_S, 0);
=20
-	roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_SR_MAX_M,
-		       V2_QPC_BYTE_208_SR_MAX_S,
-		       ilog2((unsigned int)attr->max_rd_atomic));
-	roce_set_field(qpc_mask->byte_208_irrl, V2_QPC_BYTE_208_SR_MAX_M,
-		       V2_QPC_BYTE_208_SR_MAX_S, 0);
-
 	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
 		       V2_QPC_BYTE_28_SL_S, rdma_ah_get_sl(&attr->ah_attr));
 	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
@@ -2766,6 +2763,14 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_196_sq_psn, V2_QPC_BYTE_196_SQ_MAX_PSN_M,
 		       V2_QPC_BYTE_196_SQ_MAX_PSN_S, 0);
=20
+	if ((attr_mask & IB_QP_MAX_QP_RD_ATOMIC) && attr->max_rd_atomic) {
+		roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_SR_MAX_M,
+			       V2_QPC_BYTE_208_SR_MAX_S,
+			       fls(attr->max_rd_atomic - 1));
+		roce_set_field(qpc_mask->byte_208_irrl,
+			       V2_QPC_BYTE_208_SR_MAX_M,
+			       V2_QPC_BYTE_208_SR_MAX_S, 0);
+	}
 	return 0;
 }
=20
--=20
2.14.1
