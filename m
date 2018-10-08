Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13155C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A0020652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpFiyRAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A0020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJHSZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:25:38 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:16928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbeJHSZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EygQjPUn5/oqLEKez/nsE+IZNDdJTjgKIOtJRGEPzk=;
 b=UpFiyRAVeZFCVz0MLEEwTe8oV8s2e768kiVjzkQMruwo1YiDpTrfmKpX6idcN9ZE0wFI4WNxgljSRp1BZ+AltsfiHsfyML6IHXVsA3INdZ6g3GFARXNKET/nwGfc2sn8szmRaPL0S8fRTielqGfD1YOubUn5lFBS3RxV2cKroZo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 11:13:54 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 3/5] arm64: dts: lx2160a: add FlexSPI node property
Date:   Mon,  8 Oct 2018 16:41:41 +0530
Message-Id: <1538997103-11152-4-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5270b541-9370-45bd-33c3-08d62d0f250b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:sBd9GLhU74P1P+Qod0OcSaNptxLw2yucpyF6WTFBOlq7ukZuIcTzaqukfU9tTQvntpNeRuuty52X1wpgf1Glwv7KbX6jplAF5lZ3WT3PGjMCUL1aMhzPq5pB8Z3NRCYF9t1FsscI4ixYsn+P+BVxpVDZLZ2rL4Un0coSQqC3HIk2rAY05+fNYBndV+gybi4n4Zk9CACsbZunX6dE4oMWqOeK8VPF5DGggmYKEADo9ItSJUDceK3DTPVDRtkxCJ5T;25:0vvYJUHPe07oHQ9eBwXSMYxM3RULQSv75hTYFICYVJHsdqvPxurI8iLBWR7LMVquivkbunthx+QYNsNT8NoTLKnUBBj1qgD9/G91/z/Byz5tT9jfxqe7MHsewmOCDrgcPJJwncWu+eg+ItnzEmZnWyy8pe/ZddMSjMV+aJNGg9GS0QwGFdh3FCfwWW+cZTvZ3FKpXIxa8TZVJxRNr5+MzhjDHgs/i+vaAk0OkLWW8L3XnNqAQo3XhXdecCWv6aTaqXFzbBLQ+LTYYKfOd0X4PyFpA020ypXY5H8C7o0quZJWy0WVMXnDgsMBXtoJvSVLa+SQzcDIxIhOrh8HMSqlPUbnbuwCb5IJxZmFnel07Rc=;31:PGiWB5HRV481TWrHT3aZzkIui19Ha2/gaz5sjaDK8PeIjLHYgFOWpFYHXwBtnowuU9HvcOvNbGhf1CLplHXjBFJMhjYXa9wn7tMawnTj+98MQUZUf0pQxQFsDhGICQ2fELATeEzOnvm67YPbtr7c+qlnWOyMU3Ki5SOVbmszuCZHiwEGHImjbvzMaPMmQ5dlJ+uocj06VL73RNP+3NPosnPaYIiBmLmSFU1vN7gK7Tg=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:d4VDD28EXdkwc0z33h/I7vF7/9rG4pXC7QAL2a0u9SLy0giGPS9phFX/3gdGeZz8krmXJWS7Sw5FcicLm9/5bYLKJ2aJC1d2xkO1MZuxl/FLb7e7UPqDyh69UUbxTSOaRPDyVFen+Vy1BonHSzxpuPWLX9HHfjgRCBxYsGJHe17WlZqqWN/hHUtoXw/YK3jAsWHcVlT3AE1c3Y3vYCn+7JzHJua31VZZWnxxrluOvGWtLRZBODI/k5OtJ/H3QrtKdvGEzBC+YKJ6jRPgKUZXQhncgVCXD/fwt6DW9Vz3Ir1A5zsNN8Lw2TzkU1m6t+tKFeLLs9H5skUBZf+1HsRIBgbByeyrCnLMTwPhrbyZJxBlmiJoSDyzvKwd8xI+R0q8oZWEprGx8u5UhcL8ZuswqxYjiA2xgNIkkHC/Sql3vgtcEwnXH/UurisNh8ESDrsSTpbLfE9nc2qwjiqGngPSLrtTd5wPk7YYFntE8U6AMBWOlieDpWGtrUMV2OwE4A6h;4:rgK2LTmi7YZIupnY84CUnTF96a6HtXs0x4mPlNgbqg2UHRbrnnglDfvzwxc0utiOKnpJf6CLwKFA7NapIUw4I0n1zneB83IYSiansXYJoL/rrq+QY7N5kLYP9ne9H8lwQzgGpHz8zzgBESddZRgmcYgE9qLxc4xXdWaPffdAtlSjuSqUmExkSTjEzItxBKtBWXZ5B4hDlVj+oNE1Yitbkfr6OUZNNQFVEkCgHtN4+TNapiKyJ7GPPg/6HrAZ275/hK9X5U9Ka+5OvMof/dvkZcJ4GS6vJIxfz48qkw0iIIWr5KBfaknxhK+scf0PlCwb
X-Microsoft-Antispam-PRVS: <HE1PR04MB1034650695831ABA1C2898AA99E60@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(2906002)(16586007)(105586002)(6506007)(55236004)(48376002)(316002)(50466002)(16526019)(6486002)(186003)(53936002)(6512007)(68736007)(26005)(106356001)(4326008)(52116002)(5660300001)(39060400002)(386003)(5009440100003)(51416003)(76176011)(97736004)(47776003)(7416002)(478600001)(2616005)(956004)(14444005)(66066001)(25786009)(6666003)(6116002)(36756003)(476003)(486006)(86362001)(8676002)(305945005)(81156014)(81166006)(11346002)(446003)(3846002)(8936002)(50226002)(7736002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:t8VWgOhz28Zgaw/5BGF4WXLbmFq8f4zSwQGRcKDsU?=
 =?us-ascii?Q?0jyKA65HnK3WzjKqum4ORCDiJzMNYMhO5qNiLt3UfIJ1q4ylxGJSvkJg3dvN?=
 =?us-ascii?Q?qBjOsvHRxfPohq3ssC9cKbGjOvkzmcoSHS4QSTMej/KWYMfS29QzzSP7MQ6N?=
 =?us-ascii?Q?hDf0C5Fj7jLnxBg8BXcjp9WlEhkSJRKkaToliH4qgQqGgnhn9QqswotZEOvM?=
 =?us-ascii?Q?3r9KQ3QkSnYNeTOP5F5UpjyDlEKuG93+BTs1cKrJbzcZudb6bfEbK8M3N7EG?=
 =?us-ascii?Q?n3pJFsSn1yvFjCuGbLwD54fpPxZIlQtolzQywt6o5de7oojGLtir28JH4rrB?=
 =?us-ascii?Q?bsEJ+H9sr/5jV9Db6g5MsXFEJOMbbmMhtNU7/8NbJALT6i7etyFS4LFja27z?=
 =?us-ascii?Q?RZcQHkCb2ws3TvOyXGD6aneHv8JKDnlUkL33YD9clQ/qIzwojQbYZFhorlpK?=
 =?us-ascii?Q?B5ExUO/btO8Ahirb7EmhfSRXpdjdJ6dpr7hVOx9bmgFK4chxcW7GAwkYbTb2?=
 =?us-ascii?Q?WD49VB4YMxca/zbS1UVx5Z/LoeO03mpg0uG79BkU30nF/bPczCGiAD1cKiBQ?=
 =?us-ascii?Q?g8DWo0awSyPT71Sr56+T13NzuTpR7Yn2x8qOB99LLYY99dLI1YnYO60xTWwv?=
 =?us-ascii?Q?BHPl/HVJq9rxV/kR629b5Jbl86iP6Y5FPS3oWNp5qTJW4ZZ5s5YQkIuiA6Wo?=
 =?us-ascii?Q?NNsDhRJ6z6sbdYR8IbhiGF0SsXwEnLeqphxSFuPrP6y6e4W5b6amsH+tLxxz?=
 =?us-ascii?Q?EJbNuy/cNcoMlg9AeYfLmrvl3VT0Ytw9lnyhz32RBSRbhHvc0oDITDzEhWnV?=
 =?us-ascii?Q?p1XpLQ2th4ddt68/Betbq6w6j2rP6maFeLTYcnS7+/Dtj5PFFCtAkUPPEvuA?=
 =?us-ascii?Q?sn63RNU6VYL/iJlf+vKilS+M+8H5D5XWdAPAh/BNB+EgtszaEr2y/Bn8AbIf?=
 =?us-ascii?Q?fGEU4oYCq8ovRbItl5VTnsVCAdw7mj6YydDDb5Bgr14/4Qmlr4SnbM1wB6pA?=
 =?us-ascii?Q?PjeyGgvb8HEdkFWlpiutT1z5FUluB3SsVf921FCOkbKZEYlOqZU+Vs5grRAM?=
 =?us-ascii?Q?HhpbAKOFryL6+H9uXIaF7L90e+qpsuRwy4+fUeUtI+kZiF96kQFtqc7ind8H?=
 =?us-ascii?Q?OMlOnjzoyRBzhRBCxCMaEBGD5ppNzXyDwVghsT8AICXxfMJ/c5boITvL79u0?=
 =?us-ascii?Q?r92dNNbau11xa25XdNLqpdd0P5cIp5mSSLIJEfy1U28y7lQBaZu0ZkkaMEYM?=
 =?us-ascii?Q?ihG+wjzLmcXi3wSFdcYJkAyv2DiH9kXWrf+BDx5MOUOP5x2AmftybY6nYAKu?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: Ntd32sqfm0gzZIr9OYSwjB8VIc3FORBaSI1D/eEeuKy4XeTKjowcVOHEuP0OKhlw3IoMJX0y4/f3yIOC+XtI/HW/zssN/UL16q9Q/QBa/55kz5nWonoA/4YNLG4ocGjlio6KRZ6GhITK2W+qCgnJg2CcRi8ifK7RuAHyNau50XvV40Z026RpS0jmwu6GuCxEgRSWJA+Wj18d9pvxINCKDZrhW7i2wny7zMiBBVQG6CIjn97V0KmtK0sPy2TVIRUTZoDQvb/Sj44Dviw7XsK3yJFFBIJraCVmciaqKFc76x17GQl77O+opnuyYI8Ea5uwZIh03svomafxHcTcaHhS/gSyyUS15ORCnyT7Ebr5Jr0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:AAuTH9Lmcmw/J0bWS91IE4HRpLF3WUP5n9iCuOczFM8qb8mpxA4YyICMm64P1jD88L6kJdvo+mVJ630K2QKcCkkB/n5KBIcbqHm8oUTwFoWJeCzxfAFHbNdnbO/1Kw8ZvccsOJOLCGzaL3tlW+A445zI7ettleZsKC3wys70CB7RwSDORlu1w9pfadW6oqFtU4N+7Sm62hIuwVL2MAxs/zXXXlylQH/q+Rp6GaneAaeLHYeMNAPEt/+PRWSERViLOg/pqZeMIAWul8RSsKvhgLEnBcBeLu94+heImcNRTqTPjbuVll6utUrYp8JRDXI3fXPQSNYoC4/b44lDvnlFWXolwWBwNXBKqoBawKJC+AzNbYdYQDFhzudnZm592FNvUY5lO7vmvmguGKaA70+10RuXLpPyYmKN2/vFcc0f5hnZvxSDLM2Rrd91yIoosZYCDcP8XcLasHMWZSqvl1Dyug==;5:dNetPk3Y/R7hDK51uxC9xDIeLDr8PzFiAuoiARDO/teAb3VkfLUozf14obAb1mvPOtaVa1d75OsV4j+wErt/tJj22VuPadIOh5FwmB3gQCX7+niNr7rd7p7GTqYLMTXtUycAbn618DOTVoI9Yv+T13FwRFSofgfw/OxFt1Zbg7U=;7:pMyLQEKw3Wbgw0rmp0nsiJw61qF8b5VTln5CV6LtfgJj4CqXxAExUaH/x0DA7CYJ24bbBHwwDvE1NEWDYY6tuDomdd7vMBsy3Sm5rawpGdukXvhjsUk1z0MPIC1t68i7uHdc9VkwDBe5HV9ZBp7UUYWdWQcAPGLevUgbeYaK1dprjXu4nz6ji4aswiBcCfiK2XgIFquoavSNJ0m7Ikv/ipuPl6h+4uvA73V4hlIXPiyQnyMXiHNbsPzI/BZ76EtG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 11:13:54.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5270b541-9370-45bd-33c3-08d62d0f250b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fspi node property for LX2160A SoC for FlexSPI driver.
Property added for the FlexSPI controller and for the connected
slave device for the LX2160ARDB target.
This is having two SPI-NOR flash device, mt35xu512aba, connected
at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- Incorporated Shawn review comments.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70fad20..901ca346 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -32,6 +32,28 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+
+	mt35xu512aba1: flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		reg = <1>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	pca9547@77 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e35e494..bd2d606 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -568,5 +568,17 @@
 			timeout-sec = <30>;
 		};
 
+		fspi: flexspi@20c0000 {
+			compatible = "nxp,lx2160a-fspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20c0000 0x0 0x10000>,
+				<0x0 0x20000000 0x0 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			interrupts = <0 25 0x4>; /* Level high type */
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "fspi_en", "fspi";
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4

