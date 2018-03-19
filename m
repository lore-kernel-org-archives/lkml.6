Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521499278-2-9889715341916495099
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
    t=1521499277; b=AsFz3FwFNqo9vJjGWV+fcjZAHdCuKmBUBMdCWb/QJ9V1ddX
    gYoXHhxPo48qdKzVr974nzhxSZ4mlpIqoinNqD9F6qxhC0LclsTN2OvLBar4aVYR
    vxOZHRaEwgZIZ05Zr26RHnf1n12tSXN7cyAbj1W1QcEanbIOvrN54kf4xUefG3Z8
    K7ghBNaLup9ZZbq6moe0YjfFFvDbi/gC8At5jLCEM3FKfAWeRGAUxx8GgVdDqO4J
    qWLPE/cqGYSKbEU5TznP5Fx3OL9vBAoG/+5ov0kw75j39cmhdZdT4aixop38hXwr
    BeLCLnaBO/dxmRhc2sj5NbuGB+8hZ5W/FDEmnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499277; bh=U4n+GS
    4z21SUQUO+uuFj5RHpYgajRX1M2CSHlMwUX0k=; b=ASgUjQgJuMLeWTD0qeEbxs
    B8U+5NoHKHKAU1apSyQCAsDFSyoM58XMrzVBZDF/8498G9L24Pfqv/Ra0nVyJw2R
    p+oLgInpndgk3spIioqsCz4r6hpkl2vgLdeknBtb2vIAlGk2pIeuPcJthwnb3R4p
    AaZSJxr6TK/Kv96PEasyv4O9hPbUrfT8DERnxU+ubFbE40XDLUJY7+DG89QMlOKK
    PSQGGHXNyt3bw7DRlG5LURnYM/46VKh83Pv+tOnuubnmh9I0F7BmDDdCY2e5K8nK
    lzRU73/ocs55NYYKpnvCN3p/r1YdDDscOtTpnQzv68VosoNA1qvAkHpmVPwuMiNg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NFrInjyk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefiedunecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NFrInjyk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefiedunecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeCSPrS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:18 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755478AbeCSPrJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Brunner <tobias@strongswan.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 007/124] ipv6: Reinject IPv6 packets if IPsec
 policy matches after SNAT
Thread-Topic: [PATCH AUTOSEL for 4.15 007/124] ipv6: Reinject IPv6 packets if
 IPsec policy matches after SNAT
Thread-Index: AQHTv5mG4fm8/dMZpkaX7/NaQpFPGg==
Date: Mon, 19 Mar 2018 15:47:03 +0000
Message-ID: <20180319154645.11350-7-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:8W2XUz9QWv7gaWLmWZXyFAGTJZfxapEUt5nOhXCtP+tySc8Lp+dYGi2TZShWrat86jixRoKOtL//mLuL/ZnulCc6c0xlF2uzNPV+oyW8JqV/TCDg6np4DKK/08Bae6h/LsANWhRsLOMBML/HSYLdGIoSH9tz1KMyU7X6mquFFvmDK/17rIJ95Ux6Qrg6GmYR0g0bZ+1oc8Ye4xZn1k7vtBcw6MRp4sySfpB13DY135bsjPQq4sPg81Cs9WUJFnUO;20:FM4o1zN/yir697Mx2qYKsRc2cMqLXV5ps5YPq+uiG0v2grhA5mClkzRDXJiUz0NC9hXGHJACK/GWQda+LtNQkMMKskhbQYWylIxG5w+6S16G6pxiYqx3NW9ePMZ3BgFUq857PuJ/ZIbUJDk8IWzUKTs8XyjbL1WK92/AoexzyS0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66d926fd-0f5d-4dfc-ce88-08d58db0a984
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101346D4D67E37B5D3A5E5BFFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YlfhaepwWeF7LFOeJpS30Uzsu4moNqj1PQVR0GdNeMazHQtprs0oNj1nqlZ8SwAom3/l/c2hcBIrSQnHXdNHowVO+ysLIE37OLXsKqDJbgUa3bcGIzr4d7UCD6tJns71q1bcF2sj1a5EgOsRO6rqpNxHAgyf0V134QtwYOJatRKzU3rxqJWr7uywvWp9D3qt1Hwxz5ruuDGodF5oqheq+uHiE2Qz3UQ2DjudqFuDxzqug8LZZ3yk6DQ9/31Y7Me1pmx9NuLiakMVOPzE+x9L+g+czCr4aKrKZEidT7MM5/2HsqfB5zby24ZWCdZUvdEUy5IHmeS9DFAQh4fwExQTyQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d926fd-0f5d-4dfc-ce88-08d58db0a984
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:03.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tobias Brunner <tobias@strongswan.org>

[ Upstream commit 09ee9dba9611cd382fd360a99ad1c2fa23bfdca8 ]

If SNAT modifies the source address the resulting packet might match
an IPsec policy, reinject the packet if that's the case.

The exact same thing is already done for IPv4.

Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_output.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 3763dc01e374..0f874b48c1b5 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -138,6 +138,14 @@ static int ip6_finish_output(struct net *net, struct s=
ock *sk, struct sk_buff *s
 		return ret;
 	}
=20
+#if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
+	/* Policy lookup after SNAT yielded a new policy */
+	if (skb_dst(skb)->xfrm) {
+		IPCB(skb)->flags |=3D IPSKB_REROUTED;
+		return dst_output(net, sk, skb);
+	}
+#endif
+
 	if ((skb->len > ip6_skb_dst_mtu(skb) && !skb_is_gso(skb)) ||
 	    dst_allfrag(skb_dst(skb)) ||
 	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
--=20
2.14.1
