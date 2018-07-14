Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BC220890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Nocb/Qdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BC220890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeGNMXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:23:17 -0400
Received: from mail-eopbgr00132.outbound.protection.outlook.com ([40.107.0.132]:34954
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbeGNMXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVvrJfowEewkUnvxgsNGHo8iHhZx0BoyAzClteuVSE8=;
 b=Nocb/Qdxn69voXyaU3gps7lPlCMxrmIXaVkLKclxrVpZz3E9xDnyk5T2Iq/3SB3aiBs+nNNXDwZsznd4HfHYq9LBdWx6Rtg6HdU06/fCSyX2+hUhXySMgGWOHxgXYLc0CpKcZfFNm2r8eVpQF3QgkHXPYSFTjwp030t8uzT5XTg=
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Sat, 14 Jul 2018 12:04:12 +0000
Subject: =?UTF-8?Q?Re:_[PATCH_1/2]_mux:adgs1408/1409:_New_driver_for_Analog_?=
 =?UTF-8?Q?Devices_ADGS1408/1409_mux_=e2=80=a6?=
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20180713122738.5888-1-mircea.caprioru@analog.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b3540119-73e1-38d5-1dc9-ce9f8bdad9e8@axentia.se>
Date:   Sat, 14 Jul 2018 14:04:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713122738.5888-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:7:67::17) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f16adce-95fa-4244-807c-08d5e981ea92
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:7iPO5H2XzX8rrf7Ii5x6cPJ12+M3Pulg0DsB4y+OlmkhGgFuVMeNrrVPSRElUqu/cSceKePnv5rVqY8A+028KQROcmCqeY/YS3A0FeiU8iMvSwJTuoTmzs4du80CoGxjLy2Ijxd/7jS4p6n9+HlnT7UiesOW5J6k8d5oUJVE4GEbOjoKzyAasGXRPlLpmGlyjNypUbSY2cjqenGBmlNZhUw00ZSZpB5lfOFsRKlLqiSr8dp53Tk3jh2/1+2K3I3a;25:vY9utCC+1zRI/aNJywMKNn+H6cEPK9vk/MjpzaJMb1xAajAujouuKmfT8QUe8+D/jU7VdwirNjAGc/IGc5EAtLxkHmHZJx/SHY2y9YlhT9qTVHlAqzaHolOOzKQWEjTeVmkioRlw4mLR1KdARBSOe286buLq+rtlZ/IFzkFUt1ptjqCKgXP2I2isMFdxIi+H1FqGrBZdrVuauFEiVC3t1LedBt6dSc1+MzBFKiK8pRFC4+MnUV2ro1Id+RVJYUXQ/ujLkVh44Gnnc8I+ZeS4H27ut33LoLAw7FCwKasGueZo/nZU0H4JnN0JagqLCj6su3W19cJ13sYLZrqYz72vug==;31:2di1ptP8NziuCk+4sCg27PGQ6uwx+tU7B0uj/hlsu5DFvu4lE+ddadc8SUto3ofUe6OaltBT/qF4dp+x3UiJcwzkChunkJx4XCBcRquDz7NhdkxE0YCX8aPwr4d1EQ+mdY/soBuvxT9b3qi4booWGo+27PwNPQFEKCxqOZbdciEtfHjY52hwH06dD2PJYJu7pdcjz51HjS+gKiAyjPjce9ehPOnyIW1BttIQLebjW3w=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24606A3C7316A44C2D8DAD14BC5F0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(150906107787882)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:XPTRM+A6irYYoKoYSTdEPiXOfhqhjTKJNdHTJZjn7wkWw9qz3LdqnUV8WauADy8pdK2jsPQsIsXgBXCmWLQOdvouLCRBDIbVGWdV+ygD8SoRxrcJCb41hkviaXVqJ5WVHigzC8ZTouvZrLDK3qp3vKLpdHxpoXTRfOCPiwm9I/h+osZ9f1DoWyBfX4GPzmlXxwJwhq6vPqtPTCcm5d6EFg4eoKFs4oXtNriwQGH0oKEsYoOX90bXj9Dc5jcmXy3xBoKmzgRl74bXnLpAk9zkBieim9orHRr3BcliJl5cQOKuaZnvqDImHUuu86rSEA9p2g9efEURSkqjEETmaAiaUwn9gu8ZT4WpxGoxyc1AtF1DlzD6HHKNo75kHsKaGf2mb8aEn/nd06hZDLilQFTyNvC9Zqrd94VDWnBDOIzkpOI=
X-Forefront-PRVS: 07334CBCCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(31696002)(476003)(446003)(956004)(2616005)(386003)(11346002)(76176011)(486006)(478600001)(6916009)(6116002)(14444005)(966005)(81166006)(3846002)(2906002)(16526019)(1720100001)(81156014)(7736002)(77096007)(16576012)(26005)(316002)(186003)(58126008)(305945005)(86362001)(53546011)(97736004)(25786009)(117156002)(53936002)(36756003)(6306002)(50466002)(229853002)(230700001)(106356001)(6246003)(6486002)(4326008)(6666003)(2486003)(52146003)(36916002)(31686004)(3260700006)(5660300001)(64126003)(105586002)(65826007)(47776003)(68736007)(23676004)(52116002)(74482002)(65806001)(65956001)(8936002)(66066001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NjA7MjM6YVFSWlpYSTVvM3Joa0JDMDRCOG94czhV?=
 =?utf-8?B?VWRweXVWZE5rVDZJWWdmdnhZbFpMVkhtUzJSQnB5NS9aTFNNK0FXYzNGYlJr?=
 =?utf-8?B?d2tpcVY3T1Z6WEpFS3VHY1VvejJ6b0FrQ3hFNVl5cU1TSEtzQmlVaGRUbmhT?=
 =?utf-8?B?VloyM2Z5ZVRTRkJueWwwVUxYZG12eTBHRFFxaS9lcm9sZC9Gd1FXMUd1U3J4?=
 =?utf-8?B?VTlRTFRmd0ZLR1k1NU52Vml2MHRod28wQ2cyRlpsalZIaXdNSUVmTEVpMlBE?=
 =?utf-8?B?MTlIUzlsYUNZVWRVeTJrVUdIcTI4QlBLQ2lDT0l4ZW1ZQ1J1ekV0RyttYnFv?=
 =?utf-8?B?U3g3ZTVXU3I0d0x1LzloSEE3TSt6eWNpdEMxZ1pvSWM0WDVFY3BzZU8zemJz?=
 =?utf-8?B?RzlNTXF4WDVBNEdKUVc1NjBTZEcxN3E4N1EyUWZFelZFKzNmaU9xSjlNUXd2?=
 =?utf-8?B?dG5DWEUwQjkwcm1sbFNLSDhTckVFVkhUbEhmNUw0YzFkOTBIM0hLT3JERlUz?=
 =?utf-8?B?cmZBMTAxR0RUM0xsczk3OTJpdkJTRXFHazZwa0JIOVc2aHQyRlYzRURWSHdu?=
 =?utf-8?B?ZStRTDUyeUkwTDUxZUtGT1FBU0NFZFhBa1FhOC9aTkxIUUs5dWt2dkZKU0FN?=
 =?utf-8?B?UUV2ZGt5b01lRjRjQkZndDMyQktMNTl5ZmMvSXpGSEJYVzRPSHBzTHFubUtY?=
 =?utf-8?B?ejJscmZSMC81RjN5VGNGNU9tSkFlT242eGxIam9Ka01MRHR1b0RRdURjRTdB?=
 =?utf-8?B?dVdOV2ZWbVJGSU9VSERzYWkrUUpTN2FpWjdkMlY4dlVRMTlvM0hqZU5Hci9s?=
 =?utf-8?B?ZWFYL1BwWGQyMG1saFZZenhaTHcxUnlCMlRtMmhTYm9CVnNaQ3grZ2ZiV05B?=
 =?utf-8?B?Q1UxTHdabldXL2hteFlKRDVQeUFjbktnalA1STl3RGJybGFhWS9ZQ25VZUlC?=
 =?utf-8?B?ZG53VEFNaDdwNEFDWW9tVXVaM2ZnSHB5bE11c2crZWFQM2RIT1ArOWpOYXdL?=
 =?utf-8?B?TkF1M01kOHZSOSt4dExZY2Z4T0lmSmZLZGlVU2xLOWwvSjBXL2hoeDU1Rjlj?=
 =?utf-8?B?ZzB4S1ROWGR1ZTNIYUV2cVJRaDFNMVppRG94VFFjMXY1TW1rNkR1YzVqYmJX?=
 =?utf-8?B?OTdFVnF5cFVBWFprTVlLdERpWW85eUVTZEtuNE5aQ05qaUsvWUcrbXVIVURR?=
 =?utf-8?B?bmFZRHFvOWYrMTVEaXBPODR3WkRRV081YkRIcmNTdzlGaDZQcVVJR0JBaFB1?=
 =?utf-8?B?bFlHOGFoL1kvK3RNeS9TRzdiNmVlMVJ5bU5OYzR2YTQ5UWs5VHhZWFNJMjN0?=
 =?utf-8?B?dlVIK2hzcVFiZ21CSDVKTy95ZExacitSNktESGw4K2lJSmZDTGd3VXBXOFl0?=
 =?utf-8?B?c3Urd3RpQSs3bE5LaUdtRmx4UTdMMFh3ODNhMVFYaDZmS0VFOXpNWFJOSkFU?=
 =?utf-8?B?aTc3cGE3YTFkV1Z2UU1pMGR0cFd2SjdxL3QwYmJ1a2ZzbnJTU2Vna2xTMEtw?=
 =?utf-8?B?SG1STFkyc3c1dTlMOVJ2ZDA1RHY0NXRMbzNnSzk5bWE4Y2I0VVdXT2V3aHh3?=
 =?utf-8?B?cElyZXJoclBlcmVTb0VXa3daTm5kMnkyMmF1d0lFL1o0cExKNUdhRFZkTzJD?=
 =?utf-8?B?S1c1R1FMOHl4b2lqZ1BST3kwQkQ0QzJJVkRjbGxiM05tbmt5Rkprb1BjT0RW?=
 =?utf-8?B?VlZXZTFicXgvYmdJZGpjdEhpRm9KSUlOTmN3Wm5VNmdJcVNEclkvZ0lVYzY1?=
 =?utf-8?B?c1duT0hLbXhBV1UybDMzdDRrZko1bzB1VlRkeTFhSUFlcnc3ME5seFpBMUxw?=
 =?utf-8?B?cmMzU0VIaTM2SWF3U2t2U25YNU9HNncrWFZlR01KU2poejFIQTVrM2ZjVlVX?=
 =?utf-8?B?NnZFRWhXVVh4S1dId3I2dWVvMGlKdWxEdzBnOFhVVEJTYUNtcCtaZnJINlZW?=
 =?utf-8?B?YzBKT0tVQzkrN3g0VU9xUmZVbldOTUJwMG83NXJWSUNWUTJ0NTZYc3FSemFY?=
 =?utf-8?B?eE1pbVJrRk9DVVpNUHBHMGRuZ0lVcU1JOG9lVldPY0pKb0ZpRU1MSEsya2Fl?=
 =?utf-8?B?bkk0ZENTcEEvcVhTVW1ZMGZLU1RjSThHdGhIaHdUMnF5RXdSU0o1QTJtMit5?=
 =?utf-8?Q?Yzyd/py9wxgD0u0iOYd6rEuXc=3D?=
X-Microsoft-Antispam-Message-Info: LYkQd0X3by7n+lmS9i9YaFd6AoxNe1zYqmYwP7vIcpqpVj6IW6b8DfzcRAPEvnLf7gNfd5q6h1ihfuLfm5+8TJcPOofA2Bh8RIkasHNp8Z33fc0/WZJMTugJFcr4gmojR9HXp8vUJiBI0nkFHkTOJML6QALj6+9VzjGkxnU75F3+V/t+cMSJuAK3h+OhPB1T4NbL76WQvRZmD8bF3PQGqPZoafQJSYFh6sj1uo9x8PFwhh9Iev+uM5mXydcr8uh1XeAJ9dpa8D4oCAY6dSSdvz8GUm83fgjZ+buiGHraG1uowo32KYlwE9oxpJXKf19aVxWjnN+pKMIOe+5vmibfb1687kFfrlTHlpz8YhayNLU=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:B4cNoGgGjTuzXSvcLkMrqh27C0Ic4kP4X8r7+gHchY7vAZ3M6fjg+u3xLha2QaZK3t/pkKcEn0Wv5Z45lD+kBCV4elVc9WdEcaz9FXAMKJG1VBuK02XmdFk7BvHNzFVnBUjp9aGrC+T3S6A1lh/TJdUwNvuaNYgZrQbjkXdn1aJhzCqlr4YJ7vPvevXHcfuf1fAiJTkYVY0yQ0AXR+pQ2/dGk5LbcPTCOtDsL1CY08p2kxPyyL5ivn+AkQ534La3zT39V2CmdkOhAmR7v5vPkMm/JNbzpGfHLupWf2Ix4iEXl6+7dQRueqepYCDygi6n+e2Kf+OeTsiTxouRBfpn+HYLALfrmpaJw18uyO3cBHP/1XNbSHbfRl+VsDQD0iSQMwNnhCZ5G9bY9tPCsgeRav+guuIo8KO2YaitE458MNG4QtrqnB+RZgZGrCtYr+XC/7NWP1qwVilU2at2Ut6fZQ==;5:iLcpRvg9zLYK9XtbDeeJ0nFIo19zZtxtQWHOnM8DjLiBMjuAEbea7whqLvmO7dOkpe05UyIRpYI9H1RHv895fcHWB73MLezJzO1A4xAto9uHI7RVK3NrIZHpA2DDjWINRiZvKceDMYrERwXv77DJDMS4isiInqCt2ZCdRtkqj0Q=;24:KKKpFOLLk4LJgdRY/9ERtpfNXyncOXsheHTS5w8Rjw35jQbUQkwXlOz5n+dMEXTyKHgmHrCkGx1OPYBNpSruwiQ6eEX6II5+yaCIW22CHps=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:GOmqhoOG/InIrW50FtNxvWsL2xhmnD+8jslDMHYtuHr7z9X6x3aVDEgG1NuhT8d2RWYuLXUHBWrFcWXgYhEuDSA0LBhD3tEvt6+Md7ydMrIJmxAE/nkqtfGC+i3UUuZSMEbbOqHsiYzz9RTeRYUhx6hYG39m5wjVyAhiMDwWTNfMd2KEsuKPBNpqama5+jhJz+AtrGqUOjq/nKMf9K4InOHzCjarWHIGhfaahItnz9ddo8WWtyKz80CG67GrnQA2
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2018 12:04:12.5503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f16adce-95fa-4244-807c-08d5e981ea92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for your patches!

Please add a space after "mux:" in the subject. And the second part should
generally be the driver name and the text should not start with a capital
letter. So, I'd like the subject to be:

[...] mux: adgs1408: new driver for Analog Devices ADGS1408/1409 mux

On 2018-07-13 14:27, Mircea Caprioru wrote:
> This patch adds basic support for Analog Device ADGS1408/09 SPI mux
> controller.
> 
> The device is probed and set to a disabled state. It uses the new mux
> controller framework.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>  MAINTAINERS            |   7 +++
>  drivers/mux/Kconfig    |  12 ++++
>  drivers/mux/Makefile   |   2 +
>  drivers/mux/adgs140x.c | 132 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 153 insertions(+)
>  create mode 100644 drivers/mux/adgs140x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 192d7f73fd01..7aa68f38ea4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -810,6 +810,13 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/i2c/ad9389b*
>  
> +ANALOG DEVICES INC ADGS1408 DRIVER
> +M:	Mircea Caprioru <mircea.caprioru@analog.com>
> +W:	http://wiki.analog.com/
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/mux/adgs140x.c
> +
>  ANALOG DEVICES INC ADV7180 DRIVER
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 6241678e99af..87b3fda56d8f 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -48,4 +48,16 @@ config MUX_MMIO
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-mmio.
>  
> +config MUX_ADGS140X

Please name the driver after one of the chips, i.e. without wildcard.
And keep the Kconfig entries sorted.

> +	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
> +	depends on SPI
> +	help
> +	  ADGS1408 and ADGS1409 4 independent single-pole/single-throw
> +	  switches.

That's wrong. ADGS1408 has one SP8T, ADGS1409 has two SPQT (or one DPQT).

> +
> +	  The driver suports driving each switch independently.

supports

> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called mux-ads140x.

mux-adgs1408

> +
>  endmenu
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> index c3d883955fd5..236e7738462a 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -5,10 +5,12 @@
>  
>  mux-core-objs			:= core.o
>  mux-adg792a-objs		:= adg792a.o
> +mux-adgs140x-objs		:= adgs140x.o

s/adgs140x/adgs1408/

Make this change throughout, of course. And this comment also applies
to the bindings patch.

>  mux-gpio-objs			:= gpio.o
>  mux-mmio-objs			:= mmio.o
>  
>  obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
>  obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
> +obj-$(CONFIG_MUX_ADGS140X)	+= mux-adgs140x.o
>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
>  obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
> diff --git a/drivers/mux/adgs140x.c b/drivers/mux/adgs140x.c
> new file mode 100644
> index 000000000000..13dd95acca20
> --- /dev/null
> +++ b/drivers/mux/adgs140x.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADG1408 SPI MUX driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + *

Remove the above empty line.

> + */
> +
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/mux/driver.h>
> +#include <linux/spi/spi.h>
> +#include <linux/property.h>

Keep the #includes sorted.

> +
> +#define ADGS1408_SW_DATA       (0x01)
> +#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
> +#define ADGS1408_DISABLE       (0x00)
> +#define ADGS1408_MUX(state)    (((state) << 1) | 1)
> +
> +static int adgs140x_spi_reg_write(struct spi_device *spi,
> +				u8 reg_addr, u8 reg_data)
> +{
> +	u8 tx_buf[2];
> +
> +	tx_buf[0] = reg_addr;
> +	tx_buf[1] = reg_data;
> +
> +	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);

	return spi_write(spi, tx_buf, sizeof(tx_buf));

> +}
> +
> +static int adgs140x_set(struct mux_control *mux, int state)
> +{
> +	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
> +	u8 reg;
> +
> +	if (state == MUX_IDLE_DISCONNECT)
> +		reg = ADGS1408_DISABLE;
> +	else
> +		reg = ADGS1408_MUX(state);
> +
> +	return adgs140x_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
> +}
> +
> +static const struct mux_control_ops adgs140x_ops = {
> +	.set = adgs140x_set,
> +};
> +
> +static int adgs140x_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct mux_chip *mux_chip;
> +	u32 idle_state[2];
> +	u32 cells;
> +	int ret;
> +	int i;
> +
> +	ret = device_property_read_u32(dev, "#mux-control-cells", &cells);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (cells >= 2)
> +		return -EINVAL;

cells should always be zero for ADGS1408.

> +
> +	mux_chip = devm_mux_chip_alloc(dev, cells ? 2 : 1, 0);
> +	if (IS_ERR(mux_chip))
> +		return PTR_ERR(mux_chip);
> +
> +	mux_chip->ops = &adgs140x_ops;
> +
> +	ret = adgs140x_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = device_property_read_u32_array(dev, "idle-state",
> +					     idle_state,
> +					     mux_chip->controllers);
> +	if (ret < 0) {
> +		idle_state[0] = MUX_IDLE_AS_IS;
> +		idle_state[1] = MUX_IDLE_AS_IS;
> +	}
> +
> +	for (i = 0; i < mux_chip->controllers; ++i) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +
> +		if (mux_chip->controllers == 1)
> +			mux->states = 8;

8 states is never right for ADGS1409.

> +		else
> +			mux->states = 4;

4 states is never right for ADGS1408.

> +
> +		switch (idle_state[i]) {
> +		case MUX_IDLE_DISCONNECT:
> +		case MUX_IDLE_AS_IS:
> +		case 0 ... 8:

Hmmm, I realize that you have adapted this 0 ... 8 from the
0 ... 4 in the adg795a driver, but now I fail to see why it
isn't 0 ... 3 there. I think the 4 is a left-over from an
older encoding of the special idle states.

So, for ADGS1408, 0 ... 7 are valid, and for ADGS1409 it's 0 ... 3.

Cheers,
Peter

> +			mux->idle_state = idle_state[i];
> +			break;
> +		default:
> +			dev_err(dev, "invalid idle-state %d\n", idle_state[i]);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return devm_mux_chip_register(dev, mux_chip);
> +}
> +
> +static const struct spi_device_id adgs140x_id[] = {
> +	{ .name = "adgs1408", },
> +	{ .name = "adgs1409", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adgs140x_id);
> +
> +static const struct of_device_id adgs140x_of_match[] = {
> +	{ .compatible = "adi,adgs1408", },
> +	{ .compatible = "adi,adgs1409", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adgs140x_of_match);
> +
> +static struct spi_driver adgs140x_driver = {
> +	.driver = {
> +		.name = "adgs1408",
> +		.of_match_table = of_match_ptr(adgs140x_of_match),
> +	},
> +	.probe = adgs140x_probe,
> +	.id_table = adgs140x_id,
> +};
> +module_spi_driver(adgs140x_driver);
> +
> +MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADGS140x MUX driver");
> +MODULE_LICENSE("GPL v2");
> 

