Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB13ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C692150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="eE88KAdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C692150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeISS4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:56:03 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:38944
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbeISS4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zjeKlt89emubFnnQrKNJXflxP1xxwZj7WKs9T9TRCY=;
 b=eE88KAdHtL4+PoRyjV3maQOD0FlFNRH8fsPkglghpinlo4PP7t8dekhG/7WEJvnkRmjJ69D/aZIcSNOU26it+YJ/goZQZRkukloioeHkn5LDpUM6z7FcuFRXxsA81un6HEXZWternacV7WXJEOJ/f80aDeCLYLsJWhPU1Patah0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 13:18:00 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Date:   Wed, 19 Sep 2018 15:17:29 +0200
Message-Id: <1537363049-48399-3-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
References: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5PR0602CA0003.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::13) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:37::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cf9cb16-5fe3-4348-839d-08d61e3252e1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4666;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;3:YwhQ1OtnCkdx80C/YBd0aBEigePfBZfs8B1FrnxlmX/uwAV51qJVyMt1l5khY9dX6EBjk9bxToyNRhs8hHyxkn5d+i2W7hspnxxpyMFA95kViwTlKh7sFJfdgmTJwxZxW4EuER7oHG9WkEZLSumlgs9pX/jY655fMD0wBtWu6aiC8/KBXJXrcPU8nbZR1gkK3zDo1E/mhkGxh5979IambOnA9oVGI7vazF4jd+jPiWAbn5mwifiLqspS7qkdhUz1;25:nDef3rQJD7OMbyeyeWXzltFioeN2nP7d4L1WOIk5SZbJtYqqU7EV6Z3qJdyFzqA0veqWDCHJ1/14KVrp1rsJjaqXNUeSmUAcnaJsAWdDAD9AH+e9m80YgszdZVmAgjMELJib8cqF7dzq56Ju4tKYwaQr8BDwqrHBbcTlQ+/VtoN5Dpg8NT/fnr3bPBNoZC8S4k12QxXh6v0qOCDzOGEwXxhIyfJUegZBb9rOZUVqxhngz0fvOAvy1OTmaZHrtZAa/FsI3kT6mha5/STrWmRJq/sYq6ZyE1Ds23OZhvy7xAnppitBrqjUcPV7Cua1QsDl0bAM8vNHF7wRVCHWtuRsPQ==;31:FK4fO8bkUXrMxMXzP0goXh6IIQzBvXMIackm+pRoc5qh6wuEuIS/yeNIgCoUwVoaixiiuzQ3L0dtDT42jdWUGSS4c4pLHEbfaEpos887x1p0Y5HeL05SfFlPQ5COh7QnHQCRMnknZOkjIhSbsGGcwQIOF2SDwwAQYN2t5rcEt52lM+7QNg0NPLpexrTpFD8dCSPPW+hsWQg938PD4H955Unqs6AYPGZBmdEu/oHw28w=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4666:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;20:s0dxrQSpx9v+pAcfQ9Tj+LIMHOTM8Xv1C9wCVjOMFLnL8iGxrHlO5RvXTsToB2BRDmCNxiZCR6MlCSW0PKNWUdHyNvUtvfALXnDRToEZWX9h4tkEShfp7Hn28iAsmEQuQ0O99HPPpDp/CfPf9WaR4QgNz/aTchD46v2jFLnPid7kdx50t9LZS8Ssn7oUN+FPs0qPhiZL3m/wiVmf4jd+tYjzZTDjkecUGotE4wEepE9RWC2WNfDXkVvu/YJ/bnX5;4:TC7fupNOgvZofe0z0kiompomr6SR4tU2b/LSglNYLEkHi5bOIuSIhno3WIAEZYjGzZ+xnuaUBYyLzccGClCv5btrs9KDiOXBS2MJ2RItllm9b22Eduqjw89KvgQycYjSxlvchsNhf4SNFiIZas4NUDHwQZIZgwrDS80ug+qvKALr8Ny9SnZIkFPAFjKbWJGU70vk7GXbjSFXgitRbjKK4SJGHOVlwo550IO1ZOP+wyr+U4/CuaS2BhibrSnQTm/EfFhLwY7T4WeS8Sxd9l8WkQ==
X-Microsoft-Antispam-PRVS: <DB7PR04MB4666706F9CC500090C5322729E1C0@DB7PR04MB4666.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699050);SRVR:DB7PR04MB4666;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4666;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39850400004)(199004)(189003)(3846002)(86362001)(81166006)(6116002)(47776003)(106356001)(7736002)(5660300001)(97736004)(316002)(486006)(26005)(186003)(105586002)(476003)(2616005)(446003)(956004)(107886003)(4326008)(110136005)(6666003)(23676004)(16526019)(25786009)(72206003)(478600001)(14444005)(54906003)(11346002)(2906002)(6506007)(386003)(76176011)(52116002)(2870700001)(36756003)(53936002)(6512007)(8936002)(6486002)(81156014)(50226002)(305945005)(50466002)(66066001)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4666;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY2OzIzOlMzakllNEZYdXBhRlZDdWxUQmd6N3A4dnZD?=
 =?utf-8?B?TS94ZnhxbElsSmhJUXYwRVlrNnVIN3pJUjFucGhSVndvb2pLL1FBZ0tNMFFy?=
 =?utf-8?B?Q2pWT1lQZ0xWdzNZdndhMVlYK1d1bG9jWTRhMHpIZGdjL083MzlGWGV5ZTVr?=
 =?utf-8?B?RUc3WFJ4UU1QajdURDJMOURXTXpuTUZzRlNlbEpMd29FVGQwZnRZSVI3NHVU?=
 =?utf-8?B?MFZFUTY5cmNXeGFGblBwZEFYVnJNK1hZdWI1QVYybldlUCtUZmRCcmdxRlFr?=
 =?utf-8?B?YnNvVGxkdnppQWoxbk1Sa3IvNGJvZG5oWDRkRXJqSHNWaGZZSzdwZDBWZ2lJ?=
 =?utf-8?B?VWtxSzFUS1Y4UjV0bUkrQ0dWWTU3Uk9QeU9DUXhONFc5Z082TWZleXU1VmdJ?=
 =?utf-8?B?YWNjc1lnN1FBR25ZWStCWUdJdEE5d2YrUWlYa2NpUzA3TU5RN1ZlSHlPQjZ4?=
 =?utf-8?B?UVhoM3kxanlwVFdjV0RUdGs1eUdnV01TSXRMeGk3cUZUbkdMaFJON3BhZWFn?=
 =?utf-8?B?YnlpZ0ZGVUtyd0pqV2MzQ0RuVXQ3a2lDalV3R3pCamN2UExvZGNpMW50VmN0?=
 =?utf-8?B?RXFacUREcUdzd2YwcS9xSG1EckZ1NWY0blBUbU1SaDd1czllNGNhTWdMT2Nz?=
 =?utf-8?B?R0dZVDY3amdaeTFqUGJHSDRaR2U5Z0lLOEV5ZUUyNkcxcExRckVBZGtRNm5S?=
 =?utf-8?B?ZmxQeWxiVjBCMWFlN2xpN05COUlFWDlVWXdpRlpFQkpsSzUyK0sxd090NGFR?=
 =?utf-8?B?U2VaYldySTRZV1pGZEQ4SFNPQUlqZjVSTG1jNlJ3d1NOWGQrNk5JYjkzaUE1?=
 =?utf-8?B?ZHhjcjkxaS9VV0FGei9OSmFudVFmK2dVL2lCd1hGK0lRVHltV0pxRzZDTU1K?=
 =?utf-8?B?RVg2Z2pSYktSTjB1QWpKRG94VXNkc0VmNkR5UWw4UXFzWndjLytpVEVrRDhO?=
 =?utf-8?B?WDQvZDdQeW9ieklMcTJ2eVB2UVN1MDNSU2dHbTZjckJ6NHhUOHdiWTJQczJK?=
 =?utf-8?B?bDBwVklPOFY3OXphYmtJa1QrbDliRHRLSGRER1ZBdHBCWEgwSStkQy9uNGVZ?=
 =?utf-8?B?andockpBUWN0Z280R2NXcU84VTEwVTBVckhXSThlN1RzZGRnZHlRMkhuRFBh?=
 =?utf-8?B?aUNtM1R0K1AvdGJLTlBidElaTy9wR1BNMzdNd09Iang1eUh2dVBBdzhmT3hu?=
 =?utf-8?B?ckhPUU1jSTRjOENGUFplZm1rSExDVTNXUFNPbHVmRGVtUFN3Nzc5TmxEcVlq?=
 =?utf-8?B?dnZkcGk2NjY2bGt2amFIYmUzYW52ckpiYWhjS2p4WTl4dkVudWFvdVZPTW01?=
 =?utf-8?B?Rk9FK1FldXhRd2pIVlE0U3VnZlprRXg1N3duNDEyRlVHak50UGoxWjJCTUJx?=
 =?utf-8?B?d3hZeUJDQWRnTXRYaWwrdzR0TWU2Q05XMVFMUitQVW1MZkxTNmFZd2Zud1Iz?=
 =?utf-8?B?TjFkNlB3WGRMemwrRUdxL25laTMrRGFwYUt0cm5Yd1A4cmlKOE9kb1hCRWVw?=
 =?utf-8?B?c2JHUHZKMHJCZnVQcjBNU0RVQ2N2Rys1OHFkVWsxdnMwSzBEakNWSGxncHgr?=
 =?utf-8?B?L2dETE1aaVhVcENvUkg1NHYwZXhOOXd6SnFUb0huY0ExM2hKaGR2YTQzdkg1?=
 =?utf-8?B?U2ZrdWxIbWRDSmJOTWFyYW82OGdWbVB0TzZLcytwQSt3QzRyS3dCTnF3PT0=?=
X-Microsoft-Antispam-Message-Info: fqfSCF7qWYEJIyN4jHf/VMQB4z6m50RdZPA7jVXR7qgrWY2Oju24xPdnmyNaBLGLvkAysowBGZYB767Z+u+Ler10M07BIRt6sI8KjDgT8+Ba3peKQjv+6ywG1tf0LmSAUlpuQvr6QG9qkyA1ye3oho33/vj/RlVnEyYjktoMdAkNF5VD1h2ZQIre/KufMwwp1+vR8CXWHXw075PfrI6ZU+6BW0LHBJbsME/z85Bb2Ml0VMWXb3+F8FJyArMUjE6Yb5zxaFh7lrVstK9IG3/Cve4MGTL85+OuQddjc5WacslJ880VWRoDlUUkmrhOIHoiVdjbQotLAHtNSf6yrpdVvjp6op/o5GSM6WKvcPo5vtk=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;6:TsrUij6jo3f9djZkJSeBCmX4IMKy2aWNsuvkdCO09DmN/JpN2BB2FNO+lD/RZ5Y+Apx7OGHL8TVBgRuLWwx/69ED6efA+wfD2NqgOpc5IKoSogGs7tdOdzXwPKl2BRcfHdWWSjInLehVeBUOt8eT8IFdSL+uMxFE4poYnGtQjFiz9dBk0PPXEWGItBTKU5ma27n/BWkVuzflc2wWTndP28Vq4y10ojI2zfaXooNL/7SAD/3EAg5GoMY7dr8oP3uh9khu2RWFS6IhgWBxlQbFQkJYC+G270py+D+HZ7Gtj2x2LiFp5FQg/WWj9NPoHY6deGh+R4IbcD/NbQ2ckx511LIPzEB2myVXWCpaVFl51uLVUddOVZggKVEQe6bQiijTTaP6U+GQaX8Hcwn0pCnIfBbJE13aA8X93G4/LKrczojFBEoGyIAityd8u/kQaQXKImrPZv22/jT5oGoMH+aWLw==;5:D3Cmm7w8hOYQiFo8IiLC2MF0MlBIRCFfZk90a8q7hRhX0HpmdfR3W8WaduQrssUy9r9i16LEIKMrpen+r+WsowNXb+oQF3bVHfbPJKaLBIEyQcXQdo+ccfflY2OIBZbLDhJarYmwPnBBmazHtxsRarIlw2czlwvzV/xNRT12/7s=;7:FvJD8WFpHXxFf3h+4LDR7vkXAy+9IOGC2m0uhJnE2g88Z8jOhL0INL5N4U/5CrjVBUkB8d+Jr+0eWXwvyFsHF2HNLNpMxdfWW/0po/fyRufFgxeF2Pd0Wzj+5wZaaC1K7VWXagYZhuLDOQ/dZ2PQU4HJJH/41NsNjRbwOp0c85RMUYpE8a1BTbb3RBRtL/iUk5l7mITJ6Y125goeAAWe9E9H9w6PTtEDL6NSD1ft/6SAnl5fxsQTR47SLN3UvAvP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 13:18:00.2994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf9cb16-5fe3-4348-839d-08d61e3252e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4666
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

