Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4693FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A99B206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="t/gFCx/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeLQLpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:45:02 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7554 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbeLQLpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:45:02 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="21592561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 04:45:01 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 04:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbz2GOZQE4QQflNgSpaCKYmCVQCKoRoabvhGxHv4P8w=;
 b=t/gFCx/tOMQR+s+oyGoqHudhcAaS5Adu3NTXYK3AF3LuDqBHZLHj/Aqc1mTqVvrSNcOTExx/+H1G2hVu44lEwLmp4s2XHR9P+ZEHfC4H2oAMtBLmFh1/zdmQHtaq0PIvQ+DNPQqE9W+hpg9B6abLqHYmLJOwgN0bwevdMZL4F30=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2145.namprd11.prod.outlook.com (10.174.112.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 11:44:59 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 11:44:59 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH] regulator: mcp16502: code cleanup
Thread-Topic: [PATCH] regulator: mcp16502: code cleanup
Thread-Index: AQHUlf3wmI/av2daFkCGO70rJ95l5g==
Date:   Mon, 17 Dec 2018 11:44:59 +0000
Message-ID: <1545047086-30286-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::49) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2145;6:xntV2BUJcm2PrEDXjmzLwpnGBAmQTmVA8GiHKJkLtOJpuxdtEnCjxLlYH6y9eWCiz0DBm4HeVcT4oRxnf1BOmfyeSb7Uj3682YCU4Jti+RM1RjjDtKSZHb/XenYdLOTiCcWJvfz/hu49L/MHN74aecNUWXYJ6eYvIYc/uv4HjzITwPRacVSMrw+pHxEgtiiMdm3lHj1jVGardCzazELxRdmZkdUzLpgCzgy7W3RCN90dFgikjctOJTnF64Mp5U4011u6DCCztTtnBB2LCIFKvNZFiFOg2irIL6ZHWg7mTR2y+f1cOlsyoUkKvflWD+roNV6ktlvEFVOkU/Aw1jnrJnAynczXOBVf6NInrC08yvUVnKwoJzqkut33JXs29NvnkCJ77F3r56k8RyQoIwsZc7mzxqV2PBcQ4JHMsF1nfSwql1OrYZsbAb7AbXhlvHLY/Q8++ElLZHh0enKC4+kIiw==;5:GOjK81VEFx62oFt4lh1eX2kMpTYUC44kLKOXHyXmCmNVfZ0srKZBPzXh1Yq9SWeri5RstMpTqYFxdBCt5Gw5fHuFNI8JB5PvM+FwgDblSnfhcj6cz/YrdTg3ALevs7p5q/M1JLPj6QBZsBkjgoVzi6cxeOpWIN5IejG0/4ebdyQ=;7:yD1NBs/ety7TAzDhYY2lWwhdLaoDZJQan4BVcSvudRSvhnaYKWSOjWwCYEVnul7i1a5KKF1ZXBtMMUcsbKhJ0EiNeMpj9M+TWC8StYIe5bZ8niQSmqu/6g9zRhA8zLGJ92LQVF1seRmQi61TS7cfVA==
x-ms-office365-filtering-correlation-id: 4d8978e1-8d51-456b-8f5d-08d66415128b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2145;
x-ms-traffictypediagnostic: BN6PR1101MB2145:
x-microsoft-antispam-prvs: <BN6PR1101MB2145014475658603461C94F8EDBC0@BN6PR1101MB2145.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2145;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(305945005)(6512007)(72206003)(71190400001)(81166006)(71200400001)(81156014)(6486002)(66066001)(8676002)(36756003)(4326008)(25786009)(86362001)(7736002)(14454004)(106356001)(478600001)(97736004)(3846002)(107886003)(186003)(2616005)(486006)(2906002)(316002)(54906003)(6116002)(105586002)(8936002)(52116002)(5660300001)(68736007)(6436002)(256004)(99286004)(26005)(14444005)(39060400002)(110136005)(102836004)(2501003)(476003)(6506007)(53936002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2145;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0cVF7sMc1ktwMJBUoOCcauyprv/S34C6cqZIeBrgqxTO6JIssHihaM7kPCfSrSXbVhtjiYOF3X5rvKam8PA5uW73LTWQFnIRw4W4aGXIW2B6SjPBfutdnJvW666pEUTaO3eidzQL8F1kbuU7cfVhARNRQ+xlpIVCloXzHxscpA8w28ahrtkf/ALoT9dGqq6VoDjQXTY1XmP4xn5QLEZm32vhxTiDerd6fYYYSDQ3PeBu7/p2knQWWQL7J0h6PaYBvZ2c07bMK1anEwQfiLrKdjOcyI1BK1JvcpKc4o1cccdl2x+DaCW+C0+kD+ISFd6r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8978e1-8d51-456b-8f5d-08d66415128b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 11:44:59.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does the following:
- align parameter with parenthesis
- fix compile error

If CONFIG_SUSPEND is not set the dummy pm_ops
callbacks are named mcp16502_suspend and mcp16502_resume
instead of mcp16502_suspend_noirq and mcp16502_resume_noirq.

Excerpt from compile log (kbuild test robot):

In file included from include/linux/device.h:23:0,
from include/linux/gpio/driver.h:5,
from include/asm-generic/gpio.h:13,
from include/linux/gpio.h:62,
from drivers/regulator/mcp16502.c:11:

>> drivers/regulator/mcp16502.c:527:32: error: 'mcp16502_suspend_noirq'
undeclared here (not in a function); did you mean 'mcp16502_suspend'?
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend_noirq,

>> drivers/regulator/mcp16502.c:528:10: error: 'mcp16502_resume_noirq'
undeclared here (not in a function); did you mean 'mcp16502_suspend_noirq'?
mcp16502_resume_noirq)

vim +527 drivers/regulator/mcp16502.c

524
525	#ifdef CONFIG_PM
526	static const struct dev_pm_ops mcp16502_pm_ops =3D {
> 527		SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend_noirq,
> 528					     mcp16502_resume_noirq)
529	};
530	#endif
531	static const struct i2c_device_id mcp16502_i2c_id[] =3D {
532		{ "mcp16502", 0 },
533		{ }
534	};
535	MODULE_DEVICE_TABLE(i2c, mcp16502_i2c_id);
536

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/mcp16502.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 25d7b43..809a664 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -518,14 +518,14 @@ static int mcp16502_resume_noirq(struct device *dev)
 	return 0;
 }
 #else /* !CONFIG_SUSPEND */
-#define mcp16502_suspend NULL
-#define mcp16502_resume NULL
+#define mcp16502_suspend_noirq NULL
+#define mcp16502_resume_noirq NULL
 #endif /* !CONFIG_SUSPEND */
=20
 #ifdef CONFIG_PM
 static const struct dev_pm_ops mcp16502_pm_ops =3D {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend_noirq,
-				     mcp16502_resume_noirq)
+				      mcp16502_resume_noirq)
 };
 #endif
 static const struct i2c_device_id mcp16502_i2c_id[] =3D {
--=20
2.7.4

