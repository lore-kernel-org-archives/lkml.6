Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73C9C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2BB219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KI9Hgkh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2BB219CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeHFHvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:51:39 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:59008
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeHFHvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH1kmlsUUsWKgug7gj5SrI4vrRxjWn09MBKRa7iRrKI=;
 b=KI9Hgkh24WXcjjTmJ6ZDgBas1Cq5+HhSgR3XnvEydNJGwE9eAiO+F83Uh7hBxa+HFnI8S0YQ3idT7Sr58cR27vmyZSbRtjwIDEB8TUGks5Q9lkwzjWHQvwwsvT4x1YVZCjr1I9EhpAm5J2dCUsUPkOhjBgrYBlbYR1G+kdf68Fk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.17; Mon, 6 Aug
 2018 05:44:07 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx7s: remove snvs_poweroff node
Date:   Mon,  6 Aug 2018 13:40:05 +0800
Message-Id: <1533534005-18736-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:36::17) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5beead0b-3936-48c5-93d6-08d5fb5fa251
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:kgxlKzcX1ChVmtftfGcGP3n2HHRYlcucPxtNwJ4wsZg2gUbIlxY6ZPu+WpTmbaVZOkq8ol60mfORU+Ollq6tyRfX7h1Q56ktvU9oiH849V+daVx5AeMC3RgdGMKi/P2+B96nIMcCFK2NPU2iO7I9/GLAwceOnDiHT/Wk9SndoluQsEPT9md4MIpk5mA2/8XjaKFlcwjUKHA4Jwls1y52iTobbDNW6B6cZBNTPHhLADJ8ohHqvpECoPlFtQEgcCIA;25:+NPVmHRdzGehybKPo6ZH7YkVTmJIKi7bpmL+csRni2y+ByZ1KmpIlo1WETdGLW2cq19QL/6qDUnOKH26jmKsEeOVqhI04/aysTyn446Ul+1pxf+GmEq9+0kjqO0MOC7dCJgS7/sbmd75rUxlsL/Ee9g512mHioBHcfJfVweM3n2XCb2XfUZKFO4W4q0Dhf2yUgaIBkGiVDTRibv1+EoMU9JZj6mgmt/LYJgAdi58sPkByQfKe92MJGVs93U7Ivo2m7UEd8vrdbiDaT9y4ofswqJY79U7RCVDNA3/LMotv7uojMfKxpOX2bjZSZzZSZOvCYEYJmaNFDEWT0LHznaurA==;31:gwXgZ9r0G3O7Ac2dYfG2sS1ipgptVRD5jvHZd/CZOBgVYZ1+DUDO+7UgbwEHGwVJpOU1Ba09gi+qc4E+taDv94XpvdJJCt9PfhKufkw9DftbM8etYbzKATSABogZ+NRrmR6LWy8W/Y9PbYwGH6gmZ23R5YdjjC1OF/llNpX3on4f9KntQIT8CuofcrbXPXMxlNuJwcXL0YN7t3aQwdUUSPzIDZPgDRbJdCa8veIdtHQ=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:ltxXDVcAjqWJTwKXcT45WsEROp4Q3Sg9pxmEqZFG7kDjjUeZbtJjklTlVUPnEznh6qTbH+/wcTgECGovwVSLsImcWuIEKkwsbxZVD/QCCFFv4ate4xy0WFruNF8i6eLTGlgyKotWXEIV/2F7hqBTFNQTMEnMcRA+8dj8TpO4cVspkppReiDCBtavygPn1hhg+cZ3N6VqBAG0T9aBaJb9s1UYgQ9KqYNmybgYlPnsTuTxf/mABKcVMi2Cq1nKaa1XOuMJK1rbRlrHhuvMoB4egZDPAoRMwVBVWIeS/VzTfstl1+kpmMImn94xY/aZ0Ebwt+9YbJ4BphhdMHYWPbZsbcP3g1Fr2fRGnj4RpinQQhtn9+8lCD8cHACZ6RzguTykb8wwn1heJn7b6Uqu9KAhdcRDzKfaA3OeXVYpL7k/hWH52SoYSr1w+iztCnoZEdWeg6sbRuHWHhUoeHIm6bXw7Yx08S469AYpiWxOlOVZ5X2yxL20gMz1hGnER02BSMI6;4:0DsszjSvnvJ2JLTWO76t46MFiBD5grGqqsH5Y3ASDgcnFDzypP7pIKzpDWr0rEo2RzECKGAS6E/ViSGeWEyl/ihMUWPd8y7VZNoNGRL1wMQvD06IuQJZg8NSBwDMD2m3YKFsZQg/5tdPVlpcAzOrNxDh35bid7xZyURQMnbSZygO0npRRNhniGYfPXiQo3eNmLUzicu0pHom20h9sCZYqeCR0F8vRtv7ng5QC6uTTcKonbMowBYUqTwikSK7AmyYNJHkPYu1yvXUAUhRkcdQeLtvsauEB1YlFSwhWD5Gw7w3yN5GdNfcgdbAU0EtIVE+
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315F3B882908FECAA99520CF5200@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(5660300001)(316002)(6486002)(16586007)(36756003)(53936002)(7736002)(6512007)(25786009)(97736004)(305945005)(4326008)(106356001)(105586002)(486006)(956004)(476003)(47776003)(8676002)(1857600001)(48376002)(50466002)(66066001)(81166006)(81156014)(8936002)(50226002)(2906002)(86362001)(52116002)(68736007)(26005)(478600001)(6116002)(386003)(6506007)(51416003)(186003)(16526019)(3846002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:iMAiTXLHY8vlwpWXZFHtO0NcBKaC8ns/j+wT8eUGx?=
 =?us-ascii?Q?HaxMCjvmsy23P/xdhoZj90yYYvcH7AwX6qR3HetZ56fiiRoxn1c0eyIuMja0?=
 =?us-ascii?Q?bgn7vIIauFC6mQPqlBSIHWWI06meZquZU2llCqU2qtALOO6tFIaubrv1SrpU?=
 =?us-ascii?Q?ggOlCIPA7FWLFlGym+ZKvGSVbjpLAYIhoT5HH5O7KjjDaciSAV6jRept2vlD?=
 =?us-ascii?Q?BdtwMNrpPzwNYD1kwyxxi49fWi/OfjLRIQeB29oswCPZo+buvjVQDU6tE9wz?=
 =?us-ascii?Q?yJIzAacar3DdGUJckt6HaX6hYGHwm7FPEA8zNu9QVpG8KSKTRfvMgUL5dlJ+?=
 =?us-ascii?Q?TqpxT/ESGsaLmrAXPQ6/iZny77bFLaY1vDqK1/e2XtVbMBfvBUq9cSvS2m8T?=
 =?us-ascii?Q?gJD9zB0Y/kVK66M1MR9ydL3tp6LRMXEagDP9dJb8Py7d3kjQh2Q6DoAQEWbc?=
 =?us-ascii?Q?N12/BMWM08o69OH7KpkMH+uy/W1CClYjpdllsu36m55fTl8btjeQt7Mo5TY4?=
 =?us-ascii?Q?5HJ2fNNDpwpqKJ0F4y5M+f/vskuR2kw9cFCL/ojDOoqQE20ViMPoS78gn5jq?=
 =?us-ascii?Q?AMVDdMSu7wpF7QBiPdVRWoWpW7LkE1pBO8EkPSpJOAS0svrG2iKL4WGRbsVV?=
 =?us-ascii?Q?KjG/PpiELPixZ6c4suB4QdUWj2zHbKVFf4m3vrGQfJic3yAUPpVgVjqRpGwD?=
 =?us-ascii?Q?8Sc73cRo0nvxFnvr27+JXdN4Q0lbGDE0/4MvQkEkgzOqpleDAUS9g0LS+dwf?=
 =?us-ascii?Q?5ptZiZZbwh+0+TjRuaiTjrTamaW6Vl0UsB7NPI3HDZpxWN/pTtNNeqgww+GL?=
 =?us-ascii?Q?yxdfMjtT6V4I40TJKPVKQ2MdpzqNXrcHK35UWAdCkxf/PQbcxj6wFR8eL0Mr?=
 =?us-ascii?Q?0YENNYR41IpqgO6jKjvmkus4fXPf56SBfE1U0sESprVnvOUn5u2Evj3D8Lsz?=
 =?us-ascii?Q?tAh4KfWk+bA9lfDS6UIueUveZczZ3nYgrOp3j2X1zVdQezdWgN4vYgD2RHJp?=
 =?us-ascii?Q?z7u9Z3toevHI5HyBBQKJRYWQWlo2Gq2BTn6Sg6Q9ysL6UU+Nfvc5vc17Yre6?=
 =?us-ascii?Q?HVwUQah1d4K6SmyCtXHSH7MK0ZyMTJSmYb3vhczOeforqh2Kw=3D=3D?=
X-Microsoft-Antispam-Message-Info: feZ9EV4NLTWS6PgtvlIRwccnk0lwE3BmPzCxVlkShoEB72iymD7Hr0euAzzS0nP/Zo4BYPFsBqTog+edp0UrWeCIZ5NzaTbAZ0pxQm0yUnB3K8aRoc3dukPJ5bO1fV5TiK9F0IdBOYCYZMoOB3m+qDzFVuoInGC9wqxp8B+sgCMGTiNWNarTeqRwDDF1+DwAfHAFNt2jH0ShIphw/sGPal1CuTVTh3Fpm2kwaB9N0+qlMwJtdkkjgBsw/Dmd47eU6azv3Ac7t0VySvH5dqB4X2daSkyHsYa2Ffa0C7rr2XD+fTzyA0Er3EU5giPKZSeerl0OC8JTp/gemVtgKnO1cBlTvL5Z9gY9iWww5PgKA7k=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:jdwDcSU+gqnM0KwhzKHcvL9mvNobgPf1YFN//hWRmDphVOtYD3y5b+SuzLE9AYvDnblNEuCgXgPas5XCVlxiGpnMhO+Qdm9EawBd4R+451p39jDZNVQHDBRypR0Mk0FpZzc3g7ZNGB+gC5sgNJGSWSIj0fu9DmgkvbzrD+aiJhLm8kG4YXmXlvPyp5ewrPMV8BTJBQVWlL2j0kEpUbVBOjAb5QXYEO3yDiaE7PJhJHSFX/pgF1Ng5I7icuA54J+EiDJCgH0CPKFzzHX0ksJR5of682Y5tG74Qi3T8spTdSK53JwPAekmckYPNFKXWjsjgejJUmzaFiJlO3kksCzCTynamdmbVso6blGUnhG7FJVr/jOFV4Eru+v8N1WuIz38yFwYKobAjNc3OmvMcQzK7vsrwNDmpM4zKL7E74y8WliLK/KF/yCvnFd8yAFs5NDsE9cQFoCs2oKi37O1IuNngQ==;5:YLtTycRG+0dpXzixzHm5Q7+2XfmkxsGZPnHTNlN7oeUb1ZZkdGGIdxxD7SWLE7P3v0w/DjOmgbOiRSTk5lR9dYUQUhXJUYHCr73vqfEHy7FpbBrneGwAamTZJ5UwIPeRVg2C8i04Bt5Pqa3ju2Io038WREsohZ7Rb5P4uGTrC2c=;7:8hHKvoPmksvcE2tTtDID0RE1DL8XDPZbZ3pFIey1XrTUCk5OOhK9KNeUrBFvCDTZ0maqL+bxs8yqVShLKxBySfrxZtEB0i73EMgQUG1KaOpSjE1kYVYyplVOqxqGyyln4RgaMPZv+hPoypOShWwpxGeu3IohApPNnbOm1aCKM1H+D/3/sU6tlfwTGqX4IYKFxMKWqnM1wz7omyvCQHytcQ+a3ALsrL76yVbk0BOTFYMrPIX2/yZCmbnY5AGXXZoD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 05:44:07.6317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beead0b-3936-48c5-93d6-08d5fb5fa251
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System poweroff is already supported by PSCI on i.MX7D,
remove "snvs_poweroff" node to avoid below debug message
from syscon-poweroff driver:

[    1.831414] syscon-poweroff 30370000.snvs:snvs-poweroff: pm_power_off already claimed (ptrval) psci_sys_poweroff
[    1.841707] syscon-poweroff: probe of 30370000.snvs:snvs-poweroff failed with error -16

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198..a072e7f 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -563,14 +563,6 @@
 					clock-names = "snvs-rtc";
 				};
 
-				snvs_poweroff: snvs-poweroff {
-					compatible = "syscon-poweroff";
-					regmap = <&snvs>;
-					offset = <0x38>;
-					value = <0x60>;
-					mask = <0x60>;
-				};
-
 				snvs_pwrkey: snvs-powerkey {
 					compatible = "fsl,sec-v4.0-pwrkey";
 					regmap = <&snvs>;
-- 
2.7.4

