Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231F120857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Z3Em7J5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeGSQDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:03:32 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com ([40.107.3.102]:28160
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731567AbeGSQDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AreOfQLoDbcP4vcdFWsrG4gJkk9aqcGGYE05otP8T8=;
 b=Z3Em7J5O8BF/uJNZf1Mej9NxKok2YuDjZn2A7hWlrv6swepaDhdZPipYWgdyfC1mtCxYruUbpFSNfTMirVku34CewK7t1UxzWUqzmAu7e8PJ7iECSCnEU9TCXcjfNq3MnL8eT86m1N5LvKA0bVBGINldgFjEHLt4TzFyDKQIxkQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 15:19:47 +0000
Subject: =?UTF-8?Q?Re:_[PATCH_V3_2/2]_mux:_adgs1408:_new_driver_for_Analog_D?=
 =?UTF-8?Q?evices_ADGS1408/1409_mux_=e2=80=a6?=
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20180719134359.23714-1-mircea.caprioru@analog.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e6e0a535-7dc4-3541-a2fe-d5a9ed4dfc01@axentia.se>
Date:   Thu, 19 Jul 2018 17:19:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719134359.23714-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0346.eurprd05.prod.outlook.com
 (2603:10a6:7:92::41) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17200283-dbb0-42cf-40d8-08d5ed8b10e6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:ztgl/FWApi2YjPMuN4U4GLFXWrwXsyCWbzZHMQtiVhaZuzaRo7eGHsvmOFMnEPtrk2GZoR9mfxS1SY/pdHc/tWFaxCgacppooAWf6ewDc2EbThOVHPQYPcdg9laaU3Qw679WpULGRh9mPrMcVKkEIwF47S8B0mfHodFgV+JBiG5c9rMnKuy2EwmwMhI5PvJ4BCHnCeFF+0a9my1Mt9d4pKuN9X662LTPmpfgMdVTttt107sN+fEokAUnpDFCIsd4;25:/2IOjP+9m0NGUXOdCOWIhbePNb7I1yPh9NmS70F6E+mc70CDaEuqMx6FTF8wud8Fi3+IqntM+Tm/a1x2P2Tcd2voZZaFaf9UmpgC+oQQJjmfTWp/HmGgZfQo1KU324WDPDc61AGMF8fBVrT3CasgobrlLxxS/Z5O3a6lEBcZmJW7Hr9dX3kMMi/ov0PCPZ9XVGlE2R2oKy8q3B41Et+LAfAbLbnoMzK7UdUBo188rATRfecvOcHiTBaltFDc/r+Q21Tjy7lNRUQJhYXiWYOJeeHVGS9+PkklL9ZPadWp+nsQltBwa3bQSA/DbB1nU2RpBxWRMp5LoD5PPUGR1s5wtA==;31:p5XAwYxZfJ78R2wPo+KK1IZhEtypWs0eNZ056cJvY3+FBDmPYXe38GO4H6WkwuQp76EznG2kZgRYo2y+gxunYk9Rl8YzpHgx8tdDVWhX1lpYZapPAHM5oJQrzeMwVFNBxm9P2XR7xfScabX8t+kBpIzF+QJLIa1Xh7U5VDIk47xTgvdPzKQ3XrRrjguC7SIU46vOA2kI6icnDCtdEv0rp/N7iShk1XM5in4qdMbv3VI=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464461856AC9584E840DBCCBC520@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:5RZ2Wp2/tuL7oqPHgQFeV3l4pXdetji5BPyojjEDFT1upK9zk+mUG1wjO763lZ6kEKYvc+z4K52x513Y4SBl7v6HxtCXiKCT8GniXncMQ2igEwxigZ/QZDT22MFdpy4wu5nnGNIKpmAzm7GRlD6764dank/Qm2in6AOdOC4gfh8JxtZtdL1p838JvUbD49qOMAqJx+URGMQ3zRn3eE3//+6J1vaAu6S6blmbfF4JT86kMqLbDxX8OtNW7d2SEmmOhiMyVyakCOgM0pf1h/L7KNjy1Rt1JyfeHOT0fKLD7w2hU4jAaqt97rWSaEwE1nwhj+5g4HeHR3CjgGhq122hipavLsmhdPqK5TCYD8a2O1I=
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(39830400003)(376002)(346002)(366004)(396003)(54534003)(199004)(189003)(229853002)(81166006)(230700001)(36756003)(7736002)(6486002)(64126003)(386003)(3846002)(305945005)(6116002)(53546011)(52146003)(97736004)(486006)(2906002)(26005)(23676004)(6916009)(81156014)(65956001)(478600001)(6666003)(66066001)(65806001)(36916002)(2486003)(8936002)(47776003)(25786009)(446003)(74482002)(76176011)(3260700006)(53936002)(4326008)(6246003)(11346002)(117156002)(2616005)(86362001)(50466002)(14444005)(58126008)(316002)(16576012)(956004)(31686004)(105586002)(16526019)(77096007)(68736007)(5660300001)(106356001)(476003)(31696002)(65826007)(52116002)(186003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6Mzl0UkxreS9NV3Fhb0FuL3NRVlNONEVi?=
 =?utf-8?B?NXY4TUYrdXlSQlBBTENFQVBvS0hCYnBCSGI4SDJEenllVmhYVndsN3lRcm9k?=
 =?utf-8?B?NGt2VWxCWnRodDFzMThsWTRZdWY2emVFY29BZm1kVjNOZ3hzaHltS0R6QVFE?=
 =?utf-8?B?eTBGNDI4cDJQdlF4Zzhzc2pPeENZRXVjTXpPSTRHei9aUENFSG9Od3JtUkdO?=
 =?utf-8?B?dVloOGNCQkFMUG1TT2U1ZGFqcW9IQ0tJc3pyOGZxK1NDRGRXTnFmRVFQTkw5?=
 =?utf-8?B?dU5yVW1BU0ljS09oVXJQczVhVUJXRmRIWkJhbHp0RzdlQzJTUjhST0UybzlE?=
 =?utf-8?B?dzNYbVZ2VjBaU1hyeDVIcjlEV0NXbmJzeFhpcnkxUFZhOHBXTFhKR0U5L29i?=
 =?utf-8?B?SmdmK1h5YzVqdERDOVhtVDlqcWR0VnFWYS9scVhpMDJuSjNKcDRuRlFkZ05L?=
 =?utf-8?B?eDlLbDdDWDhTaEdyaENiSlY1OW5aUVg2NjQzTTBQTGhmVjVmUkpLdXZzTUJk?=
 =?utf-8?B?OTJqRkJMQkw0d1c3R3FmNHhhVjJYdXMzWFozelY4ZEh3L3lUUUxwaVd1YWNS?=
 =?utf-8?B?QlBLWWh6Kzd2TEtwUkJaVnVoQWpWQXZSTmlVb001em1POTgvN2hFWGZUbHBM?=
 =?utf-8?B?QjdvLzR6ZXE0SXdEWm41a05rTit1OS85RjdhOWdzS25OVXF4OG9DRHpBdCt5?=
 =?utf-8?B?ZUliRGIyL2JibjIzL3Y5YlRPanpnelhiK0NIYmdkT29JRy9wMXBqd3YxaFQy?=
 =?utf-8?B?dGI2cDFtb1lIczBtb2hSV2l6TDBjWU9TS3lqK0FuYXJUV0dhMnd1UnQrbFJU?=
 =?utf-8?B?bXQrR00vcDZIcnNyTkdHYjVKZUl2ZXBndlpwR1Y5eVhFR1YzQ3VKTWcrbnZx?=
 =?utf-8?B?VEJIYmk0T0cxUDQ3RUFkbnMxaEpxMk56L2dnVGN6cDM2dzdHMVBlUlpaOVgw?=
 =?utf-8?B?MlpWR3E2ajZOY0xiS2NkdCtHY2VXZDZBZWpDdUd3bk13ejFVQXkzTGRBWkhR?=
 =?utf-8?B?VmVEQnE0aVNWVDRrVnVqOGdQVE5GZkcrNjFtdGduYmdMOGFvSkdSTmJNSjB6?=
 =?utf-8?B?WVBEa3lsVTdCeDlOUzFrRC9hN21tWHdqOERTdnU0ZGxOME85byt5WnRkeUhY?=
 =?utf-8?B?ZFdTQmZCY1VvTkxjV283U0FCRTBHVjVLWTExV2RkVEtGQXpOVVlPbUhCOUNG?=
 =?utf-8?B?bUJaTGlhZnBXUjRwdkU0ZUhzVTB4SGp3N1Y4TmpwWGZCNHlpTWxLbGFCODdB?=
 =?utf-8?B?YXpXR3g1ZithSmdRa3pFcDdUcVZ0VkNDOGlFa2kxWXFXck42YzY3K1B0cU45?=
 =?utf-8?B?aDd2RGtwbnpKV0xPcCs4QUFoaUEyekJpWk05OWhtbnBra2NBQ1dzOGM5L1JC?=
 =?utf-8?B?MkJKZWVZbWE3VnVDL2dhVm5WNlNkYVVsVVlNSlBuMWxXMVhuNktzVnBUQk54?=
 =?utf-8?B?MHN0dHBVL3RiZWdTZGMrL1dBUHhzRjc4bzZFbHhhWVJuMFp5RVVlRGF6RWhG?=
 =?utf-8?B?Q3kvMWF5STBJc3UvcXoyL015NGlSWElSUUZJcE1tUmRQSVNSMDRQU3hCZ2dP?=
 =?utf-8?B?RHJiU2FhQ2U1bVpJUWtUV1BUS1FtbE9wTzZHSllqYThZZlN4OE4vNWxNOVRB?=
 =?utf-8?B?cFNFalliTWxLeGhzQkg1ZDJKNGR0QWxoSUUyb0NpVTcvTWhBajR6TU1SQitU?=
 =?utf-8?B?bDlxNWtHRnZMSWs4N1JKVW5UVXZ2YXE0b0NXeG1mWkcreEt2cWR4WnBhN2JI?=
 =?utf-8?B?cjlBU0lqN1gzWWZ2bXZWVWRpRVhMdmFmSkZ1VkZvekk4TDJHcTNNOGNmOHFN?=
 =?utf-8?B?dmJEbTJNWDkxa1JOK3lwMGhYdFBOU3RsMExscmw0bXJSeHN3TVo2ZVR1bk5a?=
 =?utf-8?B?cTFWM3hLQXVKUDE1MkV6NGp2cmlNOXhNTGFia3BhTENFV2hYNmFPWTJaNFF1?=
 =?utf-8?B?bW5vaVJWOUZJUGVYMW93UzFEVDlxQW9IN2UyV1pKMjM0SEpmdENnaVJlS1Va?=
 =?utf-8?B?cnhzSXV0UmpySUFEMFRrQmxEYktmYTNzTGFKbU9BNmYyakN1M3lTTTFRNDRD?=
 =?utf-8?Q?gBtpAvOmUaPAdkeq9KLpgJQ3XrO?=
X-Microsoft-Antispam-Message-Info: dX6mJUNR9Y5nBspJ0p9WAdHD6RVgH/RWCeeARwRIVUEDyDV3ZvJxhbKX93t6N0zkvQrOrnR25vL6TU4sFSMXBQuDw7eaUfTdmaGIICK+IoCBkHrdTmbv7eL13tZ9qR6++sEkWxBBqsJnDqosan9q5fe2hwzU/hhD50H1AivBN3FTc6IF7UFWPENOJb6yoA+0NxCH3+M3GXR8gRipXGrucPQjXdfrBYKUlhc0AaH75gQeSySJ5mRNBsmsYgQ0MfbGtWbdE+ZOJbgCqfYqkEPJEeBr+SPeBsH6tOJKO+LZlwhikPehF+bNg2YuUoL8tdO7OaHdG6f2zfoqnGsMJ5+BrqD03gFxxAWxewhIUdZEPOI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:fJ7ZeppMyExZAnqxkQmew6AHZ/B5meU9P4OXUr/BrKd/4N+kR8Za+/PYgDn7nvoXXYoDovzFnJo0DOTP52JrcHBrJA5eaOrdjemwRhQXHPnDLtsyTcdY6NbO6K30q51UgKnTZkDD6RkJ2xWVsXTPQjPr8yXLD3O9u2z0/5WhNZrzYi/U/d0BzSvS+9P3Vw7OHq1X9kGWUhH1JgJPjTkV8QWSUXi0+xxolTj8BdJhs73PX5StvIpffc7ieski1jEiB2HMd33LlRUI4VOgAu0d9SOdFi7c9NCwwgW2gsxA/aFL/GlkrWcBFq7WrXKdt0zIUBSPLZv8pKX0/z7s0nxXkDKTuudf5tRn1pCEOTzSuYB5wqG0Uum9QKHDBBn1Wi+BUYOt4jxwFH0KgDDb7Z1z/2B/0+sRAL61xGJO16uD6l0M4rqef9xOdWNl3Wv1vvYY6SqYG1dcpEmPdupw+Fv/SQ==;5:LQEsLCFEt2k5JpbQdnnbJNC/eShT679bDrCbuSVxO94qakiDnNGAtJCeOPk6eyw93wt3IrzNSmNylFpoEo09c5OMutvYotCWM2/5FUqr9i2cNrj3OhY7p9Lm2GOo2Ay+nj2Xwfk1xqG87F1yxi6S/9z9G8hG65eKFasDLySU80w=;7:ckhz1rxOml2OOTxyZyFO+pwPipxC3em7Eio3yL+jj+Xw5CBX9FVMCGSi6dwuj3lVSwYxPTAvAeYIR8gfw4ejh6B/NR5Jpwv8KgsdcyNad4my05gZQBeg9s1TY0XtqReaSEcGSLOib1tg8wzaT5aW52WfgCSESgTYHZAzngGA+RjVLB1gSdhpNMxM3addZxQh1Ymj1d5CxUg9eTAhAyfR2Zbv5yCTxOHpei0GbeKaxg+Pxk+WDyo6T3/c/lgySjNU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 15:19:47.7201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17200283-dbb0-42cf-40d8-08d5ed8b10e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-19 15:43, Mircea Caprioru wrote:
> This patch adds basic support for Analog Device ADGS1408/09 SPI mux
> controller.
> 
> The device is probed and set to a disabled state. It uses the new mux
> controller framework.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
> Changelog V2 -> V3
> - removed Kconfig line
> - changed to GPL-2.0-or-later
> - fixed typo in ADGS1408
> - moved spi #include after linux/property.h
> - added trailing comma
> - reverted back to .of_match_table
> - removed duplicated logic inside switch statement
> 
>  drivers/mux/Kconfig    |  10 ++++
>  drivers/mux/Makefile   |   2 +
>  drivers/mux/adgs1408.c | 128 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/mux/adgs1408.c
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 6241678e99af..7659d6c5f718 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -21,6 +21,16 @@ config MUX_ADG792A
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-adg792a.
>  
> +config MUX_ADGS1408
> +	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
> +	depends on SPI
> +	help
> +	  ADGS1408 8:1 multiplexer and ADGS1409 double 4:1 multiplexer
> +	  switches.
> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called mux-adgs1408.
> +
>  config MUX_GPIO
>  	tristate "GPIO-controlled Multiplexer"
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> index c3d883955fd5..6e9fa47daf56 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -5,10 +5,12 @@
>  
>  mux-core-objs			:= core.o
>  mux-adg792a-objs		:= adg792a.o
> +mux-adgs1408-objs		:= adgs1408.o
>  mux-gpio-objs			:= gpio.o
>  mux-mmio-objs			:= mmio.o
>  
>  obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
>  obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
> +obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
>  obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
> diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
> new file mode 100644
> index 000000000000..2722fb466e38
> --- /dev/null
> +++ b/drivers/mux/adgs1408.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ADGS1408/ADGS1409 SPI MUX driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/mux/driver.h>
> +#include <linux/of_platform.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +
> +#define ADGS1408_SW_DATA       (0x01)
> +#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
> +#define ADGS1408_DISABLE       (0x00)
> +#define ADGS1408_MUX(state)    (((state) << 1) | 1)
> +
> +enum {
> +	ADGS1408,
> +	ADGS1409,
> +};
> +
> +static int adgs1408_spi_reg_write(struct spi_device *spi,
> +				  u8 reg_addr, u8 reg_data)
> +{
> +	u8 tx_buf[2];
> +
> +	tx_buf[0] = reg_addr;
> +	tx_buf[1] = reg_data;
> +
> +	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
> +}
> +
> +static int adgs1408_set(struct mux_control *mux, int state)
> +{
> +	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
> +	u8 reg;
> +
> +	if (state == MUX_IDLE_DISCONNECT)
> +		reg = ADGS1408_DISABLE;
> +	else
> +		reg = ADGS1408_MUX(state);
> +
> +	return adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
> +}
> +
> +static const struct mux_control_ops adgs1408_ops = {
> +	.set = adgs1408_set,
> +};
> +
> +static int adgs1408_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct device *dev = &spi->dev;
> +	struct mux_chip *mux_chip;
> +	struct mux_control *mux;
> +	int ret, idle_state;
> +
> +	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
> +	if (IS_ERR(mux_chip))
> +		return PTR_ERR(mux_chip);
> +
> +	mux_chip->ops = &adgs1408_ops;
> +
> +	ret = adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = device_property_read_u32_array(dev, "idle-state",
> +					     &idle_state,
> +					     mux_chip->controllers);
> +	if (ret < 0)
> +		idle_state = MUX_IDLE_AS_IS;
> +
> +	mux = mux_chip->mux;
> +
> +	if (id->driver_data == ADGS1408)
> +		mux->states = 8;
> +	else
> +		mux->states = 4;
> +
> +	switch (idle_state) {
> +	case MUX_IDLE_DISCONNECT:
> +	case MUX_IDLE_AS_IS:
> +	case 0 ... 7:
> +		/* adgs1409 supports only 4 states */
> +		if (idle_state < mux->states) {
> +			mux->idle_state = idle_state;
> +			break;
> +		}
> +		/* fall through */
> +	default:
> +		dev_err(dev, "invalid idle-state %d\n", idle_state);
> +		return -EINVAL;
> +	}
> +
> +	return devm_mux_chip_register(dev, mux_chip);
> +}
> +
> +static const struct spi_device_id adgs1408_id[] = {
> +	{ "adgs1408", ADGS1408 },
> +	{ "adgs1409", ADGS1409 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adgs1408_id);
> +
> +static const struct of_device_id adgs1408_of_match[] = {
> +	{ .compatible = "adi,adgs1408", },

I think you need to keep track of which compatible is in use. This
is normally done with

	{ .compatible = "adi,adgs1408", .data = (void *)ADGS1408, },

etc. And in .probe you'd have code like

	chip = (enum chip_type)of_device_get_match_data(dev);
	if (!chip)
		chip = spi_get_device_id(spi)->driver_data;

And for that to work, you of course also need to name the enumeration and
start it at 1, so that 0 is kept illegal.

Cheers,
Peter

> +	{ .compatible = "adi,adgs1409", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adgs1408_of_match);
> +
> +static struct spi_driver adgs1408_driver = {
> +	.driver = {
> +		.name = "adgs1408",
> +		.of_match_table = of_match_ptr(adgs1408_of_match),
> +	},
> +	.probe = adgs1408_probe,
> +	.id_table = adgs1408_id,
> +};
> +module_spi_driver(adgs1408_driver);
> +
> +MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
> +MODULE_LICENSE("GPL v2");
> 

