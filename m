Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497470-2-8829559104764803698
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
    t=1521497469; b=BvcF2R61kKVMZe7CPGsBRZ/KtxAGbDrT4SlZ4O1afb5kS3K
    8mzwejBlq95WcyJXzp7a9PRbgZ0QyWOngNwhP/OVcOURZpYW6OqCF+JW+Y9UN+Q/
    YVHkks+04m3C/9xw5VC+k8aFHhFc4xWieDziqZ8UO23Vh+7dw30RO2K2ipXhqNFM
    K6OLpHWw2r5w0dWF7pWIAbpfJ1CWjcEi5gEvw3o72Ekmu38MMiVTiPIGJoYSUZa6
    mHUzLm+oXeX2vBWyIahiE2PPeElfKzwAOD6b0y9B+QUjShWrT+RQOPX5eQ+CaAGp
    fYE5nji+ld51+9X11uqA9eAmGVZrR3YI6tI7ahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497469; bh=WRvw5G
    ZxDPY/S9baAQxEvZWmvk3/AH4eX9WzyjP2K/c=; b=Q/C3lJkkO4zUCYFK1EooNf
    qJLP2CtwETP/99WDJSA0IP4YQkYKy++Ecdr1Zo7b4JhlF5nRjmlWVjItnKcGHoqK
    6a1qObPdqOLl26FxsplYoxVZauN6fssXhGp6Hzkrvy64Naai/p6uKwLlpN9icGZP
    +8mHQ/HsfhXpWN8SvzREyVFong5HzeplLixZIx7J4FhYsjubBlJPVDVT1T1rRWpa
    MKs1pMhNUXV37Lqc54YmVTD0iInwmx+LzMufTjq6Ngf6fJFZ4+ZHUIXD0EyZ+Ktm
    71cNV77IM99nrN0KxPnb40l07TX927+cA6g1Mew9CnKjeXo7yqeFhd5/n3mFxwKg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XV1brorU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehleenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XV1brorU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehleenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeCSWKx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:10:53 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932872AbeCSPyk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hangbin Liu <liuhangbin@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 14/97] l2tp: fix missing print session offset
 info
Thread-Topic: [PATCH AUTOSEL for 4.14 14/97] l2tp: fix missing print session
 offset info
Thread-Index: AQHTv5qV5wFA6+6W9kudHUBAHX8A1A==
Date: Mon, 19 Mar 2018 15:54:37 +0000
Message-ID: <20180319155411.12348-14-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:8Ak3xkfpkXaeXuODGU8i36ZWnxdwu23FcXyq6C/GbNSEeIYVbst2KM4uK5uXQr6zccotjZQ4H8tCHruBwE1OrZkW1SwAOdzP02i/6tClh5SGOLG4bGr/nKrLerPEEttQAP2cSu3NLRJ6f3OS5+1Qlr0rYVl1FBb/yBirEIDmVAYLwg1eyiUnlA+CiO/rnJyaBzOkyAehwe+P/c8fJ2MNgcvvsI+mNPx/Lgylg6NI/XGRlnxkhlhtVg00BKXofbLJ;20:0uGmpbDq4sbT8VmhV0w8tiXoHRqrCinyEd22X1kvQhsQfw2pOfDnQlI9OFPJrl0D065X2Gl92O6YVR+Wiqoa6WIi1xn4r/W9vc5u1zmi8OdQQAW8Nn44z0jHbSxOAmOtnY1WMZAWz2s/vA5mvQV9aivUZdJXjvl2yLJrBxIvofU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae5cf891-1d76-414a-f07b-08d58db1b830
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806558F91476B42F9AF85B0FBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(102836004)(6506007)(53936002)(86362001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(39060400002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: X1EQl3pSs1Ba5zKZHBRl8GeOdXzGgeXF1WaRI7m5Y8bIPuO5KkbGTorlQFjJFCyJFmnZ7wEqomBHSVbdAQ+6LZ/2JKarqTiGyMJwg9CI1fOrjE3V+9ufHQMgpSVlHOjz45pDFqBkrwYzjd0+BF5kP38GKwxTkjo7JUhTq/rik2aqPFNE3CrxiQH+T7ggorKJrwrV8QmzW9O7rv5lT/6DTNYJP2oXdgG/thUOXuCVLxvs1pFmdZQ9+7hIyRqq0TOMjvLe68BZW4l+WCLiXzt7/67YQZkYHKa6GywmpY+qRZswbIaQPNsIWy9LfFwSscb4xlstgr8E5NMD3EDRLYjQkw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5cf891-1d76-414a-f07b-08d58db1b830
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:38.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index c28223d8092b..fca69c3771f5 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -765,6 +765,8 @@ static int l2tp_nl_session_send(struct sk_buff *skb, u3=
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
