Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497549-2-8387700895765588871
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
    t=1521497549; b=kgeqZdDJjeMqKlWWv4Ww7tm53UIQ19EGsdUlXma2ecRb0c5
    70rLY5D5sv96TIToyoxtbBsN6sp70T595ck2LgnFwvu8m64uHC8LROlxZCpvEmur
    XEhbY/6DRD+KO6iEp8fFSSapjfbjBj4OezyFbcKoOU+EoA2aRYS177Ubp28iKSaw
    23eCcicKqr+9wY2g/mxpCYHSoCdb8dQf88mDw9dTzyu+XAeBvkUXo9G1bXVEUULs
    0mRuinHS1sIMww1ssHeaSAFwTfw8QL5o5PJAFMTJfYbsc7ZmwFO2jPbElfO5hzfn
    eeMjrjJh0/DeWReM//QsvqOGA6GyuXER/Q5GnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497549; bh=U4n+GS
    4z21SUQUO+uuFj5RHpYgajRX1M2CSHlMwUX0k=; b=ligJBWTZHM3OXXh5nIEmeE
    lEPhkPpcnb3cWqMjVL+PgLlO0SKGlUdmy3YMxRc60jo8r6VoPlCKqjKtnVkU28WU
    qFmDJMiLLqUDoXEE1Ji8rDw8KPCGNB0XRV2PfctAzwKT8Xx1/xFIFb2e/BfiZhDY
    zWubh1R9JCvIxzAEZ3cc2y6bnEI5RKIDYVsTNTLeUU3H8uHcqgB2QOdkJF4L+BKn
    DVTO/5JgtwK4xONrZV8jPrMf1XQeELqaf9cajlDvelVqVva4y8IyJWDEFKcm/eae
    JNakEKCyDKHYKGvAuUIMzDopbitQtrZWNwYT+ipYZAFL2CwsQe/yEZhajaqAlwTQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MzQkYu6x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeehjeenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MzQkYu6x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeehjeenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934273AbeCSWM0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:12:26 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:27808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934267AbeCSPyc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Brunner <tobias@strongswan.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 07/97] ipv6: Reinject IPv6 packets if IPsec
 policy matches after SNAT
Thread-Topic: [PATCH AUTOSEL for 4.14 07/97] ipv6: Reinject IPv6 packets if
 IPsec policy matches after SNAT
Thread-Index: AQHTv5qQzf1S4/29X0K3k/+0MwNwNA==
Date: Mon, 19 Mar 2018 15:54:28 +0000
Message-ID: <20180319155411.12348-7-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:7hvabA6w+XjmQ55B3zJMnJU5AbqqSBp5TXqC2u2SBe33LXYvSMTz8KztJHUcc/hQz/i1BxEqIedUIm1ga4xeH6Zyt6bCrnEz23kC68QJUybCCsqLv6D2BnDnnMGFL596EMUQbvSb+hiSyRarhoBvs9O0xdwADCuK7UeaqBqds3xfxzYgjc7F52co0y/mZD+3wNzHMJTelh2PTdKJ03cnhluIZVtxsj1a0mLTBArL24GT++5rp3KSBtmrMfd8KUwB;20:r+I59ix0o52X9Xsptf21cDCkNw5bAJ40SHHI1D4pWFvKJQra+Awm8o6SEUPUNDxG5CKEO9zvnFR7P0m7zriMwbcqRI6TsQceIGB1w+3JFGSqD6QQI09w5PPAEm2Z34nO+iLPHwyZ52gQdnwWvDMbpZkd58k3o9jAIDTUIsexjmU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41c9f3cd-bb7d-4175-6250-08d58db1b2bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09037C4CCB5CCACC957C4545FBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(4326008)(2900100001)(3280700002)(25786009)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gCU1o7Q6EebNFI9YvTWoWqbE8eW0sV3uj37/zav8QmpfPL35ACNU6LoMjWxz6zpmmwxfCJiNXSeAOPxzn9QTYg3EHldM8Gi3MJ0eUO+1jXMTcWxnmaN5SRgLsN8E/k5FUMMPn+m/Pl6LuLc+12z3Abf6P7ZEaYn+PIM7utzz10nArbZvdMcgDP2UFa1utK6kp2segYOotpYsyE3NdORCkFxphwAmUHCPuG3wGQ1qKS7wLpZ6WquaI0/J4xETp9aBf/GLTv9itzqLDXZVCfl3tItq/GTngqhO2r91Ymo61TZ2vkoVRKJAqeF3G5ukyXxNhmxW+wWWgQe2muRjiTgQ+Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c9f3cd-bb7d-4175-6250-08d58db1b2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:28.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
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
