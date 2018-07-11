Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AAEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC8208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H7BlcUKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAC8208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbeGKBF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:05:29 -0400
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:15488
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732310AbeGKBF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akTc7XHJ6ueBIQ3ls3l5NXnrnLYhBN4Ag1g5umlVxwQ=;
 b=H7BlcUKTU3JIvdNMQxTtyMhvWxfc9xHU3GyXlkSgFZOgXjDPjSE0fzyuJtdynkWXdcPm8XzvobbMeymb9QDLbEpQynXL8LT26WA1f+6pfSJrhXenQKA+4lYaq9hT0Cj3Jmcz/LLEAK/7zkAnceZhKDRY/ihNeXc4jAkZHAPQ5SE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1324.eurprd04.prod.outlook.com (2a01:111:e400:588a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Wed, 11 Jul
 2018 01:03:37 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] ARM: dts: imx6sx: add ocram_s support
Date:   Wed, 11 Jul 2018 08:58:59 +0800
Message-Id: <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::30) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0acc9cbc-b827-4fbc-d505-08d5e6ca24a9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:/0W9h3gtkRyt0N2CZAOGgpKcoMp2gNC69g7ZxHcekv7d3Fu6G/XrqRWmhB9koBQz0HyN/ip+1ICsXaq4xK2z7bNdDKsMSnGIQf3/QYyYhQai+Cmc9Vj9tNwjj877DSxgj9GiJahS0LwwzxsfOjnouAowvSK8DfdK6V2bfxxK3+eWKjL1vODqmMWSb4ULfA3+waQ0XAvn4ntCG7gMEL66bznb8Ya58+fI+ey1vDfzxk8et9+cWRAGeIlqfVfkft7p;25:NpRldBCIPGYyiuUAV6HD5/PKrb9km9Te19Di31ZoB8ZDqnT8urisxg8ngLU542IHPEcdPXM/L2SDl3GoXHyPHf8dmEzxBDoKYIACRV3DGC9mCdi1zse8mZNu89EMFdzvXb//yTwPyLMai9ijtJY5xD0imL0uYAEV7Ow7Q5o8BtbURyJCobjVDSA6GwSF3WTavSRiMTNk3RXZ73URpCU6rAF/jLxDViGHZvEEd3ve2bIw636Mn8YKxorh+yAboH1qieI9lwQBVQHCumMbb+JagJoE/3T2xCKmj+KBW8rAd0NYCMa/7t0en9FbRbBManqzFOzRA4E2jVT+XZKY7hYEXw==;31:MsqQFcFM3esfObTWRYgF4xGEnpTczjgUNVsWcpzA7f5o6vJzJ4z/9dp47btm3RHX/47jx417yb+EGnh9TplGaUdn9C3Fvkc4dVr9DH6II9xk2MmlenDKcvhKRmAjmKBvIBEU4zSY1fEB7dXhqrCFa3SruTprRTE1qwnEobp0apXvC6tLN3+6umqhquXdCPiAIoJsP9OWkTeMw+1OFlEDhQqwc35oQ6bPi4PwT4slhlM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:SiOOAv+zWmMpfXXn2uk6roVnmosFy3fMvZSAL2+evrJvxqcdEibP0+u1BwWKtARYZ3zAhQikc0tZ1f9Wrg8suZhiFlvk13kQovwZHe/TjRwMM1WGTtP+ehwGwhrKY+vzXhMb7075zdk46Zx3hEUECjrDXTXLxrtBovdQV52hQ68RG4s9Guvn61+LfXwac/0+AWzB4EFV0CLWB1FNNuQGxZB1rz1hhna3fK5E4BANuClBFIw15eg8Dackxlpa3i7UvdfeSD3XKNt7NdusmdiMbDCRhp2TTA/BCK7uNP5V7Nsahr2KSY/ocoZeMj6fVks0OftmR6GYnx3hTGaI9ouSlGPv8Uyeks3+ZA1CLmlxS6IpYEmX7Mtmp63TWUbSMcYknavNN+fnN1EUu2zgBzzemexZe5cOb5+BT9xizZtvkgT+sxSLW1LdgUq99NL3JPCu8mxlCOSF0IlnqWswPNAYabN1FWxJgjmP/szmGTJAAYZU/E8O4rjOQoWWHMF9OS7V;4:Zvyc03Y2oETfGOdt8ZmDVTDVU3MyoRAnleylOxscIUlvHKKNeM5OAPg/hHDo2DMGJkASrfTRI0cUDY3jN0yNTJfapjFNMbJKt1T8xunztjBskCedoZsBJ8/JuLDTXSMNLPOI1ViSta5CrUOJ7gwsucbjytKl41YL5hJpJkwLIe+RG4Juljk5oUZWjHxUu4X91nbphpRcieoysnwMNF3HaPRjXpp7fK6IYOCxaem+z6XCLJr4hzGYmZQMGcujjZSuIvAHUfcIe0di073MEkrP3kHRojom4LSRhjL3vT1B/O81OhJbmlYRQhb+f8g7te8B
X-Microsoft-Antispam-PRVS: <HE1PR04MB132414D64876677B07DC08D0F55A0@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(446003)(105586002)(97736004)(6486002)(7736002)(36756003)(106356001)(305945005)(5660300001)(4326008)(53936002)(6512007)(486006)(11346002)(25786009)(956004)(2616005)(7416002)(476003)(8936002)(50466002)(48376002)(6116002)(478600001)(47776003)(3846002)(316002)(16586007)(26005)(66066001)(86362001)(16526019)(186003)(50226002)(2906002)(76176011)(51416003)(81156014)(8676002)(81166006)(68736007)(386003)(6506007)(52116002)(6666003)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:TltNq2Nh2NkCn66diJNuqc2kPVmURhsWnRNsC4DZy?=
 =?us-ascii?Q?7KgfdVHbdRHIWWahRLjQzQZNrFCvt9tPOgdOhFjf8HYdAhnYdsG/+TA7ETss?=
 =?us-ascii?Q?VLkCf8moyFv1DXPhA4a8ZWI7UNiPHTz1nFusqpRUcTGxNz5mMFmVmUP5qGp+?=
 =?us-ascii?Q?5fzLDSQ1B3oXbpm+kInV1vvs9Bn38svSdWmjYZC2DwHvuj6BIpoIs5P0ffm3?=
 =?us-ascii?Q?wZ9Ecl56uQog0YdSp7BpmyRkssXBm32E1lFNoxs/AY3mp8diseaMltAZX+5c?=
 =?us-ascii?Q?C5e30ZTf7Wd7LcX+TMr24JeoZ1oovk//llNp/qAU9XSCYk0JxzNVzViMKfnA?=
 =?us-ascii?Q?h0gkDzLr8kIyIG4GAvXHJifgzMm02lvjI+MT2Kyg2Gl9y38JmtPAiWerVLi2?=
 =?us-ascii?Q?3xUrbZXgOAqbhlfjo2ma+oUT8lZKCUT787+R6SsuK964g2QrQ7enugAMgtrI?=
 =?us-ascii?Q?pPDx9BoaQ6CJ9KY+6xfHOJ89dNUsHAl/LQ8sZxPectM+/vKr7sYsTRXkCmc8?=
 =?us-ascii?Q?XjDLtO5JmxIg5k+Nhgg1vS2ab+a8atWBgx+6VH1Un1uiM3dx2iDYZ+IndkUM?=
 =?us-ascii?Q?RjuqEfE57tsJY9Z1op/Yr6EOrd7zI02T2o9axs1rHJJMAFxjANU7EsVmBO2j?=
 =?us-ascii?Q?RP5eLwmjD9zUiT2Fo6zCx/Oe3+RABQw8K5CRCkOivRSot4cAitjgLe9G3Zv6?=
 =?us-ascii?Q?GhEhYVNMJJHJeSoA29nKzz4sK79BqSayN/XR19o6O5llvTSGfjN0OduwASfw?=
 =?us-ascii?Q?mVR2yDXDtMbA5RGaWeZa0khxTZBeK4vlq8UqxaNMpP/B2IiBPbTzAkvM3SNM?=
 =?us-ascii?Q?Nrh9hU6Dy3ru/5s7zJb8LVdzO+0RFzv0rITGGROfSOPTU+qRcl6nX4qqY9za?=
 =?us-ascii?Q?gAmrM5BGERp9VejnioKASJBv4s1oxmHRjSYb/gUx5Nv0/F7s9Z0M4DHo3LC/?=
 =?us-ascii?Q?7p0OypShFJlIYr/0RSZzcSjETio29E9aGjr9NSIV+1cs37McemfDTui9DFi5?=
 =?us-ascii?Q?L2JKc7su25sej96NQsWqdRKmVk5n1oGghfppxo7xFEnvw8Q9xh4U5OQf4G/b?=
 =?us-ascii?Q?k6tpx67KuSUf2a1JKMUTONs6XH1En0BE5JWUug3sOBd/kJjPRWjkIZ+dumtX?=
 =?us-ascii?Q?bPRbX7VjD0KAHfhqSe1hSxI/hI9LGmxM2LdjaWIBvWa1ACNv9x/GyrBqaRtp?=
 =?us-ascii?Q?eeB2vlZUMwP55iEqaE9r6GTy7biKZdGZe6wxxYXBtaXjNXKkm3ERGtKZw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 4tG5Fp+0/kql4kUQeXiIqCXpJknQSZvIe/FPjhsVy/69PM9dlJIiC1aYjbiMaQ6W7jyptrECy3aMYwH2SMr+/eTZd6A9Kln5PvGPeBTv7vYhN6z/WUVIK4G3QNFwmbUiMjaLRSJkuSMaJBEMouQVWo0MW+b63guBIAIk7l8MFA7LFmws0vEC5YwXzR5b/c962X8IlSKHBA7eANil9Lmi46jRLaFh8+TlfuoHqxtZqjrE7VzG+EsbTgMnean8mn13XHjILPvzz4g7e41gOJEbR60fCtsnHB8JhGfZTwLpC55D4o22ZG8S7DQOaGepxvypLJPeQlh6E8a48Dyw5YcmUFaNB0U5gVyejWSrnKpODAE=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:RtZATG1ZaV7ErPwmOwxD7CIu/TBkUZI4uyoj/a1PbSItNCEbXpPzJoT9ASoaPHXTOPV50u3LoUxEGACfeyUR/hcvH28Tm9miIhi2aL13rVIM9sjEdzPB/K6ytNmmT2c7iL/xcscms71mEi8gISn5xCzilMcb2gBf3uVZo1i1ghD5v6cOWeuxr/BnpRE1sUMX69Xqo2VkghYLw05Vz9H9M2keG2i5dNSyDaKDXlzbYL9WfINhIdECepkxRPrSTZfv+Otzs+dlvAlxLzSaxojtScXlq0jeTq82mB0bsuFjVovaujjuiKsyid5OOUF2/DEouNdfQwY7Kakd2nx/9ZMOb2M9jKjLAoU+A4JVwx/r0KaSp/FepFTb2xaoSqiqvx75hRjCRtduxw2gmiamgLT1UGK3ujIGvr/1JRSbMeb93U55kmwSANpjux8L4kAolKFuVprfyNtGFlfqq0MBNG/O0A==;5:2knGZLeb8YYagoFzoapADJKDdYAf6rTPb5XmFF3pE0vKMPfaJ2jbR6shH1Z8aK7BS4uD04EeM7sJfEWU1KhqGM6kUUaWviwd2ItuOFeqFf9YN/gge7iqDA7G6yh08fJeVE7l5RAlFMgZzF0XgbS6xVuLAEX5PmkLvwaU350h4sk=;24:KZRhKXyJnyFLuTuFWrgcRCxlI7gtLPmN0xc11T5/tdns7MhN7/12St+cyJ6w6+i2eWBtahytq1CZ2AH61pk/iZj0W4H/QAa5SLcCwh3QjGA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:lH8EIQShaeY9WzwnMTeDaCJLeGceMzbpw+67+bL99MEbzRSrXcGawW15HIvfE9ATNjf4URf+i8H0mObUUi+FMvAVRWC9dbm/UV0gHhidKeQi5k1lb9BmK0uMg/dNwikJdT8dAfzNZl3FZNQqN07u5MJanATR8cfFKDInc3rJ++OqBDNDrl7m8l7IOGG/vZw7H4HMljB6LkxTuNF3DT8/sLpZT16FbTgJH1GWCl8akrJOFkgQOWEXjOCzsDI+fyyq
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 01:03:37.3177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acc9cbc-b827-4fbc-d505-08d5e6ca24a9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX has a 16KB always-on ocram bank called
ocram_s, enable it as another mmio sram.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	resort the ocram_s and ocram node by address from low to high.
 arch/arm/boot/dts/imx6sx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 596763c..f4d982c 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -166,6 +166,12 @@
 		interrupt-parent = <&gpc>;
 		ranges;
 
+		ocram_s: sram@8f8000 {
+			compatible = "mmio-sram";
+			reg = <0x008f8000 0x4000>;
+			clocks = <&clks IMX6SX_CLK_OCRAM_S>;
+		};
+
 		ocram: sram@900000 {
 			compatible = "mmio-sram";
 			reg = <0x00900000 0x20000>;
-- 
2.7.4

