Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120201-2-8157893151074968406
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120200; b=akd9IZGRgtIuMgYBIHwKKL32iAbVKYT5kfcpgSIIZboxPSH
    K8LpThtmmhv5LuGB+f8H0fxHVS9HoG0UiLea2UXmuOLagblwDAzsrHa75+2ft98n
    cHG9Hdw2AFqnivN4L5C1w5MMYa4XKUvAfok9vqwU8YWsqpsJYWlohCGivRG2p0wD
    so5hNlvqByzDUImoTXXFKwh8q/83sT2+q8N+/BbIlWwh2JBJeg6XJgmJ/0kHLbCM
    gd3cLgVd4YmNDJ0JmT9JTjyfn01R0dPIODTfII4/3+fftASI1ylcsdxAQM1VAfXn
    jzkKF20oyyUQVaWyGZOKSHIMeaYfHfe1pWvrYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120200; bh=+LTGz0
    tSATnq99T9TqIrl3RTZbL5VGnGpjVU2OOtD6g=; b=bb63EORf0epLQ83h3serTf
    2JslUvLP9OSZol8SvIngmmaeE3AtKubkQXgyB9r/LHoWc+HdNI1j4iDIO62Gb5aP
    Z/Lv7CGZI/Cc8BV4Rr7Qdqh4CCPFp2GXrnsXb0+emwDJwwOu/uJz5sm6FU/sB4Ns
    IZUg/L38jZ7sHPyWbx4IjdMxXoXbiYcUnq2ubCudq6BM5Tc8A4P6MIYY/eE+zwy+
    S43zLXeq80WbcNwi9PfTad5oUl7eZceEtZVlwxRYjDEPr0t9+kwfQiwt3etnGI23
    /gffnV2l5In2m30zgOQZO/VWerjmhKcIc5+K3FU4kF7qN+IEwE/hT56/Ij6GdBnQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OziWm73B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OziWm73B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934041AbeCCWfp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:45 -0500
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:43384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933860AbeCCWfn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fugang Duan <fugang.duan@nxp.com>,
        Fugang Duan <B38611@freescale.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 152/219] net: fec: add phy-reset-gpios
 PROBE_DEFER check
Thread-Topic: [PATCH AUTOSEL for 4.9 152/219] net: fec: add phy-reset-gpios
 PROBE_DEFER check
Thread-Index: AQHTsz8VZF8ia/Xn0kGKAXalr9jGBQ==
Date: Sat, 3 Mar 2018 22:29:24 +0000
Message-ID: <20180303222716.26640-152-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:LHTapJz6rCsFSpTc7tKZzvmeJEfKOhA1OXk6TFEvEujX2Pjj0bisMFzDaHUse2E6uroKjTC5RexTbcHcrfPiop6gZuw3dRn4yb3AM3nIGLF7dxXlfbubQlEvhDbXOcmgYPGHxQapAr7oIdmL2FPtGaCsXE88PtGp7qlol6S8g8zUy/0Klxrf8Orjm6uALfLG2pjgLZRar4JSPd9m+YeyKmcH+/U8eYOW3zvJ/BaCMwyPVOPDnsS0m1njhaJc4cG3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a12317c8-64a9-49a5-1276-08d5815717a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034645DEB152CD91990C57BFBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(101931422205132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(8656006)(68736007)(106356001)(25786009)(8666007)(8676002)(4326008)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: d+L2QtGwWoShei99FTt2Zr0+Tvi3bWOQFZTe+q9OpWWhAcAYh9vXBCtRNqRPJsjCDV862fxhOFlgsf9KBcDm5k8ACXXF87H0yqdIYWMK6TtRI7Ebt4BuD3ry6t/1wg4xYEOAmz8cD5CSoudn+/F9yLN9asbEPwIcPHDhUlSFemA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12317c8-64a9-49a5-1276-08d5815717a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:25.0101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fugang Duan <fugang.duan@nxp.com>

[ Upstream commit 9269e5560b261eb9ee157497890dc0948db76cf8 ]

Many boards use i2c/spi expander gpio as phy-reset-gpios and these
gpios maybe registered after fec port, driver should check the return
value of .of_get_named_gpio().

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 917091871259..dd6e07c748f5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3209,7 +3209,7 @@ static int fec_enet_init(struct net_device *ndev)
 }
=20
 #ifdef CONFIG_OF
-static void fec_reset_phy(struct platform_device *pdev)
+static int fec_reset_phy(struct platform_device *pdev)
 {
 	int err, phy_reset;
 	bool active_high =3D false;
@@ -3217,7 +3217,7 @@ static void fec_reset_phy(struct platform_device *pde=
v)
 	struct device_node *np =3D pdev->dev.of_node;
=20
 	if (!np)
-		return;
+		return 0;
=20
 	of_property_read_u32(np, "phy-reset-duration", &msec);
 	/* A sane reset duration should not be longer than 1s */
@@ -3225,8 +3225,10 @@ static void fec_reset_phy(struct platform_device *pd=
ev)
 		msec =3D 1;
=20
 	phy_reset =3D of_get_named_gpio(np, "phy-reset-gpios", 0);
-	if (!gpio_is_valid(phy_reset))
-		return;
+	if (phy_reset =3D=3D -EPROBE_DEFER)
+		return phy_reset;
+	else if (!gpio_is_valid(phy_reset))
+		return 0;
=20
 	active_high =3D of_property_read_bool(np, "phy-reset-active-high");
=20
@@ -3235,7 +3237,7 @@ static void fec_reset_phy(struct platform_device *pde=
v)
 			"phy-reset");
 	if (err) {
 		dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
-		return;
+		return err;
 	}
=20
 	if (msec > 20)
@@ -3244,14 +3246,17 @@ static void fec_reset_phy(struct platform_device *p=
dev)
 		usleep_range(msec * 1000, msec * 1000 + 1000);
=20
 	gpio_set_value_cansleep(phy_reset, !active_high);
+
+	return 0;
 }
 #else /* CONFIG_OF */
-static void fec_reset_phy(struct platform_device *pdev)
+static int fec_reset_phy(struct platform_device *pdev)
 {
 	/*
 	 * In case of platform probe, the reset has been done
 	 * by machine code.
 	 */
+	return 0;
 }
 #endif /* CONFIG_OF */
=20
@@ -3422,6 +3427,7 @@ fec_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Failed to enable phy regulator: %d\n", ret);
+			clk_disable_unprepare(fep->clk_ipg);
 			goto failed_regulator;
 		}
 	} else {
@@ -3434,7 +3440,9 @@ fec_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
=20
-	fec_reset_phy(pdev);
+	ret =3D fec_reset_phy(pdev);
+	if (ret)
+		goto failed_reset;
=20
 	if (fep->bufdesc_ex)
 		fec_ptp_init(pdev);
@@ -3495,8 +3503,10 @@ failed_init:
 	fec_ptp_stop(pdev);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
+failed_reset:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 failed_regulator:
-	clk_disable_unprepare(fep->clk_ipg);
 failed_clk_ipg:
 	fec_enet_clk_enable(ndev, false);
 failed_clk:
--=20
2.14.1
