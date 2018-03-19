Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479549-2-13860517072852749642
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
    t=1521479548; b=mdNt51SlqzWQf5YcrNIUU7hHUjN1uvaM1TIRaZ/wZSp4m6w
    Q2xderwVxfV8nIIsMEh7gxDuWgE1pQJrWYwEPds/1wYQ+x3KdqeKsKtzCzZkmofy
    P6Xge+V8NrD3W85kKa3fHS9YP/rUp2+mkolG6vyarlAbI4TLH6m9SQqaU9m4QwZS
    hUBQPeQwNdhRyeGMbAuE55i7mPudY699N9H7Hhn+5+1eWgfqdtqwyGY7NdWhcGrY
    V3u14P3hsAq642tW4gbT+6ikiIOLFS8ESjv3uoLUeUvfSf+S4/MVO0SdB61b+s8t
    QEIlr0uoFhuDCbDPccLWEKaXHMrMPD01SOURosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479548; bh=A8W5BY
    3E9D+wlQ6UcylKxt2MmrWOa8dHub0CNwnruWY=; b=wLUIi1I/B1QJsnuSsF0qQv
    Aff7oecW3Jkgw1MtwtfLtYtd476xk51o9MMIJ+Rir5jYqOzqG5jNqS+KUezwu36t
    edMCiA7Qa1zjv+T8PpjLiXqUdhJX1Rcevh4idkBoD7Wr66vkIedca/vOKr06Lbbh
    ziofCbX0NONgkHDhZ03wemXDkjoPNx1F78e3cD2c0keMDLqSs9RnfxI4A3B3QvAA
    2aFSPexoFGFRyKGmEBrBrTAIDiEEYHRt1iqj6777crN9jnX0idZ4euoTlUt8AdSO
    LEJq0x5We9iqXd3lWBKZPQvLiO8MbSh7iyiT4vz9QprsCGGeFIdOJmIFzcuxlNFw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QyYzp7XA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieeltdehnecuvehluhhsthgvrhfuihiivgepheei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QyYzp7XA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieeltdehnecuvehluhhsthgvrhfuihiivgepheei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935162AbeCSRLl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:11:41 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:62326
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966625AbeCSQKh (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 122/167] sit: reload iphdr in ipip6_rcv
Thread-Topic: [PATCH AUTOSEL for 4.4 122/167] sit: reload iphdr in ipip6_rcv
Thread-Index: AQHTv5xwHdzMEXXWDkqhZV+dN0kVmQ==
Date: Mon, 19 Mar 2018 16:07:55 +0000
Message-ID: <20180319160513.16384-122-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:Zx7ZU9gGZsT6I7B0HxuAmeQfIW/CuESH/dLNB8QSRUeDWsBtV/Z+pnTX4fJ71SBQ1fZyQtamlsDXXpmOlpSc9Qj0YcXFSJZ2YovD9c4ZIDQ62ed3afS8O6YDQZyu+svbE/jA6aOen02iB6wa1veDRu7wOI9Zr1vwFSiiQoBDNzz6DKEGJhv001dC56zY+IdamzNHWyVdqyJjFmhBNnnK5Jq/8GjIYZBgRvKy088yOejHNlNBFm8VHxQAzruuGVy0;20:2bZqoGUXkJ0hQIAc9y/tCIZM9nIh7n/qSLBgnVwFmWZsy+92mJYnM3YDpca881f2LojW/VTmJDsB5jLP9bjbNJpA+d3a7FqmwAx1hGxzozMShwZElnykAvekYMJSTLLoX0Suf25wUKuaqWpCUlH60hR3WPRyJ6dTmEFA6CegCA4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1f6ad36-57da-41d0-6b4c-08d58db3f232
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045ECF735E4ACC09D737E05FBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: s4Dp8l/3KJ03Fn6V5nqv+9alsy4yfCXb6vrDQB6cCT22JhQe+0uBJrjbZelwArgkk/48C7l/eaSiGRS17ohwNaEIxNJGg6Exdca3XO4qZAg8wiPsYDTlQVPR1s6fGCE4zjZDmnMLMM7W9QnXgSNV/qyo7AIIj8IuU7rlT15EjEhl95rvC4dOVqRIRL1WLLteNrCKU5YU9El90XfwVw3BeMdsNI9E0gVLOU+jrwp14isXyRNt5X6sOrwpAQs20U8BcOpeQuyD5boZGCFVaY5UAW3jhHGFZXGIPNirOvgUoYu6y4oeaGgelVwxd/HUz/0RqLsWGsommqwUXQJpRUlXkg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f6ad36-57da-41d0-6b4c-08d58db3f232
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:55.3448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
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
index bbba435d0639..e71656fb5a22 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -690,6 +690,7 @@ static int ipip6_rcv(struct sk_buff *skb)
=20
 		if (iptunnel_pull_header(skb, 0, htons(ETH_P_IPV6)))
 			goto out;
+		iph =3D ip_hdr(skb);
=20
 		err =3D IP_ECN_decapsulate(iph, skb);
 		if (unlikely(err)) {
--=20
2.14.1
