Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574DEC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF78C25488
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="RhoHhzUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF78C25488
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeF3U54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:57:56 -0400
Received: from mail-eopbgr20123.outbound.protection.outlook.com ([40.107.2.123]:54272
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751469AbeF3U5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djuYF0OkZYrEMgDcdkO/WpWBOauaasUwWsmk8c7jV/M=;
 b=RhoHhzUyD68ZLaO1SanfDZZInaT087XbXa5pE4yO6YuOvVKHkkF5QAgGl8RAIqc+8hTvpC7eMZFNvU6XZ+J0iRn28KJYPIPtQaKC21sBoVw9MQruwOwQKlteo8dAQvVbZ/KTtVDgi9oHRp3u4/vqJo+otPwQmqs1JFjPM6tP+iw=
Received: from [192.168.0.143] (212.186.128.86) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Sat, 30 Jun 2018 20:57:48 +0000
Date:   Sat, 30 Jun 2018 22:57:46 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180630133330.23858-3-manivannan.sadhasivam@linaro.org>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org> <20180630133330.23858-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/6] arm64: dts: actions: Add Actions Semiconductor S900 I2C controller nodes
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
CC:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
From:   Peter Rosin <peda@axentia.se>
Message-ID: <F8B97397-EBE6-400A-A9A8-CD415EE24C55@axentia.se>
X-Originating-IP: [212.186.128.86]
X-ClientProxiedBy: VI1P18901CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::18) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a7abdf-10c4-4691-b00e-08d5decc22e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:NTeJBGvGKAFP7gH7XsbRn5mdsGELgmzxvXXemeELiW9QFMmTqcK0Xmqsyj7FLlujD0bTLALR96iG436oJ23sL/uiqRdqSIlHUm1RH8mpgZHForVKAdCFqV8Es83Ld+iXGcx4O/UX9BddV3qC/6r3PE4mGcW57e7QlXyjXTZzLpGdQsVK/fWUGiGZVNIKPsiZ5RVB0k1IUtO9Tw5Us3878p/YxQ4/yMLXVucGEmxTq5LlMYyeKETanvOmcHIp11+5;25:KRWfQcbLtcblJAX2BnGgN/Ys8hdpOWrnX8YhtpC56r6Bz2e+NRtSq8BESMwMGGTtWNfGTldEE2pIK7NL6VjVhj8AAjbOc8V/tFExuSNYhZj8jmzFTwcRq09mq4+pbN/A5AL7bSsQ4mLHmsyqIhMQElo7KHKibXJRgrp6X0ba0vjadyC8Cgv0Ctss1mWaFvC1cgdZq4VgDpyDVdOBxdDUNoq1zbPNVXkbuGLyeqh0MZYcEKfuuFG2VJu6SSs2J92FaG1gt8oXFq5Z+959/NzEn/q3q2rOo9MqfhmRWuT07Sf4pxY5xDxXZbcdcO+GodEvQkIJWpxUISw5BSGDwI7xIA==;31:KOgX839XkD1dOeLRDaAPISyB5b792kpcbO7luCskZzJLVqF9eSCAjJ1EN8nCNn8+tFND/GRQER/tKa7SD4CsgzRvj4Aynn5iKSEjRzCqdDbRVGjPvO8QpJ/IXHjbhVhfxGooI8KT0b5mPt0RK1jDJ/5Geu87BmZIppyVYjBT2kCeea6V/rIxmmsQg/k99uGihM9BUbX1fCJeDwBFvNYtpefnPLKq7puL3L8aoP0l7sY=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24606804F25B4C6F6F10BF67BC4D0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:eiNTKFygg4vwGXmEikfK3VU130xP+8JFTrdYgR6BT/bLhpBeGn7trIiQQmrNje/6YWAJE6dy8ofOWtKPjfjphMyEYNH6tNqdnenTeJtrhIITRpAvdaDk7aJX1H1gi/Q+dpp3hh/b+MdEurFNuhOECaoQZWJsBATEsfeh3UBAbw9GGk3eU22pfmziQ2g/svEdGwOc7MS8+FO0JdekxPOdQUy1QvtKtf+DisuhJjsr6HRFMpT5F7bmSmjIwux208nElM/ojCBZmUebi01FqlPUKA==
X-Forefront-PRVS: 0719EC6A9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(366004)(346002)(39830400003)(376002)(199004)(189003)(956004)(11346002)(81166006)(6246003)(8936002)(33656002)(6346003)(478600001)(76176011)(36756003)(386003)(74482002)(7416002)(14444005)(2616005)(229853002)(8746002)(2906002)(6486002)(5660300001)(16526019)(50466002)(105586002)(97736004)(476003)(86362001)(486006)(81156014)(4326008)(52116002)(2486003)(68736007)(16576012)(117156002)(82746002)(47776003)(106356001)(58126008)(305945005)(23676004)(66066001)(52146003)(39060400002)(446003)(316002)(77096007)(53936002)(186003)(6116002)(7736002)(83716003)(3846002)(25786009)(8676002)(26005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:[192.168.0.143];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NjA7MjM6TGcwbmRSQjk4VlVTNElqUjhnTXRUaitr?=
 =?utf-8?B?N0NYR3dwK2JxSm1KVXh1N3dzUXgvZlRGQlY5dlBhbVpaUWc5a3ArZjVpcGEr?=
 =?utf-8?B?ZWh2a240K0hnWG5QbWFkc0lBZWFBdWJmUXV6SmMyOHdGdU1mM09Ha0JRdERh?=
 =?utf-8?B?c2hXblRIOE12SkwrVjgvM0hjT3pDbGFKR0NBcENaMW56WnRoYkNYRG16ZGpx?=
 =?utf-8?B?Qmg1SU1yWC9oRmtORlhzRWVNY2MzQUE5ekJlbkRETWxJQzFBQSszRmdaY0Fq?=
 =?utf-8?B?NGxlMjRMdDgxVnRVR2lKbHIzVW03Q1NkbXJNb0I0Q3BqdWc3N0VZSzBmakd3?=
 =?utf-8?B?UURESVhpajFkM0NSR3FrOXJtZ3JoWE1sdHRMeXZ4ZDF2L1RvNGdGTk43Yi9H?=
 =?utf-8?B?UFNCbEdQbUdtQnRKSTdEeXFmV0ZveFhwbHQzSjdDVkN1K05wUC9DeFpJWHRl?=
 =?utf-8?B?ODhTVmU3N1EwcHdZUFVpbzJBeGFjOE9ZVXBQU25Cb0RaM1FQcmdDaEppZ2Zv?=
 =?utf-8?B?dlpXMXZUZHJyM0JLNlFxN3JUUG5WUFJUQ2ZFTitoa1FleE1XYVpsdjJMd1NV?=
 =?utf-8?B?OStBalhVdzdxcnZBWHlvTUpmNzhkNFdTM1MrZWowOGhuS2EwUDZCbkw0eXNY?=
 =?utf-8?B?QWNLVEJzWVFiM0RWaUJNd3UrYlZIOFNVcVY5M0xsNGFTTS94S0tLakhnMjdq?=
 =?utf-8?B?aFhYOUsrYllJUXBra2xWK3pKMHlPTnhjemdMam8zeU9scVRmWnc2VXVaSURD?=
 =?utf-8?B?N2h3SUdIMHFDcW92UTBPVEtNK015S3NxM1B1QTJLd294MHJTL3pKVGFwbXB2?=
 =?utf-8?B?ejlhcFRrZi85R0ZlUmtMUndLd3hYWXVzc2Q3ZFFCQnphUjkyTkkxdktpRzl0?=
 =?utf-8?B?QjNvQkNHTTJPY1hYT0ZXcXhyRzRURmZxTXh0VytSeG1ZU21LYTRaYjR3ZTE2?=
 =?utf-8?B?aHBzSGR4dGkrcnFuMmYwTmFGdEZNTG1xcTY0bEs5MWFlamFiUU9PT0FxVGVn?=
 =?utf-8?B?TzhLSElBTUljZVgwYlJnY29CM0QrUUlvTlgycXp2R2VYZVYvTVQyaCsxeUk2?=
 =?utf-8?B?UllHY0dqRmx4TStRTTRQeitqYjJHWWpmVmxxSzRzcnU0Y252M1ZhRS9XWGwv?=
 =?utf-8?B?dzFxWm10bzdlU3JQZHM1MFh3MThtc1NLQVp5Zjk1RG1VUFNnZDR5U2p3OXl3?=
 =?utf-8?B?b285anhvSXRRTXY3U2w2QjVzUE9TQWhOajlFZm1LR1dRWGpFTHo5NHkyTXAx?=
 =?utf-8?B?Z00rcUVodFkvM0FJcVVLVStMVnZVQndpME5qcUpDdWhEVnRxeXk3bUtFYVVN?=
 =?utf-8?B?Q0lveFpkUFEzbVlzMWRMdUNVZk85WlAxOEM1QVk1M2pCZitFU0YyY1FrWkNQ?=
 =?utf-8?B?aGg5cnUvUjdNeFk1a0tTOGluODQ4MGN5TkthM1h3UjRzZjBWSDk5Ry9IVits?=
 =?utf-8?B?MjZkVkdpU2tqZmhmelFFWWRiVVNhMCtvZzVPeUluZjliVHJXbXgreXBHUXJj?=
 =?utf-8?B?WHFZZ0RIVDFxMS91dTFDbllKYWQxZWlhVUNST29ybzFudUtIQ0xrN2J3eDcv?=
 =?utf-8?B?T015TjJkVXhHT1E5UXAzWDMrOFZaVGxGRnk5Sk5mNmZqL2h4dERMcmtuaXpU?=
 =?utf-8?B?OFhlR1B2R2xXU01vYytibzZFenZEdHRGNW9scmZrRHdVVWNyd3ZIekN6Mk9x?=
 =?utf-8?B?WERHL01VYVNwZnE4ME9JaXFkb3pLenVQbm5ER0o0VTlZdUQrVzJOVGQvWHVP?=
 =?utf-8?B?VHpnY29JWWtnRzhnQXZ4ZjMwVDgrRmdNY0d6UmVKMGg4ZG1Bcld2dVNEU3RH?=
 =?utf-8?B?cDUvZjJHSUtZOWRsVVU5QWltaXk1KzZSUm9aZkRPdjVCSzV3Vnl1WURGSC9w?=
 =?utf-8?B?NFhSTGphVWFmQlFta1dxdFJDS1FHeFNqL1lrc3lRVWVqY1NNOEhiWUNNdXRo?=
 =?utf-8?B?bkhvdkN3blBuNnc9PQ==?=
X-Microsoft-Antispam-Message-Info: gZv7ZVCpl30bj2QBfdcMhmDnzfyaxw4WqVvqXKaQUPF//mnLC6f8NtigJEn2i3NdCDXp85IoBF9y8YCcrCjmyZEFKWNxZxjOKQIMTo6qPpCLPtZvfv900cYuqvKdRkJ2IythcNjUGDXQJi8fEOnUgrVKh5njKiGnIEyCxAF5/wbrN/97HdoJxz7N8zKcJgXmKv3XCxTHk+OBjLAQ/FE6NqErXYXks1rfh859KpgMqHUVX49sTBIyRR1RCeWgXbuzopaJpiDNx0jGnfEPocMi0rwuABakl13k0TKilxoiKB2shk+o0teE3qvtISi/M1lRM1r9oX1u4IjWWg6DrNsaTjAiIRPHAIXgkLuUGegoaqg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:DsNEn31ewLdTohDctHyrGIqAr7BH8kNTPa38OahW9JDbedr5eASpZxNlwA1WQ5u2Q3iS7Gz/r9I39JK7M3LIclL03gwzyAtNzzsamYk3vUc/T1vib6JgJo1BxZ1BRcFnqf5Lvj3LKm+orGV6KVkulTOXdEv5mDZS1I8+Q3aEnPLLcU7lJBGJC5nZVcpK3zEjECcuQMyvMUzj1GlxWsyJ7Cv0fJMiSM9S1pDxvL5wi0SrIhUL8m86mh+6COVXTDp9z90DL7AfqkkQTaVkBA5jxo6E/tZuOofiVpkoEF2MDItyo4Mcyqz5jV6TBn1T/YSICHLatJ9Ha/1Kjvv3/rPVJRK27sbJgD3p1977WzPUdYRo+hNIFv/M4zzVEb3Uc//kBvxrt9rLrS4U8SC7zBbsP1t1nWI80vGLAnGOCTzaqRkF0LXIPdfhR/iGCr9+RRDDXtmdAs0XckfWRLKSQ7cz8w==;5:n5IXKzt2/rnHJUdSzuSywZUISBHmrxYgtDi+YZCiGpRISvBV50TtGNJcRZt9t36DzrJ/5G+Ir7LvHGwB/3M8G9WBmPln2srGMJDxn7bZVxylnHrN9+Cs1y3iDdzd8kGop+/t2AkF5ebAzlK9U06htxoVXZL6RDuW2fsIOpXnyHQ=;24:122+Vrj/w9eVFxSUES3/gvsJt1b7MvBWx5veHXNhg+wvs29WbGcH45/KGRJPrKANRRqB/CmeKpzqIm2mMjJ43OhDCs1NGBrxLrNG6N1uf+Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:thOyw0LEx0pUru8D+LcpxLH5UfnF/yebNzxL+Zz++ukfCX9VbpcxwykrpA//5DNBIHVEpB9r3gjFq48hnR1EhXDJSLSg81nV3zWWpbzAWUziVOylxINfwAg8uv4qHHYOPFDsjmwQL05Gt3V4wI5ZDU2Xhjg8Iq0M73m9OBOXSPO70JIG7w69WimkNSGwCH2tPfsH4YLD/AN6q7EIkcqvFxAnFnWnRnZkQTfScS+JqxbUh5Vrs1cNShpaylyCyIYm
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2018 20:57:48.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a7abdf-10c4-4691-b00e-08d5decc22e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 30, 2018 3:33:26 PM GMT+02:00, Manivannan Sadhasivam <manivannan=2E=
sadhasivam@linaro=2Eorg> wrote:
>Add I2C controller nodes for Actions Semiconductor S900 SoC=2E
>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>
>---
> arch/arm64/boot/dts/actions/s900=2Edtsi | 60 +++++++++++++++++++++++++++
> 1 file changed, 60 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/actions/s900=2Edtsi
>b/arch/arm64/boot/dts/actions/s900=2Edtsi
>index 7ae8b931f000=2E=2E6f7b89edbe4d 100644
>--- a/arch/arm64/boot/dts/actions/s900=2Edtsi
>+++ b/arch/arm64/boot/dts/actions/s900=2Edtsi
>@@ -174,6 +174,66 @@
> 			#clock-cells =3D <1>;
> 		};
>=20
>+		i2c0: i2c@e0170000 {
>+			compatible =3D "actions,s900-i2c";
>+			reg =3D <0 0xe0170000 0 0x1000>;
>+			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <0>;
>+			status =3D "disabled";
>+			pinctrl-names =3D "default";
>+			pinctrl-0 =3D <&i2c0_default>;
>+		};
>+
>+		i2c1: i2c@e0172000 {
>+			compatible =3D "actions,s900-i2c";
>+			reg =3D <0 0xe0172000 0 0x1000>;
>+			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <0>;
>+			status =3D "disabled";
>+			pinctrl-names =3D "default";
>+			pinctrl-0 =3D <&i2c1_default>;
>+		};
>+
>+		i2c2: i2c@e0174000 {
>+			compatible =3D "actions,s900-i2c";
>+			reg =3D <0 0xe0174000 0 0x1000>;
>+			interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <0>;
>+			status =3D "disabled";
>+			pinctrl-names =3D "default";
>+			pinctrl-0 =3D <&i2c2_default>;
>+		};
>+
>+		i2c3: i2c@e0176000 {
>+			compatible =3D "actions,s900-i2c";
>+			reg =3D <0 0xe0176000 0 0x1000>;
>+			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <0>;
>+			status =3D "disabled";
>+		};
>+
>+		i2c4: i2c@e0178000 {
>+			compatible =3D "actions,s900-i2c";
>+			reg =3D <0 0xe0178000 0 0x1000>;
>+			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <0>;
>+			status =3D "disabled";
>+		};
>+
>+		i2c5: i2c@e017a000 {
>+			compatible =3D "actions,s900-i2c";
>+			reg =3D <0 0xe017a000 0 0x1000>;
>+			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <0>;
>+			status =3D "disabled";
>+		};
>+
> 		pinctrl: pinctrl@e01b0000 {
> 			compatible =3D "actions,s900-pinctrl";
> 			reg =3D <0x0 0xe01b0000 0x0 0x1000>;

This patch *still* depends on patch 3/6=2E You need to reorder the series =
so that it is properly bisectable=2E

Cheers,
Peter
