Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475183-2-3198574397551787550
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
    t=1521475183; b=QfQkJftM/md4nvqWfiSpue2wwpORLl+unQzEX+Pe+QLm6NJ
    b9RGqEki9F4mWXplkMKk5J9rgny7OK9BIwvYUnUWnJCDPkhp6wOSEr7l43Zs6R/S
    vjqW854wbiVQP/WffG9w6SIBSA3GNSbaFXLGMruSMuWa508wtwKuq9HHJ2cbtE3j
    8h1FpkySGbaP57ZLljEnqeMaMADjlpuF6OgAhlUColod+HWhsl6JnAf9KyYBMdqb
    dRYgAg6xWaNVdgzFDWxdQmiqxJY+cuIbwqL0DKdY+9oRLjRwLafyyOPcki77qk2h
    64SvWB67vCr/bqpRigV6u2zB7U5/XpoFYEWuGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475183; bh=SHrSym
    JEj9v5iBL+qoFatQ7MeKwbBYaYZoDXcKhq5ww=; b=e4DJRDXXCSaTc3ZMyZhH3d
    vIQltYZkfOGasG+yK5bGfuwKtDmRefIiB9B7+80JHL3KtNgOHZZsXYxPzysQt+LZ
    a0IJGTbjgYDcjm6Qvbf8bTgYOQv10riuTRuRaALbXj1dhhzbeDMNjjR2BY3PdKqI
    Zs6pI6fQQHu6DfnACqkT7CAP4j4ig/zf1808l+BtuIKcP9mRBU4ICTYVUV6kRxIv
    9P3oE41l+0G3AeTPxo3anbCFiNxAglDNnh/V2t6k7IaymcYTUFwvcmd8fh/CGEWG
    Bnk0U2IjFeAHVFVEsDviFEIbZV1Niy1joUDRIz10BmS89e6c2Ilazq73Ramce/WQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S+Yc5uwQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejleegnecuvehluhhsthgvrhfuihiivgepudduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S+Yc5uwQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejleegnecuvehluhhsthgvrhfuihiivgepudduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965128AbeCSP7g (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:36 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:62208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934448AbeCSP72 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 054/281] ipv6: avoid dad-failures for
 addresses with NODAD
Thread-Topic: [PATCH AUTOSEL for 4.9 054/281] ipv6: avoid dad-failures for
 addresses with NODAD
Thread-Index: AQHTv5stDbpxG1Winkmld7ov6Psv0g==
Date: Mon, 19 Mar 2018 15:58:53 +0000
Message-ID: <20180319155742.13731-54-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:+0/6VmYaWEW1ULlNIQCqCqlj7qHQE7ckpd3LYjvQ4+mp8v62nFHRzfwIVLg+C9pIGdTgleaj9MiIxZI5MGcRB56oBBkPv1keOoi1wNw2hYJdtWHIuveww0sy6irGkytZhoiBcXaGVJ3oO6FXKofZnwEii6qgB0TEZv3ZrTUAXc4SNeVpIFs970X16uUb5EfuZ/uuu9a7ByeFWelZs3LnymV4O+SQ/ZRfjxSZxN9V0dK4+ttKv5jzjhk6SdawnvRE;20:222aQ72e6dwkedDHRIjoqoDnUzk3Zb0M8Ibo8Utf8K+c72cketdc98w4BIP/eQhaQcuh7Xuh2C+lDSS/SqmXHeEIArg/NqXq/i6+mieJYfPcaq73e68bTtbSdm163O77Nj1I7w2PjOpP66F6MUNPeXhFu0eCLlTN5E8ItuX7aHs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4dc16f99-b5d4-43a1-66f9-08d58db26041
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109EA24D133918FF25A0FC5FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: o85lNmIjJeTQUnioXEctKzv2Tx312u+b5jUEQ5txmRt7xHUs6x0b+TOopumHYrDZbc9dwtkSWGboLC6Vhur6xJTq7s2zs5quLyoNsXUZTOyhBtG6x2Bs1FX895CalS/YkRMPOpft9NW/WZq3S038XnUdlF3enTWgUq+4wjpEq2ZrB174PE42+MM1y9vIokhP1Eih3YQk04ceyvkaxt1JszjEuAEZD5aAFNcBs91DbdVyLzwlzP0UXzMe58JU4Z2pGyba1PMUpSuCKWF3v3gqd8P7xO76Moy1EEDxTvJhHpwWu8wbCiDIlIoBg75Pn7eHKz2RSC7Obwmi3nGLfiaxQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc16f99-b5d4-43a1-66f9-08d58db26041
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:53.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 66eb9f86e50547ec2a8ff7a75997066a74ef584b ]

Every address gets added with TENTATIVE flag even for the addresses with
IFA_F_NODAD flag and dad-work is scheduled for them. During this DAD proces=
s
we realize it's an address with NODAD and complete the process without
sending any probe. However the TENTATIVE flags stays on the
address for sometime enough to cause misinterpretation when we receive a NS=
.
While processing NS, if the address has TENTATIVE flag, we mark it DADFAILE=
D
and endup with an address that was originally configured as NODAD with
DADFAILED.

We can't avoid scheduling dad_work for addresses with NODAD but we can
avoid adding TENTATIVE flag to avoid this racy situation.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/addrconf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 1594d9fc9c92..3a27cf762da1 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -988,7 +988,10 @@ ipv6_add_addr(struct inet6_dev *idev, const struct in6=
_addr *addr,
 	INIT_HLIST_NODE(&ifa->addr_lst);
 	ifa->scope =3D scope;
 	ifa->prefix_len =3D pfxlen;
-	ifa->flags =3D flags | IFA_F_TENTATIVE;
+	ifa->flags =3D flags;
+	/* No need to add the TENTATIVE flag for addresses with NODAD */
+	if (!(flags & IFA_F_NODAD))
+		ifa->flags |=3D IFA_F_TENTATIVE;
 	ifa->valid_lft =3D valid_lft;
 	ifa->prefered_lft =3D prefered_lft;
 	ifa->cstamp =3D ifa->tstamp =3D jiffies;
--=20
2.14.1
