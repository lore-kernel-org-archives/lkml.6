Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD5BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70747204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dj0grVjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70747204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbeGTPS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:18:29 -0400
Received: from mail-eopbgr20107.outbound.protection.outlook.com ([40.107.2.107]:14016
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731939AbeGTPS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il/SUztd3gvAHiKa+Kld1H62dnFSMMJqjpfn9areTNM=;
 b=dj0grVjW9n9IM7ZSmlkeA/IY/HktNAl+NyTDYwzuHCt2Wa2xUJNrCQvvJCELTUQ9IadvHp2wOD/v+2wOhvwkBy2dhoGtdM8gTYUqFOT7BCkFPqxABseLOKsrcfUolJj52pubmA4lbGFfPEeqxEiif00mGkwrWO4LBzc4Vq1SnTU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2457.eurprd02.prod.outlook.com (2603:10a6:3:81::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 14:29:34 +0000
Subject: =?UTF-8?Q?Re:_[PATCH_V4_2/2]_mux:_adgs1408:_new_driver_for_Analog_D?=
 =?UTF-8?Q?evices_ADGS1408/1409_mux_=e2=80=a6?=
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20180720081101.27317-1-mircea.caprioru@analog.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e623b01d-c880-028c-bd38-4f23b3e46785@axentia.se>
Date:   Fri, 20 Jul 2018 16:29:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180720081101.27317-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0401CA0067.eurprd04.prod.outlook.com
 (2603:10a6:3:19::35) To HE1PR0201MB2457.eurprd02.prod.outlook.com
 (2603:10a6:3:81::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b3a3b88-8392-49ae-1c94-08d5ee4d373c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;3:UNI4BLIl4GrSp84RatOXoQxfIFqJ16LBxCVk/6HFbuhW9U6QicSTC2cU6kFqe3dTYaPsuoLa8Hs/KTBdzYl9Z0O9LzuMXkAfWZg+O/0yoNvBUyP7j0XVImdOsK2EXOwF6/1rYayTgatjyrywrd8w1tdmE+K4gZk8eTgd43R5Uh5kSxGyfYn3mrQ3GaTH8d+lvjwTnKCFTcuVXz+dV9t0S8xJp9tT5Zp2r6x9+SQU6dNh6VRRvp8emi6vrs1JM1uH;25:x8BciAAzag6TQzndRBfgoUqXrmKkPhKML6p45CF8mxX9xF4D6qySiWpelRh/eaiLtWg/rwc+OFLxJ+pEeC6IBuOapGJQNytsau5LquC/akYrJ1RY+3Q5JFexYh22vj2771E7RbrFWxycG+9jOVDzs08p1aYmeumKYHztS968CfODczUoBMaWyx/Y8oHmONs6x63zsgJnOVxsj/0018+KaBjBb3UI2EzHLiD2CHwIAl5ax0IwsiSrSS840Fs8J59zphyySJb0GE5ayvXyNmnP4R2jOwCj/ywqr+EA5paQ91uNBuwVU2ML8XQZ7JdJkYgWb+nCXR4LQfon8D2I1F9xMw==;31:miEA3IHBplNzwklEYfoqu+QreXrmGTAz0JlZUuUdEm4QFw3Cry698sb+Bhel/N8wIDkkSYPMhD90XZLk4csM3BtUt+UOveXVHMcZlZLTvbV5l9zL8rS43Y6TgVtAWjiKzGQhOnY5cflEnBn4KHawZwfsnydcs1R20DSRyA57t3xvuytPqqc4nkPvj1kFPBUivOPV63etka1foGXe/KfSH2UXgGVLXfpwTF7nDhe8pEw=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2457:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2457383239A9C1F5C2EFFE71BC510@HE1PR0201MB2457.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2457;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;4:p2kALaixww2mZnqZxkjIkvr1mwaQFeZ5tU0pO8sifwxP8gbw5hZ5HULjfW4BwvgKWCUM10ILy5SYqtr2h23rhMihANadhfEmmbHvEIF37aQy3L4rMzfLh/R9Ikj6mtWsm/dT9ziYbyuxFEgPYE0BEHIW7VQu3CnMHvZv6s5dYNCAT8HNIAW7yBUTVewIJ8xmBApF1M8Fxvk0TH3Cj9QdmnHvzSm27kjLkoc0wTh2ZmSPNygZnzwXPQtyZetEoAR9/DhPiWCmDuFn09RY0En2Lc0qpLI0Pu/tHhbTmf/GdyTdc/px0lujfFhGtqMrdFVW
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39840400004)(396003)(366004)(136003)(54534003)(199004)(189003)(2616005)(230700001)(3846002)(52146003)(956004)(6246003)(11346002)(6116002)(4326008)(186003)(97736004)(106356001)(486006)(117156002)(3260700006)(476003)(25786009)(53936002)(16526019)(31686004)(74482002)(65956001)(65806001)(6486002)(47776003)(26005)(66066001)(446003)(105586002)(77096007)(229853002)(36756003)(2486003)(76176011)(53546011)(36916002)(23676004)(16576012)(478600001)(68736007)(6916009)(86362001)(31696002)(50466002)(65826007)(14444005)(8936002)(64126003)(58126008)(52116002)(305945005)(81156014)(316002)(7736002)(2906002)(386003)(81166006)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2457;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTc7MjM6bjE1ZGtyVjlIRzVxdm95NSsxcE5wVUZ0?=
 =?utf-8?B?OUx6M0M3dG1LbXA2VjRYcnpsSVN4bGJBaWh0Vis0ZXpXV1RXNHR0emZZdUNH?=
 =?utf-8?B?UUVFRXVtZll6OVl6ZjRXWHRqcGZGSFpaOGFoVEVxd3djN2xIbmQ0bDkwSlRF?=
 =?utf-8?B?d1U2VkVjZXhRT1ZBUXF1MkdPaDhNbW9qaEZDYUtUamg2ck9kb0NlcFhqU0wy?=
 =?utf-8?B?OWNpMjdoTVhjaEVWSXRiVkpmTWhNSlNQcnVJZzJOUGRwZ0QxcEo2TDNGOEUw?=
 =?utf-8?B?L2RpQmtZN0Z2UkNSY1VpQmVtN2doTjFoSGVFZmZCQXUvZzhTRHZHRk0yb0Vq?=
 =?utf-8?B?T0UrcUxhdDlUOU5KMGVPY1o3OWVrRFRYQWFjVlFIRWVRTjNBYStPR1VVM2xL?=
 =?utf-8?B?bHR1R3lIblpucVNXNjAxcXhiVmdieUZDZXdZNGFiWWxNOHlQalQwYmF2TEpX?=
 =?utf-8?B?M2tQMG5HQ3k0cjRCWjlTbHA1VDlVQ3dwNnJweGRHOWxnSnB0d0t4NU96U0k5?=
 =?utf-8?B?eE5GQTdBekpSdmEwZ1czQzNydUdidmYvMWprTGxaa2JSa0FlRHRXN3g5ME5o?=
 =?utf-8?B?b3lYRjhvM2drRCttdEdMc0kyaU1FMCt5NnBBOWdNWEtMQkJxZUEvdnVPVTg5?=
 =?utf-8?B?ZmFZTUlDT1gwVUM4ck9IdVFZNEJ5NnRiSnQreVZlRzY0YXZxTk0yZEd5Z3JJ?=
 =?utf-8?B?anpDd3p5ZEtvYWJ4MkZMSGxKMllhZXdhTzFRazZUcHViNzZQajFNczJLQ1FG?=
 =?utf-8?B?VXBOUG52WVA1MmQ5ZjNkMU50dzJqMUs1cWIvZ1F1MFQwalptWitWaGJkdDFq?=
 =?utf-8?B?b0dWcy82SWEreFZMYm1JNDFCdTNqSDVUOXRBMnZsWkg5bnBNa0Zha05QSVJl?=
 =?utf-8?B?YWppZ21zZDdBem1EMGYzYlhzSTE3bXlVMHNpcWRFbnJmQjA1dnRici9DdXJt?=
 =?utf-8?B?RUZQYXc5ZFArb3ZTK3hHekFwV0pnVGoxS2ZUeUEzdGt0eG1hYm1NRlVpUi8r?=
 =?utf-8?B?S2RNRHNsbjFQRXhmMDcvTlMvOGxCRlB3WndVZkhyV2hvZHMwTEJpTzkzTXV2?=
 =?utf-8?B?cjBUYzlzSDZobElVVHQ5ZDJsWjF4WHltQTF3SFVoRjhrVXdDdHFVMGlpZTdG?=
 =?utf-8?B?ZDBnazhiNnJ1TVdGMUc2TGIvbmxhSk1OWmt0Z0t2TSsvYVl3ODBnWE5TUm8w?=
 =?utf-8?B?TCtJTWQzZUpyRTM3ZTBqS0xjVitzZjBCWnRyNTdyWHFmZ0dPZWcydEl0TlJa?=
 =?utf-8?B?RTNjbkZtaXp5ZnlURHFVYzd2ZjZ2RWVhOUh4ckRCa05zczRKTGJiVit3bHRm?=
 =?utf-8?B?cnZyYnF4cUdmYWVVMFB5dS9rM2dlcDlzOFVHV1BjRFFhWVpLN0VBTVhBZEdv?=
 =?utf-8?B?R0FFSnpncUY0VVRwVEltWVlGdi9Ua2dTWTFRRWpsOG5rMXdGam9VR01QRUwx?=
 =?utf-8?B?V2Vxa3F3S3VpMGFiT3U5MHpkcEZnM2I3R1gzdG01TCttU25YZEszaDJaRXpw?=
 =?utf-8?B?bjVxSUFjRUdCMnlvanhQUmU5TjZ5NVZXWmZ1ZDBSY2ZkZU1nL25CMEVxYVFS?=
 =?utf-8?B?aWJPYVcrOWQ2Si9UL1ViYWFNY0lMQVRrQWU1eG1YZENkaDBBS1FRZnRjeDRO?=
 =?utf-8?B?SG9UZmV5cmJvdEtwZlBYOEs5YTBDaDNZNlNPSTZPR09Da1JDSitzYktXSGdO?=
 =?utf-8?B?UEUrNHg1UERwRWxJL1VPa2Q1Y3VjWjEyOEtoSzh1OGc0aURGSk5VM2xpZnJn?=
 =?utf-8?B?Y2hTWCtrMVRuQWtxRjVyZUJ5NmI4eis2YlJJcko2WTlQY1kyajNDQWw0Yy84?=
 =?utf-8?B?b3Q1Rm9jSjNXTzZrUHRnai9ZYnk2c3MyTEJCM3VNNHgrR0NzSzN3SDJRS3Bv?=
 =?utf-8?B?T1RCS0w2dHhZSWVFZDFqMmo0eEJzR3E2c29JZW9TNTVjMlZXeS8ybGU1UTEx?=
 =?utf-8?B?MHVKZ2VWT3pmZFN3d254UkdaNzl0cFFLcUtMNEZ4b2ZYUk14NzU5WlNFQjRy?=
 =?utf-8?B?V24zclhFZ0ZUODRMYVdJaTZXR1BqSnY1MjJIY05NU1YrbUVRK1kwR1JranBR?=
 =?utf-8?Q?sD6fuM=3D?=
X-Microsoft-Antispam-Message-Info: FlyfRToR04pDX9SbnA5xdij44HQqZWusKI5AgVSOrZCeh2YD0uARlDD3yK/5xVboTxpjtfACqn/q5H1iidH9aJJPsjyvodHRzlkDHbbAAn8bBfDVQvVI0Oa8Krpap/3xJ9K1io7FZIMW4JB9egsXPwyEDisGq0v2E/LozMbaT6bK0b8loQ4GYEJshmsK8O8pB/fW7zAYCvjLqE1UK2enc/AWpAfIotM3yPAhw1yB+1YgaDLknyx5KYzOcI4y/4y681LxdAjOOW5rEpvqW99k3cR9XyCWVjoXmLb/GeE/B2mKxtqDQRysvgDFFEytK99vhjYFQRWZopCfYvP9WBYRSq32mVT0IOVHXU6C5uT0B2k=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;6:rwhEhBKslN21wvMFxZ62DbHwBgerDX/03PfBVaVrgIY7RJrTP0cCJOXXPpgEZ+kKI4VBm1km/lpN2DZQFxSTmP0stavqSDXuof+eFsBRJg67ACPuaWD32cqpuaHaSt+6pnm1Qjx5e7edgRVQbZuODxvPPridRabND8+Dfl+cP8ILe8zh8O1Ro4Z8iCbQaAT0i5Qrl0d8vZVCTBKo3xcfJrVwouFK/5VU3FjEErWl/ZXtCk1niVlOOJ7Opd3vlbCw9PUoTapw2YnMQKCGWN0b2TmIsxV0Qn4mGyj27TIudj+kPjk5FVPZ8/cVSHFG3mKyMsGTlxtgfxbdUOZ4LJSmGKdUZcZjvy9mzPRzksJiM63Q0BT2RLd2Nb/GxAWJz46qC/ESc2OZdbBt3S0cITXt5AaIsC5I9xscqHlZvBR/Iko3wZFfe1Fq7CCxCaNm4M+d9cY7ZK5Er0EFK6Tg1NsIOQ==;5:ItAFI5MBf/FSd8G3twoMcDd2J7uYBjLnz9lHqQHmRfg0T0844jDF4jOcTcPcbX9F+1KRTMlQvAqjJ9rnFTj5OPEy28HqOpSoQfDRvwKw0tzRRwKGasgwHyz2SZzAFxJlFn9W0ijTV/8XWtHLgJeEseDrtdfcHL3PCDLvJhDKmqU=;7:0DXGzS/tB2k8UP6eLhSH4U8SmVFR0lD8jXhhvf4IkGwC8uNJNV5Az0Dlxt2gTjOBK+YJWA//mYgpRSXoO5Hx/KJd18w8oxbnwNcsCStj4Aav5ab+H6w3RB2R6KDTGqIDPwE0NktujTuzaI71KPFnav/oUjV313NU8x21ujtZef89CdewA/FA9K0UwCGM7Opr3HpYVTUKH7VfyM9b+gC1raHcyyr7QJ7D3RjXpBsiIdHlHhxNWQtGEX+NMzLoKknP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 14:29:34.7300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3a3b88-8392-49ae-1c94-08d5ee4d373c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 10:11, Mircea Caprioru wrote:
> This patch adds basic support for Analog Device ADGS1408/09 SPI mux
> controller.
> 
> The device is probed and set to a disabled state. It uses the new mux
> controller framework.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
> Changelog V3 -> V4
> - named enum to adgs1408_chip_id
> - added .data with id enum values
> - added chip id verification for of_device_get_match_data
> 
>  drivers/mux/Kconfig    |  10 ++++
>  drivers/mux/Makefile   |   2 +
>  drivers/mux/adgs1408.c | 132 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
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
> index 000000000000..9cc749e10383
> --- /dev/null
> +++ b/drivers/mux/adgs1408.c
> @@ -0,0 +1,132 @@
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
> +enum adgs1408_chip_id {
> +	ADGS1408 = 1,
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
> +	struct device *dev = &spi->dev;
> +	struct mux_chip *mux_chip;
> +	struct mux_control *mux;
> +	int ret, idle_state;
> +	enum adgs1408_chip_id chip_id;

For bonus points, order this block from longer to shorter lines when you
switch idle_state to s32 (see below).

> +
> +	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
> +	if (!chip_id)
> +		chip_id = spi_get_device_id(spi)->driver_data;
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

I just noticed this, which is a big no-no. 'int *' is not compatible with
'u32 *' since int and u32 are of different size on 64-bit arches. You need
idle_state to be 's32', and you need the cast to avoid warnings.

And, you don't need to read an array. So, please use:

	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);

Sorry for not noticing this earlier.

Cheers,
Peter

> +	if (ret < 0)
> +		idle_state = MUX_IDLE_AS_IS;
> +
> +	mux = mux_chip->mux;
> +
> +	if (chip_id == ADGS1408)
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
> +static const struct spi_device_id adgs1408_spi_id[] = {
> +	{ "adgs1408", ADGS1408 },
> +	{ "adgs1409", ADGS1409 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adgs1408_spi_id);
> +
> +static const struct of_device_id adgs1408_of_match[] = {
> +	{ .compatible = "adi,adgs1408", .data = (void *)ADGS1408, },
> +	{ .compatible = "adi,adgs1409", .data = (void *)ADGS1409, },
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
> +	.id_table = adgs1408_spi_id,
> +};
> +module_spi_driver(adgs1408_driver);
> +
> +MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
> +MODULE_LICENSE("GPL v2");
> 

