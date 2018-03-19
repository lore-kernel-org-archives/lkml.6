Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494083-2-2253255240019346843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494080; b=cFErQok8Zs3/8Z//QOkLaXV8ljR+AL/Et1iSDr6PLeyLPJa
    ajOZykGEdYhM4/Nf3czyHa2Q+UlBdzEzRrfo93Jrx3UvQ82QD1IxQxh7/2Akl3Xp
    cRvKsPRfXrcQqWIVDY2BjVwhJOr5iud/Ew1jBhu/Tome0bmsOlnBYRJURBee+qgx
    qyNOhEUgMZu0x7q6e82yYfU4Mf4OMpZYlb1Im3I1QSE/ctDkmhdpjxf5R/Ww8eDx
    JCwtgpcxSrd1FYBc5UMQESPNGcMVkz01S9F92/wk1W+nb/YS7lfaOhoB1TxQAQ21
    oWMmoljOn8XoJz0Vn18P+2UI1jSjSTKgfQttFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494080; bh=1HGq34
    WF44w5dwjPRTUjauYROJP/tSwmk410keISBuo=; b=PFrccV52RSopZt1w0A82/w
    x1fwMCkmGkOXulPqL5YRI1f63xXW5CR4UHA32yVp7M6NRuFjTBEr68lV7SJpT4AT
    5jG53tydEQ4mm6cVzn9QZmc5EZmIjtRApgX9G0d/TjHFbz73i3MAgcAPse1ELFHL
    KUZao6ZzLOlfD+OCKub6vbGkfe/pO6abzvZoDWsJxcgjaCQFdgVOkaSl09IbuRUt
    WNlQpn5EPJp1ptzD9/74GTlJsatRz1lFBZ7isIC6YbanggNJbMr2fLZ9O5I/qILc
    DgH0Cug4NE4lXQnNiKe5XL1EY0XHHOBbF+g60w+ReczBxutr3m+kedwhfXzmifvg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IP+7m7Tz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekkeenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IP+7m7Tz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekkeenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934947AbeCSQBp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:01:45 -0400
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:25993
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934942AbeCSQBm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 121/281] i40iw: Fix sequence number for the
 first partial FPDU
Thread-Topic: [PATCH AUTOSEL for 4.9 121/281] i40iw: Fix sequence number for
 the first partial FPDU
Thread-Index: AQHTv5tf/gYrXCzzuEKAcrtA4+odLA==
Date: Mon, 19 Mar 2018 16:00:17 +0000
Message-ID: <20180319155742.13731-121-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:kAt+uvsBdFzFvgE49t5W9XyrLCiMpNsQw76con7283PAwGxIkbY9OFIyDACIm0iJ+ii7DW6HG43+Zy2zqLsRLISVW1C1hI0efZaxhtt+w0cJ/pgY7HKBvNo0eWMImIvxVLudJHfFaM4yCu0OpqFJC+ezoc0EPNi9XQlti3P4Cg3BYLEkJjb4UK5QGhoFFxuTYNoDdNrIcehC5I7lbeahqjipEw+jx4a9t3Jiq0SlmIgecZjGsAzXy2i68T70/bek;20:iBChKUtKWUb5z/SpJFmE9P0XBgvk6oLXwSrJJ/MbIW7w88djLpAhckA5UxotzxEhOKYKP9pfU8tr7XvdCGHE6PV9TW+g9M3k/43a84QfLrzqZoKg7i2HF2ehtjPCWelKtANG76ov2VtSk3+fQTemU5T46DiWjKet9mBgTr1YjkE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 416d35c6-fddd-40a6-a086-08d58db2b3b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0903A087E0A0BA16C455FE62FBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(6666003)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(59450400001)(4326008)(2900100001)(3280700002)(25786009)(575784001)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Mmdw437j7qiv8ZiMUgYFpxDHW45BeRESlHfLZUfarIjC3EpLIBzslsqptvSAmnB/cy9g5y9Bia5v/SbZLFhsaDlID4uypQt/4m2x4F1Ur+iQbuvxoc6DwIbP4PiNyvzGFhgq0v3N9al4cxIziszkoQRrLTs0zux4lmjSmVG4aJbk1hue+zIrot4hpnzu+uCGfRWFSfkPzJC+cWGBDFtlbss1aip05o1ysaYvnzY6Q8r2BuNzorJ8qYxGeCkWxO5VmueKgsoUjPXvX1Sw7fDprei5f2qjZimcKoQRvwDpGW1A3Ohby9qZfyd6Ym1gP4tAxC+ejsVVwQHlhkl2lUz6uw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416d35c6-fddd-40a6-a086-08d58db2b3b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:17.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit df8b13a1b23356d01dfc4647a5629cdb0f4ce566 ]

Partial FPDU processing is broken as the sequence number
for the first partial FPDU is wrong due to incorrect
Q2 buffer offset. The offset should be 64 rather than 16.

Fixes: 786c6adb3a94 ("i40iw: add puda code")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_d.h    | 1 +
 drivers/infiniband/hw/i40iw/i40iw_puda.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_d.h b/drivers/infiniband/hw/=
i40iw/i40iw_d.h
index d1328a697750..8ce599e1639c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -86,6 +86,7 @@
 #define RDMA_OPCODE_MASK        0x0f
 #define RDMA_READ_REQ_OPCODE    1
 #define Q2_BAD_FRAME_OFFSET     72
+#define Q2_FPSN_OFFSET          64
 #define CQE_MAJOR_DRV           0x8000
=20
 #define I40IW_TERM_SENT 0x01
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.c b/drivers/infiniband/=
hw/i40iw/i40iw_puda.c
index c62d354f7810..3ed49146d73c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -1320,7 +1320,7 @@ static void i40iw_ieq_handle_exception(struct i40iw_p=
uda_rsrc *ieq,
 	u32 *hw_host_ctx =3D (u32 *)qp->hw_host_ctx;
 	u32 rcv_wnd =3D hw_host_ctx[23];
 	/* first partial seq # in q2 */
-	u32 fps =3D qp->q2_buf[16];
+	u32 fps =3D *(u32 *)(qp->q2_buf + Q2_FPSN_OFFSET);
 	struct list_head *rxlist =3D &pfpdu->rxlist;
 	struct list_head *plist;
=20
--=20
2.14.1
