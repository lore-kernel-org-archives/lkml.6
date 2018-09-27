Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BCEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF2521533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="mFo43Z/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF2521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeI0PpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:45:05 -0400
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:48730
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728025AbeI0PpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zjeKlt89emubFnnQrKNJXflxP1xxwZj7WKs9T9TRCY=;
 b=mFo43Z/PA+yNmRuwZXevDMF4sw50fObhgJ8aTubicJ1amaByAcQ/bmJRH18Db/wS1DDSBbv5VSninifMG5OMszD+tPKL4xwRr7H30RvN8VonyCy0AwSU5krVgmVM0i52XVcD3/A7o13AOXXmU78kFtJJRaNTICfYrLAwaWX/U7A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4660.eurprd04.prod.outlook.com (2603:10a6:208:75::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 27 Sep 2018 09:27:33 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Date:   Thu, 27 Sep 2018 11:24:41 +0200
Message-Id: <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: HE1PR05CA0360.eurprd05.prod.outlook.com
 (2603:10a6:7:94::19) To AM0PR04MB4660.eurprd04.prod.outlook.com
 (2603:10a6:208:75::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c740844-15b6-4764-e56b-08d6245b74bc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4660;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;3:zaRdhsz7LYCwCbs14o26I1EnndYWMcCZ3AEHbXMEeCic72PaWUxv+lDsBIuV4tsUQhL3RGU6PNaw3ztTrtG9hOTHbglcAkKtqL/azuSbx+P12muf+TJKMmq5uN28Pbhzmk/VSFVzfdiuhI0eK+yjm19NI8SrJoOu2FzGTGywG2RgUIOjNZ7+UIygG3JUI34R9t7AuF9g1Czgg3wAchIC7sC32guzh7V5xVC5dgrcSlXVFISwwKJuaCyFkB5J1iuj;25:zu/LkiskPVX7BH6oEXjmjCMQdMM475Lxu3K7qGJpNjg+0EYdrqkez05vwTI5hf9WBux+2Cj62p5EZQ0EsaFQECQaxRirrM35ey7WBhLYrOAvWPsJVpKk/b3dDHM7O8Urt1Ixu0VE9L4XiY9i7AnLyr4vgS4+e4+U227O6+39svqyQ3UjnMidvJsH6kBEhQzv4G9LjjASB8KD2K2cEv5SND9pmrFuuos0JsEpd8h5n8QoWP+hN9yCzyLZPsQZXlGmK+idAqOMl0lcS5WYzJYVh59WHiF3atLBpm24x8/48Y7BemKV16OOLBmpYeVUIM/DCZ1giSGXWJ0QCy9jikM6ug==;31:Uxd0gfnDlpKoJHMWB1HZSMMYQcDG7JTY6FBhg78ZbcmzKHcz0L7L9VZklv8fVsa788VZ5LSxh5xPTxb9wPZfGUJiWaannRA+u3uw2Oa5IdvnhMhQC55rcsZT3J71wYZdrN/PK2+iYQdCxyDMTcJy57d/MACbvAu2H4es0WKfuFkoG/p7PQiL7Gpz9uYJch729syFhIKhHSwp92ekQfFlr0whfwj98FE8KAipi8Ji4Us=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4660:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;20:PbUPJJP7MOhnXVgw/1RD+rMJMdzanhtevT7PaQFH/NcahHdW2WZ+hAEf5PlxlFCb7E671CeNc3uorjZ5Qj198qFYWIpJe/scspXM3rMOupT2JQt51MLbPN4D98doW/AlxkqFlgQCyEEAr2Zo39NyIX8yWxTV+xBGTuTd6uV9g/eIOVL4MNEk+Tip4bX/yZvnHLLcwlP8X2r6hWhbHIka228/14dgHkSjb8o/9FSoYOoAi+/O4g0PTsmDbhK2F23O;4:Bd0k5M3qaAaaUBKDCJIdeuYPz5+EA8wmNwF/P975x7K0nnKIIkhMP3uQnp0Q4Lo+kFeW6rVf3WPowLdxzpwgrVyBVOfh/CEiPuMLj3AYxFJNsCIk+n+ph0AwwrdONGU4AJ0ftCW2rMRi+A92mhiq6YdgPHcgkRxS9rABdOlWkbLpzCooVLAqIIz5X+oPQgGivBkfislULJ4Pp1Qgk66NfuVNUZ6g50FLWBW1NKFoZ/G+KNmyob0Lbts/NS2qGMVi3qvjIMFwhiNS3u/m3vbaiQ==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4660875C6C5BBB5DC253FAA89E140@AM0PR04MB4660.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4660;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4660;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(446003)(6116002)(3846002)(26005)(476003)(97736004)(2870700001)(81166006)(81156014)(8676002)(486006)(86362001)(316002)(8936002)(72206003)(50226002)(2616005)(186003)(11346002)(956004)(36756003)(16526019)(53936002)(2906002)(14444005)(52116002)(6512007)(23676004)(47776003)(305945005)(76176011)(217873002)(50466002)(478600001)(6506007)(386003)(6666003)(107886003)(5660300001)(106356001)(66066001)(54906003)(110136005)(4326008)(25786009)(7736002)(34290500001)(105586002)(68736007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4660;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjYwOzIzOjNLOUd1UkFBcGJsck1Id2t6dzJNbDc4enZh?=
 =?utf-8?B?Tzhzb0paa1Y2azVjZHl0MCtUQTduNnFhVXlPMmNTcndhaDlkRFdiQ1VBSm5z?=
 =?utf-8?B?SEZMK0hzc1NmbEN6em1YMjB0dTkzUkJSUGpjN1JqdlVvemlpRm1XMWIzczhO?=
 =?utf-8?B?dUl5MjQ0RzdVT29qdENBZVJxRXJRT2lRaWJUaEwyRTI4U1JUWTZucjlCZlph?=
 =?utf-8?B?YmtTVVNORm1NZXlPcHU5ZEEzZmVITEluK1V3T3NjTktwdlkxM1B2TFRBa0lB?=
 =?utf-8?B?WGxBWW44emVuRVk4ZXhlRmd5andMcVFRREoycFlycWFzT0lybzUxaDhtT3du?=
 =?utf-8?B?a28wQlNsdWxUbVo5ckJ6QnlLRGZnbU5ab0FpTEhoZHE5NEk3Uk9xalN0RXBD?=
 =?utf-8?B?NkR6QmtSWFJqNEFyYzI5aDdidHNvRlpqUjlvOVhtYUJTcVZJNXRoSm9lSUhB?=
 =?utf-8?B?aXNraFR5RFQ1MkhwajN5TldGamhibE1SRm9EQ3QxOVJlRmxpbXBUYTRpUDdC?=
 =?utf-8?B?aXZmTXAwME1XSVRHRVowMDMzTFRSYmsrYXNOMS90ak9aQnZnNGs4ei9YZGVq?=
 =?utf-8?B?eVNLUXM4WEpWbUFTRXlHbldpT21jV1NQdnBTUmNYelRoclhRd0JXZXR5Q0h2?=
 =?utf-8?B?R2tnL01HNmh6OGxqYnc4SnNGM0ZhNzJ2RTg0TnNURU5aczJwZUhmaEJGWHBR?=
 =?utf-8?B?Uy9LNXJ6alF6QkNpZjBZR2FMcVJFaGxCaWtVcWloOEowaXdCWmxsVzdzV3o2?=
 =?utf-8?B?cnlCb1MxM1RZcnc3NDd0Zi9ycU9qZUNFQ2pzS0RESjFQM0xkMmYvekZRYnhv?=
 =?utf-8?B?Z0RHTDZXb1c1a1JaOS96ZlVCWk10ZmRoYUlIWXBxQk5HckRvcUN1N1VPeWF0?=
 =?utf-8?B?UXIwMkNPdEp5SGZWdkRCN0JvZVIzaExTSGpFdWZ6OUJkcWRnOEx0RVcyTTAz?=
 =?utf-8?B?NlU4cEpFNDUwb1NIdy9OMDdNMlJGNEZzWGtvZFpjTXVDSWJib2x4OGxJekF0?=
 =?utf-8?B?eCt4MXo4SU8zdlROVFFlUTZJdUtzRFhISmhwKzlBb0dmeFp1M2dEWXEya1VR?=
 =?utf-8?B?cG4yUnJTV1FvQjFnazhmZTh0S0hyTUZORmpyblp0ODh2K1R0REN1SVVMUjVn?=
 =?utf-8?B?M2JtVmtlVHRGMkF5WEdqa2dkY1hqSVVoRUMraHdidHhkTE9vbU8yMXNkSVlW?=
 =?utf-8?B?Tm5xNEluUzRyeDZPcVhqTmRrUTJNUWpGWFJ6dWJqT2daenFJd3IyZDgwWEdG?=
 =?utf-8?B?M0ZkRkxoY1hKaWZVcGFNT3plMTFidGJmY1lzS1lWRmRqUlY2bVVUT085K1Y3?=
 =?utf-8?B?YnlhQ3JheHAvTzUwNDhxU2xJR2ZQS3piNEpjZGRiTmJHWjN4RDdPRXFidTIr?=
 =?utf-8?B?SXRaSFhVSjAxOCtGaG1UOEd3Nng5bmV6bXcvZGRBRjhXOGkwTTBpdnArK2o5?=
 =?utf-8?B?dHNqck9FYXdaeUZ1dHJ6Uml5WTZBKzQ2WHZkMFZRbFVsUE1rMHgrd2xpaG13?=
 =?utf-8?B?VGtmd3lvT0lOeks1cFBiUExqeG5vck9UK3ZkQk1SM1k2dGtpSEg0WmY5cG4x?=
 =?utf-8?B?Sy9vVTl4QllWMU12WmQ5c0lKa2h2QmJHVVlLMzdnZVpsVEVJL2FDNjRsSHlF?=
 =?utf-8?B?NmZBK2o0anlhc3ZnV3dLd3VRVFhZZGlGVi9iajM0c3JXRXZnQkl1VUFQWFA0?=
 =?utf-8?B?aGJ0RkZEWmtXUitXSVI5WC81L2w2NzR4bUtlcWMwc2NqaTVjYzAyMVVpRTdL?=
 =?utf-8?B?MFhMemNxYUppSjVHTm9oUT09?=
X-Microsoft-Antispam-Message-Info: ttE43guDOlG7wvdldDTCOzVPcOPNFiOMVDbMfxJcfUW6VEuiQp+gE0O0xlMUSC3Dk+3Xyt8WpN8rI3xQQ0AYsmOO56i9J/BQhY/oQlOClGM22UPzdzXyCsArTwKS7UDQ9uFjHKuVGImNt0Q/gZo/5Nw9i5HwN7Zzm5391FPMhmk6mlJQdV+SuW9Lzh+ZoNgYs4fDkefACbUnrJE/bbp0XI5B4KirA7YvAuQoO3W51Tv7hxRl4qbqxBORwz7wcsVCN9O+nvfbo7kUVbbDIlWxzanIlzrnXL5ZPLm7TjVleFOeMReQlq0yG64XFfPamK/yqH8UEdhYJCYlw+G/w02TM71VjUjJ9cJEC9lyupDWIF4=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;6:8Np+cs3aSO6VKX+AaU+xUY5CMFGJbeZQ+kbkp6HYrUhn3EPbSEgaFFMVd7+eYutUBEKxDetbKpVl3/KQ67g6+2TWrg7tdmMLFy++66LKsu9+8/k65AuQoDQAw8HywUw4+To+1jWK0zr+MCj49W3pu76BDNvKjiRLK+NkuAiu0VVeK2l6egEBO9vWMi0iUc5KA8FU2RxzrjrcpBS3s0gA/FAd1rzjOaRZniG/btYPazNzqNb8ofsfmFhrKbqPtSf4kKo/iKaakaXCSLQdkAF1gSpFaSyC9UX31rdia8ianyPLU/D4zF0xPWnyHydzZSj5pt081JRHuAgO+wuJ+UQ5mTlTNueo6Us6TXeKnxofQhA5KnJOQa4k5mw8di5MG9ImPdeka0KFnYSGkJcjW98dCWXprXRODhqEPnT+Y1kFxPCijxyYTE7SpAQMM+roNQ1bXTbTAhFRXIcIleSAmbOjww==;5:qlbNWKYIAUIBxEZaMHzcbBP8n2+ixK81+bVNI9BJhGE5TYf2cz4vigvJVEVWaukLWrar9UQ/4rIYjF99b2N99qcN6LgITRemQyJlvUwqNKquQoCmtiOSO/z/SFohS+sbQfOJDzwl8rk3UX8Y/WKT77ewnmtCcyOZkGNh/1Niuwg=;7:Dl776Jq6Lf+mHoKFnHZ2u/6o+uelsvRC4e+t3Am0j18swg78pTaBnF3iS0B3cBxnuFvDDOVtvxJuXRMk7HYQMzZ0POvp2eqrQpXEMp4XabEs6V48l0Se2DRpEfFZPWpkbVfu5YQ271kI+Z1FO03cTReEfAtjkUcv2w8qatEBsHyQ6Pi8aGmt015F0GIzc5FJJqsu1nBK67eBG/EjBW20zvtGQLjCdiatJ4Gz4m0anLcLnC98DYu67OnPyplF4fhI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 09:27:33.0695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c740844-15b6-4764-e56b-08d6245b74bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset signal of the SSD1306 OLED display is actually active-low.
Adapt the DT to reflect the real world.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v2 changes: New patch in the series

 arch/arm/boot/dts/imx28-cfa10036.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index e54f5ab..be3406e 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "imx28.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Crystalfontz CFA-10036 Board";
@@ -95,7 +96,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&ssd1306_cfa10036>;
 					reg = <0x3c>;
-					reset-gpios = <&gpio2 7 0>;
+					reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
 					solomon,height = <32>;
 					solomon,width = <128>;
 					solomon,page-offset = <0>;
-- 
2.1.4

