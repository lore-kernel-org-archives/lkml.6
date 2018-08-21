Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D6B2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="edwEKXR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6B2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeHUSC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:02:26 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:44045
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbeHUSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPRPwyg4QSjTNsZ8zyfnCX3H26JR4J8OWB/VpQTNdC0=;
 b=edwEKXR4NGulil5x4upzFyjOoFN4hX3WQab8k6p71kzy7FgKuE/oc6IigjECcqunowoQzVYJSE8hYEVFC51RCV1neKAjA/VtXkrRUzcMXGvVvFe6E2qx1MtCuS2PWX10NFfn1djhqZLpPJkYE+eNCjw9yKygarAevSQpoZpUTJA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM6PR04MB4661.eurprd04.prod.outlook.com (2603:10a6:20b:1b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 14:41:07 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH 2/2] pmw: imx: Configure output to GPIO in disabled state
Date:   Tue, 21 Aug 2018 16:38:53 +0200
Message-Id: <1534862333-27950-3-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: HE1PR0301CA0012.eurprd03.prod.outlook.com
 (2603:10a6:3:76::22) To AM6PR04MB4661.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c32565a-cafe-4227-b6c1-08d607742478
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4661;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;3:xDgdnsxltKiqPCEhPySvMzgTFPaHVF9/k10UImfF3AX5g9Ap+l3g007Tjj01/RAw3R18xXfbzLa775aGR8NNjD6OxrTCiOOPT6sXiwDW2rhwc++n8u/4gqm4nXiVqdlQyemWBAr13oBIqmPmPl9/aFkK3KcaPtPS35KwMoP2YHdELeC9Y846OYbdKmO6JKiamdyUTEsBIhaU79ZvZE5XIXvhK7/LgBZR0VmqkHPf3CemG+63hBSK9T8W47IOr+aA;25:IbFl/UMyQEIgfOUyAuCJfAj71bU5hZHyozBsQIsi2bQvcMYOUoiBk2vRvV4upr1pAJ4+CEnIQTX/kOW8KbrlI9pirrRuCABRFcj+sV+JeAfJ8LcaSxIXCK6i0j4R0v32xIFv9/xk/MR1W58P4V12fSvNTLoZXen+5fhOtKZ4F/qqiK8m81pugHyduUBC2EoOEklGHG3kIXsHDqH10QN25OOJf8HfWVmmotsowutFN3IciERCfp7qm1ZwIium6WuGIPwTvak+Q1yPoqnz1TMvUnPdSxdhx/qPpI7q9cZp4f4tCkvTVhAoBqwsKnCImmk29iaS5eiH99QL3raRhPI6rw==;31:BwapsD1ydm5ZriRFGntDPKVoPGTwX7f4ysGFVhnj3Lzc44KTeSkwhvCbyb95QDyz2uefTlNk5fWChGifjEhURwOySSCwIQe38mx+SxmpWNsN2y0OAW499SiD66VDfrvBcBpdH++loqfmhMhwPdRQLDfg25S2u6TS4o4PcCBe9SQXk7D481oEPr/u7F3xpZUxPBajxzFAoAzDeIym4i55NgYvUTLvDLOJFVcPWxWRWEg=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4661:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;20:DRKbz7bXoA10ruf7fDgRia3ADoXhz7DuCLSFijrY1HSdWWzFGY1GAPiIZkAvJCyEcUExUU51eYegvHYLLQJx0AllGMLWuJPS//V5d6x+Kr0qYN+zttLdCoECHm3aAb1oMtnXWJ+tJoCS++CGBAUNdsDbO6W4RnrPHWqp8Iy/85E0ykWJM0djO0zE+adej674wNJsBPcsKq4aZE0qLATB1gp1xr+IkQq/Dm05jyaOUHe5XWEm6UFZHzmSYx9AHYS5;4:6ZyigMBm89gpmHYvgbMi6QH7siGvmbgCRaoHmEsoYTOus2W8NOV9gsSsapxf4vPfPk3YLCPTXmggJ3agRgwxpSByQpCYPTsQoK9yhDkGh7qJ5zO6XwPS14kXdDebhe5z+RDzDr3Nxv6MTa2ynPEwitwBAXWib374/bfDaeOxJw3OoAi0H0oRFAR8EGqZydnGb/NA1LtMBUroVh5mQMMbWh40VMSCl3kVbIC3o30GJ9Sc5kMHe/1gk9e52I80pb+4UDBC6q4IXZEUDbjMHAHYcA==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4661BB5A28BA5C4EE0CFB8849E310@AM6PR04MB4661.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR04MB4661;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4661;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(7736002)(39060400002)(107886003)(2870700001)(2906002)(25786009)(23676004)(76176011)(52116002)(54906003)(106356001)(50466002)(110136005)(305945005)(6666003)(105586002)(4326008)(86362001)(316002)(72206003)(6506007)(217873002)(66066001)(81166006)(81156014)(8676002)(47776003)(2616005)(6486002)(14444005)(6512007)(486006)(53936002)(6116002)(476003)(956004)(26005)(68736007)(8936002)(478600001)(50226002)(36756003)(446003)(186003)(386003)(97736004)(16526019)(5660300001)(11346002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4661;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYxOzIzOkhUbEVEbE5Tbk1YVjIyd1M0WTNJcnBRS2RH?=
 =?utf-8?B?T25DZHBsUGszSzEvVmpMdlJiUFRRNElTVzVOTXBFU1FTcUV1R1FkamtIUVFS?=
 =?utf-8?B?T2VpYkROaThUemNZSEZQUlVSV3hUMlQvUW9QOXVGMlBTT2tVTGttYlI0ZEJP?=
 =?utf-8?B?elRiRnMwMzR5MTYwYWNqdXJTT3pGOXVLTGVpOWQ2RlNuSk4wVGNHR2Z6Y0pq?=
 =?utf-8?B?eEdHbitleWlTWXVqdUlsdXNOQjNIaGZ3ZnQwZzdNMTJZL0dHblVZL1BPSW03?=
 =?utf-8?B?MEJSNFd0TnZGMERrNXdIZGZrSEdNdkxWcVFNYXFkZFMyTlk3UUlXNzlUN1Ro?=
 =?utf-8?B?UThUYkJlZmppK2pBYWJLdytVdjROSDF2R1JlcEVkZjQzMEwxWVJaYlIyRHFH?=
 =?utf-8?B?VWVSZjVxTzdmVENMeGkzcjlrS3l2K3E1eVBlZG9zT1JqSjJLWVk2R045ZDRJ?=
 =?utf-8?B?dEFOL2ppQUo3VGQ3WS82Y1dyQ29KRDRIZlcxdk9VK1VXUlVkdmpjUCt3SWV1?=
 =?utf-8?B?SzBQdERZV1dUbnZ5a00vK2JtWDdGbFdpbHlDWnNHOVF0R2gwMXQwaTk4T29Z?=
 =?utf-8?B?TSt4UjNGZ2ErekRNeE9TanR1UnBDVGhUTDdieVVSRHdkdzBrV1RyRitad3BL?=
 =?utf-8?B?cThGYi9uWXQ1SUJtV2ZBOE55NlNrbGxHQ1YvVUg5ay9QSnRnd293U3NadUp2?=
 =?utf-8?B?amRjbWVUK09SV1hBOSt5RjQ0M1BpeVp5WXlGeEtwVmpJSDhnaEJtNkVnQmR5?=
 =?utf-8?B?NHdhVFV0V0g2QjhtWGhaMmtmTjFSS1JYbTFrcVlRNGN3MHd5U1ptbnVtblNY?=
 =?utf-8?B?WkFyc3hHR3MzMUJOQ0EzUTk5ODJiSnRJVnFXOFh0VmUvSVRjU3FuUWNrcFZ2?=
 =?utf-8?B?OGYvTlZKdVA0Q1RWL2dpM0I0ZG5CY3plcjJMV1N0UkxNMlArK2lIc0htUFhs?=
 =?utf-8?B?aXMrZlMrNnJXWFFUTGxZYkZ0OUQzUzZxRWNpUXpuRjNLQjNOQnFVRFNRanJu?=
 =?utf-8?B?bmtsVkZPYVd0T01tV1RNVEN2OEJqOFRlUTRvMTdPOXdJbDFpc2lWQ0Q3Ung0?=
 =?utf-8?B?azVaMDNLWnhkRXdzMS94Z1BhWE5aaHl3NWs2MVBGd1RqUGtGUUVOcnZOOFBY?=
 =?utf-8?B?RDVZYUhPblJCZDZhRGlHTGplaFljVHNTMG1CSlU0dDBmUjdERkRBdU0rV28z?=
 =?utf-8?B?N2VUS3BxNHJxMFZOdWJtZHJ4K2dRaFdCWjIyZHFCMTZNUmdKS2g3U25KNHp5?=
 =?utf-8?B?RjgzNldRNFZGY2NqYlExRGFzK0xvclVraGd6cTdlN3A0bUNPdnNWQ01tL05h?=
 =?utf-8?B?RXJCQVN4eUlvOE9pd1F5aTFaT2pBZnZ0ekd0cTFoZityUkxrQmwxNVpTODJa?=
 =?utf-8?B?NmVjQXJyeWgveWhtUUhiZjBvcWZIWVRVSk9SRm91OFNYNmcxd2pUeGpBdFlK?=
 =?utf-8?B?cm1lOGR3cWRQNFVteituL1RjTWE1YXlsNEhNUTRqcDg2TXE4eEVQaTBzR250?=
 =?utf-8?B?VWpYSU9ZZWp2ZUhDRC8zVDFXYWFqUzZlTVV0azZuaWsxbUluYzVsTkxqRVVN?=
 =?utf-8?B?dGZuc3hGSlVsaVJITXpBcFJjRDFmTUlsMGRjaEdKdXhoczFhRkxOV2tEWENE?=
 =?utf-8?B?KzMxMmIxaGlselhMbmc0TDBrM1p4STl2anFuTVRuTGhzN2hjTTRZZzdGZktM?=
 =?utf-8?B?ZjhlM0htQXR4T1FwTnBhS1ZHQWxTMmMyek95dHU4UHB6RWtZM2MvYXJUM2hW?=
 =?utf-8?B?NkduK2JWS0R6Y3BRbCtGdz09?=
X-Microsoft-Antispam-Message-Info: IWeaVUUVxIsyxXQ4Jn2qJQgy/1ttTb/lVgzJXv99p0GP09wq7FtJPoM8vmj4SXEEOY8gM8nvWg+0BypQt50m5lBlnxkpia35sfwzm5O/AIUv6iOgLuwtkQtZzSOSPXYAsjm2VFT35QaVhziobwzKFOFH6XnBikwC3WVWlqgDycbcKE/CSum0Gn1/TpyxDQ1xvpLZ++hz+8JTeB70M3IxDElyGoS1/O9lSazf+lQVtznaTq9p6nPSmoEzkFpBMSduNlhGeMxolvvvrOq5IvjjZgstTV0JJkAndpxTwExhRPfN3hImclCjq573N3HaBG+Lr/qk6Q6F7/dfRNh1/JDC2fEz1IC/w1/3x/QEXtdGVjE=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;6:nIlJ47ZJ/jUprVpWJXo/kweTmKcaKAIJvAJolmVNUOUSNi1W0OnJiY6fTnkIEj06Q/NCw2y1CSL7bpITeH6/aom420mBd9J2wx9dwEhC9mZ9BbxXeLTllC75jXoaW8iWJEShFev/6TXiMbotB2t1pGq5lhh5DNEK2bsM4xf1N/yet0kbtwRxPA2d5bxjlD4qXWJHpkfziryxj/Kbp22m4jEHL4lbA+JBhmFpkG0zYVmQXVGfK3zYOsZ2J09WWAyN8UVHrLajFPCTo6s9cRN5k9GwjoJk7KY31+JkkbuXPCdOYOSThdwHuB35lHNbaJl36qQmojGWbHLWewtr1u6j1FzXl73CFTsbb0fQJgbAiwG5rSCXteY12NiYQ1uvXD9YnacrdbroJ2cI4d0JaN+sBHOzrF7Cx416BGDrSd7dA6SQR0RgBGT4FJXSbYDyNAecIsahlil+D/3kvT0D7DD/Ng==;5:EUVxFowXIqC65F80HPiVbkep7jeLWhhxqu+8BM4TlQsW3bvOIA29MA+mILurpQiMOMmkrUGoTiVRVyX/aVLtsxH1OKb1+1b06SIxJQhUCl53KZOgIf9Px07XUXd7a8GBU2VQsz27xyD37i1GDFsdnx2M7PhTZwmYSl6LKzIK7i0=;7:8c5QYHF8mycHXNuZ7GuN+uSBeIsT8G3pHqV9sANDWQYNMwN9+vzUW5TjpAiHsQYKao5lMv3dIl0fgdWpUUZq9oQwqV+a3cge/B/yv2NyiIaWSZjCW9tdgn9cJXoM8aNnItBG6ydR1xM6dsziFg7keuta6qaGK/bvhVqVdw+WhoiTYtn1VNSIno3ypE3fGQ9+UXUC8J1zBnkfCfFPhJPCJqyMBPFId+Q2dIu1qPmhp4XIKJSI1DtXCLXe8+QPnJuS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 14:41:07.4446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c32565a-cafe-4227-b6c1-08d607742478
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM output is held at zero whenever the PWM block is disabled.
This can cause issues when inverted PWM signal polarity is needed.

Allow users to set a "default" pinctrl state that will be used when
PWM is disabled and a "pwm" pinctrl state that will be used when
PWM output is needed.

As an example, with this a PWM controlled backlight with inversed
signal polarity can be used in full brightness range. Without this
the backlight could not be turned off as brightness = 0 disables
the PWM and that in turn set output to 0V, that is full brightness.

When the pinctrl states are not correctly specifid in DT the logic
will work as before.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1d5242c..6212c98 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -52,10 +53,39 @@ struct imx_chip {
 	void __iomem	*mmio_base;
 
 	struct pwm_chip	chip;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_pins_default;
+	struct pinctrl_state *pinctrl_pins_pwm;
 };
 
+
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
 
+static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
+		struct platform_device *pdev)
+{
+	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!imx_chip->pinctrl || IS_ERR(imx_chip->pinctrl)) {
+		dev_info(&pdev->dev, "can not get pinctrl\n");
+		return PTR_ERR(imx_chip->pinctrl);
+	}
+
+	imx_chip->pinctrl_pins_default = pinctrl_lookup_state(imx_chip->pinctrl,
+			PINCTRL_STATE_DEFAULT);
+	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
+			"pwm");
+
+	if (IS_ERR(imx_chip->pinctrl_pins_default) ||
+	    IS_ERR(imx_chip->pinctrl_pins_pwm)) {
+		dev_info(&pdev->dev, "PWM output mux information incomplete\n");
+		devm_pinctrl_put(imx_chip->pinctrl);
+		imx_chip->pinctrl = NULL;
+	}
+
+	return 0;
+}
+
 static int imx_pwm_config_v1(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -216,7 +246,29 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 			cr |= MX3_PWMCR_POUTC;
 
 		writel(cr, imx->mmio_base + MX3_PWMCR);
+
+		/*
+		 * If we are in charge of pinctrl then switch output to
+		 * the PWM signal.
+		 */
+		if (imx->pinctrl)
+			pinctrl_select_state(imx->pinctrl,
+					imx->pinctrl_pins_pwm);
 	} else if (cstate.enabled) {
+		/*
+		 * PWM block will be disabled. Normally its output will go
+		 * to 0 no matter what polarity is set. In case reversed PWM
+		 * polarity is required reconfigure the output pin to GPIO to
+		 * keep the output at the same level as for duty-cycle = 0.
+		 *
+		 * First switch the muxing and then disable the PWM. In that
+		 * order we do not get unwanted logic level changes on the
+		 * output.
+		 */
+		if (imx->pinctrl)
+			pinctrl_select_state(imx->pinctrl,
+					imx->pinctrl_pins_default);
+
 		writel(0, imx->mmio_base + MX3_PWMCR);
 
 		clk_disable_unprepare(imx->clk_per);
@@ -294,6 +346,10 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		imx->chip.of_pwm_n_cells = 3;
 	}
 
+	ret = imx_pwm_init_pinctrl_info(imx, pdev);
+	if (ret)
+		return ret;
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(imx->mmio_base))
-- 
2.1.4

