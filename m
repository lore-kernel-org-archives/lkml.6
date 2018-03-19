Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497676-2-12254473734527215524
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
    t=1521497675; b=G8Lz8oCnpjcxHnRlkX5bGzZS5Wo4y7CSCkV3q39UpGEzPNu
    8Rr6clKp6TFPVO/8rubVSTfGcGA8cHY3tiYNrj/dHTdxBdgn24xqJoqrtQ2BvmnT
    +0O2StPAEsGs+15sh2T3rSN8af/oNKFVOgkP8tO/1qp0eBN+aLcVsT+t0qjcQeuA
    S6uUNgMx3cEQKuycP0Vg7nYMl1W9oLIMUGkJoBDiyfymMZjSYAZ8MHWeLGjXsUgI
    5UjoUs//YmwFwr3N70sRRXV72OnewrVs69s2k4pgzn9yY1lnfckfHgKJqkbHmNBY
    cGnFMusYiOVuNFyTK9gaqEG87S5aQn3sLD9Lwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1521497675; bh=oMRaz1qeOAC5qrMItn5ynvB7XS
    +MEUv3PI988JLvk3g=; b=mS843RXta8BRRXljtNj8e4ryUDzB4VyycP/FYWzKjC
    NsIm9/ZSM4bmQKzYm0+mbshKnZP0rBMpg1nD2n3fxKMfSj/+l4YEUQppWWuj4isf
    AZ3ymQR3cDJdvW9Kjs4tusb9RmejYabipF+4rDflY99ErXmqNiJyR5qZzIfwhCRx
    l+5kQIfYHJ45u8hJCb8HYe4BZovh+rd2SCuPfYLrdDfdaeiMo6OTmaNud0Kvaa0x
    B5kd8T8BEkdb+NoGvopX70U+hOh9tRZhIxDZ27kGQjOZS+m8ulioOX09ULTnvOuv
    kxFyKAme0VIb8z8IbzSgfKNZa11vp4XVfrb2+yfjdgpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KJm/ZauH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieduheenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KJm/ZauH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieduheenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934247AbeCSWN7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:13:59 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:11712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934147AbeCSPyV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 01/97] i40iw: Fix sequence number for the
 first partial FPDU
Thread-Topic: [PATCH AUTOSEL for 4.14 01/97] i40iw: Fix sequence number for
 the first partial FPDU
Thread-Index: AQHTv5qK/oCzsgE4e0KaHkRyuyqMLA==
Date: Mon, 19 Mar 2018 15:54:19 +0000
Message-ID: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:ysSGp+W2Pxy4jd4//RiklggmC81Zg3LQ0U97078zYCR8CJm+wYphlVER38DRRYisG9V80AnSuKOc9l7lh5FmlhCZX4wamGSXasqdMXbrv+/CYtyg3+anm8IW3ITe5RaiU7wL/DeeDnZwzUPkldHPOeyWiMJrV32hJmUqE4EpucUY8YNJ8enUydo2GSgjXVd6y336qwW/9kNUYAkOwThn9BdW0sqYuiLqdqzvOq3UQHHi4swQqabv2Obt60fnfPyC;20:MG7Eq6Nm5V2zktTvqCGXCiamZG/7AEQXTYUbuQO9cOz9aQ0v9DqmLe+muqHOF5BZdKn4ThA/m0X3RH6oBB8+IkdFjOI6FTB5+/T2IDmug6RaOX9NbEMbrAt745B1k5sDDv1u/c9S/l8fjlYE+y5tN4swx4vtndn8/NpqJYBPSUc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2436855c-461f-420f-c5cc-08d58db1ad30
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080644BAA70CEBCA0020D989FBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(575784001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SjFRQBFgbTxzhCS+OVb3LdW2ulPLXuwlPV21eJrXgTuwIRPf/LnXhSNyvde7wy/u3YMt/uH/6/Gx/BUI0Ypg67tl5KvdHcZ+RaUf3K0R3jaduFhhwEgEtJjAZh7T+oTR03LzXH2FY9ptmYKInm9bLoD5yCfGhhUHbeRvgIJtPJ1TpILFigmLp4JeMe2bjlZoGGhO+0ZlBkEw7il2seA8K55PHOkBOqzScRcpP9MZsJIvepbAk1aS349weOr66pfBxl34PqH1FzxPv+oB/8J4uqBg44VIoMeU5LQhIJGIJtk/qZq6SOp2TPubBlC/mEBWfBFn01lMKP1ExdIQr21HfQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2436855c-461f-420f-c5cc-08d58db1ad30
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:19.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 24eabcad5e40..019ad3b939f9 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -93,6 +93,7 @@
 #define RDMA_OPCODE_MASK        0x0f
 #define RDMA_READ_REQ_OPCODE    1
 #define Q2_BAD_FRAME_OFFSET     72
+#define Q2_FPSN_OFFSET          64
 #define CQE_MAJOR_DRV           0x8000
=20
 #define I40IW_TERM_SENT 0x01
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.c b/drivers/infiniband/=
hw/i40iw/i40iw_puda.c
index 59f70676f0e0..14d38d733cb4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -1376,7 +1376,7 @@ static void i40iw_ieq_handle_exception(struct i40iw_p=
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
