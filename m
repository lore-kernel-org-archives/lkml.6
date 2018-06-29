Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30D2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAD2278DB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="AU5D9x1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAD2278DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754274AbeF2Epc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:45:32 -0400
Received: from mail-eopbgr50098.outbound.protection.outlook.com ([40.107.5.98]:3180
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752453AbeF2EpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0x5Q32+rI3bCR8bOG4OltIqiyLnY+NVz4NK5dqmFX4=;
 b=AU5D9x1nLKAn/t4InpThrQBMUFQa+lMKGJny52FvRaGlqJikx4NHfv6ONyp2UYPOSEFMKP4JnQxsJerqsDmkpWMfYh67RcadwxDVEZ7licg46h44kETytujsOL0dWMusrMdcjfU6vrDseAM4WvX7Te/28iJs9dlmF1I9/WY4KJY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.114.68] (91.133.71.105) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Fri, 29 Jun
 2018 04:45:21 +0000
Date:   Fri, 29 Jun 2018 06:45:19 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org> <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
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
Message-ID: <58C2C9DD-44D3-4002-90E5-69D83CD93C40@axentia.se>
X-Originating-IP: [91.133.71.105]
X-ClientProxiedBy: CWLP265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::16) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ab5d0e0-0df8-4108-e126-08d5dd7b1f57
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:34Hw/b8rAOGcLyL5dRfoq3te3D58b69d2qCrdZ5XcWj/dXoipzy0+ZltXyxqQw7uwnPbpuXWWCgWU0YGSieSk+ij/gLiLsMmGf6YEiBIOqxXznEI5is9ssBrv+ank2qNScziwQCbhwFXwiiem8pODL/QP51ea6Dc9VlREaZ8C9gkxAtSWiR3yNqAbRR+g2mOKDXYXkxQYW0Iw+SNVlR52YFka728q263adnNXbvHNWdZV2hBI3Sqp2rooomy220M;25:SvjTvyR87muXUUoRMCjYRY6O+9FEJmd0AzQw+6dGE2V7vpE42xf3eTPr3IASeI/1OmyHl69m2oNu+USOXoQ9OagpSLaWKc7FCRQ0su2MKbA0eJLT11OPyKAe90YAZeb+LpVYy8LsTUb8pBCU94fI7krrSBwRD4OgNphI0Y8KrtZCdjwvP9FHuid833V4yoXZpzZUyWvQFvXe5k20lmNzecCmEag33Aw4e6A5FgHbA3BY+Yv/VfnCxH5iepsQ9IO3rs4YQ6azYA89f9whYwQqxDvfjFABZUzZxhzMlaj9NJpXmjKKEAJPgQqcLzDk1Gqrh63wKhdqJXu1pcsxZFeNbw==;31:xVIRkC6hMvu89/ZPQy0E+E5Ev+yMQBJhiUG7fcw1FpZoDkyHH1qiJOqDGVKSAaH5fVjusUGZBeF1IIWHwTy/gq9Ws9uOLFD1etF9PLLN/mANxNf32TGgObNAb+KEUZZH1IN9eH/gZndEyvtbZpeL0U7xfjBxgLAOJQsAPZS4ND2KqvLbD+H9OtZ4/n8yEFK2TEcM6VE/kAEr8LtoNBD1Xd0z0kpYbTdgoy/x9SI5jho=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB244955414C078DB5A057B8FABC4E0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226)(106291317490208);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:hV2r0fOJbfhYwVZd17OWUdZ0iF1j7/cAmAXu6suMPaoWtzasAlsgoMKgCC9zhBykjN47xlrpZU1haeUvFtzzrHerNCmna68rP8Z48gV8zOixRIyyY0jbC4rd8dZHLGLGFaOHdK1lpabrQijs2cRIS+C0G19eoC39OUSd2TEDMsYYSLaX6Bg7b+LN21t+2wTMkyafSF497HUDJP/2kkEqyRX7kMsgwulCT3PeahnZFyaE12wdXxRl0Qq5mv1UjPrkUPqNesZ8lucUdstRpDQTZLsPsJqZzI8idbEUbSonVt4m5kX1yx7/b+XkmN6Ot/KspudXpEr41AfNqL28LjgOIMMsFNdouQqrcBSNeoPuLcg=
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(136003)(396003)(39830400003)(376002)(346002)(189003)(199004)(82746002)(16526019)(74482002)(186003)(229853002)(486006)(4326008)(386003)(26005)(33656002)(66066001)(77096007)(11346002)(47776003)(551934003)(68736007)(52146003)(6246003)(52116002)(6486002)(446003)(14444005)(2486003)(8746002)(23676004)(39060400002)(2616005)(53936002)(476003)(956004)(76176011)(7736002)(50466002)(81156014)(58126008)(97736004)(36756003)(5660300001)(7416002)(25786009)(16576012)(117156002)(2906002)(105586002)(966005)(6306002)(316002)(86362001)(575784001)(83716003)(106356001)(305945005)(81166006)(8936002)(8676002)(6116002)(3846002)(478600001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:[192.168.114.68];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NDk7MjM6WG9XdWYxRlNFYjc1WnN3ZHZ0T0RFY2Yv?=
 =?utf-8?B?cmd5eHMrbHN0elNYTzhSSmVxRXp2eTJnMmpBRGpDL2VyeFNTaVd4R2h2Q3J2?=
 =?utf-8?B?TXJwMy8zamdlN0tuaFpoUWF6anNqekQ0MTl2dlY1VmRwR0ZGcmpuUlBoMElO?=
 =?utf-8?B?Mkc0UkFMZ3lJT0puMmxEWUFSUzBDTTA2eW9zS05vNVdOaVZMM0JuS0tPUmNl?=
 =?utf-8?B?ek5zSlB1OUpLcUFZS2sxWFcyS0EvQjFRQ0FJSnRFSDhWNVI3U1ZDbC9RV28y?=
 =?utf-8?B?MmJTSVlPV1FDSG9YaThEa21uc1JFRSszb0FTOXpjMURHK09Va0FLQnJzOWlT?=
 =?utf-8?B?QnhXRi92NDVTcHMxaTR3VVdXZ2swTTNFSkE3VEpEYUpxbmxCQjJjdC9kZDRx?=
 =?utf-8?B?OEk5OWYwblNiRW9xTU9DNVROU3Y2SHpKL0pWTTc0MlhXblZ6Vm15ZkM5UzB3?=
 =?utf-8?B?WFlsaFJwRXZ2cDdOWUZvV3Y5dnRpNFlIRSt0dHE2Q1NkMjAyVGNtRmEzbnFX?=
 =?utf-8?B?bDVndlgwTUp1V1RDWElwRmRQVUV5OHRLb09nVlRiam9Vb2pBL0VneUNwVEtZ?=
 =?utf-8?B?V2J3Wkc2OFphTkNoSUFUbWt4dDRqNjdqR0VhL0RCV2dFN290UUNzNG9xUGFi?=
 =?utf-8?B?aDExR2x0T3RJeTF2SnFpaU9tTjRRb2N1SGczcVRWRnZqNjlieXpDNWV1eThP?=
 =?utf-8?B?bWZ2UTUydEdON1dxOHhxWnhOL3o5cUVjSEFpbGJwMkdVWC9ZdDVmVjdIN3B1?=
 =?utf-8?B?NXJvZWdJbXpZR3RyL1dxVXBidlplS1JLeTd2NHRsYk1jM1AvNW1pdGYwZ2xP?=
 =?utf-8?B?WEZWck1CMmZNTTB4dUdLZUEzVzBHcTVCK28xVFhtQTF6enVMWmlqMG9qd0h3?=
 =?utf-8?B?dDFCalRDam45OHM0VHcrdU9SN0dmSkJOaFl1YWtWdTdRNXdreDlzY3BwZFBp?=
 =?utf-8?B?SFM1bVgyclRsVU9zVURlbmxCVFJjMzdzWlR2SFBqcHliWHJCOEpPcVZJUHVU?=
 =?utf-8?B?OU0zcDB3dm9WZ0o5bFRRbG1ORis3Qm9jT2FWLzIzenRGelFCbGV5S2hYY2Vs?=
 =?utf-8?B?TzFGSFRRbDUrZm1kOHZJTTdJZlNTUEdhNjFoWmh1b0p4NGgwVW52azdFSVdt?=
 =?utf-8?B?Q1VVMWVyK1dmbHJFenhOemdldGdLQ0lQazcvSWUwRHFEbmJUTzQwSnRqL3pj?=
 =?utf-8?B?cVRWYWFnRGt2NWZWQUdnTVdKR2V0YkdYQ3g1SDd0bDBScnRpVXpqMUlEL3J3?=
 =?utf-8?B?SDFXUG9lbGNOTzd3bDVFTFhlVGlPejF2TWQ3OUlmYlZxcnVHajRCSlA1U2N6?=
 =?utf-8?B?Tkp1enhOWktEaE50cWRjM2RJazRqQVhPTUpLMktMMHc3TDFVOHc1bUFGVVlI?=
 =?utf-8?B?NWg2bkI5dVhxUE9ES3BmNUwzS2Q2NnB5UjZPRTd5TThVMFpUS3hYdnpyc29v?=
 =?utf-8?B?cDlIZFhZSGVyeGplUEFrVFRFTUpqcDYzK2ZudFhZcTJ0UFNRaE9sK2h4Qm1P?=
 =?utf-8?B?WlZ2eXRIcHVZUlQwVjVRK2t1YTFTUGVYRlVOdG5oaE9BeU5SejM0YTRZVGo1?=
 =?utf-8?B?R21BNEl0SGtMVWFFcmdPMHpQVTBhdGdpKzY4YlpLSzQxRy9jaHdRZFBNKzVB?=
 =?utf-8?B?WEsydTRqaTgycVd3ajloRG9KR054MnRqcnhPMkI2ejJCWjBJWFIxTnR0UnNn?=
 =?utf-8?B?WStFMTJVQ2pVaDROVXdWcnZpTTJpMW5BSFp6aE1ycytGTVB1Y0JGNjFiaHdq?=
 =?utf-8?B?Ykszbm5NRllpS09xaGgvNDBrVk0vZFdqSTdhQk9SQk9MRHA2UEs5emdtUDRu?=
 =?utf-8?B?OUNmKy9XSU1zQnA0UGpXdmxRaHFkbFVMbTRpTXY0aVBnL3BhcDVEVHdReDFI?=
 =?utf-8?B?UVVwajlUN1FjSXhCbGU4T0hoUGxtSWJreVZ6RXBRMXcwNjlBQURsYlozV1kr?=
 =?utf-8?B?K09RdDE3cTI4NFFLTzZLa2xVa1IyZVFWb1NhNDdCU3E2aU1TN2VsTGpQaXNX?=
 =?utf-8?B?dkxaVHQrdzVMdFNFNWxxRmhNNmIwZkNLeUxPYzJ3PT0=?=
X-Microsoft-Antispam-Message-Info: gzkJSFAquhG0WFG0jWP++kp8wPrafxVpgiEkDoNcKJsq5B5fIxrhx9d6a2eBoPeHpeebrBu0wYf9zmfRqOQqYrbYYhUY+B2vsjn379BVI4jPHw798sp/1k6c0QgQ+CKi8Tk+euim4XrHJoQ2a22F5yQqMv1IRJHLN4J+oqK9jZy8FMdGYVWYTV7+x85CjkQTtFUpj/ycYc9FYyX6lmaZv4Mm4AxUYhASsqLchsgPBYrufTqOxWUXusqbscRKtAodx6N0MlHbqNxHdR7XMNe++/bsgfd21T8LgYGSzpR/mGVdvB9gthNKzOZ3f78Wxshp+6FQ6aYGKkRNuCVbw6G1qIFM4s3BxgDx563R5bTFvDM=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:D+M3bZsSS4HqSagbtsWYHWTGpguPCPIGiLzCGAhnh0eWz0Gc1WN8jYpCbA2miB86RWMVBxTdWa9T4nlUiJLFvVet4/YQAZnEwDnlOzXhGoWaScvYYrWxOsk8qE7uAk2bU+xJ+dFF6ehv4vqPRNG1qfqb+8T4s9trZSQjw7SVwAf4QFIZGK29UICNG/qS9WtSajr7cq2qtfWVcE40GF5dL7071zCHZXbcyiKuXdd6f/dTQIwwwLyE7kK+9yelb+D6RfEbJduO+gu6KCm+330Ff4KakkLJzp+DLouL5mN2EbNrrzS4B5sJFzpIIZOUB8OAMYZGgGcuhC/6gABr6JtdetgCgVdKGVjUrRjjcMzlTnQ8mGswABw3AiZKCkWltj4JSGeATp/EU+IUpHfuPyrqP4ZKaNvR2igyMT+7QS37MTU2M9cyRqMtD4JPBjfY3BjvZL7odZ0y1innOxJMpdtdrA==;5:zbSViLUvRba8WB3QqIGWwXL/CevG51Z1kNhn3osFn0jg+6faxl48xhmas974CJrOHGY89FYJ+O6J/1wEGYKrhhkfgstZ+GQm1gPrhrkKyyp7/UmsCezq1+tshCqhO8CMPE68j0Kf5eSDg1V/N9vbHx7cjtVQqOlOGBrh9jGE4JM=;24:ki/t9BIvLHRCfDc7FHC7gpDmpfSUwkLWC8eIPgIWVBS+jKIGk/h49Mwbngl+IasQLccxdAX8PgwH3TVLkoDF8vSoOIqK/81FuozjI7kKvBQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;7:YBCgrem4XApJKP4xFIZAytcCV9wLBGvX66/M6nG0uYOZd7ZapWD9iPBP108fGaXhpZSa1oGrt9CDnC/6lkHDhp7NvfBhcZv1sbMcz9ee3uGr1fAG/Kz13/mXnA4MejhQgXdhbSkqjASbJxl/+2J8kLomWtBrIWaaRut7qFvVFruDVYY+R/HXezd/GaHmUwyWx1oVJ1IFvaoPytEjzVnrCrVQ6YS8ckxgGkI8dK1Rs6P09ABbLbS/S3oha0/Zrfja
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 04:45:21.7530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab5d0e0-0df8-4108-e126-08d5dd7b1f57
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 28, 2018 8:10:41 PM GMT+02:00, Manivannan Sadhasivam <manivannan=2E=
sadhasivam@linaro=2Eorg> wrote:
>Add Actions Semi OWL family S900 I2C driver=2E
>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>
>---
> drivers/i2c/busses/Kconfig   |   7 +
> drivers/i2c/busses/Makefile  |   1 +
> drivers/i2c/busses/i2c-owl=2Ec | 471 +++++++++++++++++++++++++++++++++++
> 3 files changed, 479 insertions(+)
> create mode 100644 drivers/i2c/busses/i2c-owl=2Ec
>
>diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>index 4f8df2ec87b1=2E=2E2062da17e33b 100644
>--- a/drivers/i2c/busses/Kconfig
>+++ b/drivers/i2c/busses/Kconfig
>@@ -762,6 +762,13 @@ config I2C_OMAP
> 	  Like OMAP1510/1610/1710/5912 and OMAP242x=2E
> 	  For details see http://www=2Eti=2Ecom/omap=2E
>=20
>+config I2C_OWL
>+	tristate "OWL I2C Controller"
>+	depends on ARCH_ACTIONS || COMPILE_TEST
>+	help
>+	  Say Y here if you want to use the I2C bus controller on
>+	  the Actions Semi OWL SoCs=2E
>+
> config I2C_PASEMI
> 	tristate "PA Semi SMBus interface"
> 	depends on PPC_PASEMI && PCI
>diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>index 5a869144a0c5=2E=2Eb71618f77880 100644
>--- a/drivers/i2c/busses/Makefile
>+++ b/drivers/i2c/busses/Makefile
>@@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_MXS)		+=3D i2c-mxs=2Eo
> obj-$(CONFIG_I2C_NOMADIK)	+=3D i2c-nomadik=2Eo
> obj-$(CONFIG_I2C_OCORES)	+=3D i2c-ocores=2Eo
> obj-$(CONFIG_I2C_OMAP)		+=3D i2c-omap=2Eo
>+obj-$(CONFIG_I2C_OWL)		+=3D i2c-owl=2Eo
> obj-$(CONFIG_I2C_PASEMI)	+=3D i2c-pasemi=2Eo
> obj-$(CONFIG_I2C_PCA_PLATFORM)	+=3D i2c-pca-platform=2Eo
> obj-$(CONFIG_I2C_PMCMSP)	+=3D i2c-pmcmsp=2Eo
>diff --git a/drivers/i2c/busses/i2c-owl=2Ec
>b/drivers/i2c/busses/i2c-owl=2Ec
>new file mode 100644
>index 000000000000=2E=2E12320fca6755
>--- /dev/null
>+++ b/drivers/i2c/busses/i2c-owl=2Ec
>@@ -0,0 +1,471 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/*
>+ * OWL SoC's I2C driver
>+ *
>+ * Copyright (c) 2014 Actions Semi Inc=2E
>+ * Author: David Liu <liuwei@actions-semi=2Ecom>
>+ *
>+ * Copyright (c) 2018 Linaro Ltd=2E
>+ * Author: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eorg>
>+ */
>+
>+#include <linux/clk=2Eh>
>+#include <linux/delay=2Eh>
>+#include <linux/i2c=2Eh>
>+#include <linux/interrupt=2Eh>
>+#include <linux/module=2Eh>
>+#include <linux/of_device=2Eh>
>+#include <linux/io=2Eh>

I would have kept this list fully sorted=2E

>+
>+/* I2C registers */
>+#define OWL_I2C_REG_CTL		0x0000
>+#define OWL_I2C_REG_CLKDIV	0x0004
>+#define OWL_I2C_REG_STAT	0x0008
>+#define OWL_I2C_REG_ADDR	0x000C
>+#define OWL_I2C_REG_TXDAT	0x0010
>+#define OWL_I2C_REG_RXDAT	0x0014
>+#define OWL_I2C_REG_CMD		0x0018
>+#define OWL_I2C_REG_FIFOCTL	0x001C
>+#define OWL_I2C_REG_FIFOSTAT	0x0020
>+#define OWL_I2C_REG_DATCNT	0x0024
>+#define OWL_I2C_REG_RCNT	0x0028
>+
>+/* I2Cx_CTL Bit Mask */
>+#define OWL_I2C_CTL_RB		BIT(1)
>+#define OWL_I2C_CTL_GBCC(x)	(((x) & 0x3) << 2)
>+#define	OWL_I2C_CTL_GBCC_NONE	OWL_I2C_CTL_GBCC(0)
>+#define	OWL_I2C_CTL_GBCC_START	OWL_I2C_CTL_GBCC(1)
>+#define	OWL_I2C_CTL_GBCC_STOP	OWL_I2C_CTL_GBCC(2)
>+#define	OWL_I2C_CTL_GBCC_RSTART	OWL_I2C_CTL_GBCC(3)
>+#define OWL_I2C_CTL_IRQE	BIT(5)
>+#define OWL_I2C_CTL_EN		BIT(7)
>+#define OWL_I2C_CTL_AE		BIT(8)
>+#define OWL_I2C_CTL_SHSM	BIT(10)
>+
>+#define OWL_I2C_DIV_FACTOR(x)	((x) & 0xff)
>+
>+/* I2Cx_STAT Bit Mask */
>+#define OWL_I2C_STAT_RACK	BIT(0)
>+#define OWL_I2C_STAT_BEB	BIT(1)
>+#define OWL_I2C_STAT_IRQP	BIT(2)
>+#define OWL_I2C_STAT_LAB	BIT(3)
>+#define OWL_I2C_STAT_STPD	BIT(4)
>+#define OWL_I2C_STAT_STAD	BIT(5)
>+#define OWL_I2C_STAT_BBB	BIT(6)
>+#define OWL_I2C_STAT_TCB	BIT(7)
>+#define OWL_I2C_STAT_LBST	BIT(8)
>+#define OWL_I2C_STAT_SAMB	BIT(9)
>+#define OWL_I2C_STAT_SRGC	BIT(10)
>+
>+/* I2Cx_CMD Bit Mask */
>+#define OWL_I2C_CMD_SBE		BIT(0)
>+#define OWL_I2C_CMD_RBE		BIT(4)
>+#define OWL_I2C_CMD_DE		BIT(8)
>+#define OWL_I2C_CMD_NS		BIT(9)
>+#define OWL_I2C_CMD_SE		BIT(10)
>+#define OWL_I2C_CMD_MSS		BIT(11)
>+#define OWL_I2C_CMD_WRS		BIT(12)
>+#define OWL_I2C_CMD_SECL	BIT(15)
>+
>+#define OWL_I2C_CMD_AS(x)	(((x) & 0x7) << 1)
>+#define OWL_I2C_CMD_SAS(x)	(((x) & 0x7) << 5)
>+
>+/* I2Cx_FIFOCTL Bit Mask */
>+#define OWL_I2C_FIFOCTL_NIB	BIT(0)
>+#define OWL_I2C_FIFOCTL_RFR	BIT(1)
>+#define OWL_I2C_FIFOCTL_TFR	BIT(2)
>+
>+/* I2Cc_FIFOSTAT Bit Mask */
>+#define OWL_I2C_FIFOSTAT_RNB	BIT(1)
>+#define OWL_I2C_FIFOSTAT_RFE	BIT(2)
>+#define OWL_I2C_FIFOSTAT_TFF	BIT(5)
>+#define OWL_I2C_FIFOSTAT_TFD	GENMASK(23, 16)
>+#define OWL_I2C_FIFOSTAT_RFD	GENMASK(15, 8)
>+
>+/* I2C bus timeout */
>+#define OWL_I2C_TIMEOUT		msecs_to_jiffies(4 * 1000)
>+
>+#define OWL_I2C_MAX_RETRIES	50
>+
>+#define OWL_I2C_DEFAULT_SPEED	100000
>+#define OWL_I2C_MAX_SPEED	400000
>+
>+struct owl_i2c_dev {
>+	struct i2c_adapter	adap;
>+	struct i2c_msg		*msg;
>+	struct completion	msg_complete;
>+	struct clk		*clk;
>+	void __iomem		*base;
>+	unsigned long		clk_rate;
>+	u32			bus_freq;
>+	u32			msg_ptr;
>+};
>+
>+static void owl_i2c_update_reg(void __iomem *base, unsigned int val,
>bool state)

Is base really a good name here? I would go with reg=2E

>+{
>+	unsigned int regval;
>+
>+	regval =3D readl(base);
>+
>+	if (state)
>+		regval |=3D val;
>+	else
>+		regval &=3D ~val;
>+
>+	writel(regval, base);
>+}
>+
>+static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
>+{
>+	unsigned int val, timeout =3D 0;
>+
>+	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>+				OWL_I2C_CTL_EN, false);
>+	mdelay(1);
>+	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>+				OWL_I2C_CTL_EN, true);
>+
>+	/* Reset FIFO */
>+	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
>+				OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
>+				true);
>+
>+	/* Wait 50ms for FIFO reset complete */
>+	do {
>+		val =3D readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
>+		if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
>+			break;
>+		mdelay(1);
>+	} while (timeout++ < OWL_I2C_MAX_RETRIES);
>+
>+	if (timeout > OWL_I2C_MAX_RETRIES) {
>+		dev_err(&i2c_dev->adap=2Edev, "FIFO reset timeout");
>+		return -ETIMEDOUT;
>+	}
>+
>+	/* Clear status registers */
>+	writel(0, i2c_dev->base + OWL_I2C_REG_STAT);
>+
>+	return 0;
>+}

This =2E=2E=2E_reset function does a number of unlocked read-modify-write =
cycles, and it is called from an interrupt=2E Is that safe? What if a spuri=
ous interrupt happen?

>+
>+static int owl_i2c_set_freq(struct owl_i2c_dev *i2c_dev)
>+{
>+	unsigned int val;
>+
>+	val =3D (i2c_dev->clk_rate + i2c_dev->bus_freq * 16 - 1) /
>+				(i2c_dev->bus_freq * 16);
>+
>+	/* Set clock divider factor */
>+	writel(OWL_I2C_DIV_FACTOR(val), i2c_dev->base + OWL_I2C_REG_CLKDIV);
>+
>+	return 0;
>+}
>+
>+static int owl_i2c_hw_init(struct owl_i2c_dev *i2c_dev)
>+{
>+	int ret;
>+
>+	/* Reset I2C controller */
>+	ret =3D owl_i2c_reset(i2c_dev);
>+	if (ret)
>+		return ret;
>+
>+	/* Set bus frequency */
>+	return owl_i2c_set_freq(i2c_dev);
>+}
>+
>+static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
>+{
>+	struct owl_i2c_dev *i2c_dev =3D _dev;
>+	struct i2c_msg *msg =3D i2c_dev->msg;
>+	unsigned int stat, fifostat;
>+
>+	fifostat =3D readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
>+	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
>+		dev_dbg(&i2c_dev->adap=2Edev, "received NACK from device");
>+		owl_i2c_reset(i2c_dev);
>+		goto stop;
>+	}
>+
>+	stat =3D readl(i2c_dev->base + OWL_I2C_REG_STAT);
>+	if (stat & OWL_I2C_STAT_BEB) {
>+		dev_dbg(&i2c_dev->adap=2Edev, "bus error");
>+		owl_i2c_reset(i2c_dev);
>+		goto stop;
>+	}
>+
>+	/* Handle FIFO read */
>+	if (msg->flags & I2C_M_RD) {
>+		while ((readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
>+				OWL_I2C_FIFOSTAT_RFE) &&
>+				(i2c_dev->msg_ptr < msg->len)) {
>+			msg->buf[i2c_dev->msg_ptr++] =3D readl(i2c_dev->base +
>+							OWL_I2C_REG_RXDAT);
>+		}
>+	} else {
>+		/* Handle the remaining bytes which were not sent */
>+		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
>+				OWL_I2C_FIFOSTAT_TFF) &&
>+				i2c_dev->msg_ptr < msg->len) {
>+			writel(msg->buf[i2c_dev->msg_ptr++], i2c_dev->base +
>+							OWL_I2C_REG_TXDAT);
>+		}
>+	}
>+
>+stop:
>+	/* Clear pending interrupts */
>+	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
>+				OWL_I2C_STAT_IRQP, true);
>+
>+	complete_all(&i2c_dev->msg_complete);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static u32 owl_i2c_func(struct i2c_adapter *adap)
>+{
>+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>+}
>+
>+static int owl_i2c_check_bus_busy(struct i2c_adapter *adap)
>+{
>+	struct owl_i2c_dev *i2c_dev =3D i2c_get_adapdata(adap);
>+	unsigned long timeout;
>+	unsigned int val;
>+
>+	/* Check for Arbitration lost */
>+	val =3D readl(i2c_dev->base + OWL_I2C_REG_STAT);
>+	if (val & OWL_I2C_STAT_LAB) {
>+		val &=3D ~OWL_I2C_STAT_LAB;
>+		writel(val, i2c_dev->base + OWL_I2C_REG_STAT);
>+		return -EAGAIN;
>+	}
>+
>+	/* Check for Bus busy */
>+	timeout =3D jiffies + OWL_I2C_TIMEOUT;
>+	while (readl(i2c_dev->base + OWL_I2C_REG_STAT) & OWL_I2C_STAT_BBB) {
>+		if (time_after(jiffies, timeout)) {
>+			dev_err(&adap->dev, "Bus busy timeout");
>+			return -ETIMEDOUT;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
>+static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct
>i2c_msg *msgs,
>+				int num)
>+{
>+	struct owl_i2c_dev *i2c_dev =3D i2c_get_adapdata(adap);
>+	struct i2c_msg *msg;
>+	unsigned long time_left;
>+	unsigned int i2c_cmd;
>+	unsigned int addr;
>+	int ret =3D 0, idx;
>+
>+	ret =3D owl_i2c_hw_init(i2c_dev);
>+	if (ret)
>+		return ret;
>+
>+	ret =3D owl_i2c_check_bus_busy(adap);
>+	if (ret)
>+		return ret;
>+
>+	reinit_completion(&i2c_dev->msg_complete);
>+
>+	/* Enable I2C controller interrupt */
>+	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>+				OWL_I2C_CTL_IRQE, true);
>+
>+	/*
>+	 * Select: FIFO enable, Master mode, Stop enable, Data count enable,
>+	 * Send start bit
>+	 */
>+	i2c_cmd =3D (OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE
>+			| OWL_I2C_CMD_NS | OWL_I2C_CMD_DE | OWL_I2C_CMD_SBE);
>+
>+	/* Handle repeated start condition */
>+	if (num > 1) {
>+		/* Set internal address length and enable repeated start */
>+		i2c_cmd |=3D (OWL_I2C_CMD_AS(msgs[0]=2Elen + 1)
>+				| OWL_I2C_CMD_SAS(1) | OWL_I2C_CMD_RBE);
>+
>+		/* Write slave address */
>+		addr =3D i2c_8bit_addr_from_msg(&msgs[0]);
>+		writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
>+
>+		/* Write internal register address */
>+		for (idx =3D 0; idx < msgs[0]=2Elen; idx++)
>+			writel(msgs[0]=2Ebuf[idx], i2c_dev->base +
>+						OWL_I2C_REG_TXDAT);
>+
>+		msg =3D &msgs[1];
>+	} else {
>+		/* Set address length */
>+		i2c_cmd |=3D OWL_I2C_CMD_AS(1);
>+		msg =3D &msgs[0];
>+	}
>+
>+	i2c_dev->msg =3D msg;
>+	i2c_dev->msg_ptr =3D 0;
>+
>+	/* Set data count for the message */
>+	writel(msg->len, i2c_dev->base + OWL_I2C_REG_DATCNT);
>+
>+	addr =3D i2c_8bit_addr_from_msg(msg);
>+	writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
>+
>+	if (!(msg->flags & I2C_M_RD)) {
>+		/* Write data to FIFO */
>+		for (idx =3D 0; idx < msg->len; idx++) {
>+			/* Check for FIFO full */
>+			if (readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT)
>+					& OWL_I2C_FIFOSTAT_TFF)

You should cleanup here, and return some error=2E I think? Or, why do you =
break out of the loop early?

>+				break;
>+
>+			writel(msg->buf[idx],
>+					i2c_dev->base + OWL_I2C_REG_TXDAT);
>+		}
>+
>+		i2c_dev->msg_ptr =3D idx;
>+	}
>+
>+	/* Ignore the NACK if needed */
>+	if (msg->flags & I2C_M_IGNORE_NAK)
>+		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
>+				OWL_I2C_FIFOCTL_NIB, true);
>+	else
>+		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
>+				OWL_I2C_FIFOCTL_NIB, false);
>+
>+	/* Start the transfer */
>+	writel(i2c_cmd, i2c_dev->base + OWL_I2C_REG_CMD);
>+
>+	time_left =3D wait_for_completion_timeout(&i2c_dev->msg_complete,
>+						adap->timeout);
>+	if (time_left =3D=3D 0) {
>+		dev_err(&adap->dev, "Transaction timed out");
>+		/* Send stop condition and release the bus */
>+		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>+			OWL_I2C_CTL_GBCC_STOP | OWL_I2C_CTL_RB, true);
>+		ret =3D -ETIMEDOUT;
>+	}
>+
>+	/* Disable I2C controller */
>+	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>+				OWL_I2C_CTL_EN, false);
>+
>+	return i2c_dev->msg_ptr ? num : i2c_dev->msg_ptr;

This is wrong=2E Should probably be

   return ret ?: num;

Cheers,
Peter

>+}
>+
>+static const struct i2c_algorithm owl_i2c_algorithm =3D {
>+	=2Emaster_xfer    =3D owl_i2c_master_xfer,
>+	=2Efunctionality  =3D owl_i2c_func
>+};
>+
>+static const struct i2c_adapter_quirks owl_i2c_quirks =3D {
>+	=2Eflags		=3D I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
>+	=2Emax_read_len   =3D 240,
>+	=2Emax_write_len  =3D 240,
>+	=2Emax_comb_1st_msg_len =3D 6,
>+	=2Emax_comb_2nd_msg_len =3D 240
>+};
>+
>+static int owl_i2c_probe(struct platform_device *pdev)
>+{
>+	struct device *dev =3D &pdev->dev;
>+	struct owl_i2c_dev *i2c_dev;
>+	struct resource *res;
>+	int ret, irq;
>+
>+	i2c_dev =3D devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
>+	if (!i2c_dev)
>+		return -ENOMEM;
>+
>+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>+	i2c_dev->base =3D devm_ioremap_resource(dev, res);
>+	if (IS_ERR(i2c_dev->base))
>+		return PTR_ERR(i2c_dev->base);
>+
>+	irq =3D platform_get_irq(pdev, 0);
>+	if (irq < 0) {
>+		dev_err(dev, "failed to get IRQ number\n");
>+		return irq;
>+	}
>+
>+	if (of_property_read_u32(dev->of_node, "clock-frequency",
>+					&i2c_dev->bus_freq))
>+		i2c_dev->bus_freq =3D OWL_I2C_DEFAULT_SPEED;
>+
>+	/* We support only frequencies of 100k and 400k for now */
>+	if (i2c_dev->bus_freq !=3D OWL_I2C_DEFAULT_SPEED &&
>+			i2c_dev->bus_freq > OWL_I2C_MAX_SPEED) {
>+		dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
>+		return -EINVAL;
>+	}
>+
>+	i2c_dev->clk =3D devm_clk_get(dev, NULL);
>+	if (IS_ERR(i2c_dev->clk)) {
>+		dev_err(dev, "failed to get clock\n");
>+		return PTR_ERR(i2c_dev->clk);
>+	}
>+
>+	ret =3D clk_prepare_enable(i2c_dev->clk);
>+	if (ret)
>+		return ret;
>+
>+	i2c_dev->clk_rate =3D clk_get_rate(i2c_dev->clk);
>+	if (!i2c_dev->clk_rate) {
>+		dev_err(dev, "input clock rate should not be zero\n");
>+		ret =3D -EINVAL;
>+		goto disable_clk;
>+	}
>+
>+	init_completion(&i2c_dev->msg_complete);
>+	i2c_dev->adap=2Eowner =3D THIS_MODULE;
>+	i2c_dev->adap=2Ealgo =3D &owl_i2c_algorithm;
>+	i2c_dev->adap=2Etimeout =3D OWL_I2C_TIMEOUT;
>+	i2c_dev->adap=2Equirks =3D &owl_i2c_quirks;
>+	i2c_dev->adap=2Edev=2Eparent =3D dev;
>+	i2c_dev->adap=2Edev=2Eof_node =3D dev->of_node;
>+	snprintf(i2c_dev->adap=2Ename, sizeof(i2c_dev->adap=2Ename),
>+			"%s", "OWL I2C adapter");
>+	i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
>+
>+	platform_set_drvdata(pdev, i2c_dev);
>+
>+	ret =3D devm_request_irq(dev, irq, owl_i2c_interrupt, 0, pdev->name,
>+				i2c_dev);
>+	if (ret) {
>+		dev_err(dev, "failed to request irq %d\n", irq);
>+		goto disable_clk;
>+	}
>+
>+	return i2c_add_adapter(&i2c_dev->adap);
>+
>+disable_clk:
>+	clk_disable_unprepare(i2c_dev->clk);
>+
>+	return ret;
>+}
>+
>+static const struct of_device_id owl_i2c_of_match[] =3D {
>+	{=2Ecompatible =3D "actions,s900-i2c"},
>+	{ /* sentinel */ }
>+};
>+MODULE_DEVICE_TABLE(of, owl_i2c_of_match);
>+
>+static struct platform_driver owl_i2c_driver =3D {
>+	=2Eprobe		=3D owl_i2c_probe,
>+	=2Edriver		=3D {
>+		=2Ename	=3D "owl-i2c",
>+		=2Eof_match_table =3D of_match_ptr(owl_i2c_of_match),
>+	},
>+};
>+module_platform_driver(owl_i2c_driver);
>+
>+MODULE_AUTHOR("David Liu <liuwei@actions-semi=2Ecom>");
>+MODULE_AUTHOR("Manivannan Sadhasivam
><manivannan=2Esadhasivam@linaro=2Eorg>");
>+MODULE_DESCRIPTION("Actions Semi OWL SoCs I2C driver");
>+MODULE_LICENSE("GPL");

