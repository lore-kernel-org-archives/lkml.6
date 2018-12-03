Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B6BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0FE20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wk8yCgzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0FE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbeLCCpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:45:17 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:16853
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbeLCCpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgnKrEbtHZ/kdCP9oMRJ+9RiYo/9XXKSKqFhAleLYHA=;
 b=wk8yCgzEdicWvVdLO3LGtSOHbdzkzF7SlVrtiSWdZRvIM/Kd93jSQ1LXEyq/5s2/VkOH9NwmN2GwNwoiFTQ2AgsomfaaKV+e+P4SY9EYNE4HYt4kGzlVyW0ucGgorCBWOwj9gN3LhSiEMKY/OtRCufAs3yrf93QjPsQVjC6f4h0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 02:45:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 02:45:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: imx: update the cpu power up timing setting
Thread-Topic: [PATCH] ARM: imx: update the cpu power up timing setting
Thread-Index: AQHUirI0UtO9K47MFUWyoWpC6YVNRA==
Date:   Mon, 3 Dec 2018 02:45:09 +0000
Message-ID: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3721;6:EWuwsPB63pCBxGWc0eY6YM2Jg+8iZPZoglwLXEbMl6zwcy4aVoD8XJfc3ss2/LBmagZkxfpWG8lEwIbVAU0Mcp4SGGCC4ZE0oDZlT8VAaPb+91jQjNd0I6GdIG9EbFSVc7aykESWlKVKqowkHRkA+U2p9iQloTUBx0aDMtUbUqHbrWQt6BuIVSDQrAdqRLzAYsBdokt8coQhQgC9Lr7DWdln19H04lLnGaqEKBqYKirL/Z2aoqvwb4Lj77J9yZMiSd4YV8T8yKepyNUheGPiihXtDCEeR0Me7amVD5Ezvb/q0YZErHB+jt5qr12e5SEJyYgAmMUQblIA2a9IUJQnmzD/pjPGhqg4MaCKHujeKpIxEbI3SndjGd+JZHFK93fbmI/tYMVCKbMLfpwJUxZ6WHCm+besCTEduG2g6Jrrq9iOmwIjaZdU45w/KaVmL9M5QTl3T3YsMzaYQc0EAEGaUA==;5:gc++zmeNgsAQLV+MQI30kQnFrZJ82JApZe2fUvnMUbDHa+4n69RfwoNhWJaqDaYAdppUYx+1kPKwth5PXgBxu+EtwBSiUqmJ0qMcaBeyISko62MEYXSYV6wzSck1vgSEt/ZxreqFeusrjLXz1y+nvlTnr7VmzdZJRv4ScaI2nKE=;7:hUGK1rjA4uCucxJ76+/7D5gah/vs6wteJylboUXlIVW6tf5um96gUBojbbYnz7l9EJIfp4MBhs/yB1weuj6a0tQX2A77wdjOaGC6JOqKxrBcIZBjEFOjMh8tEBhtynKAtHL73fbGXWo/uO3Frp919A==
x-ms-office365-filtering-correlation-id: d3e31897-adc8-4274-c363-08d658c9567a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB372137E001B1562723FD7A48F5AE0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501493)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3721;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3721;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(6506007)(476003)(2616005)(110136005)(14454004)(97736004)(105586002)(486006)(386003)(478600001)(5660300001)(4326008)(7736002)(316002)(2501003)(66066001)(106356001)(71200400001)(71190400001)(2906002)(8936002)(68736007)(6436002)(3846002)(6116002)(26005)(186003)(50226002)(36756003)(6486002)(6512007)(53936002)(86362001)(2201001)(14444005)(256004)(25786009)(52116002)(99286004)(102836004)(305945005)(81156014)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KMUpYDJKOXrCXzeC3KbT+0xfraHsJ23QMf1TgXq5jEfTlTwzD1AagVipq6KAuVsu3QfJIlud9kZyKY8q70QLYZV7L6/PmRS56YD0pgseDrj/4gf+On3W+gJSKHqWNreoFWQAbwjI8IbCOIiV0IfwWxbxIftNsGoh6gwUXV2aCkGtwUPsFF5vOvG01tuaDR3hwFi5FAAc+0tARP3/iQD1Ch7hLBiHUjUoTvzg5Ew2MTR+tzEMcLz6Hl+HGTJJ9Q4mGlegsRamAfIV2h9u2P8IDjT4ZoDS+u7dRdbCcY4uHngQTbRAWL+0+TJqOLbiFGHf1P/l+n0EJr+sFkzH+0AOpr4flwS7ygi9isTxMr48vgE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e31897-adc8-4274-c363-08d658c9567a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 02:45:09.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sw2iso count should cover ARM LDO ramp-up time,
the MAX ARM LDO ramp-up time may be up to more than
100us on some boards, this patch sets sw2iso to 0xf
(~384us) which is the reset value, and it is much
more safe to cover different boards, since we have
observed that some customer boards failed with current
setting of 0x2.

Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6s=
x")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle=
-imx6sx.c
index 243a108..fd0053e 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -110,7 +110,7 @@ int __init imx6sx_cpuidle_init(void)
 	 * except for power up sw2iso which need to be
 	 * larger than LDO ramp up time.
 	 */
-	imx_gpc_set_arm_power_up_timing(2, 1);
+	imx_gpc_set_arm_power_up_timing(0xf, 1);
 	imx_gpc_set_arm_power_down_timing(1, 1);
=20
 	return cpuidle_register(&imx6sx_cpuidle_driver, NULL);
--=20
2.7.4

