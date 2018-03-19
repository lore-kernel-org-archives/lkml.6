Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494515-2-5105656573200881640
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
    t=1521494515; b=OQ97w9wdBG4SxgGGpL3wFtSGudbuVTAdQk1CC/WlWo81Tyl
    u/pcCeqS/fcmhBVTMDdA9xxiszpwToG3OIhhk6wPtcBqLyEPYcrj9iKNB0a5nMJL
    d9SfuD5HEYDftqizwDzWVc8aqLhPtnULfxcRTzOYQ4SrDC2VKTICOAMcGNJr1b2L
    mOFr2B8ocD9UhLYOWYcFxBt2x5cMXhE3oQAlZ4LnUoVhr88VjNdDPyys2yFELAU6
    OEEBCEKvPI9PB005zkgEAf6iUhwQCB8x5GbwV8q0zxbs+9yIqnWmXA6ro7QWgCjN
    s7HePXK3ruPmqvn4n3g+xg/PEEdogeJcSp7hmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494515; bh=4TyUCc
    cO67ypExMXOT+SNyHycPo+HTnn3yrm0Li+KtQ=; b=oWlNocXujev0RIIHZc0u3o
    EBWSMd8pnIffLUvhFAwcCVckJUJAQN1U5UsaUbsRUa0sSG+dSpsrlxvUvocB+WEq
    8t05UbwracVDVLLE2JwJCX3kFsfLBhOwr0uuSNyrpcQxx04xF8nhoexlqLVdDeaL
    XAAYPe+z/9/KBzJNIIMKLDNczNxy/+Hb7DbRko5EtHK5lmotii30HnyxEpbwhdV6
    PWy4NM8X2bGeuuieIlJY79txZgLrV1Zp8y6wvIDhHWn/qfz4K4is4324X1dfJgXo
    lKQ3lOhbtriDmoloLoLt/kcLaA76I/e/+Du6o+YJVFGs3RAcxQ+X2Jub/5k5oUaw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kutmzo0P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleegleenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kutmzo0P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleegleenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965187AbeCSVUr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:20:47 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:44079
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934724AbeCSQAv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 103/281] netfilter: ctnetlink: fix incorrect
 nf_ct_put during hash resize
Thread-Topic: [PATCH AUTOSEL for 4.9 103/281] netfilter: ctnetlink: fix
 incorrect nf_ct_put during hash resize
Thread-Index: AQHTv5tSrr55Z+xilUS1+KqmqLopQQ==
Date: Mon, 19 Mar 2018 15:59:55 +0000
Message-ID: <20180319155742.13731-103-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:t26AkPr1U9HoNzobo4X5iroJhVxtur82PV9EedwT0QMqggB+bwpCd6JUujDHQ2QKR04mAS3X88gZxaHnFKYdUM1NLT4z5UQcvuIs0UbsWtUvz8pL1PZWsZ0RiYIC4UKXeCvF2QmO5Ws2jU42Pk245BBfHxaTv7nUtIc3qIHJ0z1pIGbF3in2ha2nbEt1epE03iL2yHtziC/i8P04RdSO9Mz8MhviZDnTEIfj5e/vjmISbrl65Aqs1hCqHg3S7bd/;20:tRBj+z7ehFNNKIMX53xPBz5FJVX2jdf6pnqd3PyXcrWVrX1bt7LBwdSe/pj5LhFvaHvV7W3xaVVKGA8of+fIhcfli6Umw/rjtzQ7tsyh7VDn/1oew21y1c3EyL187dWnuj5RhmTNrHfddTYxb28ayAYLi59d8Opvh6ljOIydME4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d7a24d8-c639-47a4-e025-08d58db293cd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031915FD9D03BBF85523D39FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(39060400002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gAtmZZiv67mM/5+lI7jP202Ckt7CIGq9w/WbIxmEFAHL2QbMqcDJpD/gvQd8n06OVNtlfO3QWaFlw9byel4Pw9EGJmYBI0PGCYTj4W//GEthKHO/ek/lwWdVQsEBSoqRjM6NwHEO14xQSQNBTaOPMkPg/3tywt5se+fBmLT9qvfOBC4GJ+g2r24SAcn+GF6O6dldiqy2XvBvkd7JGfTTKGsiOItdV2BAhom6LRe4x9VWLgMcOPWdQpkCkj2gYpJMj4qoa2F8KQyRtJt+HtCP63L17dS+brD+fBQ38AB3Td7Z41p44iWVw2I2MAjEaUR529bAsuL0dRmgwv5LqAdBXw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7a24d8-c639-47a4-e025-08d58db293cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:55.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liping Zhang <zlpnobody@gmail.com>

[ Upstream commit fefa92679dbe0c613e62b6c27235dcfbe9640ad1 ]

If nf_conntrack_htable_size was adjusted by the user during the ct
dump operation, we may invoke nf_ct_put twice for the same ct, i.e.
the "last" ct. This will cause the ct will be freed but still linked
in hash buckets.

It's very easy to reproduce the problem by the following commands:
  # while : ; do
  echo $RANDOM > /proc/sys/net/netfilter/nf_conntrack_buckets
  done
  # while : ; do
  conntrack -L
  done
  # iperf -s 127.0.0.1 &
  # iperf -c 127.0.0.1 -P 60 -t 36000

After a while, the system will hang like this:
  NMI watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [bash:20184]
  NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [iperf:20382]
  ...

So at last if we find cb->args[1] is equal to "last", this means hash
resize happened, then we can set cb->args[1] to 0 to fix the above
issue.

Fixes: d205dc40798d ("[NETFILTER]: ctnetlink: fix deadlock in table dumping=
")
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nf_conntrack_netlink.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntr=
ack_netlink.c
index d5caed5bcfb1..8535cefa5bff 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -890,8 +890,13 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netli=
nk_callback *cb)
 	}
 out:
 	local_bh_enable();
-	if (last)
+	if (last) {
+		/* nf ct hash resize happened, now clear the leftover. */
+		if ((struct nf_conn *)cb->args[1] =3D=3D last)
+			cb->args[1] =3D 0;
+
 		nf_ct_put(last);
+	}
=20
 	while (i) {
 		i--;
--=20
2.14.1
