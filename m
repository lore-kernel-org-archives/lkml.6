Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6843CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32730207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wpF7cPfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32730207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeJWRTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:19:40 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:36896
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728372AbeJWRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnK6v5vsJ7Umgt5yF4KnUKEIOHe7cCFP4OXTjhmSUE8=;
 b=wpF7cPfmGnLBiG3OZQQicvreFMzRomuGaDXP5qlMnFbJpHaHxJHye/EnvWoUoECV/Pxz8MnUVNDvqBg4rsExw8eGs8P4a2NzMwXz0rkG3WRBH0CU4rkqOD75kKxEI14iK+em5lYvL08QM/eoc/rMkxe1tpwaiXVOP/+Rhg/iFJs=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4367.eurprd04.prod.outlook.com (52.134.123.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:57:07 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 08:57:07 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH RESEND v4 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Topic: [PATCH RESEND v4 4/5] arm64: defconfig: enable NXP FlexSPI
 driver
Thread-Index: AQHUaq5goAQQeUMdOEi/usSBMvverw==
Date:   Tue, 23 Oct 2018 08:57:07 +0000
Message-ID: <1540284888-32307-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18)
 To VI1PR04MB1038.eurprd04.prod.outlook.com (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4367;6:4K07wQ3u91pm7BeYFm+k1CQ/qxzoDDzAwW/6USJCJeqebFnJXEKVaLKmKTi0uj2WGHu0htVUDrUJYa5YBOZ/Wcw7TPNa4amnPXhIaSrDvLGI+yaSCBv5OpQfW2we1mbGuZNtnYiMxSOnMJ46xpDW2ZtM57Qz5qXEnYc7oI+RozhcW0f0d5+pij8ED0+YbAPl+SwwBlmHRplRVNTsnPmsOk+Vf3UUD1upKDn+nWSx1ivSBeyDFazljC+YwTXPWm9bdluphQORs5RJJmtHp5Jy8rn2a2LAh4OGWfwPhDe8pLu5PZzol2Pv6qTy25BzJh1OTiUBjSVFdrNbGVCv24yUuAWBot+J9BzFyA7l6tf+orfYI0gzSsdRaqCcvZ/L2fdoG9djFpdphccbZS5PIycvRKvdQ4uAkuO+kl1Le7kfIH6cDoZwfEB0iY3gHtDTSdoa1LyEVI1TtdzWgaur1NaPKg==;5:yepM8iMm/n4zA/vAX/MylcSInSq1PBeQ6oZjD+CBtesHYRTRfLqfZH+6QXnVelMtMstZW6ed2oIAMr1+EnEQY/FXpAx+NMIrkKeUuYAYuH09//+xcHNHv612jw74C8iuKSp80WrrQyTFEd/4f7GdOu7KuBNZJ4OTHG4VBwi9kHs=;7:mr/irklh4ts6gkY27XFgOWcQhgHSwg5pn8bRvGKdFgMFtF8diHMHfvcPKiVuKbBEY0+S0aH0+rs+XxDZMlXX0CGzacab1x1+Wg1RnCtgLuLtj/HwCzmjxz52DUMpI34wJ4aLm08GzGQqBTPb/CaSEzlDepBBlJY6tBgw9foYLKxhXdY/tza9yTcWAjj0FZe6LtH5mZ5rYeMI2aIGzSS54ayP8f8IWFowehvdjtAf91viKW65mz/Ph0jAfVn6l0Gr
x-ms-office365-filtering-correlation-id: 707d51aa-9af7-4260-9517-08d638c5826b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4367;
x-ms-traffictypediagnostic: VI1PR04MB4367:
x-microsoft-antispam-prvs: <VI1PR04MB436729B7C529F7196705A27399F50@VI1PR04MB4367.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4367;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4367;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(2906002)(7736002)(52116002)(66066001)(71200400001)(71190400001)(76176011)(186003)(305945005)(3846002)(54906003)(6116002)(110136005)(2501003)(217873002)(14454004)(8936002)(68736007)(316002)(2616005)(7416002)(105586002)(476003)(11346002)(25786009)(53936002)(446003)(6512007)(5250100002)(2900100001)(97736004)(486006)(39060400002)(102836004)(36756003)(81156014)(478600001)(55236004)(81166006)(6486002)(8676002)(106356001)(6506007)(386003)(5660300001)(2201001)(4326008)(26005)(99286004)(86362001)(6436002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4367;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DxMHnH6ehpHm7qUs9xnfni/d1L1LyUHqOtbW2xbB5vRCA37TwZkOqiMWfFnIA4nXPO6qctGzmDQFAYBWS+iAtU+eMW2Sz7OjruMaWoXpXqAgRmeIq2ZH5XdsL56WJTBEEzKNzJLffI2yblAY7QPvJMfVX5JMEG2OpXwXrkaN5UBygaOaSoJwzUYCMs0ksOz54GZJGKkBBPRYaTTgr3ac1abmewQz5pLqGpbbMPqrF5ZpGtWUtoeYx9FsjAgB3Tu9HfUS1oeytHMyQJd0463qaaue/MiUYptj9h+8fDiteNz5J9U3CbJVhOkiUJp3WSa8CfN4RILRwH+559JHJo8u1HEc/jM7eImRM6fdJGCgDoU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707d51aa-9af7-4260-9517-08d638c5826b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:57:07.6022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3cfa8ca..75ceddf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -335,6 +335,7 @@ CONFIG_SPI_QUP=3Dy
 CONFIG_SPI_ROCKCHIP=3Dy
 CONFIG_SPI_S3C64XX=3Dy
 CONFIG_SPI_SPIDEV=3Dm
+CONFIG_SPI_NXP_FLEXSPI=3Dy
 CONFIG_SPMI=3Dy
 CONFIG_PINCTRL_IPQ8074=3Dy
 CONFIG_PINCTRL_SINGLE=3Dy
--=20
2.7.4

