Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2309C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649352086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DaAH2jaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649352086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeH2JAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:00:09 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:38631
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbeH2JAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQVZmfkLTJiMHJeMSXKLFfkEY12ik0TxmHWt0ClUDoU=;
 b=DaAH2jaRFlxNn5lMyh71c81xdsSX2ZqBFdOjE7XFJ15INqqIVDRfeYuWru7mszqCjXbz9LkLl9h0uj8siAgEoNCD5KBVJ4NCfifXk9XrRokpxO3f/mc19RW3W9gLO9Zninthw6GGWmjyvfB4OjYT74zOg2shoA/F5faFpBAGEdw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 05:04:58 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] ARM: dts: imx7s: enable cpuidle driver
Date:   Wed, 29 Aug 2018 13:00:46 +0800
Message-Id: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To AM6PR0402MB3909.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9344c8-a7c9-4e41-5445-08d60d6cf9f6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:VovRm8LaNTj1bytlhfWizwj/QqLHN4Wp9HoX5FgzVGEiI157sxuhujy89CJjFp9F09KeoyYHWtLH+nu4oNuTgLtouAwkNJLvVM0ZSfy4f1kvm/PJTSQABX1SM+CdK87uzZflGtI8ND52aP98nE7NRYOsx+TAtvL+HmC0yk3z9PSStEQXW2Ab1rlUqS14ClyP3kQogMs9sVN1hOUK/k0ANFNo/VJ28XZOPHBscDBUr6lh89ar1qrLr/RY2+CIq6Ue;25:rq742ZkaocREw4VGoh8JevFZDOozXKIrI8q+2rw65IgZRc8uNCEAAbfFJTfO7oMb/HrwRUeiGDQAxjUtKJxr7cVFvIaT7Zwhl0Q++LL4qJ5xnhIIsF6BB4zmLypbh6if0BZzEibzMxaXhG9lq0qS3IUJ8pBs+/dO/ZG96aX1tIa6Ykp++9AOHHDUhQKaTZ5p6SzlMvvDVmW2JD4TRqbr5SeHVG7TfeJUMUR5NHq3k9VdD7LUxBtnD+1um2i6ywl8Vqzq8/ndH9vLX7Ip6KgvhVxMYJ/S3ROJc4EobGn4r0gjDqTsogNABk2xqa62UGX7keAhRVcpGo9yazh0XHp5bA==;31:Y4cZxDZU5BqdTv85kBObTrGzUccFSto6q4Yl+uZdcGB3jy/9ebYPzaCWYrlnl0i6WiwFiLXrPkpZFeL6pfBHuZeVW8vxLUT7s/aCpour9k4w2BnFit0YrhdSar6+NpyCn9C7KIYcwV/lLZy9GRScQnEcWcxElsGxG8jHvMhqK38vRmTnO7BOh4fnH5xSIig90a/Q/6txOyKR2Bhu1Sk2Qtw9ogvjS9JEagB9rr9dXlA=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:fjpTc8We+wvFm5Njt+PJ6RPz+ddkOpfS42yVUB7WeUmlQsxw+FbunVUUku3JLwjJImRFx95dslgbyLJ9Da2VliuVEkyydOgnt7ClqHz4aEx7+XpeB3b0bwsogP5UKW8zwLcUwv5E/pbOLRARuhRvfohgD2cSUxQkBfwH6MIgcQQoc+cLqH962EOnFMXMJ4EBVGnUOdEFOfdoOfMenUUYMutUK6mY40n1esHFB9ilqwC9VXrjM5t6js8sNedHEXPYPLzXIQbq3VFi30mjIsxaih3I6A/g06OplC3NHul2Ij3j1Hb1cL3p+pvUb7D17I7/Pl0RF6pWDJFKxodaKspRD9vzVK7wqnQQMul5E3p3r27+V3PxZB5nE8OKylyYJXpy/OBOmNJ8Qhxf/+10qwiFgmgfStFUXyjupbyswuFE/PH1rtJ1At+3bB8up/9ZQgb/WNEmytZEs2/5m8VJmgqcSHjqdTRt7ANPx57M3OB1veCgdIn8/9H6TrVY7N9AO1yT;4:ljhTObFxY4rnWUN7pxlcWIu2mqYrGFvtSthSu1rqXKk2d5zYB6RcXJqxyBFAdlWOQYXRgYkkvol81TfvHxakTUEZKlU23aI/Cta8g/zMN/3B6V5/iIqwKUPix0oOjbWkeqVrdQH9+r9Lzu7mPx2JPXw+wXygIXRMOpcjHYv5gFtTwJJQH5sVi6rW2e4anPkuFmbGrfaPf5pV+IWVD8kbm5eh8FucjDh0y91WdKi6+HhAsCqP7G3wlmcITbfxVoN0BC/pj7S0xgYOMDUqAnKkT+2YPex/y0XcMUjYrJ5ZZ3n3KwWSD9BXk5ciMCgbMabS
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3909AD383F52559BE2E6F873F5090@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(97736004)(66066001)(50466002)(36756003)(68736007)(48376002)(86362001)(105586002)(305945005)(47776003)(6486002)(7736002)(14444005)(106356001)(25786009)(956004)(2616005)(486006)(575784001)(476003)(5660300001)(50226002)(16586007)(81166006)(6666003)(8676002)(81156014)(6506007)(8936002)(53936002)(4326008)(26005)(386003)(52116002)(51416003)(186003)(6116002)(6512007)(3846002)(316002)(16526019)(2906002)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3909;23:kRKw+lt12WLGYasbWiraG+l4UCExBzg6Pn4x/X+?=
 =?us-ascii?Q?l8GdP89A1qH9wwpgz/jYjBz6Dpcs2IR41spMcEUe0krBpgG5TcaZvdWr+ZA5?=
 =?us-ascii?Q?kz7toydUb0rL9M/gW2t+M8acFvNwaNgfIRiYg5N9LfT/mGHJ34/qACnQL9FR?=
 =?us-ascii?Q?SFu8LCnJEYHen5Cy5kB58i5oD/TKGgEO0ejGv8r5UAZRqwjf1LGZ/XcuxwHO?=
 =?us-ascii?Q?X6IEHlaskmFyUX37rcFyK1s9SSyjVNHc4u41xKWr1fJ2dhIH44cF75z7gB4N?=
 =?us-ascii?Q?ZnY08TVVjV69Yyh/EimSNspT7d3F3g/4XguyaMfAy4jombAOq3rgsaSGgGEo?=
 =?us-ascii?Q?0qqiDoHK2xFaOnsUCgLCkJJjF1B1aciEvOi4tlSPFlACIh8ZjITv2TPwSALP?=
 =?us-ascii?Q?xax/aaYAsi922tqoSTZUgB5j2deNFOtFzdMISR8CeqtLjB9XidSEgt+d7E+B?=
 =?us-ascii?Q?iszHPmALGzcP0ITyNSLTy90uQdAoaZs3A7++FOonDl31WRiDIl262DOFeucB?=
 =?us-ascii?Q?+9brsobj8wmn9ktfR/zcmUctfBeEhwtLJ02AihTl6IwPfBy2AxdjG7mpeXfC?=
 =?us-ascii?Q?wPTQZ/atxr5OgwFS/taAO2ca4mnJKpAOUgguL5UZQLWp/vK57MabQ5ytP8b6?=
 =?us-ascii?Q?gyzErBK1PEFQDeP88+2tdsyqA9TyJrhaGn1Va9lfyvQD5Sapt+sg/Mt8yR1O?=
 =?us-ascii?Q?c9eZV/HGj4f4gJVRbix38PcbFJegTPJ/HSVyrTg3+WpLlYxkoBkc2HcYJcHv?=
 =?us-ascii?Q?XGRaCypS11oIdyXNbrvpMl3M7lulbU/9fhX8j32b0/k2CuklDeYN3t187el4?=
 =?us-ascii?Q?L9apg6vtpyPin91I0MLmSr/ei8b2hEOSHY+SdkxIcA9WfwBtKfAzYQDmOJWA?=
 =?us-ascii?Q?rbAi/km32S+0oidE3GUAAv7wrwBh+ghb0Dm/br0cacOb2FgV/1WMO5xDq9aj?=
 =?us-ascii?Q?RmHg03Cxmp78CMei5ngZCdvzh1om1sAhCQPWhvPXSIbpXHBb9l6wn2YQuJFo?=
 =?us-ascii?Q?YQ89jVL1paOGFGRNcMV4y6KUpfPGpVcO5fPRhkDOxWVCwUZeV1ZPxZCZG7mQ?=
 =?us-ascii?Q?wmTvBvj1McytGq61TgTkexgRDBY77vIWuNHZN5+jce5S0fG6W7vRe7jeAIXI?=
 =?us-ascii?Q?7x77pJG2UU6v4uEAJslSqnEkTsk6bxdE/35d79R77ETGQs3UvO4uSwA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Q7u7UrGqHyhVFOLgD7ipvsUcfdj/k/ECGkqdbOcNTLY2hKw8GmmmP9EpgDQ1Ais8XdUdCOxf+DlzKLHiJMpD/tJZQUpgfUUw+rI8QFUmx7HGVym5P8raQBeBz3ScsrDeWl/1TMd9Vd+NI4OhLKBgumJwp62wlsAQ1CiWbpXybJkS0cyVEtWEqPerNN1i7zOWnbckAh86N0DztOsaNdvFKtSDpc1SYa2UEfuGIKgFmJ6qoaVpeNnR96X/FGzz5hd3ySPN4BxuzsIZcwVYEuUXjEUjUyioSdGJCycYEZ0gS9yv7QCCPBTzAC2GiMbd+alT/uTh5FUsVxxbhKr9pnfRbdnh3L0SiNrNcSennLJbXdU=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:TZVyeHlS9Zb+nQR/klHXTkX+MLXlSXtWVfBenQJDFjiqFacjYI26PhVuT8TPrBn41BsEaU5hDhqFRMHye6dBc1Az8i4jsVcaDabekTy0uWSbMDExOS6jbq3InTQHKeVLKW6bt3fbHVsYLvVzQ0Hh4AzUYdGdfRDqDXVvD5705yoWtjz5l9Utf6JwAw/1PmwQ/xQ7dZcKnAFxrF/6U4zvgYVV6lR2ff4P4/kdXO4y13UvJdPwXT1nrCNTLZ92psp+kJF5wxLm5zUyegXz+apa/YPi/DXdej4f4dKx3vUyCR7v14P3M909AOSFNxe3PJyQQgcSVhg6M33pnZtu8HuzTUVM5lDhrQCtIXWXu65SAum5mi8aUzzEvHf2Fevfwj7QEnL6A5/rF5iuSE7nzFgV/3Z4kMvaKjTHEAYJt3OoUciDylNzKwapouYWm3m3E+cPYbB31ted3o7hcDAZr3iTGg==;5:qmd9ttAPZ3xff4UCc2TP8/MFO4jXayzEg8/2T/HKkKgsdP7NxKfxb7M1nZhMfYb2+ajHCyQ/ZKgtTDh3c8oc+OtWJV8gRIfq8FL8ugaIv75snk5yEnDjwwdddjRpUkyjs5Knv0cEC/JBmMj0DqLqDFx95gkAOTvndcnHS8LKkho=;7:gFbp51LOMXSCiBFR3O5tI6EezC8sv128M61Cx8fZYDWZi3pPPpDn+JF2O+CwSFJXnVv0PZrxcjR9mAe9eonZoW5j1vzVrJ+/oQNXrIJZrTbT6osx0Doo3UAoZrz1298vY1HxXE8BHlEO0Pe51MUrxA7Exo3X7owsRw77N9cWLomiuWL88I3/+f9r+khrLxhcgaHYUVHfBCnUIihjMJVhj6hRTwz/6DICHmZwxQEID/XjcAUG+ecKZSpDys4oYrIK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 05:04:58.7859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9344c8-a7c9-4e41-5445-08d60d6cf9f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable cpuidle for i.MX7S/D using generic ARM cpuidle
driver, below 2 idle states enabled:

1. ARM WFI;
2. SoC WAIT mode.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi |  1 +
 arch/arm/boot/dts/imx7s.dtsi | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7cbc2ff..4d0d0f6 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -20,6 +20,7 @@
 			reg = <1>;
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 93884ce..cf5570b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -54,6 +54,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: WAIT {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <100>;
+				exit-latency-us = <50>;
+				min-residency-us = <1000>;
+			};
+		};
+
 		cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
@@ -61,6 +74,7 @@
 			clock-frequency = <792000000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX7D_CLK_ARM>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 	};
 
-- 
2.7.4

