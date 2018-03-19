Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476414-2-17571243669396436200
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
    t=1521476414; b=E6OMOmmD9YxBDOnVd0YRQrSp8bhzeqzK/ZHlzBQhKDTqE03
    Qj/RFR4zdci7sFFMO+0wiYzYLSReiTgfHmlwOnRs+xaRQh9cKue3uCnvmk4NIFOa
    65QSQ3HZUM8SXfS/TXIJU3nw4RdLfNrgh+STd2j1igrKXHy/NwGy316av62FJurw
    SP4Pj7JcRWaaXSEkUnD09xPxAfEi4qnr0hQ3MYxeoDiChIDPsD7YHPsovAq1QA4S
    LVj9YDijLQtVcMVRXGEA4d1Oa631Cb+wIxzfKr4OuBLq1q46cmuNYNy9Kscn4Zm2
    Bb1y4S7cuY7cKtxEEDERADkCC/KwwPCuhT3jBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476414; bh=fmjgq2
    SJzCCZ5VDx2yAG0HoEotAXSzRw0jHLtD9dkh8=; b=f1+cARsbu2mZsiX8rsr0M7
    0KlWRih4Nny6N0j7nE5ims/1aHTovOjKTU05/SixhY0YqsoHhKghUg3kc7jEdGps
    RSR7hXqqFEzwX+502mvjXgZCjvQFfc3Rojizxf5Z8fw0nzV7im8j25ws8mL1vt0G
    XoPRxiX4TdizNPWTQHwgwCozazrd6x+ke454R6wqY8EHWQHVKU/dAXw8QKAZ4aFl
    4yCOMSzTTMFxFYQHajn6WNPimBjF6r7HtJWDCC21iRp65EMF04dzY0RRZz+0myJQ
    CFhP9Rm8dPj+g8Lj86aOX4w9HwDT0oz1m3cR0/QJ1e1qDLhvejdTTrVQkXlfsIqw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gkb369vE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljeeinecuvehluhhsthgvrhfuihiivgepgeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gkb369vE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljeeinecuvehluhhsthgvrhfuihiivgepgeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935366AbeCSQUH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:20:07 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:50448
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966947AbeCSQOV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jag Raman <jag.raman@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 086/102] sparc64: ldc abort during vds iso
 boot
Thread-Topic: [PATCH AUTOSEL for 3.18 086/102] sparc64: ldc abort during vds
 iso boot
Thread-Index: AQHTv50wZlrugQzjAkuI/y4BnZ/djw==
Date: Mon, 19 Mar 2018 16:13:16 +0000
Message-ID: <20180319161117.17833-86-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:MBJ7m1QBw2EohLbrMQktIiddn5E8lCd9jXFhs8PnJ7w+YH7z6MsnXZZyE5Vz0q3lBPQl9te0unUE3dhvQVuovt7cutXvDw4L+5pWFFkms+ZWX55iY7M4Mt2te+gJq4fO293nFL3VBG/eKH6hwlfih651abMZ0zBMCkgImRPRgbvvO1uvtteJ3Kua72QSTulWt46x4eN/ARBUVtDB8WqKSeto24k/VAPdl0wucv6DVRpoBqkMsiCnOoWGLs8bT9Mg;20:3y3rktzvJVFpAiZSdwUxQY6KjxNfCRkk+8FZDvZ5PpNsP+gCcI44Yg/K/WYHNcxkDdRxjqzvaktP+P1AvQzpEih3TYevSzF7maJhVlnn2Oz6r1LrbMx6I1tC96O0lAthYMPdc+LzmVaZT8rr43fOS71KDtGhhyeF2Pvp95WKihE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45ca0671-dad3-4ae4-3b4d-08d58db47563
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063D75E51926EDF5970DBBAFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(59450400001)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4840IeBEnf8aQKR8c5hG3QNVetEMrkqNHFszhi9zkiTbtGDR+HcFM9BNbtGZn1Ay3TH4dBtyiCjN887uPsM15ywpPPQSWf3AQ1jwE9AUMTwGYLou+iNSLSrT3+cYUvVTe2c5JgKoOVEt5kjzTV2KCgZxA2PT1JT/jM8FwXu8UX5XXhehbCFXaoi0XNIxQzPRP2vaWv8QCFuoUc+SX5WwW0hbzbUc7j6WSGqrq8M266cM1MiUEYIg5mTG2/ILo3vczU6b8w1izFzJRODv0b5YyULdsTC1oH8XhFrQiPui0XMEbX094Whj/q8HCF0hR6kzg8JaGVA0QUiUEbmjlme01g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ca0671-dad3-4ae4-3b4d-08d58db47563
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:16.7892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 71762565513e..8bca543977fe 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1693,9 +1693,14 @@ static int read_nonraw(struct ldc_channel *lp, void =
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
