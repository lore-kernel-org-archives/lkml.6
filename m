Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480098-2-9346949385837228106
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
    t=1521480097; b=AmSdAH4kXA5IJDBABclRppXsX/FTbk8mPrj1h7yScE7O1LG
    w6TMkD68IVJlJ2LpOqxqJCli7zFId+sTrFAMKeLz+yEhLAvAmxaPRVeXs905662q
    c3nzBEYG4Pt/FG4PRSwZ8KTcllHwvMp1FUkXszYFSW5gaI8YRzFi8KUn7g5f/Z0X
    SKNyi2DzUo5jp9OzMw5cPZGpet0Jov/rFYqCRPKFQ+7fNXg8CeUjnF+RXaL1uj+a
    Ij3t8/mhbFbakcrer74LmE8NXiQwv8GQ8oR4jT7ic/8yTxzldLIp9ZM/1PaNwZKw
    0qold21xrHoWW80DB3PlnvsRPV9twwfFAAqS4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480097; bh=yiPMx0
    CnbHgmhGc+02JVZDhUgEBUh4CYmmacbzfxqDE=; b=QV17HUE4QxXEeJqHE1t6kF
    g2JCk30peSE+nBNqycJq4MhdXOeshGo4a/bULj1lAL/35BMFb17LThJAm4/sPozc
    1Flkh1MMyTfB0+/CAA8W7C2QWZGm1sAwmUSEPPaC+Fp5w8Vud6E4SZ7PCZmsWVnF
    X3TVo26MqI+Y/2foVebe+MZbvUbRt7ZmiqTfvoK0z/SUl1IdTd3Cf6z/WPKY2jVS
    Kk0C2dmsWk4dzkC0cAJy3DpyPJ9RO0CQFWEMDiZQnzhI3l7sqQIB2LILqdczcw6Q
    J9TZ9RHtRqpfo1LN0xzbu08C0mR9fv4KeNVQN09NbUtUXOeZPzSNx5o1+aK99YVA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qzca2UdS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleehtdenucevlhhushhtvghrufhiiigvpeejhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qzca2UdS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleehtdenucevlhhushhtvghrufhiiigvpeejhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965127AbeCSRUw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:20:52 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:49376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966400AbeCSQJJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 070/167] netfilter: ctnetlink: fix incorrect
 nf_ct_put during hash resize
Thread-Topic: [PATCH AUTOSEL for 4.4 070/167] netfilter: ctnetlink: fix
 incorrect nf_ct_put during hash resize
Thread-Index: AQHTv5xJvAIm6cJFvEm/hnrDXWHMFw==
Date: Mon, 19 Mar 2018 16:06:49 +0000
Message-ID: <20180319160513.16384-70-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:SKj9dfHFMaWo0coIPJsruww0OW5/QZW9xf2Vf9mFob6Vw/ZKysVEMbYBlKs4yik0vdYlpuoSsUqKoAu5PX3BsuFw8gP4keAqM4FBhblvBnXdcXP5XwcB6+KEJJStFh3Lt7JwI4tmkedYrf8JXW07svy1pQ0VRXp1oHdGN3sMnTtV+7+Mb3P5191bxQrAzvstN0WCDW4rvhW1lpbd/8m9gjpFjADkVRx641Do2Suhd4G7MTvypkplFahmMXHSfTK1;20:wU1BOpWgK66gJ07genOIausgzu1rXhsAdNXgfbEg942OeJarDUzLMpqDybEsNk6b4+uZ6eSFUcSYOYLJNpkKR5D8AILFrXJlmRUGcyVIoR8yOEEtUWJ8jJalfa3TVPVaEEPkEK5AOnwWXsk+6YmSlVCTcc/ASwd7iP19CkxRW9Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acadb210-42c8-4394-25a7-08d58db3b92b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096538D3D84DDFDBD12A49DFFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(39060400002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2LPIsGzChAg+ZuU0qVe4ugHaskAtaH50OAFTIWnPewZWZQMrs/dDthiFsBorEfQ/EPelS9uQP450BAWIYgvsGoY5uZHTuXSXT4iea/emzJ6YFdUM3Cv9ScLQgAAgtWJ4SBuhzBt082x0UCOkjU1m9q0ePPB9AqLEO/PZe385wXeSuS9gAh/PJk0ViBXRjsslrsBmywq0ULR/ycqgn66n1IafehFa6aCxdCyONyaPziwYpNnL4CKUOBlfDirLN/fDcUxwjAsVWLdYZpyuwZ2kG/M78KeWxL93tgx3L1xhktaYxegTK/IN+3OaJDevxoPnDw/80ibjJJHo+UCVr8oPpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acadb210-42c8-4394-25a7-08d58db3b92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:49.6763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
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
index 660939df7c94..3a6f0fa08338 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -887,8 +887,13 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netli=
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
 	return skb->len;
 }
--=20
2.14.1
