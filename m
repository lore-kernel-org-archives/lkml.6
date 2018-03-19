Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493853-2-7640685022990684404
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
    t=1521493853; b=cIzRcFDW9+xV9+w1a/sF8qilxyv707DKx47SqWSByw4YHFQ
    WMse1+6/BSPC/alGHkuh8mkY/QkqpJojx8Xf1LYGoKxGRLE336Qv4A8f9Le0fEPB
    PdlrT7cOw9mY2+TsYaA8J+xH0mRajoPtE2iQchL0JEgL17G5zwI+JX2+NUMiyShh
    ebvY+KyAPV9JLm/iP7QFZvKlru24GDUS1KC/P8cZ6G9nXgMupGY47fCJuhewqqT2
    1cxtuqc0iV5lN5w0HFidF4CZ91F/cBU3aB5IPPW8ZSyT/Zce8h0yGObXP2xgkwDm
    pJfU/uxSZ38q7XB//ndIe6h+j6HnIEyBHRNZuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493853; bh=fincDN
    /8UTj4iUvpBx67YadvnXvKGmoi257Xo73hwLg=; b=bd7QKrvt+7I0VVVoETMgjo
    CAbQFkUgoAQaKXalic6GgzdeJyWwFvYvOHlRWat8PMjRRK/JA6d016YB+uyQ7gdj
    K8LATwRwREFCFvbhJLvRYtdRxpIRJQWZjtzDPqg84OraLtvWPD2PlBaCJqxeYR0X
    SyVKkWroHm3QVtCeH/qm9tUz55LjbKoOHaGLQ6E6r3UTAgNywi4+fgu0eW4A1Xh+
    73DM3SzYm2lif17ck75YYy/j8J3X2KkULj78Q3efs4k7EPB1V5Dhd2jnaMixY+ld
    VShyUbV8rRg7ti4uWloLy04LvPjeatLs0lx2boNvdUjXxOFaGG34skpf661bqqSw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l4cnj1uf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekudenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l4cnj1uf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekudenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935002AbeCSQBy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:01:54 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934952AbeCSQBp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hangbin Liu <liuhangbin@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 126/281] l2tp: fix missing print session
 offset info
Thread-Topic: [PATCH AUTOSEL for 4.9 126/281] l2tp: fix missing print session
 offset info
Thread-Index: AQHTv5tjKIO2NPJqBkei5Al8aQJWHQ==
Date: Mon, 19 Mar 2018 16:00:22 +0000
Message-ID: <20180319155742.13731-126-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:FoFKTnF9q5E6nWGSeXE6dZvfXNPQUXil0/Kbv2JGu6x5GOyzAhLsyTQ4U3wibusuHFAQeqAR8otRRzK08W5HdVvm61dPrP7ZUxyhj5pN7L2d6DWE0O+8t1kasvP65TeYy2nnyjGdxzttmDhzJuX8nLTCdbm6HdzF3c8DqrbmDgp4ffc9t/KN0sf24Dm5gCVAs3EMLH+Cxl+aENWuPP4xRqfRN1I4F1ILPMZI5oJd50HDHdMk6qDhiEcqXLSKpsAU;20:/5YYnjTtvgfVNp4IE0UHuW1UoY99vzlNykvmFDjGF0TlF7+CJ28P8oZDmQuOiiAieGlqa2gJT6Urz2LzFGVEovtJI+n6WvHdWUo/o0lWBBe+0KrPjwgK6ZjKT+K33u6MPz2hEFmLARZKzTGpLvN0l4h7Teo8YOzhE6+OftrGGLg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b3618fa-d3eb-4ffe-fdbc-08d58db2b5ef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919EB7AB18A00D8F2B69B05FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(39060400002)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wxBIzEbual2Ib7y7+33HZKtEf/mt1vy3qAeetYnhYNZies5yY4/4AFOmsz60xKnWTh8b81ikCLJN88Z/Hr1xEMhFDYiKVZVBi0z1NLSNGikdUU+0zpAg1xOTSoh0XIvHuHXEwfr0aeA/ytTplIp8aTwzEk+GCorEIhHqyd95Ai17n/bMsKel5zyoP7qk/9Sw7juAB9anJ/iBuI5ATZ68VYrvjYiuVTLyTk8diMGljM3RLbKRNbTh27uXJySYjY1Qp7Izviz4PbFmuVVmKf6IKLbd7Xlg+TW2tY1uerB772K3GREtY07Ccg3iWEyt+GjgMAV85/DZV9HwCs0YRK1weQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3618fa-d3eb-4ffe-fdbc-08d58db2b5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:22.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index ee03bc866d1b..ce1238492c0f 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -750,6 +750,8 @@ static int l2tp_nl_session_send(struct sk_buff *skb, u3=
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
