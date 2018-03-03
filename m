Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121980-2-8922290862539876587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121979; b=aOXmxgBfde5pARhpMCiVKp20uXVn08MusTYvX+H/SYRqMBU
    HgiJshA9IpU5SljpFNfmxu0eMn5rNtPicqU5jQ/HZ1GCz0boIaZa4PARI9qJxfXA
    4Ru8QTsJqvWzLjkOmDFccD2Gx4OtA/Q0YcqV9wCWqj3YWh9g0jl2c1qOibd/R9Ps
    zfpf8RBKPLqUF9lJJr3SKsCYk+BwcbYMDssxA091Rffan8ZxVvUemGoyF/Si0wlX
    RSrZEuZinlCtljfedSq7P06k9t5Q5AffkdyUGIoQyljqKMDDlgL4k4s+NX4F13QJ
    FVcsOWxJnMhYx72UipMa4Xa8o2YuSUng2b6An5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121979; bh=4aNKVk
    FEj5/aLyYSVeolM8DlY1ut1QOd/AJCQDHexpY=; b=KxnAmPpm96K2+Xxs/B9Y3/
    i/dX1tHm+23wNSERNtlWmhFd4UOoBaL1wjSvo49A8NWGBCgOtrPOo1U2m66KD1CZ
    Oco7CCPIPQlkvOsAfTl9tVYG6hp7uLykAKCs70sWmoQmzaWF/35DtLTlh1o5ijk2
    gFxP3kQUPtpxuCzpWy0cIBJ3652XXESRdwGO5z3v/fIskmnw2HPUbhIgTE0KZFdK
    6ik5LooKWbOkHw8DRk63k4l6pm5nR95lV+CZLqFqZx8c9LKXoz3yUXIjThXk7CGG
    6rGRbjtpqRU1uG0M6ZewENZxVhBtx84lPYW8bQ6fy4mKVwI24Ac7TspmG4Itqcgg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D4nlWqWb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D4nlWqWb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeCDAGO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:06:14 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933362AbeCCWbO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 018/219] drm/sun4i: Fix TCON clock and regmap
 initialization sequence
Thread-Topic: [PATCH AUTOSEL for 4.9 018/219] drm/sun4i: Fix TCON clock and
 regmap initialization sequence
Thread-Index: AQHTsz7m88qNEYzHmECi54vjUskcTA==
Date: Sat, 3 Mar 2018 22:28:05 +0000
Message-ID: <20180303222716.26640-18-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:Xlka+fTAHs8phKebkUkcgTHq4+WZBaC1+rlSOaRsL78u3DMptUCuECkfHjNH14m8aTM3zc/kHsS9ray4nNVD719RWw3aFYC6rv51G3OXmZYSIOSzaCb/nt3uruGtkGZyP1sKb7nS4wVbshsZeI4idEEdnZUL3pN/qIA/TRuTkzD2zLtJy9pE4fgSuIRgLeum3vZLpOwtElJ482EywhIkX/QMGTQartLwjL4JNJpryx+hsNvxSE7IRUF61SrlRIROEBCipq8+0B6yLu8d1eKqiTeLVMxousyCusUI3KYWx2SJQ8amihigRMn0e+ZXOloYh/fNQcjbzAwhhX/To/5oaUIeISjfP4UNDe33BPN8pBY/UFdPWE2kb231h1BtakVi;5:KHPBpmPHmqZxoR83f9JWdC1PSZ5PIQ0PxNp4k4d+3DaR+SS8ldQiQ6o2zz/Bj/ENQsOXxJ0MkFwBywSfbydADTIcmvyo9jFl76FR2OjVAJAsym6NTALBVpkSo3rFCEZU3ifZpR2u8LhUCuZemxWarUN2p8mz4a5WlcKuPLWxMPE=;24:D9z9seRbdYM4RMpnpRRzovHfUs3FdnbhUzQGEpk405bSWx+IiROgs3eO9EX3eTCBC1nr0VOxuwogLOGiKYoPVxF9u/mwoHUKHn0W76nbsD8=;7:ZCww4mF2aURiIo/3rwB9g/pA6SU+ClD6eYpVnuzfejybhrz5bGMOdRvCU8zA9eoBB2OaaEROqYPuG1Xwj8oVmd8f4J0L77rvjWHOfGYgVraEO0naQ7K0fstueUA5zXAn2uKeIAVTNwBnxNLHpuhl4K/SbGcL6+OVIZhZz5Maxl8npsxQQvsiM8nVkCfmpr8jbxd566YLm/gCVWgEwENFd9DmsP+2qa0LruCPvZxsJtcXkpTjOKfgNyO/ngogR17i
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0c16447-d9ca-4bdc-b4c4-08d581567572
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09709AB6C5681D93221A615DFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: dj1HCiiG1SgiFVXzJy/5xzsog61MlpgvzYJbPl6UCZRIiE9+Tx1aoDqS8mh687a6oJ4eW/RpUnMNdluJ7J98+YktF7QNrWyMk2hU4lNwUYNid9FUaLNyesG4GHssOP3vyJCdbvnpVbc3NQeNyFuCPFQ38rTAM75OEU1Lq127S5k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c16447-d9ca-4bdc-b4c4-08d581567572
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:05.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 4c7f16d14a33a9cfb4af9cb780d8a73bcca64a92 ]

The TCON driver calls sun4i_tcon_init_regmap and sun4i_tcon_init_clocks
in its bind function. The former creates a regmap and writes to several
register to clear its configuration to a known default. The latter
initializes various clocks. This includes enabling the bus clock for
register access and creating the dotclock.

In order for the first step's writes to work, the bus clock must be
enabled which is done in the second step. but the dotclock's ops use
the regmap created in the first step.

Rearrange the function calls such that the clocks are initialized before
the regmap, and split out the dot clock creation to after the regmap is
initialized.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun=
4i_tcon.c
index c6afb2448655..f2975a1525be 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -336,12 +336,11 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		}
 	}
=20
-	return sun4i_dclk_create(dev, tcon);
+	return 0;
 }
=20
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
-	sun4i_dclk_free(tcon);
 	clk_disable_unprepare(tcon->clk);
 }
=20
@@ -506,22 +505,28 @@ static int sun4i_tcon_bind(struct device *dev, struct=
 device *master,
 		return ret;
 	}
=20
+	ret =3D sun4i_tcon_init_clocks(dev, tcon);
+	if (ret) {
+		dev_err(dev, "Couldn't init our TCON clocks\n");
+		goto err_assert_reset;
+	}
+
 	ret =3D sun4i_tcon_init_regmap(dev, tcon);
 	if (ret) {
 		dev_err(dev, "Couldn't init our TCON regmap\n");
-		goto err_assert_reset;
+		goto err_free_clocks;
 	}
=20
-	ret =3D sun4i_tcon_init_clocks(dev, tcon);
+	ret =3D sun4i_dclk_create(dev, tcon);
 	if (ret) {
-		dev_err(dev, "Couldn't init our TCON clocks\n");
-		goto err_assert_reset;
+		dev_err(dev, "Couldn't create our TCON dot clock\n");
+		goto err_free_clocks;
 	}
=20
 	ret =3D sun4i_tcon_init_irq(dev, tcon);
 	if (ret) {
 		dev_err(dev, "Couldn't init our TCON interrupts\n");
-		goto err_free_clocks;
+		goto err_free_dotclock;
 	}
=20
 	ret =3D sun4i_rgb_init(drm);
@@ -530,6 +535,8 @@ static int sun4i_tcon_bind(struct device *dev, struct d=
evice *master,
=20
 	return 0;
=20
+err_free_dotclock:
+	sun4i_dclk_free(tcon);
 err_free_clocks:
 	sun4i_tcon_free_clocks(tcon);
 err_assert_reset:
@@ -542,6 +549,7 @@ static void sun4i_tcon_unbind(struct device *dev, struc=
t device *master,
 {
 	struct sun4i_tcon *tcon =3D dev_get_drvdata(dev);
=20
+	sun4i_dclk_free(tcon);
 	sun4i_tcon_free_clocks(tcon);
 }
=20
--=20
2.14.1
