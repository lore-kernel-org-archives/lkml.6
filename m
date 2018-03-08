Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491693-2-116650848698434169
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
    t=1520491693; b=brSWsOZip1gsEcqV+2RpdWhehdMWW9w4DaNIY2QwVbv/lz0
    9YMLAYzNM1itrOVD72Aryeno7dPn0Ev0JXOAP/LeJvddxYBTD58rZ2E+XcAOiq8m
    VqqChJkqGXcqNXPfR/ulNrRRsGOaKMxzKjQbMMH0iEo3Ws1mg20XUG/B37PfUXo+
    SmbEGAy3uH2ndYLRc41n3jOxbclyMrdUmCFgemDev49DKPMPtJ9k56hzZ/+dwPWz
    /0CdISIziWNPw4KF2hwIz98+qt66/wziVvrTGcvag4sDeBN7dFrbSkVDzhHrxbi7
    iuQ8kQ05eQTbPDu8QjE28rxLuEK4ftBGOitPJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491693; bh=m7veg+
    J+y5obt0em17tRpJi1nK8Qgiw/JrMje5YtRR8=; b=EfBk+IUjRr1mbz9iHGgoXV
    BLHiwnLmbfGNG5w9dsCTNwfW8uxn6oQAZziq8YRMVnTsRQeFMljEbQY9d1bWw67q
    mtgJ2tbS28apaninOaR9QymkC6gr0OAbZwqLnA6xVSiJwBR4vYnwoyxUNHZtiK5E
    OMQ0dP6qXL+Aj5ExPPKC2bkfRrE4JRNGd3TcF1C66QBu09hhRDAFbd0gP7/r4gHe
    0oeohSQ1PMH7tYOkE4nxJAxS4afrA8EleNM58A0Zhomb45Kh7U8QEgh4l6Vk6Tbx
    f5PGw4RjHyMQyTFPYg7Kt4YB2HQRddqJphJ64eLPenYsKl+9WfGTFfTOBGRsw5iA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cg0m+bGh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cg0m+bGh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935236AbeCHE6T (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:19 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935225AbeCHE6N (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 11/67] hv_netvsc: Fix the TX/RX buffer
 default sizes
Thread-Topic: [PATCH AUTOSEL for 4.14 11/67] hv_netvsc: Fix the TX/RX buffer
 default sizes
Thread-Index: AQHTtpn5HdVKxBtIDEK2ojCHmYthRw==
Date: Thu, 8 Mar 2018 04:57:36 +0000
Message-ID: <20180308045641.7814-11-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:Jrm/62Y3nomoU8ns0/89Hp3cXSM20b1BW+Sgzt8ovuvrwPSOW6QzjyUCsriABLfQ34gtf/zTo7JbxY8ZtDOKIlHxa3M78WXxRvh6qI7jGWUpyiu1uLWQ64qkYmz/EkGXWIAHmm2AOJGEKuZ2v/Qr0kdlDFSWvn9MdTCKlb3VAaTwtlKFaB/TpopDjw2BtfeEPl3o3djmMHDYTTVqzYwD9GRbwHzacQ2zJfGnEbXzzr3cljppWvVwKy3UETCq6JZ7;20:t4Q7aZAbwTAWvuiQdyx9DdwevS1q6vjnG/x3iQftQiO9mEpi2eozqpmonBg0px0/82r7WGA6vC6AeQCLPKnYvLFfl2C1uLEc+jDsOkTiyk1Twzmq21uFdM5mNx1fZ3XCO7FpXaJ+mxVKv2ZbkG2aht+UmW1SuJDo+V7VsFOwKAU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5419beb4-2279-4ee2-b3e7-08d584b12eb6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08880CD16619206085C228B0FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kqncWIKyHDz8eR4UVpM8KqV7QOm319e+/mIh/oS0M/t/t/p3A7yqsNrA+jrAhW6KF42fYlgmwhUYZQrQiv8dn3dhRKDxLZ16fQfN6K0ATKu7tDhLFvoUZG0gcUYc01BvBMZpgCn0/YN3cpbY8vwdkdVci/wSwnHMJTengjsygQbDt36TaVt+idhEp+oqNUPrTGBBA/np6V/NadXjbm8081HeWc11EaJ1sXFmShnt7I8XykOC1OON04qYlgJCpvnJdY+c5g38f85JYL/ZJRUQVQPiDp3VA47PwhSCfFIpTb/jHT0aIYTEBKPywldridz7Rd2xyHbVrsc56djhyLks5w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5419beb4-2279-4ee2-b3e7-08d584b12eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:36.2101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 41f61db2cd24d5ad802386719cccde1479aa82a6 ]

The values were not computed correctly. There are no significant
visible impact, though.

The intended size of RX buffer is 16 MB, and the default slot size is 1728.
So, NETVSC_DEFAULT_RX should be 16*1024*1024 / 1728 =3D 9709.

The intended size of TX buffer is 1 MB, and the slot size is 6144.
So, NETVSC_DEFAULT_TX should be 1024*1024 / 6144 =3D 170.

The patch puts the formula directly into the macro, and moves them to
hyperv_net.h, together with related macros.

Fixes: 5023a6db73196 ("netvsc: increase default receive buffer size")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 13 ++++++++++++-
 drivers/net/hyperv/netvsc_drv.c |  4 ----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_ne=
t.h
index 04e9852ab804..4f3afcf92a7c 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -638,13 +638,24 @@ struct nvsp_message {
 /* Max buffer sizes allowed by a host */
 #define NETVSC_RECEIVE_BUFFER_SIZE		(1024 * 1024 * 31) /* 31MB */
 #define NETVSC_RECEIVE_BUFFER_SIZE_LEGACY	(1024 * 1024 * 15) /* 15MB */
-#define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)   /* 15MB */
+#define NETVSC_RECEIVE_BUFFER_DEFAULT		(1024 * 1024 * 16)
+
+#define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)  /* 15MB */
+#define NETVSC_SEND_BUFFER_DEFAULT		(1024 * 1024)
=20
 #define NETVSC_INVALID_INDEX			-1
=20
 #define NETVSC_SEND_SECTION_SIZE		6144
 #define NETVSC_RECV_SECTION_SIZE		1728
=20
+/* Default size of TX buf: 1MB, RX buf: 16MB */
+#define NETVSC_MIN_TX_SECTIONS	10
+#define NETVSC_DEFAULT_TX	(NETVSC_SEND_BUFFER_DEFAULT \
+				 / NETVSC_SEND_SECTION_SIZE)
+#define NETVSC_MIN_RX_SECTIONS	10
+#define NETVSC_DEFAULT_RX	(NETVSC_RECEIVE_BUFFER_DEFAULT \
+				 / NETVSC_RECV_SECTION_SIZE)
+
 #define NETVSC_RECEIVE_BUFFER_ID		0xcafe
 #define NETVSC_SEND_BUFFER_ID			0
=20
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index a32ae02e1b6c..c849de3cb046 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -46,10 +46,6 @@
 #include "hyperv_net.h"
=20
 #define RING_SIZE_MIN		64
-#define NETVSC_MIN_TX_SECTIONS	10
-#define NETVSC_DEFAULT_TX	192	/* ~1M */
-#define NETVSC_MIN_RX_SECTIONS	10	/* ~64K */
-#define NETVSC_DEFAULT_RX	10485   /* Max ~16M */
=20
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
--=20
2.14.1
