Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491343-2-470459261729102896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491342; b=upfg8xGA88yvbAGmF7R7LFjY3gTZNnigkMGBnHCfKX0r8BC
    +KBlwWJ2bwVJiDF58+ZfSa2vHbTGnOPaNUrqkl73jjiUAA1BosSvhw2DG7ZUhj1N
    z98WebHATSKUTibYRnEyQdbomYNLGgUM9IKqYmQYudEdt8ViRY1B6MeUA588LXYu
    fJoG6pZjMNaJWyJksxGZRZY+B+Uv3E5xf0666bGoypioGwqg+NQP4tEN528eTyub
    M9OG+oPBVA7UARIuO0GQc9modNR44Xr5F2XxDPy77IeiK3IMcIo55gTHpi94JWPi
    JqX8SV+zK5/ziOJE5v/GKYhAdmrQz5Bufzr379g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491342; bh=SnuzcW
    Cnuauxm4VNwSCPcvq1h700KtxmtWDNjPL2wtE=; b=PaMvfzYO0pZXJf1zEXKowO
    XUmVpktkbOian5OivJMzg6Ilm4lm6AbHsi1xLm/PLi/YwJhGO7rpYb03c0vmkBUf
    drb6Z+j+9Ph/6ngmUOb2pAvpaNnocsxhils9mb0MOj8WXcDeoH08F8cHT/kDyXuv
    W/4dt2LGdyOyqPBNlFV2eKr/01Rhv5GtunU+4Alkpo2gi/m2KDgUqpNQD9BZ+hws
    8D77vBmG/sOp7gEIwsHXcRD60pUsotO4y1ZoBRnvIEGbwApSuja46ZoTxDgRQmTF
    4yRpmwwzLJcQpdCBKM03nHo2n1lLVEk03I+jEjwjxYfBwypPuB4CviRfxH9M2pDg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3KVm+gg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3KVm+gg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965259AbeCHE7C (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:02 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:6433
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935348AbeCHE65 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 33/67] sfp: fix non-detection of PHY
Thread-Topic: [PATCH AUTOSEL for 4.14 33/67] sfp: fix non-detection of PHY
Thread-Index: AQHTtpn/UL6pmOh6Ekan6Gf6JIur3A==
Date: Thu, 8 Mar 2018 04:57:45 +0000
Message-ID: <20180308045641.7814-33-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:LsbU6xC4BBdDrHIHFiLlOAPYyFuniC5TJZLKt4u0ZLmpVDNGENAPtbSEkhpaTaD8DhhSbMa5oyG2KD1+8q22RfFDLmNNi2S81pZ66Ms9J6pNdYZNjkiuuQEzp+s8ZkgK0h1sIzhO6uvbQL91k593twHYp702QqcaWz0Cc6F5Nan5NwiwZlxoBGGVXvl/TChFCM5pVDyMypgNqBwhyrP+/VapSxIfeH5uMYXuzDWQ8Lrb96sHbbCcg47RmzhpK+BX;20:/WOBEqU0hyB6cVIamOfhPj0D2XupFS37L1yLOK01uWzsjs5843NIqt0GX3tjN7qHxDm1Uc46yR3dQxaL/zuPRDk5Lnla/j5CyLsqZ7iNzDfwM9WpazBKLVOUiX5UCRtan4Cy3Jxv2Di2yEJ7LTIcHRAKWPjDgYU8MsqjdyF11UM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62359016-407b-4e86-7db8-08d584b14ab1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB108097D8AF9E6023B27E8AFCFBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ci/7L/nW/KusRFdiMJCnVL2lRiqLCswaKQOToTARG1EOCYhJRiMaeaUtA+PUo1l5Vl8rvojOiMBgS4QTCe/KE9po4llu/DMRUIIR6yziAlGHN13o42Ry0JadNjeU498CV1ah6blr2t05wlgOPQsYOeHM/sZfWGennABtliGP7ncnWrMu3393KzpjXNMFTZVzndDweWIiVVQ/VACtb5CObEKmJmJhZvP8OglNTs3HfgFYxJI4Hr13G/2/ewdtMag/8q1D/xPadJQUe2bny42y4mB0KVmkQBlEINPaFvNsYL0GVdetLZ37t0YKq+HXc91G8i1pPkv1LdFRT6+xbtJtRA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62359016-407b-4e86-7db8-08d584b14ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:45.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 20b56ed9f8adfb9a7fb1c878878c54aa4ed645c1 ]

The detection of a PHY changed in commit e98a3aabf85f ("mdio_bus: don't
return NULL from mdiobus_scan()") which now causes sfp to print an
error message.  Update for this change.

Fixes: 73970055450e ("sfp: add SFP module support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/sfp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index ddf184db9c45..3165bc7b8e1e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -318,12 +318,12 @@ static void sfp_sm_probe_phy(struct sfp *sfp)
 	msleep(T_PHY_RESET_MS);
=20
 	phy =3D mdiobus_scan(sfp->i2c_mii, SFP_PHY_ADDR);
-	if (IS_ERR(phy)) {
-		dev_err(sfp->dev, "mdiobus scan returned %ld\n", PTR_ERR(phy));
+	if (phy =3D=3D ERR_PTR(-ENODEV)) {
+		dev_info(sfp->dev, "no PHY detected\n");
 		return;
 	}
-	if (!phy) {
-		dev_info(sfp->dev, "no PHY detected\n");
+	if (IS_ERR(phy)) {
+		dev_err(sfp->dev, "mdiobus scan returned %ld\n", PTR_ERR(phy));
 		return;
 	}
=20
--=20
2.14.1
