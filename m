Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477893-2-13773221090153509454
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
    t=1521477892; b=pcw9BmBjCQbHhZxVUZ3B9uvQzAlTEwMz0ngTR6Su09p5y1Q
    dQZNffUKTJ9kfG5GnPgfIKcGXL+fN5/jg9obNRZtyD4oGwlg1iyz7iGmwW1wPyNH
    7SOmDb8TUgrB+3jmygHJQCFj6f86gG9563yPsuEDhOjZYCg8n0fLfsHZVV9zUCCU
    Cg4YLd8yF6S2t/yla5xtRNErzxKXmHUxd4yV9bjwv93/10gGzNor1mLK/a/J0lOz
    PasEB7Gvz8I1qTJNMPhGC/D7QCz83HdfY1c8Yn9Cu6m5YfKdnr+87i5X8ibmQ5QJ
    8eVvFKMJwEI9hzK192StcUgLRCpjLU9GsOFSmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477892; bh=VMBO40
    p6MgbQ8HtH/NaEGwOQXlcHDP6M0Y1/YukOlac=; b=pwoF+JREMpuMBlwRO90oTl
    JcI2dDd5JwtqSOQeOU6fBxYBFNwxl6HNb647Ian+dyxvIOKtXLp0TVUzfpV0kvUk
    nEzF1R8hvQDHANPsmhWLcVi+ySj3nEV/R0WBXPR/LeAl9H7O3sRzRw6V9yz51b0l
    dYU1LOcTHWVOhGzxfCktgoLOThpu/AHRmbs/4lQ5uVCNfxAskbmawOA/RSIQwgjx
    yv8MBbaXcQOJKkBZEYGZ+Xk2BeUOXsaoTrKNsQhm2dtqajRs1mph+zkixPvoActw
    azI9/A4OOGGXao1zUGzndQ/TOUl/etNhTZg2L98WPKSXadGO5ALj+TjEaDB/h8YQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nLCQ8HgC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledttdejnecuvehluhhsthgvrhfuihiivgepgeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nLCQ8HgC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledttdejnecuvehluhhsthgvrhfuihiivgepgeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966816AbeCSQob (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:44:31 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966814AbeCSQMT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: linzhang <xiaolou4617@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 031/102] net: x25: fix one potential
 use-after-free issue
Thread-Topic: [PATCH AUTOSEL for 3.18 031/102] net: x25: fix one potential
 use-after-free issue
Thread-Index: AQHTv50G+BFRi8aC80CbpW6z/vjvhw==
Date: Mon, 19 Mar 2018 16:12:05 +0000
Message-ID: <20180319161117.17833-31-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:bERQL0k7t4i+5WsCblX+2g5fEdChB5P1fZQxkuPyHDJNIwht4wqfcRhQuWv6gTGhfwM0Cx1lVLM4HV6C91ivN/hBbq3Zw81z0sOwqAVRl5qws0VSyQnlqvu6yOXdFe/JZIwq+Sz9odvfD6hUzcZLrhSHCU38JvRP9FzAXXalUDBmzi5U+8Q9f3iWJlnEF/7GzYrPaAhloPAgv/6EiO5M1azw9mydM32UX/FTmDG4+BcEmu3FfM2c8amoeZfu/1q3;20:/1pgwblxkcGW3s/stD5oMm195dtF4jGkOLtIugoq899b+HB1jenv4U0cV9lAzIWVnI6FbURjqNNQeQ+DUom/co9vQ5hNswqnHrwwQ9qCd72BaQQRvH880SDntQmAwmr+1TtMHCo8GCXiiTzQZK0h8fLWImjQQqMILHO+XT4+fZc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12ede8b9-3713-4866-6eb9-08d58db42aea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092014C131A6918208FB2FE5FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(39060400002)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2lIG6BE4II4pZG0GgZdkkcmpDJ2CQs9kHJrGfOAT31UW262NQ9M6JRx5aTYyrrAO8kjNLZL/B7MC49teTU0QkQ8kuvzUgiKi9em3pIoGti6AqWMOnGEljFtEEcfR+1ZpgXSgMjE7LIILqJYSY3jVctB9HaajhVCDEX2fgrUHNJiCw2Kg6R5M0VqTi716hoJpRt3Vm5dAcnVdy64wa5yYA6hTFlZ/n3clC9v1hQ5f/iRPkH5BaSL5xwPrnUOErnfm30qW0UGIAnvTYeeIBY+3l934RqgdTPC6dkau6flaAyGhVoUA9L09J1EwzstI1khMxJOOVSZtOtqQLAzrcye9UQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ede8b9-3713-4866-6eb9-08d58db42aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:05.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: linzhang <xiaolou4617@gmail.com>

[ Upstream commit 64df6d525fcff1630098db9238bfd2b3e092d5c1 ]

The function x25_init is not properly unregister related resources
on error handler.It is will result in kernel oops if x25_init init
failed, so add properly unregister call on error handler.

Also, i adjust the coding style and make x25_register_sysctl properly
return failure.

Signed-off-by: linzhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/net/x25.h        |  4 ++--
 net/x25/af_x25.c         | 24 ++++++++++++++++--------
 net/x25/sysctl_net_x25.c |  5 ++++-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index c383aa4edbf0..6d30a01d281d 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -298,10 +298,10 @@ void x25_check_rbuf(struct sock *);
=20
 /* sysctl_net_x25.c */
 #ifdef CONFIG_SYSCTL
-void x25_register_sysctl(void);
+int x25_register_sysctl(void);
 void x25_unregister_sysctl(void);
 #else
-static inline void x25_register_sysctl(void) {};
+static inline int x25_register_sysctl(void) { return 0; };
 static inline void x25_unregister_sysctl(void) {};
 #endif /* CONFIG_SYSCTL */
=20
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 5ad4418ef093..7ac8d3869267 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1796,32 +1796,40 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
=20
 static int __init x25_init(void)
 {
-	int rc =3D proto_register(&x25_proto, 0);
+	int rc;
=20
-	if (rc !=3D 0)
+	rc =3D proto_register(&x25_proto, 0);
+	if (rc)
 		goto out;
=20
 	rc =3D sock_register(&x25_family_ops);
-	if (rc !=3D 0)
+	if (rc)
 		goto out_proto;
=20
 	dev_add_pack(&x25_packet_type);
=20
 	rc =3D register_netdevice_notifier(&x25_dev_notifier);
-	if (rc !=3D 0)
+	if (rc)
 		goto out_sock;
=20
-	pr_info("Linux Version 0.2\n");
+	rc =3D x25_register_sysctl();
+	if (rc)
+		goto out_dev;
=20
-	x25_register_sysctl();
 	rc =3D x25_proc_init();
-	if (rc !=3D 0)
-		goto out_dev;
+	if (rc)
+		goto out_sysctl;
+
+	pr_info("Linux Version 0.2\n");
+
 out:
 	return rc;
+out_sysctl:
+	x25_unregister_sysctl();
 out_dev:
 	unregister_netdevice_notifier(&x25_dev_notifier);
 out_sock:
+	dev_remove_pack(&x25_packet_type);
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index 43239527a205..703d46aae7a2 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -73,9 +73,12 @@ static struct ctl_table x25_table[] =3D {
 	{ 0, },
 };
=20
-void __init x25_register_sysctl(void)
+int __init x25_register_sysctl(void)
 {
 	x25_table_header =3D register_net_sysctl(&init_net, "net/x25", x25_table)=
;
+	if (!x25_table_header)
+		return -ENOMEM;
+	return 0;
 }
=20
 void x25_unregister_sysctl(void)
--=20
2.14.1
