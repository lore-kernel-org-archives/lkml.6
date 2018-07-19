Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0959FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8246D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="det/mIkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8246D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeGSGn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:43:28 -0400
Received: from mail-eopbgr80139.outbound.protection.outlook.com ([40.107.8.139]:55628
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbeGSGn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtvD+JP0avgBO1pOQKolOY3CoeFrnT7qd9aNu8uSj3I=;
 b=det/mIkd2/wT1fcWa4W+qyX6TrU3a5srvK8jDoGfadqI/XIN1isjE0sjPFqfBtTr3iwNGx/1g8h42ogtAt0vc6lYss0PwBoCIxdhmgKgWZZaS2MC4xVv4E3BusZdi9a4LBzlbZfijirTX/rMmP6Ox2yfMbwQ18t1JECU0QZ+SSo=
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 06:01:50 +0000
Subject: Re: [PATCH v4 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
 <20180701172305.15663-6-manivannan.sadhasivam@linaro.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d1a1d687-dfa4-e9cb-7216-67d458000234@axentia.se>
Date:   Thu, 19 Jul 2018 08:01:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180701172305.15663-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::21)
 To HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc8e3ee8-7822-4c11-bf02-08d5ed3d1ece
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600067)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:ErZvzgylOMXCUNcgfnsPKkivFOSj5YsxAoLZPN7WaybJyriBH7ti5X264osC9rQCFlIlEbvvpMM2CwG2tnhL9HC0z3BepHOcV0rVQGeaZD9aC0o/bwVzdOGVikmarVJAWEk+xKsrSlf5ZW/9IEVHuiEp2CrekKuT5+uVJko6DkSyoyEeeKGbMsA5yKmlvxJd7SqUR8VKO+UFKR0h6xWzfuP8tsYuSQduhWRnhvSYTrlsllJLZDQQXrN/GlJ+RIml;25:/Vx+oyiTDrX2QaptcZCQD6YNemUS+HhOdmaZxPBT02zRKHbniF9xRqHfUDNVhVFDnYqN82S022vOUIAZL/RWltC9cx6soUW4mHzcweNMN3bBFWX8zcbWfefxS0YxseRjjm+umte4QOrDhLDUHVlF86TQar4F6eKqrpCsbgnDgAfu3VcH1N/L9061XXAeTsHYzh4kvu0rAZ7oVlPRT/gNfNDq12pi5zw6Eq90AKAkdpyg3b5Ee4eLS0JWeDz4/Cthd7XZCnx9c7iWbT4wSxw3pekIttNMfwoRPhvqiZs/snbihexDmVG041sQyyQMeL4pnG4ujPurtrFWTDBjLN19bw==;31:PjeeKINDjAlVBFiW+iHzaNV+PFSe3MjzDk7emQ6mILqVHeQZvo3kuYbphLwQPATz3Zbj4ZJpJjJQCMoq9UDDsyzoKDNEp0lvzPGieQZY2KwJFKVi4zdOblE05k20qCvNBurlupptp+T41LNZ21+hYG0oyB94JUA4c6tWLMe0WfQvCnJg+F6OPMslCrJ+W9cbbUBlZZ3EqH3j9d2WiBW9JuvKnd2iameaM9Y3QhtcHwU=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24585B067FE5AACAF4E88D40BC520@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226)(106291317490208);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:Cnm0bYrVusUoeB+msMOdYCXX3m1LUpLpE5NWZER80Sw8a20u836xJUIGhOFjqe6rvvd8VuZpDZ+OJfki4FW48/eMcuVOlt9AibwSPV9ljO0O183kqNie5gkJXxZyRqlbIIqRowZIeRs0SRZptBcak60hPOtfaSVETdfh1WS2beIsKpCTyc0knzy/6/tqMBoUCKTqfstQDcTuROAivtXSJVxCoGh1ubzyJPhPD2MsdaH5Bgc0N5QPVuN0rLQ+UnG5PbeaONd4uv37K5VVPnALKqaYJZ57MoIyCmbVu3RuhqMp36ENIR9IB1l1Rn8OpokOJPG3MKAkvbxQP4gS1dR0i5MVdqsMxnmYoGYCh8dm6Ro=
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39830400003)(136003)(376002)(189003)(199004)(5660300001)(36756003)(117156002)(386003)(966005)(3846002)(76176011)(6666003)(81156014)(8676002)(478600001)(52116002)(52146003)(6116002)(36916002)(23676004)(2486003)(65826007)(25786009)(3260700006)(47776003)(53936002)(4326008)(6486002)(65806001)(64126003)(6306002)(7736002)(305945005)(229853002)(8936002)(81166006)(230700001)(6246003)(53546011)(7416002)(50466002)(39060400002)(68736007)(66066001)(65956001)(86362001)(575784001)(16576012)(14444005)(97736004)(486006)(316002)(77096007)(31686004)(26005)(2906002)(186003)(16526019)(956004)(74482002)(58126008)(11346002)(106356001)(476003)(2616005)(446003)(105586002)(551934003)(31696002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTg7MjM6SjZDbzhOSlpnQzRxNnFtTnVuaVpTenk5?=
 =?utf-8?B?L3g2c3VOVlpXVGJ0Z0ZOTzdEeVdjc0VhRE1QR1ZJZWE2MHZ5SE0raTYyNEtF?=
 =?utf-8?B?UG13UzcxVlhjcXlpWkhGWjJPa3FaTlBXTFhuYjgyeWZnUFp1N3R2N052Zkk2?=
 =?utf-8?B?aG9JTzlFL0JOMkhKcUpBbjA2YzVCazRBQ0JwaVJKNnhhRHhMbFp1MjJMVGpO?=
 =?utf-8?B?WkU2LzZwZVdjKzM2Qm1YSXpLSjYxUG5nOFF4ZG1FTlFxTkxBOGRZNnBnaFpX?=
 =?utf-8?B?QjlWMDZpQ2huSTcyQzdEbURLOC9NQmNZMnhNd2FxSWU4bVRtNTN3bi9MLzBs?=
 =?utf-8?B?c2lySFlsOWg4VU96OUpOSWhQbmZJcTZ2eFNGNDI2TlRUZnhFVEpjUlp2WjNs?=
 =?utf-8?B?WVJEMERobEJxZ3FER1RjS0RPbGpXZnJqNHNjSkxiL21scS9Cb2prY2tCSyt1?=
 =?utf-8?B?N0xjL1JNZnlOOVlmTmx2cVhVcUtaZUp0bVladm5ZVVBVN1oyK2h4ckxSWGs3?=
 =?utf-8?B?dFFOcHVndWhIdmcrM3hrWi9OQVpBMHpwcVZyNzd3Q0J3TFovem90am10VUQ3?=
 =?utf-8?B?dVUxTmlnSVUzY3B5SWt1SmkyUHIrNTJRdUNsaTJPM21iZmZ4V29oanJXNy84?=
 =?utf-8?B?cVpIOHNkbGpzQXhieVlTcmM3L3FnTXpMa3FHU3VjZUJqODdtcjkrejNDajN6?=
 =?utf-8?B?dzZmVktyMC9IcWRrR2dtM2FJdWxBZXQvUlhlK0l5eUM5NS9USC9ZQmZlZ1NC?=
 =?utf-8?B?UVlpNkVtQm5oeE14c2M2UUxvNmVKRUhDTTBROFNBWnZsL2pSTTJ3bFJRbERy?=
 =?utf-8?B?T0FXQWxIUldKUlM4TGFmNlg1T2QrNnRRUTZhZVVZd25WVjNiSmRrd242NFhO?=
 =?utf-8?B?OE95Nm1ua0VMQlEyVjFKRndQVFE3YVlBMFBKa0YxSm01b0h1Ym84cEtnWWxG?=
 =?utf-8?B?YmVjM2swZjEvcGttM1dXdXoxUmlta0tjWHhIdDM3VHpmOHVNbVZnci9GdTdp?=
 =?utf-8?B?Sk8yQnRoVkRQM053RzZsSlJaMXl4d2g4M09BZ0YvWkJld3o5K1JFSU43ZXds?=
 =?utf-8?B?ZTdoZFArTHQ2a2FTMnJlMENuSGNxaEwxZ1ZOcFhlMlpZbFZjMmg3bklVWWNZ?=
 =?utf-8?B?cnlYMnU5SE42VTBhd0lPZ3h4Mi9qSS9vd1U3MDFwYkYzdU82dEFMcFRWa2NJ?=
 =?utf-8?B?OXlYZGt5TUJvWm95aFVMWXY2djR4WUZSeXJ5SEdxN25ScS9lb0g3KzJJK3Fm?=
 =?utf-8?B?THorQS9sYkZqQzJKK3ZNYzFUTFdaL2hsZHMrYWZ0N2srTzc0QWI0WitzREI1?=
 =?utf-8?B?OE4wMlJJQ0YwelhJcGJmekxrb0FVajFkNTdpSHRTZVZvUUM1MngzT2hXODRJ?=
 =?utf-8?B?WVEwYnJFak1ZOFJpdElSNlV6a01nNGhZU2MzbWlhVitEV3B3MUxSeE10cmFO?=
 =?utf-8?B?Vi8xY2VtS3c0dXZ6T3d0eHVzN2ZoTUFVR0pWbVVEZHVkeFhGUzl5ZWVqL1Bl?=
 =?utf-8?B?SWdJYjdIdTNVNU5FVHJyWlhadHJQZzdiSzRFZFMxam5CVlJRYW1MUnpzRnBW?=
 =?utf-8?B?Y1VjWlhNMm5vUUtlVklOVWkyeko5d3dKcFlqVXZmbWZrMGpTa01Xc2Y3UHVP?=
 =?utf-8?B?YWNJNFJsb0NNTmZQSU15NWJSMGxMaUxUTERjSWRMR0Vmc05QclNodm44eWZ5?=
 =?utf-8?B?MC9wTlF4cDVrZ1JjdWRjdWZsTFpKQzYwell4RkZ5V1gzNEVtY2FvTW1TdlJ5?=
 =?utf-8?B?NXZQTmp1S3R0QUVPWnQwamFraTlYckpaSHpKQ0VJcUw1QTdQeTRGek5OTE1V?=
 =?utf-8?B?Zm1kZnZ1R0xvemtRYy9XYkhud0JlOVNEbWdFUHhKQ0lqWktzanNkdXlVQ2Vu?=
 =?utf-8?B?Ui8xOUUwWCs4My9vQ0xLOG5JV0hLM2JOd0lnc2xiU2huRWEzWHkxNCtTSW1i?=
 =?utf-8?B?UWZpSXRWUjF0Q3dsWm5iMXdWTDJDSGgxcFFocDd5ZkV1aysrakVhMHFPUmpy?=
 =?utf-8?B?eGxNdHBVQ3piLzFzOW9seTZ3STAyNUQrWVdhUUI4NHFhOHRja3NEMFNhMEZ2?=
 =?utf-8?B?NElDdEp2bEdoRmREQ3M3ZCtYUm1VamxWbGtsbkhaNFZPeTNka2I3cm9MR3Q4?=
 =?utf-8?B?a0kydTdTVHZlUDNLN3NVNWxFdUQxb243N0VYS3U0eklHOTBpRFZXaHJLUS9a?=
 =?utf-8?Q?JyFJwvwdhp9Uwd9v1qV3t2XTwqd6sHCakEhcsiOh48oI=3D?=
X-Microsoft-Antispam-Message-Info: LSnoHE3I6SAYtqCmxtyxLBHzBm6xSSCK2B3WnBzRUqkluq34kwiejls2LI28EOokgIk7pJR1+T8lWJ5AATK8ai4RtF0cQwwt2nV+mFVS7zJ7eikoVZMYvY5Pc+7pHkP1HK9MGZnbRblUp0lGVwdJHwoiZPZH+r4eq0QpfjY13FozyNWgU/URC73e+QlFi7E2pW2mOM4Jxh7MyU3nMRtWydgdYqYyAzTOn04EBLqX0Wf4cc32LPRth5Tg5Qt/7R18gXcPVJu5B+ZQlESIrdbo+IB0j/Ah0wr/2S4dh4NfE1wFSoP4/NmleSsGN35xkWM4s6zUD4LL20ZXD40vewqbdGjJkFjG4/Nmlag4WKdfr14=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:/VjKTGAZUcxJAREJaFM/2sJlmI0SkNEzTorUjUu44BqIImIdo6nKgpVoKsH7l+xVyfsTQ0SyYQuPnHrIgYWjH+N2o+pdzS/OCrop3hh3+KgTDacxRClvyvULMu2qzTstclrhHPETcmFyo5IChU1c2ECHCMaqiiHGaG+BvIQWoauC02PKYVgQjYlyzy7ouw4Tn58xLZQ0zjcrDCtvCJKwvdBov4+/rXCIfpDJZ4aXNzAmy/mwPslODR8ZUOsFKQUwNjY1icXy6itRNDzOzHWL+OJ5j2rVmMg2VBNLuMw1uNKoK6T6Fo+lPs6RuE8uL99AlyVM9OmQ4Hhk+hCm7TAFWzT0sE+cabXjw6ZYp/xz2WtUQ69PKT1+c6Sjp2Iskj8SivT6soba65tkEJb7keCFZ6h7ScB8QBT9WBLfW/pO9oo7LSqqCLpSL4CoJUmnSX5sWqoDOmPGG/MRiOZOZ2s1Ug==;5:M0wI8249cB223uIE5l2RGDxb3qinseVXH9E1PSKHuo+7uiFIvazcNSQlFhtGtdlknGcFysHeZaN5jhjhvi01xUheblmbg6uzrSQQ6iZLzSiMw/7LYIdVvu9aB14pb3zssrH96I0tfcthDwawlhmTf42g+fSoqB1BDe6RNKNzZq8=;7:+V/yMnA/pJpWgnMQle76FNm+6IUoRlo6bWywGqO2Tvd33+9v+GgbwY+WRfSqEj06PDFVYPRRm88pbkXlhyNwkp+dGwUET6mlr9cUJQPxjRe9KR/hms2Z58TMHoK/Va2qNIEURepq5lJplzG/tMj3xENR2fcKRoDxaI6oivtZrNNWy4sfRTS6M4DKdCnvn8VaOys5IBFxGPZj0TzUySd4tXaWL50qID32Lr3sT7k1RR+4yVM0LcFTW+nuYAEoUFCn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 06:01:50.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8e3ee8-7822-4c11-bf02-08d5ed3d1ece
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-01 19:23, Manivannan Sadhasivam wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/i2c/busses/Kconfig   |   7 +
>  drivers/i2c/busses/Makefile  |   1 +
>  drivers/i2c/busses/i2c-owl.c | 504 +++++++++++++++++++++++++++++++++++
>  3 files changed, 512 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-owl.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4f8df2ec87b1..8c8025f87ce4 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -762,6 +762,13 @@ config I2C_OMAP
>  	  Like OMAP1510/1610/1710/5912 and OMAP242x.
>  	  For details see http://www.ti.com/omap.
>  
> +config I2C_OWL
> +	tristate "Actions Semiconductor Owl I2C Controller"
> +	depends on ARCH_ACTIONS || COMPILE_TEST
> +	help
> +	  Say Y here if you want to use the I2C bus controller on
> +	  the Actions Semiconductor Owl SoC's.
> +
>  config I2C_PASEMI
>  	tristate "PA Semi SMBus interface"
>  	depends on PPC_PASEMI && PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 5a869144a0c5..b71618f77880 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
>  obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
>  obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
>  obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
> +obj-$(CONFIG_I2C_OWL)		+= i2c-owl.o
>  obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
>  obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
>  obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> new file mode 100644
> index 000000000000..580f8d092302
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: GPL-2.0+

The preferred spelling is GPL-2.0-or-later

> +/*
> + * Actions Semiconductor Owl SoC's I2C driver
> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Author: David Liu <liuwei@actions-semi.com>
> + *
> + * Copyright (c) 2018 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +/* I2C registers */
> +#define OWL_I2C_REG_CTL		0x0000
> +#define OWL_I2C_REG_CLKDIV	0x0004
> +#define OWL_I2C_REG_STAT	0x0008
> +#define OWL_I2C_REG_ADDR	0x000C
> +#define OWL_I2C_REG_TXDAT	0x0010
> +#define OWL_I2C_REG_RXDAT	0x0014
> +#define OWL_I2C_REG_CMD		0x0018
> +#define OWL_I2C_REG_FIFOCTL	0x001C
> +#define OWL_I2C_REG_FIFOSTAT	0x0020
> +#define OWL_I2C_REG_DATCNT	0x0024
> +#define OWL_I2C_REG_RCNT	0x0028
> +
> +/* I2Cx_CTL Bit Mask */
> +#define OWL_I2C_CTL_RB		BIT(1)
> +#define OWL_I2C_CTL_GBCC(x)	(((x) & 0x3) << 2)
> +#define	OWL_I2C_CTL_GBCC_NONE	OWL_I2C_CTL_GBCC(0)
> +#define	OWL_I2C_CTL_GBCC_START	OWL_I2C_CTL_GBCC(1)
> +#define	OWL_I2C_CTL_GBCC_STOP	OWL_I2C_CTL_GBCC(2)
> +#define	OWL_I2C_CTL_GBCC_RSTART	OWL_I2C_CTL_GBCC(3)
> +#define OWL_I2C_CTL_IRQE	BIT(5)
> +#define OWL_I2C_CTL_EN		BIT(7)
> +#define OWL_I2C_CTL_AE		BIT(8)
> +#define OWL_I2C_CTL_SHSM	BIT(10)
> +
> +#define OWL_I2C_DIV_FACTOR(x)	((x) & 0xff)
> +
> +/* I2Cx_STAT Bit Mask */
> +#define OWL_I2C_STAT_RACK	BIT(0)
> +#define OWL_I2C_STAT_BEB	BIT(1)
> +#define OWL_I2C_STAT_IRQP	BIT(2)
> +#define OWL_I2C_STAT_LAB	BIT(3)
> +#define OWL_I2C_STAT_STPD	BIT(4)
> +#define OWL_I2C_STAT_STAD	BIT(5)
> +#define OWL_I2C_STAT_BBB	BIT(6)
> +#define OWL_I2C_STAT_TCB	BIT(7)
> +#define OWL_I2C_STAT_LBST	BIT(8)
> +#define OWL_I2C_STAT_SAMB	BIT(9)
> +#define OWL_I2C_STAT_SRGC	BIT(10)
> +
> +/* I2Cx_CMD Bit Mask */
> +#define OWL_I2C_CMD_SBE		BIT(0)
> +#define OWL_I2C_CMD_RBE		BIT(4)
> +#define OWL_I2C_CMD_DE		BIT(8)
> +#define OWL_I2C_CMD_NS		BIT(9)
> +#define OWL_I2C_CMD_SE		BIT(10)
> +#define OWL_I2C_CMD_MSS		BIT(11)
> +#define OWL_I2C_CMD_WRS		BIT(12)
> +#define OWL_I2C_CMD_SECL	BIT(15)
> +
> +#define OWL_I2C_CMD_AS(x)	(((x) & 0x7) << 1)
> +#define OWL_I2C_CMD_SAS(x)	(((x) & 0x7) << 5)
> +
> +/* I2Cx_FIFOCTL Bit Mask */
> +#define OWL_I2C_FIFOCTL_NIB	BIT(0)
> +#define OWL_I2C_FIFOCTL_RFR	BIT(1)
> +#define OWL_I2C_FIFOCTL_TFR	BIT(2)
> +
> +/* I2Cc_FIFOSTAT Bit Mask */
> +#define OWL_I2C_FIFOSTAT_RNB	BIT(1)
> +#define OWL_I2C_FIFOSTAT_RFE	BIT(2)
> +#define OWL_I2C_FIFOSTAT_TFF	BIT(5)
> +#define OWL_I2C_FIFOSTAT_TFD	GENMASK(23, 16)
> +#define OWL_I2C_FIFOSTAT_RFD	GENMASK(15, 8)
> +
> +/* I2C bus timeout */
> +#define OWL_I2C_TIMEOUT		msecs_to_jiffies(4 * 1000)
> +
> +#define OWL_I2C_MAX_RETRIES	50
> +
> +#define OWL_I2C_DEF_SPEED_HZ	100000
> +#define OWL_I2C_MAX_SPEED_HZ	400000
> +
> +struct owl_i2c_dev {
> +	struct i2c_adapter	adap;
> +	struct i2c_msg		*msg;
> +	struct completion	msg_complete;
> +	struct clk		*clk;
> +	spinlock_t		lock;
> +	void __iomem		*base;
> +	unsigned long		clk_rate;
> +	u32			bus_freq;
> +	u32			msg_ptr;
> +};
> +
> +static void owl_i2c_update_reg(void __iomem *reg, unsigned int val, bool state)
> +{
> +	unsigned int regval;
> +
> +	regval = readl(reg);
> +
> +	if (state)
> +		regval |= val;
> +	else
> +		regval &= ~val;
> +
> +	writel(regval, reg);
> +}
> +
> +static void owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_EN, false);
> +	mdelay(1);
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_EN, true);
> +
> +	/* Clear status registers */
> +	writel(0, i2c_dev->base + OWL_I2C_REG_STAT);
> +}
> +
> +static int owl_i2c_reset_fifo(struct owl_i2c_dev *i2c_dev)
> +{
> +	unsigned int val, timeout = 0;
> +
> +	/* Reset FIFO */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
> +				true);
> +
> +	/* Wait 50ms for FIFO reset complete */
> +	do {
> +		val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
> +		if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
> +			break;
> +		usleep_range(500, 1000);
> +	} while (timeout++ < OWL_I2C_MAX_RETRIES);
> +
> +	if (timeout > OWL_I2C_MAX_RETRIES) {
> +		dev_err(&i2c_dev->adap.dev, "FIFO reset timeout");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void owl_i2c_set_freq(struct owl_i2c_dev *i2c_dev)
> +{
> +	unsigned int val;
> +
> +	val = DIV_ROUND_UP(i2c_dev->clk_rate, i2c_dev->bus_freq * 16);
> +
> +	/* Set clock divider factor */
> +	writel(OWL_I2C_DIV_FACTOR(val), i2c_dev->base + OWL_I2C_REG_CLKDIV);
> +}
> +
> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{
> +	struct owl_i2c_dev *i2c_dev = _dev;
> +	struct i2c_msg *msg = i2c_dev->msg;
> +	unsigned long flags;
> +	unsigned int stat, fifostat;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
> +	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
> +		dev_dbg(&i2c_dev->adap.dev, "received NACK from device");
> +		goto stop;
> +	}
> +
> +	stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (stat & OWL_I2C_STAT_BEB) {
> +		dev_dbg(&i2c_dev->adap.dev, "bus error");
> +		goto stop;
> +	}
> +
> +	/* Handle FIFO read */
> +	if (msg->flags & I2C_M_RD) {
> +		while ((readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +				OWL_I2C_FIFOSTAT_RFE) &&
> +				(i2c_dev->msg_ptr < msg->len)) {

This is poorly aligned and has some () that at least I do not need.
I would write

		while ((readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
			OWL_I2C_FIFOSTAT_RFE) &&
		       i2c_dev->msg_ptr < msg->len) {

so that the two sides of the binary operators align.

> +			msg->buf[i2c_dev->msg_ptr++] = readl(i2c_dev->base +
> +							OWL_I2C_REG_RXDAT);
> +		}
> +	} else {
> +		/* Handle the remaining bytes which were not sent */
> +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +				OWL_I2C_FIFOSTAT_TFF) &&
> +				i2c_dev->msg_ptr < msg->len) {
> +			writel(msg->buf[i2c_dev->msg_ptr++], i2c_dev->base +
> +							OWL_I2C_REG_TXDAT);

Here is another example of poor white-space. I would write:

			writel(msg->buf[i2c_dev->msg_ptr++],
			       i2c_dev->base + OWL_I2C_REG_TXDAT);

In general, I think you should have a look at most if not all your
multi-line statements, and make use of spaces so that things align
better vertically.

> +		}
> +	}
> +
> +stop:
> +	/* Clear pending interrupts */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
> +				OWL_I2C_STAT_IRQP, true);

E.g. here. Make the OWL... argument align with i2c_dev->...

	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
			   OWL_I2C_STAT_IRQP, true);

It really does look neater.

> +
> +	complete_all(&i2c_dev->msg_complete);
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 owl_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static int owl_i2c_check_bus_busy(struct i2c_adapter *adap)
> +{
> +	struct owl_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> +	unsigned long timeout;
> +
> +	/* Check for Bus busy */
> +	timeout = jiffies + OWL_I2C_TIMEOUT;
> +	while (readl(i2c_dev->base + OWL_I2C_REG_STAT) & OWL_I2C_STAT_BBB) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(&adap->dev, "Bus busy timeout");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +				int num)
> +{
> +	struct owl_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> +	struct i2c_msg *msg;
> +	unsigned long time_left, flags;
> +	unsigned int i2c_cmd, val;
> +	unsigned int addr;
> +	int ret, idx;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	/* Reset I2C controller */
> +	owl_i2c_reset(i2c_dev);
> +
> +	/* Set bus frequency */
> +	owl_i2c_set_freq(i2c_dev);
> +
> +	/*
> +	 * Spinlock should be released before calling reset FIFO and
> +	 * bus busy check since those functions may sleep
> +	 */
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	/* Reset FIFO */
> +	ret = owl_i2c_reset_fifo(i2c_dev);
> +	if (ret) {
> +		/* Disable I2C controller */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +					OWL_I2C_CTL_EN, false);
> +		return ret;
> +	}
> +
> +	/* Check for bus busy */
> +	ret = owl_i2c_check_bus_busy(adap);
> +	if (ret) {
> +		/* Disable I2C controller */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +					OWL_I2C_CTL_EN, false);
> +		return ret;
> +	}
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	/* Check for Arbitration lost */
> +	val = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (val & OWL_I2C_STAT_LAB) {
> +		val &= ~OWL_I2C_STAT_LAB;
> +		writel(val, i2c_dev->base + OWL_I2C_REG_STAT);
> +		ret = -EAGAIN;
> +		goto err_exit;
> +	}
> +
> +	reinit_completion(&i2c_dev->msg_complete);
> +
> +	/* Enable I2C controller interrupt */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_IRQE, true);
> +
> +	/*
> +	 * Select: FIFO enable, Master mode, Stop enable, Data count enable,
> +	 * Send start bit
> +	 */
> +	i2c_cmd = (OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE
> +			| OWL_I2C_CMD_NS | OWL_I2C_CMD_DE | OWL_I2C_CMD_SBE);

The operator is customarily on the first line, and the () are not needed.
And I would throw in a couple of extra spaces for readability. Like so:

	i2c_cmd = OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE |
		  OWL_I2C_CMD_NS   | OWL_I2C_CMD_DE  | OWL_I2C_CMD_SBE;

> +
> +	/* Handle repeated start condition */
> +	if (num > 1) {
> +		/* Set internal address length and enable repeated start */
> +		i2c_cmd |= (OWL_I2C_CMD_AS(msgs[0].len + 1)
> +				| OWL_I2C_CMD_SAS(1) | OWL_I2C_CMD_RBE);

Spurious ()

> +
> +		/* Write slave address */
> +		addr = i2c_8bit_addr_from_msg(&msgs[0]);
> +		writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
> +
> +		/* Write internal register address */
> +		for (idx = 0; idx < msgs[0].len; idx++)
> +			writel(msgs[0].buf[idx], i2c_dev->base +
> +						OWL_I2C_REG_TXDAT);
> +
> +		msg = &msgs[1];
> +	} else {
> +		/* Set address length */
> +		i2c_cmd |= OWL_I2C_CMD_AS(1);
> +		msg = &msgs[0];
> +	}
> +
> +	i2c_dev->msg = msg;
> +	i2c_dev->msg_ptr = 0;
> +
> +	/* Set data count for the message */
> +	writel(msg->len, i2c_dev->base + OWL_I2C_REG_DATCNT);
> +
> +	addr = i2c_8bit_addr_from_msg(msg);
> +	writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
> +
> +	if (!(msg->flags & I2C_M_RD)) {
> +		/* Write data to FIFO */
> +		for (idx = 0; idx < msg->len; idx++) {
> +			/* Check for FIFO full */
> +			if (readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT)
> +					& OWL_I2C_FIFOSTAT_TFF)

Operator should be on the first line (and align, but as I said that goes
for virtually every multi-line statement in the whole file).

> +				break;
> +
> +			writel(msg->buf[idx],
> +					i2c_dev->base + OWL_I2C_REG_TXDAT);
> +		}
> +
> +		i2c_dev->msg_ptr = idx;
> +	}
> +
> +	/* Ignore the NACK if needed */
> +	if (msg->flags & I2C_M_IGNORE_NAK)
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				OWL_I2C_FIFOCTL_NIB, true);
> +	else
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				OWL_I2C_FIFOCTL_NIB, false);
> +
> +	/* Start the transfer */
> +	writel(i2c_cmd, i2c_dev->base + OWL_I2C_REG_CMD);
> +
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> +						adap->timeout);
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +	if (time_left == 0) {
> +		dev_err(&adap->dev, "Transaction timed out");
> +		/* Send stop condition and release the bus */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +			OWL_I2C_CTL_GBCC_STOP | OWL_I2C_CTL_RB, true);
> +		ret = -ETIMEDOUT;
> +		goto err_exit;
> +	}
> +
> +	/*
> +	 * Here, -ENXIO will be returned if interrupt occurred but no
> +	 * read or write happened. Else if msg_ptr equals to message length,
> +	 * message count will be returned.
> +	 */
> +	ret = (i2c_dev->msg_ptr == msg->len) ? num : -ENXIO;

Consider killing the ().

> +
> +err_exit:
> +
> +	/* Disable I2C controller */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_EN, false);
> +
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);

AFAICT, the ordering of these two statements do not matter. So you could
unlock first and then disable the controller. Then you could have an
unlocked_err_exit label (or something) that you could jump to when things
go south in unlocked regions above, and thus have common error handling.

I.e.

err_exit:
	spin_unlock_irqrestore(&i2c_dev->lock, flags);

unlocked_err_exit:
	/* Disable I2C controller */
	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
			   OWL_I2C_CTL_EN, false);

If the ordering actually matters, then I think you have a problem if either
of the unlocked owl_i2c_reset_fifo() or owl_i2c_check_bus_busy() fails above.
But as I said, I don't think the ordering matters...

But all this is stylistic nits. It's not my code and I don't care deeply.

Acked-by: Peter Rosin <peda@axentia.se>

> +
> +	return ret;
> +}
> +
> +static const struct i2c_algorithm owl_i2c_algorithm = {
> +	.master_xfer    = owl_i2c_master_xfer,
> +	.functionality  = owl_i2c_func,
> +};
> +
> +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> +	.flags		= I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +	.max_read_len   = 240,
> +	.max_write_len  = 240,
> +	.max_comb_1st_msg_len = 6,
> +	.max_comb_2nd_msg_len = 240,
> +};
> +
> +static int owl_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct owl_i2c_dev *i2c_dev;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	i2c_dev = devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	i2c_dev->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(i2c_dev->base))
> +		return PTR_ERR(i2c_dev->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "failed to get IRQ number\n");
> +		return irq;
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "clock-frequency",
> +					&i2c_dev->bus_freq))
> +		i2c_dev->bus_freq = OWL_I2C_DEF_SPEED_HZ;
> +
> +	/* We support only frequencies of 100k and 400k for now */
> +	if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> +			i2c_dev->bus_freq != OWL_I2C_MAX_SPEED_HZ) {
> +		dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
> +		return -EINVAL;
> +	}
> +
> +	i2c_dev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(i2c_dev->clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		return PTR_ERR(i2c_dev->clk);
> +	}
> +
> +	ret = clk_prepare_enable(i2c_dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	i2c_dev->clk_rate = clk_get_rate(i2c_dev->clk);
> +	if (!i2c_dev->clk_rate) {
> +		dev_err(dev, "input clock rate should not be zero\n");
> +		ret = -EINVAL;
> +		goto disable_clk;
> +	}
> +
> +	init_completion(&i2c_dev->msg_complete);
> +	spin_lock_init(&i2c_dev->lock);
> +	i2c_dev->adap.owner = THIS_MODULE;
> +	i2c_dev->adap.algo = &owl_i2c_algorithm;
> +	i2c_dev->adap.timeout = OWL_I2C_TIMEOUT;
> +	i2c_dev->adap.quirks = &owl_i2c_quirks;
> +	i2c_dev->adap.dev.parent = dev;
> +	i2c_dev->adap.dev.of_node = dev->of_node;
> +	snprintf(i2c_dev->adap.name, sizeof(i2c_dev->adap.name),
> +			"%s", "OWL I2C adapter");
> +	i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
> +
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	ret = devm_request_irq(dev, irq, owl_i2c_interrupt, 0, pdev->name,
> +				i2c_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", irq);
> +		goto disable_clk;
> +	}
> +
> +	return i2c_add_adapter(&i2c_dev->adap);
> +
> +disable_clk:
> +	clk_disable_unprepare(i2c_dev->clk);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id owl_i2c_of_match[] = {
> +	{.compatible = "actions,s900-i2c"},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, owl_i2c_of_match);
> +
> +static struct platform_driver owl_i2c_driver = {
> +	.probe		= owl_i2c_probe,
> +	.driver		= {
> +		.name	= "owl-i2c",
> +		.of_match_table = of_match_ptr(owl_i2c_of_match),
> +	},
> +};
> +module_platform_driver(owl_i2c_driver);
> +
> +MODULE_AUTHOR("David Liu <liuwei@actions-semi.com>");
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
> +MODULE_DESCRIPTION("Actions Semiconductor Owl SoC's I2C driver");
> +MODULE_LICENSE("GPL");
> 

