Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482618-2-10969532136308316050
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
    t=1521482617; b=EOYzRqq8kK1P5fDMHfSrrIJFjhIotPK9YcU2ABD2cyG0IYw
    ooRQ8aLrWLLxLL61QDi4OlLqIPOz8NVt9A/dojVgKv2AMqiPOQH0ZjATJMfCkB1M
    YchJ7UHi/+6DgYoqKdGuFBRokRHsdqEAJ4hFRPHVqutNTzg1+q9DKNL8Tr5CnhgC
    70ThUeVSfHtNIpQrUcfY+9MAJWeR/jSjxpvBNx5STVf6/x9yOt7oK3xBV3lXzKWC
    V+VDvRZXaS5Jg+P+D6E+SAlnuwB1l5VUwPqA7kQYr310zjNxcZYV1Q3NF044THTJ
    lfj7wYQCYgCTo8B486Z+s7hns71G3hu3mHqcmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482617; bh=5ymDD7
    keQ2dGfDfXFzW9mAPIj8c8B2VnevQjFm2EVWY=; b=oxfl9NmQqjToQjeMGU0aoP
    hW/daLe2i+G8s1Imq66zlVJHhfjgqewbZgG1GmmPKgaOYZr88KMnHMBb6Lc5G8Nt
    WJdbkoNgEkheUj000M8emRoAvadvNp1UdSzyn6G4fyeusWicdVHEQew+mxin1NFy
    Dnr0ZIHLiBQ1s+R2wn+DwDEuX/nPVhp8rDMZ+Dg4eb7pc5IYN04X6T42Vq5hpoPG
    X24wEX8aR/9sTyeAsO+3AiVmLA3NYYpjfNmCg0RWTRgiJOcgrW9FOf3aVyT6f/H/
    2dpBpaVA65uilXkYvIwjFqzpF6Q9Y7XVrmCgc+1kGZ2Ow0sLoPFXbd97SRrDAMCg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LV5kLBEZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeeiudenucevlhhushhtvghrufhiiigvpeeitd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LV5kLBEZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeeiudenucevlhhushhtvghrufhiiigvpeeitd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968255AbeCSSCg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:02:36 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:39072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965619AbeCSQD7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liam McBirnie <mcbirnie.l@gmail.com>,
        Liam McBirnie <liam.mcbirnie@boeing.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 194/281] ip6_tunnel: fix traffic class routing
 for tunnels
Thread-Topic: [PATCH AUTOSEL for 4.9 194/281] ip6_tunnel: fix traffic class
 routing for tunnels
Thread-Index: AQHTv5uS9kMoY7AyG0SCj6dja8psLw==
Date: Mon, 19 Mar 2018 16:01:42 +0000
Message-ID: <20180319155742.13731-194-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:XoxeriAXHqfupvd4A6kcIT7ApUsSOgMSw/E9hzdIc3LbbQCsjGsP2I/OpsknfhYmLEKJLy9S/2oG6yWV+TTCNxne8WE5eMFuoZ19Q7qWpKKWvjXI/faWS6WQj1UmJzRfSStl2XE61MUzU4hp1M/dVKjzaQrRHPKHTEgaIGM8aneYz+EXmk8UxNWPruRlPJHPhHS9cy+wKLSJBGQ7V6xup0aHs1n7UFuVuFUG6VzM27wQIN1DsP+oJmVHmJjxRnZ3;20:ztal8YhPBQ5SGARF0XZn2iiyC4pWkQGSUpvkS9z9n1V8Eht6B8S1ccxgUMl3A4bccUNK77ymwrMPlyg1IEdLG4YoVgXzKg5Kzf3eS8wLiNFWWalFupFGLb60Cs8r2ObIDKcskMo15YA+CnotJVwxMO0w4WZPfPRFesoxu4nDOh0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d0df9a3-047d-48d6-3fdd-08d58db303d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072754EA60D1F41DD370F731FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(39337521807258);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(8666007)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(39060400002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zKTgqg3iQZm5TKsbsPRYRY8GMPj2WVlAUZOpqzE9B5F3U1KaEtu99mnFx/Z27C9MR9Tpyr1UdhqJsU2EN78mxzuOBegzHEInGWZB77FxDaMZiMvkrJQ5rImIPJ0LRHDUGxuNc/z3gywoNeCh1uQOpEgOzeVD7vkIdVuxIh5hpfnbPQipXRphZcYKbvmHmzyzr6BcGiLEhe+LfT2UXDAUpba+wkv2/UxCijE7Q8fwOMyfsB/2tYxLbLIxJNBilkwbl7km1q6Yw6r4lX9u6soG0HX3NN8ZKCU7jho7gZ0kIS2rcs/ugGOHyfN4zruCuETYtWyFAbA1ZCzKSTZU39a3PA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0df9a3-047d-48d6-3fdd-08d58db303d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:42.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liam McBirnie <mcbirnie.l@gmail.com>

[ Upstream commit 5f733ee68f9a4df94775299ac6a7ab260704f6ed ]

ip6_route_output() requires that the flowlabel contains the traffic
class for policy routing.

Commit 0e9a709560db ("ip6_tunnel, ip6_gre: fix setting of DSCP on
encapsulated packets") removed the code which previously added the
traffic class to the flowlabel.

The traffic class is added here because only route lookup needs the
flowlabel to contain the traffic class.

Fixes: 0e9a709560db ("ip6_tunnel, ip6_gre: fix setting of DSCP on encapsula=
ted packets")
Signed-off-by: Liam McBirnie <liam.mcbirnie@boeing.com>
Acked-by: Peter Dawson <peter.a.dawson@boeing.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a2fcf7bdb597..f185126b0327 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1097,6 +1097,9 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_devi=
ce *dev, __u8 dsfield,
=20
 	if (!dst) {
 route_lookup:
+		/* add dsfield to flowlabel for route lookup */
+		fl6->flowlabel =3D ip6_make_flowinfo(dsfield, fl6->flowlabel);
+
 		dst =3D ip6_route_output(net, NULL, fl6);
=20
 		if (dst->error)
--=20
2.14.1
