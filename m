Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475023-2-15182024330242435671
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
    t=1521475023; b=I0qCut9bwqE3abNZf1NTh20nDCi/Ay1bcjY1sdCzn+RMfyv
    KPpz/igT3vGX3qgUqJbYtdufjDIw5aUxkYR1O40Vfxts0QEMfuDRNb/op5Mk/CJ1
    DamkO1p12IdMgX6m+SSqzPR4YXGCr28jgOnBWYIa44zTXCGavDWKDv76Md5pW3Ak
    gt2C4hen/U9KjUk79zK5atikYVEvFl+Dhe/oYYFwzIK2ch/y+c8POGKNWNeueXW4
    mVHOuVADRjgUYTDrmakZUeJYf1yt8PyBy5bcZ/edbOUMiTAo4WgA6/y/HCprHQh0
    dH58D9yhwu9/CZIXpTdNFFzUGPJjBlnDtV6QRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475023; bh=EEczb3
    3mfFSDPDTJRW6bQ/2e8XgsmE1AXVCB/KH/Uug=; b=ez3Hfhrm9peHw5bz5kFmLE
    I3jVE87eD/hMCriWcdwBn+Pg0dhVBzPgcvB2pFfKnEhzDfqxonfstgtiH7fR3xDx
    VMqRTr77RoYBcQXYzEgYjhZE7TOQ4lXDHdfaD0QbIyJP+O61d1tzHlLlejIAsfK7
    1r8d64p6FudELiOJBdTYSTRM3qvcjHqG05bWrCTB/XYa4V/lOaMnuyPy3UAZ6lzG
    xht9IZF7CBF6QobJdQjSIgK4+GFUk3a9SjNYTTYFqjlEcA3Pcg6jVwuA4en5Y/Dc
    nCw/nRVsNKf54cUqaM8yVi2lIXc7X2fv3egWYqilzPAdSU4gk/x/zC675AuzXqxw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SDtY8Abd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SDtY8Abd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934628AbeCSP5A (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:00 -0400
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:58464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934601AbeCSP4p (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 74/97] EDAC, mv64x60: Fix an error handling
 path
Thread-Topic: [PATCH AUTOSEL for 4.14 74/97] EDAC, mv64x60: Fix an error
 handling path
Thread-Index: AQHTv5rM0DlUVPcqukKYosXMWHjY9A==
Date: Mon, 19 Mar 2018 15:56:09 +0000
Message-ID: <20180319155411.12348-74-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:TzbxzHKZVYqZS/U19JjCcECzGOQGEey0b5UDd1y0Z0Smk0bQM5L/4OAIgoyJBNjdrZzpMriM201MxU+FsSDIgvD4INczygylX1IENR1Mih7V4faPzzqZNh8zNy9vd50FvLP4NKSo5i6d+Y+rZNkq9PTItrG+GwuckK3i1GDplTdd/GMUmC98B7GRXoT6ez3tIpZ//LP2MFvrvkgPvx6mCldzgEfVUtetpjr8FQABnGYQqXqJEWinU+IoF9KbCQLP;20:jrmYn9n9Oe/vJjaG2TijfHO2SQLMBNkyCwoGkty9mvqVs9XFrggP65aR/ATND6m5ZbAwS7liwnd5pizHcKp7Hbi+8l/B5B1kzduuR8s+qnRPm6xjIYQkY3FCMryQh7e/xf9HLaoZANr1i5nrC6OOam7dgpElyGgvf/iS4V9HiTA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fe6a99b-02d7-4db4-a8f6-08d58db1ff37
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031AF2DA823FAFAE4C40476FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(155761271638844)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(966005)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(6306002)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4VnBZLHyqHrj82Gu/l6TEaBeRLcsD1Qrp8R9UtE8QWB+u3xZU6Hse4lBC1mH7nq5s8cS2bRsc1+3XLnxYBikWuYmTecyRa2cLk/txRgHGKO4e0c/LpisSXw+4mKC6N0uCkuYlBROCmrCh7Y1F+eBZAZQ2hj9oOVcAE23MwkAbMYYM54z490hSaej65yejCpvrK3Q3IaSeyS+RKDvmGreP/pLDHrgp48BzpZQr1jrkj6UobirIzkmAdajb40wteBt/4VYPjtUjQAwPpmXQmDBIyGUHfxRwlkck3e3yNPK3YCQpKJwZtLsokKmR7g3/zNpjLRRRpfHSguiiAELpBFZtQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe6a99b-02d7-4db4-a8f6-08d58db1ff37
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:09.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 68fa24f9121c04ef146b5158f538c8b32f285be5 ]

We should not call edac_mc_del_mc() if a corresponding call to
edac_mc_add_mc() has not been performed yet.

So here, we should go to err instead of err2 to branch at the right
place of the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180107205400.14068-1-christophe.jaillet@wa=
nadoo.fr
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/mv64x60_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index ec5d695bbb72..3c68bb525d5d 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -758,7 +758,7 @@ static int mv64x60_mc_err_probe(struct platform_device =
*pdev)
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res =3D -ENODEV;
-		goto err2;
+		goto err;
 	}
=20
 	edac_dbg(3, "init mci\n");
--=20
2.14.1
