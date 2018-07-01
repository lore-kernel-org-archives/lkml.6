Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE42CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 04:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D47525327
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 04:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="HB0d/MUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D47525327
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeGAE6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 00:58:08 -0400
Received: from mail-ve1eur01on0130.outbound.protection.outlook.com ([104.47.1.130]:48960
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750922AbeGAE6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 00:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLN4wFt77H3az5MCIC65rxc3yklgxeR9ZNhMtImpxYs=;
 b=HB0d/MUogBQhRftE+s57+wmFkvZxClJzvyS3GBSy3nH7GASS/Qe14tYwpKIcraiYsJVmCiWz5dWNlwwAesIkBLgJqY2Lj4uDHPxmzFfdRDg6GjQqDIQ4HLELzcXiBeW35JLbX9Ik+63RxtCo1j0aA2/CIZ8Q/efGEZB/HPP4sX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.0.143] (212.186.128.86) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Sun, 1 Jul
 2018 04:57:55 +0000
Date:   Sun, 01 Jul 2018 06:57:54 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org> <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C driver
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
Message-ID: <5E14949B-D87F-496D-837E-243828268285@axentia.se>
X-Originating-IP: [212.186.128.86]
X-ClientProxiedBy: VI1PR08CA0090.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::16) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d53080-b1f6-4982-5644-08d5df0f353d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:5GHXD2Vn6pAYbsMTLHxzeuC2IH0Dj3WY6pll+rQzJtFhGHu0D55Nf3v02jz0l+sUEuDA8zzw/8jIEuEYKGTRTpLR7zh/aWvQCqAt03aZDwuKCJvCUo3cH0QPRmVdPWKyNt40EqOSnE0wulbDNYx8U9SzFsKKmqAGgm7zM8CkNZnNSyEn6zwNzqsNDLfjF1rMzsVRTXEJATWAZuGZqagcEgc9fN9fV2TDepvPV2Eo/QfTVd+wDuE89WjnaWENJsX2;25:l4Gg+/itbVzQJQoBk0NuHr+XNN6B3DXv+vC46izNJMO0zEDVibyeaCZr1tsXZ62jfhqdZWuxb6wZ4YIpRzhtw6tIZJw93zgWY1y87RKu1pRaRX2t9iF+vjaWoryKYOARgarBAZwbWb1kTnIVoW+TrSJ/F1woUtr9j+/HXZQPsh88auxOyQiieP2U5rjcN61439hbg2Lao5KId6bf716AmmE7YrMO0i4YVcmhF0GO8w1/ogzk+RKMn/6KmCTQsSA095adDjJ1xr4X6XIFODF53qqtFV+LzS5vbLPkqlly4AGCGFmT7Yvxw+bCMACY7D0AP+ZA5XELqQVMoe56biy5Nw==;31:pRXUg1aeuFU2NWnCbQK1ojH1w9c512PDvyrb8Pxpm9yFox0ad9Hx85zDzXumpfMcD+6Yqd5pAlnIFPrf/RTdE0CnDoVCAEXqGgj9jW7BGprjSdaG/oGMK0PBcJus85Cr5q/GxIr2yurmH0osjkI/SpDMqylv9S3XdhUprm9W5UagzyRfaczAbc6wmuYgSmlJuP5X22JP34Kjl4M0AmZgkzB03wNx7P1mw5I1kZIHSeg=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246447D34F219DABC1D0439FBC4C0@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226)(106291317490208);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:Y3XzwuoRsVNo5nEm7V04lGtGX+O8OHQJpk9i27/4bu150ROBGZRIJwU1ZJilRl35TYCmZnYBX6ipuWBlQAkWrrhiHRYHPnWhxiGn2dULk9DJ6WCXF33Je8ki489q1Lcd5DeaPLnJ3n6mHyfbEBULnPBg083KRx4CxxDvxEcxuKgZvU5U9KBL3zIFfK/s6qsNZGZfywDJOr7jGzxDdlZS33f2fL2pdfJKFuBpetGG2Xq7dZxlpyH+HdEgMJL+0IrccEmYh5tWM1t6xYw+1JAAqA12O5e+I520psQwic7+9bp/sCmQbEAyMouTE3vsI/kTatFhqK96+VBCWe6pwKeAN1fc4kYOaRAPE+ZwAIJVfFg=
X-Forefront-PRVS: 07200C0526
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39830400003)(136003)(366004)(396003)(199004)(189003)(3846002)(11346002)(6246003)(6306002)(8936002)(81166006)(7736002)(77096007)(5660300001)(74482002)(8676002)(2616005)(4326008)(25786009)(68736007)(97736004)(8746002)(14444005)(16526019)(305945005)(117156002)(478600001)(82746002)(7416002)(53936002)(83716003)(16576012)(316002)(2906002)(106356001)(58126008)(81156014)(39060400002)(52146003)(50466002)(966005)(66066001)(105586002)(36756003)(26005)(551934003)(386003)(486006)(47776003)(956004)(186003)(446003)(476003)(76176011)(33656002)(2486003)(229853002)(6116002)(52116002)(23676004)(6486002)(575784001)(86362001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.0.143];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6UWRXaEZyQnU1cTFRcjljYy96WEZQWVJG?=
 =?utf-8?B?ZTc2MlV3K2h5Z1BjamJYWFY0ell5c2RHNU5BU1BwU0RJeTJabTNTM051UWd0?=
 =?utf-8?B?dTEzWWNYYjJoT2tncW95YkN6RkxQaGtISmw2bjNMWkgrL1RmbUlWMFZJcS9i?=
 =?utf-8?B?d2h5a0plcnhKTlEyN3I2eEJZbWVJZXNZZUdZSzVaN09PcHJGWmVvNlE0TGVT?=
 =?utf-8?B?a0h3N2haeVZJZmgxRWp3SkxONW1nL1hJTVFKVnVTb3N6WTdHUjZlTndvWkVS?=
 =?utf-8?B?WmZwN2ZETHlRenhHQ1hsS1V0bmcvTmNSWVhuaFRRVktHOWZBOFFUTlp4UWs5?=
 =?utf-8?B?T2RtMnA1YUVJd1FURGRvb000aUZJR3lSSFMxRk4vcUNOVDJBdlhFUDJXQXRR?=
 =?utf-8?B?dklwdXBFd2ZhZUl0U0liZ3poTnJlR0QrQ3JaM1oydzlqYUdBUnZwTDVVWlBW?=
 =?utf-8?B?WU0yZ0N5ZG1sM3JSWXRZclU0cVhDQzl6V3ZsL1NYRmNZY1YybE43ZkxXMFA5?=
 =?utf-8?B?ZkdvMmlrWXJRQndtekdZNGtkZWVzNEJ3eWhxWEZ4eXBGdGtyUm80RXRHWmRl?=
 =?utf-8?B?dXQ4QjdnajdPN1l5TmVFL01qbjZnTEVkZDRhOFRpYlpsNlJWbGZQT3hld0tW?=
 =?utf-8?B?NGs5a09xUllmOFdRaW9BNkRzdUhOWUlRalZGTE03S1RuNmdjQ2VoSE12REtX?=
 =?utf-8?B?ZnBrbXk0ditkWmNaVkhOZ0t2MUROYktJMkFVRzg2RzBSUTJQci9KdEU0elc0?=
 =?utf-8?B?SG5vbm5JWU9vMjAwQlpHVmswTUVDaHJDVXdIWDdYOUdvcStMOHZ6OTY1UjBN?=
 =?utf-8?B?WW9nL1hET0NXaVgzSDF6ZG8rWmRHZ25BOFhKV1V2T2NoUERodDBRZ3ZOVUo1?=
 =?utf-8?B?dXVJaE5nWHNwMWpiUCsrS2g3QlF1aWtKeFBYUGpKajhXZHZNRmVPVi92a0NO?=
 =?utf-8?B?M0FMZENYTzZ1dDgzZ2pmQnhHVE9PNXh4Z0RFekw0RkZmTFBEOWRFQUJvVDR1?=
 =?utf-8?B?Q3pnVWorRjFRNUtGbU1zTDZ2RGNXaFZGdnNPMVMyTFV3K3BCRThoeFZSOHpu?=
 =?utf-8?B?V1JWd25YZHNCZi9yZVV4SDVCL2J3cEtYUHg4Q2ZBWE5idVVLVEhtbVVFN1dQ?=
 =?utf-8?B?N2J1Ui9qQmt5bncycGpWOUpVaitELzNvRFhkbjNjbkpSeW9KNUdVTjR6MzFO?=
 =?utf-8?B?ME5wZTQ5U3MraGZxajhNdHJmMVJZaE5aNVYrUWZvU2l4MU0zSlJxNzRSRG1x?=
 =?utf-8?B?bzAyNmdIQmg4QVJnUEM3ODR3YkVPemE0SEluOWU3NDZuNEYwcVVrejZpK2c0?=
 =?utf-8?B?WkdUTEY3eWJvOXVNMmtZTFVJNmFySURxd1hNOGdybVU2N3lTa3A4QSt0VFk5?=
 =?utf-8?B?NE1sZXR0SEhFNE5aMHB0UTdJYm5CcEFQMzI0b3M0UjhUVjh6RkwvWjlqOEVE?=
 =?utf-8?B?U20xTk9LNjFrM0tCZTFzZ2grU3JqdGp3KzdYRW5iWE13VFQ2d2RLbWRmUHpX?=
 =?utf-8?B?eUcrWUVvb295ZjJOYVd0elhXSWJDUFhiRmVSVjQ3QkxDNFMxbUExZCt6SFVU?=
 =?utf-8?B?VzhpYzl2RE4rUUY5d2o1SE1wWlRJeTZnZU43RkZlOUwvYkgyK2tPNThsSXFi?=
 =?utf-8?B?VThjZUh0bS91aXcwQk5tTzlTOXZKb2pPckd1ZmswbkNuZmFWUEdGMUlCMnlV?=
 =?utf-8?B?Tk9ndFlTek1MM09yWXlvb0JjYUl2cmxDN3pSaElrS0VSbUp4UjgwaXVsTDlm?=
 =?utf-8?B?QzBSbUNINUJjd3hUWm1ZbjdpdWJXdkxCUWcySDZ2RHpNMHBUbEcwNW56VjB0?=
 =?utf-8?B?aUx0Q3FYMjdlVkpsY1M4OG41RjlRRmlML25HOXZJQzA2Z2Z0MkFELzlDTFkr?=
 =?utf-8?B?U3BGL0Y5UXNuTThabkdhS09XV3hTcVpCOVVBMHQ4K2kvaW1yVXBveXpScmFF?=
 =?utf-8?B?SDFIVGZnV2piRG9mNlJCRjlzcTNJY1lYQ210bXQ2bjVkNnhUMHNldVQzQXJJ?=
 =?utf-8?B?c0pySWRZS0Y0bHVDcEc1SURLWUF0OXUxMEZDV2FnPT0=?=
X-Microsoft-Antispam-Message-Info: T4pFXyR4BAryGw+r2NvOfp1dYGO1fgxflokzVKs00i00MvA0/iwNNhPMXoFSDPDv5Df3zUhhotm9DQELpErXikjNKJxxlW/DtQovFZG7aDQj9fLLTAil9kI4e0/gyj7wYyM+cX6MB0mQu45zkQZOjF9Mx28jOsVwc6Dnd307pllzo4ggjPFiOFOamlpCkiF2zcRsIqjvmH4djsxjb6l9f2kxvX5NmJIYj4d3ss/pX6yGUnWuugz/ulMjpru/ofzEKwmQhD5TXv3B9KWSgxyljm1el7A2lhWLZI85zNSn+K2/oHICfljjoxbtBdwqA3BcYSKHGwWRZSEBDpXoZXpEqSfGW4D1JKYkqqIXOGVbikI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:T7VJ4AfhVLAF+orM3MGhuirt60/XuSHqcPItevFTLyrHB9QVCXqE21Owx5bZw+LnDhDXikDR0+oYdbDXFcpW3QEfr4C3pnpoRyj9KDmOO1VJeQACAGCNdm2pGwWm8UGuxrNW1CgDJQYXPjbTXUpOoin3Q5kSRJHv/UE4NfRdNuPfBUrrZVjVISAxPjGrJP58gYY/iF9kfH8jFTLOTqp/IcxinYX4fT4sw+07ehbLlx+ceCOhXsBZaLKnOIZqz4vG6PUJ5Bvp+q+GR6i3IIY/wrvE0tiB31+7k1dElZ7CTy5/TwUr/DpyZIlCruZlh8WIvwMGf9yko7+gYZrkFAmcIVtvXJ9XQ+Eui23ISb14pSlKw3QmpPVQUm1xbX/RtS2+K1hX5jjGVa0bMUB1BBMQmFo3OvkWcLR3T8fOJQkZJVY3M1h7puq94wjTwIaaMHyP2L3rZ1FSJw/D2i+wQYuDDQ==;5:aT8ac/35m6PWOrXjF7RO8dnFijLzkEH59v6dtuOgH8qtPgeDEh2MfAGC4toSxKs1vj+HJj/IsErbm7F3UWBCD1edFk1sHmlJZibgxOjf6k8a5krPIQcOc0rCYJ3l8x9+o0GEyubom9PU5WVSKrHNcRbzSjkrFKg5AmqrEBJU14Q=;24:D09CjUkzEWgqGEMCU83POFis7esRpqFPkVhN14Xw8o0wSTlW4OE/19j87dxWgFZKK8pNRb3TJ7A0zHVaviJZQu/7CZClcV5dqIK6PRN+PXA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7://aCStagziJa2FbQBCWl5jbILcfntqVxcJcbmsnzpjO5rShOepDTwXQhnUt0UjvRdjyNaAaGeQS2az+rmhrQoU4ue3D3zFyE7tJQLaV6Um9MYlf/5KFy5iLoG6on9MSRJI0SyF93YfJYdhYK87qfgpoyyVvoBGDLUcPBt8tmyOqhFCVCP/3n9wiHGAf/qgsxdFtswnmhml+BZ2U37nxzFHYEO2mnDG0EqRz24Imvl+xu9gCMNmiIUi2It3tfMxYt
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2018 04:57:55.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d53080-b1f6-4982-5644-08d5df0f353d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 30, 2018 3:33:29 PM GMT+02:00, Manivannan Sadhasivam <manivannan=2E=
sadhasivam@linaro=2Eorg> wrote:
>Add Actions Semiconductor Owl family S900 I2C driver=2E
>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>
>---
> drivers/i2c/busses/Kconfig   |   7 +
> drivers/i2c/busses/Makefile  |   1 +
> drivers/i2c/busses/i2c-owl=2Ec | 477 +++++++++++++++++++++++++++++++++++
> 3 files changed, 485 insertions(+)
> create mode 100644 drivers/i2c/busses/i2c-owl=2Ec
>
>diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>index 4f8df2ec87b1=2E=2E8c8025f87ce4 100644
>--- a/drivers/i2c/busses/Kconfig
>+++ b/drivers/i2c/busses/Kconfig
>@@ -762,6 +762,13 @@ config I2C_OMAP
> 	  Like OMAP1510/1610/1710/5912 and OMAP242x=2E
> 	  For details see http://www=2Eti=2Ecom/omap=2E
>=20
>+config I2C_OWL
>+	tristate "Actions Semiconductor Owl I2C Controller"
>+	depends on ARCH_ACTIONS || COMPILE_TEST
>+	help
>+	  Say Y here if you want to use the I2C bus controller on
>+	  the Actions Semiconductor Owl SoC's=2E
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
>index 000000000000=2E=2E144a249bf994
>--- /dev/null
>+++ b/drivers/i2c/busses/i2c-owl=2Ec
>@@ -0,0 +1,477 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/*
>+ * Actions Semiconductor Owl SoC's I2C driver
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
>+#include <linux/io=2Eh>
>+#include <linux/module=2Eh>
>+#include <linux/of_device=2Eh>
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
>+#define OWL_I2C_DEF_SPEED_HZ	100000
>+#define OWL_I2C_MAX_SPEED_HZ	400000
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
>+static void owl_i2c_update_reg(void __iomem *reg, unsigned int val,
>bool state)
>+{
>+	unsigned int regval;
>+
>+	regval =3D readl(reg);
>+
>+	if (state)
>+		regval |=3D val;
>+	else
>+		regval &=3D ~val;
>+
>+	writel(regval, reg);
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
>+		goto stop;
>+	}
>+
>+	stat =3D readl(i2c_dev->base + OWL_I2C_REG_STAT);
>+	if (stat & OWL_I2C_STAT_BEB) {
>+		dev_dbg(&i2c_dev->adap=2Edev, "bus error");
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

Here is a read-modify-write on =2E=2E=2E_REG_STAT from interrupt context=
=2E=2E=2E

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

=2E=2E=2Eand here is one from process context=2E

Can they cross? If not, why? Either use some locking, or add a comment exp=
laining why this is safe=2E

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
>+	int ret, idx;
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
>+	/*
>+	 * By default, 0 will be returned if interrupt occurred but no
>+	 * read or write happened=2E Else if msg_ptr equals to message length,
>+	 * message count will be returned=2E
>+	 */

Zero is never a valid return value for this function=2E It has to be eithe=
r num or a negative error=2E So, this comment is bad, which makes me assume=
 the code is too=2E I didn't bother to check any further=2E=2E=2E

Cheers,
Peter

>+	if (i2c_dev->msg_ptr =3D=3D msg->len)
>+		ret =3D num;
>+
>+	/* Disable I2C controller */
>+	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>+				OWL_I2C_CTL_EN, false);
>+
>+	return ret;
>+}
>+
>+static const struct i2c_algorithm owl_i2c_algorithm =3D {
>+	=2Emaster_xfer    =3D owl_i2c_master_xfer,
>+	=2Efunctionality  =3D owl_i2c_func,
>+};
>+
>+static const struct i2c_adapter_quirks owl_i2c_quirks =3D {
>+	=2Eflags		=3D I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
>+	=2Emax_read_len   =3D 240,
>+	=2Emax_write_len  =3D 240,
>+	=2Emax_comb_1st_msg_len =3D 6,
>+	=2Emax_comb_2nd_msg_len =3D 240,
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
>+		i2c_dev->bus_freq =3D OWL_I2C_DEF_SPEED_HZ;
>+
>+	/* We support only frequencies of 100k and 400k for now */
>+	if (i2c_dev->bus_freq !=3D OWL_I2C_DEF_SPEED_HZ &&
>+			i2c_dev->bus_freq > OWL_I2C_MAX_SPEED_HZ) {
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
>+MODULE_DESCRIPTION("Actions Semiconductor Owl SoC's I2C driver");
>+MODULE_LICENSE("GPL");

