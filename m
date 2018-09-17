Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1C2ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABCD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lQGyv3pQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABCD2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeIQIaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:00 -0400
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:36496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730225AbeIQI3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLh1GgT8xUI0UtcYBANkNVq6ya08BMz4yZj6cSTPDUY=;
 b=lQGyv3pQAcUC0yrrOwiWm0RcdpNRu2lUhGOhtkFJZjJe/cxNAh58z8w6NUqkprLeGXmEo+QJol7wCs+bUJn4wNhJT/SaOEIq4jVAIkMROU1Iild70WN3p5Vy+GUzKFS3u+jUgLUc7+S3upGweyjQKepXQKdRfIRDZQ6YnWzekCk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brandon Maier <brandon.maier@rockwellcollins.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 60/87] net: phy: xgmiitorgmii: Check read_status
 results
Thread-Topic: [PATCH AUTOSEL 4.14 60/87] net: phy: xgmiitorgmii: Check
 read_status results
Thread-Index: AQHUTjLyztWWSK3lvUSGK1FjNFzRkg==
Date:   Mon, 17 Sep 2018 03:03:02 +0000
Message-ID: <20180917030220.245686-60-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:aJjG+uFg4RzNRp/q0GUUApwYd42QI2ZlQux0dvpfMsWGBUAd/5Rkusw/nSxVk/pczAxlTxqJFyW+prTqvolVobiiWPdSSc/4MLNhvvV6VFXLSI8oGNohs3be6PypUuC9qVix5Os68MlEOqdacS6/g/g17XXAwd8cl62GPXCnOwX/1XV3LivP4uS7DacI8De8K6HOa76VbfdPfo6N2Ef8B7gyJrm+5Tlha4M3uKaMKCLNZ6KyuNeNdflY1lDG89IIXk33SoSvbjZiyNrkghSkCyGTNUNhNtGC1T3RgDTpMLNUyFpdrPsph9/a7WLBsjfOewNK7Qi7qVJAY3BEiSJA/9YPBZ6uw28CDY1ZxJ1Q1SItKSOvk4Y4P3lYYVV61AhEAcw8jqcGAydYJQeY0PH3faNjoDF6DQYZIbIpk7jaeIrQVB31Bg3SMIzMLxSEX2+ePMGibdE4pqFG69XJ6szIeA==;5:+lYSnvyqeEUPA3cQI+dRS0mUHY/T4Ghyd19DUpOdypv4UZYAgebdEUS0Cz99Bq/d3hwCPpfk2MyHvAsMMSV11Cjf1mCXIgyHIiSHnMZFBHLMCzG7UAXHsRfdZt1FwaCXBCWmM8Z8V0c5YEQ+ybxNlqO+Iu414AYfVT2xf2s1qqw=;7:2VKrwh70yxSdaDdVE8mLv3Odaxs1nGgA5OsLSMRW9vWxfFhwkJFZw8jmBWAWdksW/sKLDa70l/FuottHKKOciQxJKo4YEI48pfENBhuZezNBPoh47Wt+6lJrUNREhddt0D7IJ05l8USJ9flsVCvKGbtTtES93FBO+iww3+uYsq8dl/QO6fVI4wbnszJJPCETMJTgjwtrxxgq2RUYo4Cr+MMaRb9vTcZgPtz874zDS5k2cCLWbLcwK5BobOFQJ3qz
x-ms-office365-filtering-correlation-id: 34480234-3065-49e6-270d-08d61c4a4587
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB07741230F3676F7E2B49A7DBFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(5024004)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: t4BkP+blyRkLprNxkBJkbYk/PMcukTzy5xKjKa6Si3mtKUgkMlQkX01/fQrCq78dz2GUB8J694FIa9c1+C1TqzO0Hds4qOk28BcHcahvmZMLF4JCjSozZxUEo+O9RxnuhJ7J4vSp+EcLLxtPEeZZXE+3Wkcf8XAsleezaKNOKGxLO+vyn5UX9b4UrsMVVQcXGNQbkQqlOwO/STx9JJqtQo3YEtkYWaAwD6kgaaKb5sKQ8Iilj1ArrNPG2mXyNOzX2yWgPnN3alKrgwYGLOedZ9ROthJ/I+E++8TAbNBJ65iuET6jwpQmkGhEbfiSGwVGFTOkroQuQJ7PSuRRGeadUqsT2fDe/L5G6wo1ayWEEQ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34480234-3065-49e6-270d-08d61c4a4587
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:02.5716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Maier <brandon.maier@rockwellcollins.com>

[ Upstream commit 8d0752d11312be830c33e84dfd1016e6a47c2938 ]

We're ignoring the result of the attached phy device's read_status().
Return it so we can detect errors.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_g=
mii2rgmii.c
index 2e5150b0b8d5..449b31319010 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -40,8 +40,11 @@ static int xgmiitorgmii_read_status(struct phy_device *p=
hydev)
 {
 	struct gmii2rgmii *priv =3D phydev->priv;
 	u16 val =3D 0;
+	int err;
=20
-	priv->phy_drv->read_status(phydev);
+	err =3D priv->phy_drv->read_status(phydev);
+	if (err < 0)
+		return err;
=20
 	val =3D mdiobus_read(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG)=
;
 	val &=3D ~XILINX_GMII2RGMII_SPEED_MASK;
--=20
2.17.1
