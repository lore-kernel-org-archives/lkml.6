Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479064-2-17225074925103492923
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
    t=1521479064; b=ZT97SE3ZyxKpWa08OIPFGQaeHCPjGfnSCaQu5h9+ebXlcOa
    Np03V8LbA9JvHpMLqrm+jLIv5bIkTGai0vKgSyaEwkmrjFC/hDzdodAWzouxNoOX
    nKv5IoYe8ZNbcLDNhr8OFGCMShKyvP0AxbE26Yi1RwcCrj+nnqykpBzZNo+jivNj
    OLKwDvHLXb43xTAo0+1YNPWHt3bHVyLMrZU4WXkcDVdUV7QWp9g6xo7IB+2MPwzS
    kVr7I7XE6jtGnhCABylFBuQPLKsNYdYOZfIxDUC+99C1gwkj4tgr4zvulV4DT0Hw
    Elt4bnMPgd8I338rmCLf+XK0aOz9MKIWugebcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479064; bh=/W1BvY
    kuxlnyFWZRD/S3Is3szUhIEhdjw6dEVeuBlK8=; b=ImLBF+B6IHwfRN5E2VjWbP
    iZAE7DUJrJ/cO6skLXhBM4iFmGIfxWrDyzgbK2lkvQ8SpO5KM2NG2wpOds4h10gM
    lpUm/JN2GpHw4KwgP69/B2IDSkmIwbm2WS37OdGMudXKQj/pqf8AnrLKmzh59EZ/
    BMLve9XmGqh2kSz2LuSuHb2xFIlNu9gv1/t2I+mmKWWOPBUnCViTbUE4kQf+IPIe
    ZFF11Bw1EG6h+FsPZLy64Ozl+0r7ULzwpqy68ZEFp3jl6EX1EWVbBLhN+r5ulLng
    PCGZMI6xSVFyXGkCeDrZ6xQ0fT4NutTzmjlwJ9jmyCE+ERK7pWnMv4Jx1Fo9hDLg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N9cUeJWe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkeefnecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N9cUeJWe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkeefnecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967706AbeCSRCC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:02:02 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:37952
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966204AbeCSQLD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jag Raman <jag.raman@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 145/167] sparc64: ldc abort during vds iso
 boot
Thread-Topic: [PATCH AUTOSEL for 4.4 145/167] sparc64: ldc abort during vds
 iso boot
Thread-Index: AQHTv5yC3zgjdU4WGE+t6KhkqIyhcA==
Date: Mon, 19 Mar 2018 16:08:24 +0000
Message-ID: <20180319160513.16384-145-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:tNII1CMAE/UpmWYf95Ugy2fHTvUDGILHwKmL3FvyuhOaqA1sCahgiFe2R3bbxOdYzImsX70ViyfaGcbPiXU+ZCCP1DlQq5h0OCN+z2zKQh4/3c0NwXmVznMI3VMJqQ8N05KhZyDkWZaRGwi0KLkANnCEhoA9mRjG//VCfYMdEsoJIyouLy2N/I68gS7shGN7GBEdRnBte5hTz+7dTBpPYVeF8UPv9sOKJi1Z2eJ5bzJR2cdWw2vtnsntYE/cAIkr;20:/ACJ7tg8+qKkpB1oqplwp0RNIy8cQL9dU2Jxv3hF8kGotRIzXP4onrnVUzKOX9ua1Olbng4f3l2SmJLfwBVZJQRXHmEFst9vgn8patyWe6HnHCrrt+xIqTfj9jPJuUJPflgL810xCAhDk5AZ3jmJYBAnqiagM5uA91A2ST4kOro=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 521a0e7c-2f85-4da1-0bd3-08d58db3fa17
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888D961F92EF49DA08ACB4FFBD40@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6486002)(72206003)(106356001)(86362001)(3660700001)(6436002)(68736007)(53936002)(107886003)(8936002)(81166006)(8676002)(81156014)(2906002)(6116002)(4326008)(6512007)(1076002)(86612001)(66066001)(25786009)(7736002)(3846002)(305945005)(5660300001)(99286004)(5250100002)(110136005)(478600001)(36756003)(54906003)(2501003)(6506007)(186003)(59450400001)(26005)(14454004)(6666003)(2900100001)(316002)(2950100002)(102836004)(10290500003)(3280700002)(97736004)(76176011)(10090500001)(22452003)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eOQZutp3GTqFvC5C56oBRHye8whXOZVplDV3F7+sXVMkfNSx18HGByuDkhlj/d51/jAqNdIwUeWaxqERycvARvX8LN/CTTmUxJUWldSHe0lgLqAVJKH94KFJEGkzOgmGQzVy4ZoXpzPxfkkGXukZBCnLdYJWd4sNk6IsmwsDSgtV7Pb8SFW4JKEr8XkIAd7shfzeAQnott1JTeU1RugI1qv9SWvp82lm1/XFRO+R5nmKKnSxK2sb5vjCbM4YBMU/zZJHPKpr3UdRiglpNUYPHKEh7idyG5U7c0Rlt3VXQn/M9BxpwMhsEoVv7Gq55tca0u86zo2baWqOm32s7jfG/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521a0e7c-2f85-4da1-0bd3-08d58db3fa17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:24.8327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jag Raman <jag.raman@oracle.com>

[ Upstream commit 6c95483b768c62f8ee933ae08a1bdbcb78b5410f ]

Orabug: 20902628

When an ldc control-only packet is received during data exchange in
read_nonraw(), a new rx head is calculated but the rx queue head is not
actually advanced (rx_set_head() is not called) and a branch is taken to
'no_data' at which point two things can happen depending on the value
of the newly calculated rx head and the current rx tail:

- If the rx queue is determined to be not empty, then the wrong packet
  is picked up.

- If the rx queue is determined to be empty, then a read error (EAGAIN)
  is eventually returned since it is falsely assumed that more data was
  expected.

The fix is to update the rx head and return in case of a control only
packet during data exchange.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sparc/kernel/ldc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 59d503866431..9cc600b2d68c 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1733,9 +1733,14 @@ static int read_nonraw(struct ldc_channel *lp, void =
*buf, unsigned int size)
=20
 		lp->rcv_nxt =3D p->seqid;
=20
+		/*
+		 * If this is a control-only packet, there is nothing
+		 * else to do but advance the rx queue since the packet
+		 * was already processed above.
+		 */
 		if (!(p->type & LDC_DATA)) {
 			new =3D rx_advance(lp, new);
-			goto no_data;
+			break;
 		}
 		if (p->stype & (LDC_ACK | LDC_NACK)) {
 			err =3D data_ack_nack(lp, p);
--=20
2.14.1
