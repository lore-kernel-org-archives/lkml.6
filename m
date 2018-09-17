Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D15CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1441A208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hir3nCxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1441A208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeIQIsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:48:33 -0400
Received: from mail-ve1eur01on0055.outbound.protection.outlook.com ([104.47.1.55]:1063
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729632AbeIQIsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2HuukXjsuO7O9I3yj3ffFpQxwUpQbWAV/74nMIwV9M=;
 b=hir3nCxUgzufz4933Otp7gRZdLFTEvgnwFXHEDnj7LKTQNgz42ccydbOnFebuQB+etYi8NOSIhd+A2CGzD7EIxFKSMt3zO+DPw2MX99hY+uAeoXhJkQSx8/so2PV5LP1zrMIX/QHypbI6DcVlpxkeY1vo6Q+whM0szjM5M6GUm4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3906.eurprd04.prod.outlook.com (2603:10a6:208:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 03:23:04 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed grading
Date:   Mon, 17 Sep 2018 11:17:43 +0800
Message-Id: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::30) To AM0PR0402MB3906.eurprd04.prod.outlook.com
 (2603:10a6:208:f::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc402f14-453e-4935-a8d5-08d61c4ce436
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3906;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;3:YDoOQYNB1BAojUwYwOQ1XgRCtfodlUY0hylSZC1sjWwmiUwTwYIX0uAH5295FmgqV1gvy53H9RXD4SwCxEF2xCJI9AkttoVSWzMP8lIK9P9DfHPYBXajycYd9U5P6X1hN7RJC5o8tFhRwLyuNhLVciwKEZyEqZlWDELnHVn/aC5kxmB9Kqblj4UqyD8n/c7aiByH9VrizgyNg6EMh41csG2RYRGqC9w2iRhcgSwKhHc4c1aRaV0LUTP6BWP7Iyqx;25:g7ySn9S/uK7Jolr7pKiT4qc4qY47i8GP4PyToU+BBA/6KNumTXKC0Q5Q9grDsVYgVGHVIpc4vPR6wgijq9GUeh7+U6co3dlk+dooahb3/4xg38l4RAGBseJDI3idQaAZninxSLck7oayC5k8d5yH/UZ1o8L6ZJcPPu4SCK0w9bmiSnhBxOYvYZV2fCzqdY12Zc9gFBur0VcKY7pFeNHi+jB+ZbbMSdKpaaCCh003ypsp3c+4iaL7PIyp6f07I6ltJV2tfhfdkBk2PXdwo8j/amgUzVO6cvOgi/b9o43tIdN08DcKz6YZQjPC+TyelzQQngma7wuGNHEQkTHss++BQA==;31:mGUubI5wlr9mX5yv0brmXC6FAFhTHBHkQQAH28EfTU5pS8SqNe1fsM9NnWBsb3EH0AEHUnPDsjGILZxrJ6LJDcOXkmQ2CtQxsMtUILUWGOIYLygYK3b5VDUpKgsEnwBO+tBPJK3KLbjOP2NrhvN+/fzsf3y9LP2NkZePAL/SEIpH00hr/cgFffEBpmzKdr6G7H7APHwt/wrhYnuYOBIehdWyo2TT6j2yu9404V9fPsI=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3906:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;20:wQBW+YlRgQybaiB3Wwq9hMVpKoO0TfR3iSkJVVWigU6VBy5TiL/85qC5DWXBvxB9fdQ28cCrnbiyLTKVRbapWsHOlDuJsLzOAT35//YyGCKp7h6iU67FD0DG9FrwqwF/SYNW3zed8iPkiFWRpFRBwWrDlWi6YBDz8IaffUCpC9WfrhPuafmHTBA+H8Cki38KGQFrX3TmGm7xUstEtLbblW/Lzc06uDVU0GB41hRutt3+47SZaVkA1MaHzvejUwO4LHIRNJIdG+RGLSB46wJlvMlENyjnAmeZvDSLe7qhN1AtQk+XTuPi46ekjLCsFGczUbXrjS5B06DKvy+J+MiSyUz3sAhBqxohLb0y5pkEJvfjHaKkgvnfEXe+4HgfaTrkgzCII/7r6vSVkEprLw8QtNZWlBseM+WynkEofQz5gpi/I0LIGirlpOaCNpn8k+07NIAJaMOlsQvbPaVe0ZunuMxkMDgp4/qGbC5UmZ7dv86AhNz6NwADy5tbcoDFBuWi;4:9I0Dv2Jy+hQOtL7zuQQzVx/jLwdC2vd30YrafOh+2/VsSGg3Pm21XTFcHSWTueXD2tZuSAFcubHAe0NSNDeKXSa0XP8lNLX/BdjVDob0PFiOt368oYrrrV2Reu11d0pnsdR4XFvWmEsFl0zu8SzpEt77oNeMdSIwL3GEJ7VPwTspi4H9QUaBghKajn1MQ7R2sr502ZZmuPpN0MfQJS5k7ymeD7r7IwPqg+iWM5AkmiAEQUjfs76V/9a0DIjglGZNbD+Eo0qLpi1+w6aDeU0K9Y2PSlLlV2VZ2MpWJ9W8xgMo1jwMdst85eDxQdMGWxg2
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3906A00FF56CC4F993780C79F51E0@AM0PR0402MB3906.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM0PR0402MB3906;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3906;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(956004)(186003)(3846002)(5660300001)(6506007)(486006)(16586007)(386003)(2616005)(316002)(36756003)(6116002)(52116002)(476003)(16526019)(48376002)(51416003)(6512007)(47776003)(2906002)(106356001)(7416002)(50226002)(25786009)(68736007)(50466002)(105586002)(81166006)(81156014)(6666003)(7736002)(305945005)(8676002)(4326008)(8936002)(86362001)(97736004)(66066001)(26005)(53936002)(478600001)(6486002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3906;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3906;23:+y3938uzyjtqwdAU44QWSNkPpGy1I2ZlDCXm1Ar?=
 =?us-ascii?Q?a2m4S1sW+U+f2PxVCEcm6uYFtue/0BYnHDrvH4w6Ho6NLOCQly6yRfzGOYKN?=
 =?us-ascii?Q?81+FY/4ihT+EXZoOcK7Xk+kF9GsFEGyeI6mr73FgZXnAxIMostB5HRJQG9xq?=
 =?us-ascii?Q?FOKCABCsxDY9p7dGwpiSqYHgZ2XgWtopAFXCw0XdeWJ8NIKrQa8mLNkjJMhA?=
 =?us-ascii?Q?LflKpWKcLLXkpZ+t/hweH7gRM98Pdq01BRdyjiDv1seSEXhmSI3O7H0GulDE?=
 =?us-ascii?Q?YfAR88s+zBBzBOAgu8B9tXEAEe6cvkYWG3X99aHTSiEHA1pP6cUwTPxADhM1?=
 =?us-ascii?Q?2KXehQD+YP+KonZwhA4Jmv8bFqZyDp4r5L70usSzVR0P+W89NSBby02oD0G4?=
 =?us-ascii?Q?OaXhuarTaroMmJZJ5ABiDMFcd/bnF51+P24qVx2XlqJC/uyvAaAxiTnB5cQ7?=
 =?us-ascii?Q?RhKknCtqeBBH3a4RshO/skPVNwOOQQcbEyVvb1Qikk7d7/9JMkBHmHPx1fOr?=
 =?us-ascii?Q?lll/62yYda3XtBCRQHE1K0GObEs4I8YzCXBUpkNuJWmp/S9IvY3oMK8+Y9ic?=
 =?us-ascii?Q?4Jd2CaTNfeWhYSfCc/cNiZwtfI+YZOuqEmWbrl6ic+Kv3BN3XbsvP/wLr3Cf?=
 =?us-ascii?Q?sUtsqEA9uEKA6hqoLBJ4wylLS5At6Qof3pl+8tEdMOvqStzKxjxYHK6i40TC?=
 =?us-ascii?Q?p2o3ZNslFwz1NbyLUtK+ATigs8zO/t029vEVXM98Oe5D3rFunvP62cLBVMJg?=
 =?us-ascii?Q?0nQASdj6DYo2e9Qx4QGR+YvKM4iu8ohz3k4i671YGlMQUnzQy/WpxyPDmIfm?=
 =?us-ascii?Q?mrkStdhJDoZF9l0EXwbbr5pIDvYFTS63OiYBQVWnvbB8xwBH+nelzmVhME1U?=
 =?us-ascii?Q?CffhTEHD4y51egXK6xXeO05X0BKSOsNvbTtMYwefodhtZ9OOJoZ8N1JaMp+3?=
 =?us-ascii?Q?l0b17+ct3kqgy8yPmUPSueYbzrScjOqp4fFaCyvS9xUKThYBCUFgCze4DAYC?=
 =?us-ascii?Q?bWcwM+EQ3W72r106mc/ahED8dg2lVXd9dSM3eQZT83os+vdgv+GfAto67fZ9?=
 =?us-ascii?Q?ILi3ZEp7fTctbTXUpqymjEZ6l+qC26yONQMVWuBFrhWhOsv0AHNVwZLQJQ6w?=
 =?us-ascii?Q?fPRFjpDUy7ytIQtYMw2AOmyTgf/K3uVEagyUD9WRmXoGyJx+48jqjlQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: qenCma2f6Q8O4aRt/TNvcY40MXaCM+fSqvasRRJi9xHYv+H3gUTvCx+SUkCT70Zt/CgRx+8Cxf+KpQrgNXEMt0C9vBlnVr42v8xVsWyq3lIKknJ0JJLACOqEyW0TC+ilUL37BxdkkMM0kKssewjs1kMq9OYzZG0AI35LWofQjk0o8oxDMAD94sRDZw30rGex2UF49xOItQRgTfQEtfl+S/soBM4u+cineCqGwzPhtoMknP2qf3G2eG84PSxw9j0NgcRWwXQ7hc5CFEDK54fEWQ6jSj0nYU3IQJ+bM01ycuEz7yLlipSai+QQNXV9MFpsrrJCl7m4ZQ1JyBhM+fW3cLnUeQ/Zn4WbBoI7KMhvRLI=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;6:t9/feQOwdr+a205Ul3T0sb2SWrjOqJB4Ta0Mni6PPeSvWUpoCEpIznWeipG9kt2KcvMS/D1RuDKcs06kyL0Rvxj6jhXrqjEXpqUBRHBFMgjHK6kJZn0V4qDl6C9n3ciJlGp8xQVDyQnp+/Kb+Rc49TbfZv3SDPzRoVqNB+kEnzjvZ3VybnfVUUtM8C6iRpUH9J6BVbL8T/gWelX5C0opTirGcEqqRilVHQMgprWq9hLqJ+Ustr3dO5Je1G71wx4RjtuatyqbTdvQV1lZgTUekk7VjSdW1RSc4s8iKyvV04IeZqu6dvF64z5cEr8zPVWs7wDNO6Zox/g49t6XKrCiv1q20Ehv+pkRS6gaNu503DJWOgzSaLM7FodEUvFNFMZHWuUu1kolVW2oRSiie9nvq2sZ2vGe2DyhV20of4TwSUyxElE9/WSVo9zezuWKSVJQmgwoYG51yEbCrHYCSBDR8w==;5:cdbDzRbXKjIX+tAc31w/GoVddYUku31744Gz9Abv0YUfQrudqtfZo2GTOsigoWpenXJpPMtOSKTMrx433HYCOyHzLSbsHfLxDYdkJeqlziHaqYEb9Y+zVt3y7C0MBfr4WCtSQPPMNqcoTfAQgXQ+kzeJwMA/4avn8Adm5zJL9cg=;7:OwyetvKqjcFHYyaxV1ZS/F3PlaTKZwJVlJAr44lr8csCug9C9NRLbVHiT7tXI7L+HprEGbqcmOHyCd4zDSCt88QETTRiRwogtUT/72v4mLpdkO0CUwGiCP1UgVESL75yo5IaUo0y06x8uCNrTkslVm6QSxg1mB07qHyYhw7hwBoqAJXAuLfnOdVQ9Baui96rXdb2VvNjNOVKb2L98OdrVHDApIr6QS41vmqB8AJ382d6+rPW0EjxJonfaDUxnAMF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:23:04.8726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc402f14-453e-4935-a8d5-08d61c4ce436
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
needs to be enabled first, so use the nvmem-cells binding instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V1.
 arch/arm/boot/dts/imx6ul.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 5ef4320..ff8c6de 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -89,6 +89,8 @@
 				      "pll1_sys";
 			arm-supply = <&reg_arm>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -943,6 +945,10 @@
 				tempmon_temp_grade: temp-grade@20 {
 					reg = <0x20 4>;
 				};
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			lcdif: lcdif@21c8000 {
-- 
2.7.4

