Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517680905-2-5371257759278842383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES da, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680905; b=Q9lG+gtezNXbkyJXtCE5AAFnNUjKXcpFyMoEg0KpZvzcz0Q
    1GV9POY80WyNhns0r+k66P3nR/3f54TAtl7A14SCSQC5Pbe3truPsOhja7YPPLeU
    X4BIE83SowAr+2/3Bzj/pKNxQ7qOnD+BmFrOapx5SO54ELhXhKuQdPO6rDco4Ljn
    bdxPnQ0e5Y3PsoFZOilgLPVKG4vpf4TGM8W3nqMe2bipRL2acG555y/9kvm8dlxw
    hL3Yibe5u1xHO/+SMgiq95OQkIzqbAu9mfAQsY0Ci4dAc9cRjE8h7NbPsgW4IkTn
    tgsBka7CLmM8nvn8ng/sB1Snyd393eUvL6yimAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680905; bh=XOeV4h
    95Xfc16d8zy1mIHYK8jCPhCtNFqzL8EkFb7aY=; b=XY6JoC1apvVudcb8IJqX3s
    5SY/pIGD7DBGlDbiIZirL/rNrnEpVuEIjc1qHxSLb1maQKrwnjdY66vNk53EPJh8
    JeHN6oRJabqFtS7iXiW2JuEc9pIrmt1tl4alA2FJqEKmWlRAfOQKtDAluIRGr1XC
    jfcZaQfOpUTlW7KceQAOQ8LOc61OEcINopi4xhjUM6cOzKidW5+9A2V9Rc13utud
    gG9Ot4MgzlT/zh4SEHk27DD8fE5KzJqu6MTSvL0RqT8BT0OMsiGVauKB7+lQG5iE
    FJjz1yL5yYRGoZYsX6cewwdIxY6EfRmXYJWkltGplwJ5mUpRJ/nKUxP5F+TnoSLg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KqYQc1RD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KqYQc1RD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeBCSBe (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:34 -0500
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:2624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752538AbeBCSAu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 021/110] sget(): handle failures of
 register_shrinker()
Thread-Topic: [PATCH AUTOSEL for 4.14 021/110] sget(): handle failures of
 register_shrinker()
Thread-Index: AQHTnRjl7w2OjzjZok+g4LG8ttZmPA==
Date: Sat, 3 Feb 2018 18:00:37 +0000
Message-ID: <20180203180015.29073-21-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:zDPuC+fDnJT+drCw1tJ4dA+Ba94jADoXpAiC1EwoepydH+nF0/foE2cxq9gve2PtqJJGXT4Wh0oKZ9wQVbHokUU3DSpUyp7IYYMtbBl0GUD7/2Ec5HHO+Z+B4dZG83CpjJ3p4EhM3c6sGcxl6JEGRKDp1di21dASiff4lcpdjrl8bX/8EieeKaj4fiNkFqviNcXH3rWnBisF2/e5Mj0v8zpCeQQazZqjTjWELELbqhgMqesEtV4ipn9cdTfsJ8i1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cb91b3a-7aa0-4a2b-331a-08d56b300992
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090C1D039596EF0F7A53583FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(575784001)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: p4Kez6JWTLlrn9Eq2NodqPfcW1tp++9xxa9hRgIsPOYN/TKxyPLYy5akirLw/yFylTUSThOTHnyiNSyCHDEoyA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb91b3a-7aa0-4a2b-331a-08d56b300992
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:37.5659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 9ee332d99e4d5a97548943b81c54668450ce641b ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 994db21f59bf..79d7fc5e0ddd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -522,7 +522,11 @@ retry:
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	register_shrinker(&s->s_shrink);
+	err =3D register_shrinker(&s->s_shrink);
+	if (err) {
+		deactivate_locked_super(s);
+		s =3D ERR_PTR(err);
+	}
 	return s;
 }
=20
--=20
2.11.0
