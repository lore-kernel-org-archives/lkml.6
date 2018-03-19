Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475986-2-13924467083598654538
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
    t=1521475986; b=wi3hVUsnZJPvgjgzK8i2FXRA3CHb1l0Mhvi7FOyM00sfFI7
    75SyD4oWS0o2pTivQ5tvfztSKogiU4BQFwrvYiIEJfXveBbd0GXgRzV7LBRVt5fg
    YjdInH9POb+1CC5ZDOv6xsyJ0p6xrHZIeHw027yOcgb4wF3nA3L2OHXs9lblE8QF
    SLwSYF+rFnAUU26OFar/uQVIP5tkohWRM8h4xpAtZ9SYIn8gnAfQvRXvG3LM7e/Y
    YKP24+c452WcdTu3fa1zba9sH9Gf9IeSj+2WreATtD01Xpa2uXd1ZvwtQvPBGx+m
    xCHmSKvfnBrw1PYNo1EM2MxAI63sHv/0/YYcvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475986; bh=xjSYwv
    56yxfh0/guAjCjaBUPog82VsBmX4K+dVV+mdY=; b=t71v7IbEZu0nOeQW0TKeos
    z/JsQn4Z4kryOk40nbKmIjkdCQ4vCKkjcYiSqsCwLjkwXe8CpF7koEGFce4MYM6M
    eoMqRL5bas70pcughlGiH3VpT6SAiYQPDooZHprXct/fYEwrQx5ItKgm5r+xhwcx
    XIiGWtWMpdqKqXGy30YaIPlkaFgZBfJuy4L9PtEI3slv0jQlRBiTR+AObWq2bGF0
    RKu5EyBLf5P4b2douC9XCGqw3S8xKEEfaeM6XFTvPi8n/AipTfvoiWgwqY9M2cHH
    jbyA53wha7Z9Y2Vz+id/0xC7e/dAHNSkxZydxqM4fJHAqb52OkOw9quXAcpf+kZg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QtW+2TyI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelhedunecuvehluhhsthgvrhfuihiivgepuddtvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QtW+2TyI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelhedunecuvehluhhsthgvrhfuihiivgepuddtvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966854AbeCSQNC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:13:02 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:1938
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966830AbeCSQMy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 042/102] netfilter: ctnetlink: fix incorrect
 nf_ct_put during hash resize
Thread-Topic: [PATCH AUTOSEL for 3.18 042/102] netfilter: ctnetlink: fix
 incorrect nf_ct_put during hash resize
Thread-Index: AQHTv50RPqEMTNoL20+dN5T4v11isA==
Date: Mon, 19 Mar 2018 16:12:24 +0000
Message-ID: <20180319161117.17833-42-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:22NKmAsaERsF2MxA8mzw5aAOR9GjpZAdTmjmufQVbrn8XdykSgqTQQM4YD4seLs/NvHO+dmz5rrWg+iKb3vyqf92dgZsnURISH+EIbohR/o4iTBDYkVwfjmERxgwPNInJIoDw67ztovQ+24v9WvyCZF5wqpW/SYhIYtc+PQlb2QtU/IXtq8QsYOfcvvj4Lgl2f5gvuOh6CLxw0kc7hWpIJbypXY6MdaauTDdA3AMxeNME619iS7eaTHRzuHd1oht;20:NF0B//pfhp4uk6Kaibkxnf2hUAj164BUC+A6IcH2t5aOLJkGGDoB6X10mr/NhdqYuwR2vOK+kJe4MMNd92D+xSo5BReGO50K1EQiGYdHX4I3yA+CMXgKKCd71UOqY4l2VyFmjwyaf837cN0LdkZ4IMpMhaeoPFKbH2LwCHKZIHM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 253d21d2-61b9-42b1-488e-08d58db44427
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10486EA7DA9F95C8D658A58CFBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(3846002)(6116002)(59450400001)(305945005)(6436002)(36756003)(54906003)(110136005)(53936002)(14454004)(97736004)(3660700001)(99286004)(76176011)(22452003)(7736002)(6512007)(316002)(6486002)(186003)(86362001)(2950100002)(575784001)(6666003)(5250100002)(66066001)(3280700002)(102836004)(107886003)(10090500001)(106356001)(25786009)(6506007)(26005)(8936002)(2906002)(81156014)(81166006)(2900100001)(8676002)(86612001)(2501003)(478600001)(105586002)(39060400002)(1076002)(68736007)(4326008)(72206003)(5660300001)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gsmeHbuxVHsNJ/jcsVfyTMTOGijcft7+BXQXDm6COaOmHcxH/R0PViKsla53uQDnUM3YN3gNMJlGztFggZt48WIVilbVAt2M9x82Nf2zfhESwaouFwLvMTOa8WO2CJxj2zBBPvczZCf4erXzsMEzHZ1HmvlpHuu1d8sC0Tkehu06OtpCUZgbqF2HJmw8X0y3NDmvtsDpngiZi08M4o8t9YdzbDE9ucjomOJdlFjgfEbfAspJDFTvy0nZnpHaIZYRkV9SfrUsrZ59PictelFYpClyWtaxwAgO3TQtZcUQwk3yfBMMZrfMoYP53+0UA1Ze85sTan5mHCTYYygTse3Now==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253d21d2-61b9-42b1-488e-08d58db44427
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:24.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
index de9ea452dd60..4d69e924a0f1 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -828,8 +828,13 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netli=
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
