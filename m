Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474527-2-16966481405976056829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474526; b=pW7LzTpybidb4JMk3upa8L29rvqfOi5xSyF8qxazJSHrqbN
    3IW5xff9w/HsadhH7E6qK2OVxv196OHocxdzts6hgGMvMPT0QbyI0EwD4L1yIoNZ
    Ew1vsDk39+Dl2cGtnEArbl/ArK9j0KVBFvF3o4MDzE52xYUCzeXpzaPmmjApeBPL
    AaFuvikeE1Mq2JITvkAOp5Ts8unEgPRMIMuU8L1i6tUBKo+BK63Tw7wbCKeCVOo5
    qXQn418fXouZusVB8pwKGfzRzpdiKpfjaM8Hp6UTeioTUkoKU+h8zUqJ4sm26pjm
    9M5V/ul1zZtDDuTIsKeL/Yv4XUe7wMUc6SqnAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474526; bh=NoIpFt
    c/FySgsMBHVnfwd0meQ5Agwi05K3X/jhIqNto=; b=PFFo4mzcmdKI3rthZavP8u
    MtJ6ZTLNCVRKlXewGYjMjNkt2VgPlfPojqiRhFbJ/aUdIfjY9qLWPd68U6yxy0QO
    50UkghQ5IegatQH+WXxrZQWOO1nOvqlE/79xv0wid82MAULilsRUVRvuF5y7ZusG
    2pr2Om+ARMAxPZF0Z54xb7ZDsrPohbB1S3ajjjgTrlasOan4EjDpEROzgNYGuplZ
    BBhrBwJl/nGF+hi+qTsXIfzxzK+jo4mXzS3zTM43BYlAKzBUPVQJmciQ0OgKcJjb
    BCfEzp87w68BmVvZPbAye04BxX+Nk73QunFDWiUCwxfC2s+zaG5kQa489jXIU3Fw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E6QIYxeP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvieeknecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E6QIYxeP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvieeknecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933787AbeCSPsk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:48:40 -0400
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:45246
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933768AbeCSPs0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 045/124] irqchip/ompic: fix return value
 check in ompic_of_init()
Thread-Topic: [PATCH AUTOSEL for 4.15 045/124] irqchip/ompic: fix return value
 check in ompic_of_init()
Thread-Index: AQHTv5mgh/9BTvdfCkGepsDirNXE+g==
Date: Mon, 19 Mar 2018 15:47:46 +0000
Message-ID: <20180319154645.11350-45-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:pdAgVp7fYatlyqzIp/h41D0mEnkJlp8fk4XvRq9uQO/joZItVjKEegWAPEfEmOCdDQHGASXmrpsbn3O6A3G7hS819MA7AnhAVI4z1ODwp4yvgKdVN3VVnUPINlhF4m/QhR6ca8Ht94AdqgLf2mjkuNN/LQmePqTtr4b7Z/GDXEri2CwZQl4dr19avWQNqxT+Epuhp9xlkgjvDipTopBPgkxdZDDaD2RQkfTRsWh5wzPHCnXfQs9GI2kVuZyyUjvg;20:c12WzIYpVjwKfVCSuhmL2/Hm0IcmvVD9LPEh1Icl5z0rkWYiJXZ7lh2hUhUyvY/hNmjXq/4/t2X+fEp7WhnUGrUWQD1tE4oP0M0idTE0RYBq1RqZl1tjSSS8flU1xqlNP7kWloRqCScF1H1yrBL3fiquxrAxsFkP4fyYVZkdl/s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c32a39f-8d3f-44db-ad3a-08d58db0d097
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09985C8F2072CCBCF8D9BA80FBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(50582790962513)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(575784001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2fetDnKOqPPOpP2dRYnZrApnXkR1e2tAuynbNKivKUy17eHdlULNpZW+Lm3UkecnimDzVpYAafwk59PYbQa22YLIGQQHvoSO/N+F0sYZ5feUX4kK5XmMNd7VmCAefdy0JWZKQxLT7wphmD0VoGNf8x/gvkU7pgh3hXAOoZyDPx/1MgHLFIyjvuDDp+OfiKtlWGmK8AQM3hHvDQ8ZmlGBBhU51KiN117qsiknATyrcOjmsjqgPtREF/BuWx3ygWPbiQsByWdyXU0ljmkaRj2ww+tq7YBZTZAa7NQ8/qkVF64jDGyHUT1KFbfwY742gx24I+YGca2valwf6hRN+zD51A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c32a39f-8d3f-44db-ad3a-08d58db0d097
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:46.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 404e6bea10662f0e142748353169d25378271e49 ]

In case of error, the function ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 9b54470afd83 ("irqchip: add initial support for ompic")
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-ompic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
index cf6d0c455518..e66ef4373b1e 100644
--- a/drivers/irqchip/irq-ompic.c
+++ b/drivers/irqchip/irq-ompic.c
@@ -171,9 +171,9 @@ static int __init ompic_of_init(struct device_node *nod=
e,
=20
 	/* Setup the device */
 	ompic_base =3D ioremap(res.start, resource_size(&res));
-	if (IS_ERR(ompic_base)) {
+	if (!ompic_base) {
 		pr_err("ompic: unable to map registers");
-		return PTR_ERR(ompic_base);
+		return -ENOMEM;
 	}
=20
 	irq =3D irq_of_parse_and_map(node, 0);
--=20
2.14.1
