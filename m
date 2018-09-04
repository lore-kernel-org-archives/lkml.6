Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D54C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286672075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="T2Zmfh7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286672075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeIDSju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:39:50 -0400
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:20608
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbeIDSjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5a21CWzqqsk/UceUyXPMrm5J1WWaMCPLaD42wWxSrc=;
 b=T2Zmfh7wZhvC8Nb43VF9csu83XnitrTOWhgMOH+3WLiTN9jIuFhx6ImlEXFpXs+rUiIy2W46a2ZSqU/mLv+E+NHBMBRoMsm9Gx8rk+j2mubPPa3hkhS+8txOOqZjQ1YZ+RJuLg8hhIa4GXONbBahQdxFYSjbQq+RHPR7OilTSu8=
Received: from MWHPR03CA0025.namprd03.prod.outlook.com (2603:10b6:301:3b::14)
 by BN3PR0301MB1218.namprd03.prod.outlook.com (2a01:111:e400:403d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Tue, 4 Sep
 2018 14:13:37 +0000
Received: from BN1AFFO11FD018.protection.gbl (2a01:111:f400:7c10::175) by
 MWHPR03CA0025.outlook.office365.com (2603:10b6:301:3b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1101.13 via Frontend Transport; Tue, 4 Sep 2018 14:13:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD018.mail.protection.outlook.com (10.58.52.78) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.11
 via Frontend Transport; Tue, 4 Sep 2018 14:13:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w84EDa2q028232
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 4 Sep 2018 07:13:36 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 4 Sep 2018
 10:13:35 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 3/3] dt-bindings: adxl372: Document the adxl372 I2C bindings
Date:   Tue, 4 Sep 2018 17:13:14 +0300
Message-ID: <1536070394-5679-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(305945005)(7636002)(47776003)(2906002)(6306002)(26005)(356003)(110136005)(54906003)(36756003)(8936002)(106466001)(16586007)(316002)(53416004)(6666003)(44832011)(4326008)(5660300001)(478600001)(7696005)(51416003)(72206003)(186003)(77096007)(107886003)(476003)(48376002)(8676002)(106002)(50226002)(966005)(2616005)(426003)(336012)(486006)(246002)(126002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB1218;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD018;1:4WU1wiZZezp6xMCvC93k4fpz4EUUu9aZ0Orgsm6GxAjWLlHQ4s8Aw6XWAumje/ekmMGDQ4Wkp7w/q/CfmwODiqNIg1r3ANkcuosKldjyPmPXtmI1xtgzMsNqIVk7p0As
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e11e35-0daf-4f6e-64df-08d612709b07
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN3PR0301MB1218;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;3:rybPHegKO3uaAbE/gTNOYVRQ7meKBsG3e4FaJdf9u7eMTyK0ixhox7+g3CwFHd21drSdLfdKggCW894XoQNsttQvTEzN0nzyXBBfJTYILAQNSQc45GsDZbbz9OADOHgpJSN+QLVvukCoi4VKbUg3rFv5EDSxXBcUUS6dmKdxnJRqPaKuJXfzOW0AyYT2Lzt87w370ikIv85R/zgSQS2NqV3d4sL4lLumsmXUuXpVdqkMBw4HUc8sK5fjRi61XiNh5ODUInYTAQlr/30M80iD1cu6gsf6Ovm1L3Ghq/PdTEj7DZfSJZALO9Coa8pvI3zVYzBvNvYoYdGpK4dvJ/9xO93hSe44bNd2VqJRMth+JfE=;25:3Wf33bFjstYEdBRuY2tZ0UKyTH0koZKNMM+35zH9pp7d7qDlz7JA5n9oxNO0ZYTQYTIsXaDcvsY+vFs2z21EeBlx3wjEGmNfrTQ3gTmpyKPSSvCJvSgH66uVNKVlsSMT+lIpzzYtjwFKOFRc8iuIEjV4C61e3+YVPD1Ah7f2KIczRjkfxBGKdQXMKScPykEkVo2FlEHXeQV4BhvqqK86zzpLk099kE6JDC9UFaHHAYBPG3HA5iMil3F5v050Znr9XjZELLqQ/Iv9qouGG4Gf9mD2mC5srctJG8nAJkm9mcnzUVyFoCqDDNc7Fte/vk87j2ky9IX4mHMR+/UOXUUBcw==
X-MS-TrafficTypeDiagnostic: BN3PR0301MB1218:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;31:7i6GiG+XGbMCM2tewHLM2Qt6rKzKO16D5kIrJi6fiHmJvSWBAvKBFKMtyTjo5dHcJozShRcMiiwKj1HdrnMf0nnA/wg62/AJ2TwYC8A3kyAlDtr6mBKEj9IWMgiDJwavpBx4b4KInaB4fGunftk0fd1t/n+jDMQfH2xrJUNzmCRpR/Ram2txUwKCNnryfOaz3xrhUuPLh9KsZp6CeK1z9D38AB9dr4kHcKpZFcpC5Uk=;20:c3LWXYmxnWAxErU/yfOJ5zjrzZ9ehxEKkqhG60/kHr1vNXCY2e5R+gRHB3nvpL4/cYNkuKx60m630h3eroKHO5m7VXk5XcfCL9t2GQsUuh2xjNwZTdhsa8FgwBvqlaJsnA0CNcESqZzs2Tt4oUQ/Mdx5OB9Vr4pv8gq8j+mhgFWaYxEdkYox51upA1FLuGRzYsbC8wlNBxonEq894RaKLMmveDnzy1XedWOp9yJ3hxM0x7RPN+5tfl07t5b/j4P806H7Tp9t/9KJmfG3E9JqRGgDf7GgWLTqhLHnkgi0osVkpvRYVLZkkfyElFf6jjpiFUDZsTZu8scJ0C5hg/2O41l0eaqU+qTcRkUoTkn8H9Pu29OE11+0emcZBVpytJ/hCZzEVxJw0txGDJ+OQnK0qiVCo7kwxDaCX6zjFdZ+zpk28wDVzVQsw9ZL8RYeDuR/JaUuiHNotcVRzU5w1iBNX7kWIuadTQCrTTrcSPM0NTAfwuORO9+5J/PRsTE+3HlY
X-Microsoft-Antispam-PRVS: <BN3PR0301MB1218DDB88D111727B2778F6D9D030@BN3PR0301MB1218.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN3PR0301MB1218;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0301MB1218;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;4:o97v6AlxEq/V/Y9a8Ss8EU7buzyWkoSC9hRWOGg6BcfoR2rdZnO1uu19b97SyezSrZ6gs+NY/ev4UTJbrmgzmeX9loQOZaYVylES9BksEoUnyXdBsnT0RoaDiXsJga4pFtKYqIEzf8FTcqiTz2AJwhuz5V9CTtv4FAP4TQDVrNDXzzoUkWx6Cs5FeYDyYNFfxCQ8NucdQLBujkCgb1rfO4Tcr/ShOhqj3r5rt9eePlXfHSqPUCHQr0HpOPNQXFLyw1s8GzyKkfVasKXvgZYX96VuP/RcKMhRF3QJ89oIat7M7wRYP+va0lPBlckpVkWVU59EDnUg/LO7ap5v9oxIBUBxi+tW1TkzQ7KQ28LdGn8=
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0301MB1218;23:9lDfv/KMB0griIjTpcjUIb3nXWYBLiDnfct2aqA?=
 =?us-ascii?Q?SRtCsqHTFrsS1Kif+2rBk0291KD9kykuSD8ZLFf7ilK6xdU/achvclq2GtaN?=
 =?us-ascii?Q?IfoAOiiX6MQiALglOPB8ls7r5FKe1lW7OqdjJqmLgqD9X+1NOlxD/lZIWmJK?=
 =?us-ascii?Q?8Lv85e8sCrYc28DQLkOExtif4ljyvul9wbC1NdDMV08nLVTOBCYSRrapCWwL?=
 =?us-ascii?Q?mE1AFMm/n8vEDCq0UCinZVWpNt9W+QaclAsgxpSJV6Nq4wr2snTJXibHhuSm?=
 =?us-ascii?Q?qJ2jxSqnZ3GKF4iDY9lZw7bxEKCzxkY8C0LoAeyIko15iA0NLQeWSet7jjzz?=
 =?us-ascii?Q?/qYv7PiiI0GBS7JLvWHaP80mwNndyCo8q6EzlSBxFLcC1bzurV1Ze28X5g68?=
 =?us-ascii?Q?/g3Z7OusthZMDIwMGK4vfUHHh9wP7vVGb7HIIWdNEsuU5biHTRrvApW6b9Qm?=
 =?us-ascii?Q?uVGj9+vrOil7/bzaxGWHc6PrAWrF0tuJYeSi+yzbx9IdiOMkyAt4Vfhujs6U?=
 =?us-ascii?Q?x/Yji83kHoFaoH0yJGtDRQDQDwyHJnZ198fJ34D/67c/rqbKqKDTuAJhb6Z7?=
 =?us-ascii?Q?sZOwz5GhX6ehvZo7FabN2213NqccgDbXKS5e/3JWoI/GhDo/cEWlib/rNppm?=
 =?us-ascii?Q?8wlMvl265RhHr6XRurJHuh+7YVgjSXmjCI+aWcAvFnBLJsRYEip1iHYfCFwI?=
 =?us-ascii?Q?jqKGZp6xylSjvfZY2eD4583BIJ5Rx4UFYcbH8z2QaXtuMzGkB2gNBZ6fdNMY?=
 =?us-ascii?Q?uv1zT8eEs+z1mfstwLvAO/mA44jPSKoRzVx+UyFh+QXSku3B9tV5bRf6iNgE?=
 =?us-ascii?Q?H5ge4YaiU/4GDF27HHTWfh3FysI/KyZD3x2PDlL5ffs1WPcf7OBKsHajWLJr?=
 =?us-ascii?Q?UhaBEuuUsp0Qsqlo+nXf6yVvP7XTm7X0k0hzLF8L3iPEbS8ZZ4F7rSgFwecJ?=
 =?us-ascii?Q?WsyV111LGhGcJRtWOpMVKlxPdwFmux2pfT/lEf4j75EVtNejLs+TGtrfoFlR?=
 =?us-ascii?Q?Vge+PnvtPSWWvvOxkVPV4z0UsUG3L9sWXgnhFrztFI5awmuJgDhnIiWlqXL+?=
 =?us-ascii?Q?QuETZ1SI=3D?=
X-Microsoft-Antispam-Message-Info: 3OuVDXNGR0UdUKCnALm+KqCDIasPQb9VJCysIEoUH9yanQSM/KvGHNQ2X2hWiFHaxWQf0igy2MZNtMHRcDqnT8QyI8Bio3jMEKPnm7z20kiZyLzikFpe+qBIAyKU9krxhKSZoEs2lZ1VBWnEg7UE62peJZ7ES4l73a3RW4P0YvJ3QxARZnoZB9VGZaTiPTRs2wV7+Xb6B8Dgsm9HhjCUX1GFvX5jHWTjme+9YAW6d2eVld19VMI3mbsexmq4WMdx3LKyps3MeAhVA/GX0DxIPd9k1KG+ryvQZ490GCwkL4Y3hR6ENx0yprZmKLuRAe1kZN7agU/svY2N+FWoFBs20/DtOObMzKg0b1iyXyyGRfo=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;6:NNK43tRolLngZWZJJTwOfUhG0LZxdzi5fsg/qttJ1RhmTcTXNi/NWg/8xBL6g5gzRQaTgazhniNg0HsW4jjI5Q0ZmQIRcHQaiv+37ILWc0cQev+6DBNzBD9Tr9l8Nd4NuV0uL3ABNdV91bMSgSxSA5dTQ3My9wisl1P4m/PXApQOqC3YppBYJwShoHtj/62zxgQdo4whTQLPHGeyyjavUoFynqmbl+pqeBfK0xVolhBqxdXfQJRzRqtAOBKi98HVwPDgBoCWjJfDD/I5xv03BgS5z+w0ehB2cW+VqSeczA/UMpWTrmVlMliLknj7PNqB2L6vA5qTzPua3+ZqmFVm2AXLBvpc2hJ65sp58qpJVnyqs9NPaLudYUS6aTov8XB66c+wVXkmfXkXaoLy+OBMRxwiaXoM7BD9L70bZXvj2zav/ED4L8MNwefjPs7EvuYNbwhl3JKiV2mX7etvDl0hUw==;5:3+siUefLSPwpJ+DU3Otp+D0MhB0nkmroXabG2zEVwyTW6hgCIe3ZL3QGzfKfWna1j5Ljaz8qRO1GToqNbykIvBYZDeMQW0ZFjFCkIeZPS3SNtY+pExSGbBHg1wE8AVkMwYQcNkdoLmZr2574prAhXpBRWeFu+FJRZz1jzXTRJQU=;7:i1IWtND+jEO+rSDAudDy5UYuGwQ25BUXFDCseRCSiYhIcpplaUMVT4tUpqf3sHZNrBl8EMh2jNi9Wp/SBK5XsxuZzSfSWF9UIZayhEjYFIbPuy+jhR/7TYFfymUtHV7JmQ+urXeBL6WaWg+JldTjWwzeV8dhhAyxJC5Vgl3PqItERxxgVyJaokek55D0S0PopXhVdqtX+ZOvGUhQnTXYYTl+u8XW1YQv5WHgaxYkdGPzaOd/W3Kb+6jUWaSjesWX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 14:13:36.5001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e11e35-0daf-4f6e-64df-08d612709b07
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB1218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adxl372 is designed to communicate in either SPI or I2C protocol.
This patch adds the documentation of device tree bindings for adxl372
I2C.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 Documentation/devicetree/bindings/iio/accel/adxl372.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
index 9409984..a289964 100644
--- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -4,14 +4,25 @@ http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
 
 Required properties:
  - compatible : should be "adi,adxl372"
- - reg: SPI chip select number for the device
+ - reg: the I2C address or SPI chip select number for the device
+
+Required properties for SPI bus usage:
  - spi-max-frequency: Max SPI frequency to use
 
 Optional properties:
  - interrupts: interrupt mapping for IRQ as documented in
    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
-Example:
+Example for a I2C device node:
+
+	accelerometer@53 {
+		compatible = "adi,adxl372";
+		reg = <0x53>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+Example for a SPI device node:
 
 	accelerometer@0 {
 		compatible = "adi,adxl372";
-- 
2.7.4

