Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1402533-1520124665-2-4678945503115853171
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
    t=1520124664; b=guBlqiWd8W19vViz+/Jh3WCmwcxsExWsHv1NgxFO3ytzFnP
    fxiRY6GI5gzS8dUhXs1viav1KfVVDHxcmmdpPSJ6kuY/a2pkuBYCtkzz8zAaI2fe
    0/lblZx6U7491mpEp/VYPBmIHJ4/dOYcRVHPHt4HOUrG86sqnJFLLej5iZv4worN
    Hh2P+XSkzQ99ME2RhiU1JegBEBiKnxb9zDzdaYVwq7OzAIx4xtrWabh//WIwd/nZ
    8E1L8Zuagiua6v6ZCAp5VcBN2og+voXgsoy5ez7LoG1gNXySFC1tLPoa289xEJ9g
    yJzkpOG8WjS1ycJ8Ekod73DgoCcv4b7C4IWTcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124664; bh=4GCZO4
    PqhMvjc1invdWZAN8i/ORS7Hp+Wp1FFQpTfZs=; b=Jxu813CUJ9pN8EU2TY/Uc3
    oXHUa5ALhTZlfjUROdXOAXB03sW93gB3eE7Dt2fNYJk2OTp9sR469jsl5XEqbHnf
    E+5eOEx8vyVgo+UDITDoHfzcuq+wk5n0fN6rA9QHYhwhYK8PXO6VPspw9rpdxzW7
    tojnOFQED0nU+FKVFRPnqDQvLokJCgQSUupW0POQCPOlB8S+w69pqN+iT19mqEbA
    GonGV9lxWaV8rNDb834mrFkyq5CycGvnaLhoKt+U9BtJEuZzzyF0iwHINW30+5Ba
    Lq30BmYTFdG/1ToxOLGKxpQTXg8So+owx1iZyqdDxCwBPA/DJfeszBF3VYtticag
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IbixSWXk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IbixSWXk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeCCWYQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:24:16 -0500
Received: from mail-by2nam03on0125.outbound.protection.outlook.com ([104.47.42.125]:4384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752451AbeCCWYO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trent Piepho <tpiepho@impinj.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 002/102] spi: imx: Fix failure path leak on
 GPIO request error correctly
Thread-Topic: [PATCH AUTOSEL for 4.15 002/102] spi: imx: Fix failure path leak
 on GPIO request error correctly
Thread-Index: AQHTsz5ZnbXkDtFXyEOF6Ld3GLGnEA==
Date: Sat, 3 Mar 2018 22:24:09 +0000
Message-ID: <20180303222318.26006-2-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:wOe7iN94pVVgUE7Bdag1IzLxnw7BqrMJ6DGORmmyYnUzvY4M8XD283S3qRe/XZicKklQOuLjnO7AE09zzBGLc2lAYuCPaq6FDBS48KzPFF7eoOBl1HExkOfxCUFbues5cEUy9vwyoHwf55U/ZrWOLT3YdMkplPKQU+XNq89NTZrIr4puNbaroKTPTh+AIYaw3p5w4cXkpXOLXTElnBndj/hnpYW0aSpzGaegxwE2AGH/dbkeTWu8Ew054u8Y+pXb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99d661d6-54ab-470f-66e7-08d581557c75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10362DF45D3C4C4B676D7B12FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(8666007)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(25786009)(106356001)(2900100001)(14454004)(8656006)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RnypMqhsxWDlpkSmOkfE9RqMIlyZhpVPyPKL9hSplEXDTfP40YOUodR2/VEFow95zKdMtk+AAStJqF9aBlqaUqKOZRf50tMAp5WZdQbOnpRdPJWy99olAc1hl3ZG3dMhjxKhiB2zyi/bkaetis7RfvaqsJQbAxsiCh/Vy2e6N5U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d661d6-54ab-470f-66e7-08d581557c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:09.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Trent Piepho <tpiepho@impinj.com>

[ Upstream commit 8197f489f4c4398391746a377c10501076b05168 ]

In commit 974488e4ce1e ("spi: imx: Fix failure path leak on GPIO request
error"), spi_bitbang_start() was moved later in the probe sequence.  But
this doesn't work, as spi_bitbang_start() has to be called before
requesting GPIOs because the GPIO data in the spi master is populated when
the master is registed, and that doesn't happen until spi_bitbang_start()
is called.  The default only works if one uses one CS.

So add a failure path call to spi_bitbang_stop() to fix the leak.

CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Fabio Estevam <fabio.estevam@nxp.com>
CC: Mark Brown <broonie@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-imx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 40390d31a93b..6f57592a7f95 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1622,6 +1622,11 @@ static int spi_imx_probe(struct platform_device *pde=
v)
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
=20
 	master->dev.of_node =3D pdev->dev.of_node;
+	ret =3D spi_bitbang_start(&spi_imx->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		goto out_clk_put;
+	}
=20
 	/* Request GPIO CS lines, if any */
 	if (!spi_imx->slave_mode && master->cs_gpios) {
@@ -1640,12 +1645,6 @@ static int spi_imx_probe(struct platform_device *pde=
v)
 		}
 	}
=20
-	ret =3D spi_bitbang_start(&spi_imx->bitbang);
-	if (ret) {
-		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
-	}
-
 	dev_info(&pdev->dev, "probed\n");
=20
 	clk_disable(spi_imx->clk_ipg);
--=20
2.14.1
