Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480026-2-4877385363950525211
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
    t=1521480025; b=JUPlFwTYRDrVVTbbAyw9A00gggebIGuEqySnGgGMoLlqM5+
    ewoViIfuE4C5dhFMwbwLMwwUV7shZ8ju8xf0IhdVIqaz1Lb8FGT0yJIoT8poGlsb
    yucvQEHr7LSI5UsRUs1rPxOr0ITrXnEA//zscx0XAk6quTd65TvSgTJo6n++Ujtu
    LfxLL3/MWop7Q6vxIAvSsWl9Jd9jED8lFYQq5oMt0CSe6uVSBsn7u1FYGGaUcDDE
    ZrfZiAKOvcTRJURvUhvNzi+/AAb/PBJbFgkZUzhqD65xIdc/xE1eLCb/fVb/OMlj
    Ux7UyuxcFxUj+crlwnCkfR0cGvZE+JKjbgzaWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480025; bh=4En17y
    m7Mj4gqQKTiH+Lqjzz8aR1M/LdaLPOJTK2/Lo=; b=TbAqUYVRC7nTCxZmWjSqrg
    +ft1/BkxEvKmkRVTtK8RYzoc4hbuQ0LPmRsWRj0UI9p86WoevHA61TLJqoCrqxKz
    R3WM6ontuEkYfPoCJIcd8DrvXcTwG0t2gBt7NQqkFD2ko5mZVDr5VvAXO4YUqm41
    +y7pcInUFmTnqMHf4bT1HOtNNZABsYEBOYOf2WQ4ZnbKHOBga9fUtM5yhlN5mJYW
    ddIvqge1a+9aO5z+yKCDNp7WqGlbv4gMarimQLaKXAaH7ZMtMXWv4FbG4TdtSMS+
    FATr+TtgK+XV3hfci8e1FFPF2CGUhS427usmBixyeyu1lNL2SDjKIe4AMVTyDCyA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S2SouzVi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvheelnecuvehluhhsthgvrhfuihiivgepfedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S2SouzVi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvheelnecuvehluhhsthgvrhfuihiivgepfedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966421AbeCSRTc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:19:32 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:20373
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966420AbeCSQJN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hangbin Liu <liuhangbin@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 085/167] l2tp: fix missing print session
 offset info
Thread-Topic: [PATCH AUTOSEL for 4.4 085/167] l2tp: fix missing print session
 offset info
Thread-Index: AQHTv5xVz/1bJjJM70WHsAbca7f4QQ==
Date: Mon, 19 Mar 2018 16:07:08 +0000
Message-ID: <20180319160513.16384-85-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:8wStszR25l5SiwVvpILudcGGSgF2EL1/Bx1E/KP2jXVvWGRDRL39bUvtHRErR1G8Fu9ncRVC1E6j8PYq3OMWE9wD+Spf3H5RVr69Ums/4i70YwIrQTgSDi76cr+eA2dTBIAOVJjLSDSJz+B3TgaT2wygA594yuqxjtDM1Y3k23gTtpS3ZDqMosh56k1YW67UFIuZPgdXs+5UjxtxEzazAvbEon5A7jE9x9uhmA+4VFi/Vau6scgBORJ6908LldxS;20:onZJ8ZsJmrmXoaMuk3WCIbGjGZuwXzvVkWJBw9aMxVevcZh3P6vFzifXIjgp1TIHXoNf3ngPGiXAnwH61z13q+FkepDXF3IpofSm1LmnWt4oGopD+V6TLdVdG+H7dQy1vvgFIPGPnOPXzTT4Rmcjrop1W0oYcm6Z0fTvS2LZ0NQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8e02964-8b8e-4a9a-d837-08d58db3bde9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090271215002465072717D86FBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(2950100002)(5660300001)(97736004)(39060400002)(81166006)(81156014)(3280700002)(22452003)(99286004)(186003)(2906002)(76176011)(5250100002)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(68736007)(3660700001)(478600001)(72206003)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pnv06UrRJBry0cvgceNI4SpA3yotersbRjCxHd9vJT42xOvpdXgVv4HT9hJYuv39Fm5ckg0hkoninlIBwVF137RRsfc2ep0JkI81uPNAkiKEqzZMYWHrs29g4C83GgNQXujAxpr94i5cigISL0mJTWkLOU8v+y2gYAlaule2G50W5k+JMx9NfF55k7h1do7aNjaHIiD+R2yQ3GEPrrX9BGaA/TkHWo2HNKfF/Q0HgZoqh/B5J0vJUIwpiHEsc6Jpqv8CC3RWWtzvcRKtAUK5Wwu8Les0LOLV3nE9w+sn1fTal4S1zzSeceam/9pGaPVXr08Pghh6oe1cArVMaG0ehw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e02964-8b8e-4a9a-d837-08d58db3bde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:08.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 820da5357572715c6235ba3b3daa2d5b43a1198f ]

Report offset parameter in L2TP_CMD_SESSION_GET command if
it has been configured by userspace

Fixes: 309795f4bec ("l2tp: Add netlink control API for L2TP")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/l2tp/l2tp_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index fb3248ff8b48..ae3438685caa 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -732,6 +732,8 @@ static int l2tp_nl_session_send(struct sk_buff *skb, u3=
2 portid, u32 seq, int fl
=20
 	if ((session->ifname[0] &&
 	     nla_put_string(skb, L2TP_ATTR_IFNAME, session->ifname)) ||
+	    (session->offset &&
+	     nla_put_u16(skb, L2TP_ATTR_OFFSET, session->offset)) ||
 	    (session->cookie_len &&
 	     nla_put(skb, L2TP_ATTR_COOKIE, session->cookie_len,
 		     &session->cookie[0])) ||
--=20
2.14.1
