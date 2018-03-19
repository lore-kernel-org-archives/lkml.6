Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482502-2-5361526847959061555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482500; b=RUFd5iNSalhIOi82RvgbHBN9gq7TWDg5f3+iH4aScCW9hZe
    FvIijN4eh8/01y3XITkdU/SBFZRVvr1PQiIfcqHwcT1Ntl6eBvYNtvbK6MEBKoQM
    EuGyCtYNOsYK6DTN9x3/CuEoy11umvGzt++qlvX13lSSBJQ72YibSZbhV7l/p66s
    i96w9gg8FL3TPBHUhuYSMHwJTdLZP/9b9w/pN9HznugVFifZh8mXh2mVyeIPexcd
    g/IPPq6FxdC1IEN0+gbG67cJeOG1/sYCy0CqsUm5nbe8hleSN1Xn3yQoiC9wxRjI
    v0lgLrx+LY/7fMVG2S4RW81aPDbGmQ8TX9hyR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482500; bh=Xtq/DV
    OHL2N265OU9fGzK5kC0hE448nsyFjKcJlZINg=; b=OjyeoJIBfuWa5EdaQV4zdX
    bd7px6g2zbg8JQ+tIiaWA2v7yD41XFbJoJlJYoT9wNInRVIbi4AsM6bSgfwGmWR9
    C8ILrNNJt+pT8bB5Ojw93UgjbzFSemge2LxUtLARVV94jQQecO/1iiFGFXmT6kKW
    Xen5bIjLUl1BMcXhdMQjQTujwiLamvzWGj+4RVX+5KalEk6RFd+pXjBiukENofT+
    a1ly/qSZktklSPTylQShpLpKPl6uGUmIjwzFrymVs6v5lB/sQ3CrOXhJNoEebc6z
    5DDt40LKiaza6KLQ9RANwhGd7p5UU0sSasYAhwD2mT+G1xe9nGeKLo2KJ7mOPgbg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b1NpWbyu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeileehfeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b1NpWbyu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeileehfeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968491AbeCSSBa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:01:30 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:39072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965640AbeCSQED (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 197/281] sit: reload iphdr in ipip6_rcv
Thread-Topic: [PATCH AUTOSEL for 4.9 197/281] sit: reload iphdr in ipip6_rcv
Thread-Index: AQHTv5uU8VHZoP+MTU2brmSJg14aTw==
Date: Mon, 19 Mar 2018 16:01:46 +0000
Message-ID: <20180319155742.13731-197-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:plJosX8vuZMo/mznaBKcG8DCfRuDkPl7JjpXoB9wj7wqW+ndNiV6byWAV8H7sTwjdTRBKxq24GD238Ks7C215aBqcTLj/RmIZOgX97PltjxkgXoIYpNmVlqnRJnosMkHfe9S70pu9N//JNoutE5IdPI8JAHd8ZK4E+x5dOpT8RcQsaG9xj5ZwHUePxl/b9a94bKeFsnve3ESTK/mccns8ql8x2w+30HJ8wGsH5KwKfYAB00yK7CvcsRImIiWr+h7;20:7shglxWYd0m5NqYbLvIeg7GREOzOsXt+EspPT6v2pGYICa9aU8pQTmuL6Z2vfLfRntddR4hfpSXpUFeAN3334aT1Vm2lopiOnN9X/G6PkGW0AHdaj1PCAeTP/XCvLvqBrUuWWw2ey1uIa5UZbcxh7IN1EWnfQlBFAADxNAm8jgo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10969ade-6231-443d-23f1-08d58db304ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727D2D7FEC6A7679C8B829CFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lKwMwujbsxMhdDghDKrQZ6MROKiseoK55O08SqDPg+g4HG+ak/fZEsOtGz3DUIEnm2at1WawxFrUJGxqFPbdx8PRXBmiWpr6rg+5X8HjdUJUiKZuNSOm9TjrfAsLAI6mjBtVLKnMJMWqlMwHga7c8HcHVMYudkViEUSuRv+82zmJTLMEyFoI+uJY1th29Aeo5FYmxplptXpSfJNn3ne1MT/DxcGwK2azgDTXGr2wSK3vvoJBnTzujT9OxbZzIyymsPZwZf49RnwcwgcPDgX/Z+UEudtfg1VflPUKDFR9gF/7F8UPddkBqwdTufItSeeR89ASH7vlBq59KtsFL7+TCw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10969ade-6231-443d-23f1-08d58db304ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:46.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit b699d0035836f6712917a41e7ae58d84359b8ff9 ]

Since iptunnel_pull_header() can call pskb_may_pull(),
we must reload any pointer that was related to skb->head.

Fixes: a09a4c8dd1ec ("tunnels: Remove encapsulation offloads on decap")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/sit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index d4d84da28672..181fd958c82b 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -657,6 +657,7 @@ static int ipip6_rcv(struct sk_buff *skb)
 		if (iptunnel_pull_header(skb, 0, htons(ETH_P_IPV6),
 		    !net_eq(tunnel->net, dev_net(tunnel->dev))))
 			goto out;
+		iph =3D ip_hdr(skb);
=20
 		err =3D IP_ECN_decapsulate(iph, skb);
 		if (unlikely(err)) {
--=20
2.14.1
