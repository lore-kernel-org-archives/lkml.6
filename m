Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0099C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E26E20878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="aulW/FxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E26E20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH1KXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:23:24 -0400
Received: from mail-eopbgr50129.outbound.protection.outlook.com ([40.107.5.129]:4967
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbeH1KXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygn6Zf6Ke/8/rZnJijBmuTNtKX875rNfLbKc+fPcQrE=;
 b=aulW/FxYoSEnTsFclYLF00pGZJCM4FUDQ87aeb+IEAfcDFxWR/cPHLM8prr4sTMlxnjAGAXjHLQMWYyB7e070RCWPtr+6Nb1L14K2/9DD6+YErIv/VIX6jG+SpbWX9KzPzy8FbL0bTvQSBPTzXdEY+3ZotClgbbF02uW4pQzYGo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2457.eurprd02.prod.outlook.com (2603:10a6:3:81::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Tue, 28 Aug 2018 06:33:08 +0000
Subject: Re: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-21-robh@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
Date:   Tue, 28 Aug 2018 08:33:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-21-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::20)
 To HE1PR0201MB2457.eurprd02.prod.outlook.com (2603:10a6:3:81::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03841c29-449d-4405-cfee-08d60cb01e9c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;3:9swA08tHG+YWTyhWtVXiD6+Q2cPJcOxS+bZwOen2VMWswXClSeyqgZC71dPbcXAdf0HwH4uHqIctaBT8Pkio9VJ4Zt0YMIzKKJMubmrzzqPPO9ZdI7ptl/yrsVLbOZ/5B9/+P1zWPUm06Um5m7LmA+mCP2IEbxCosK1/b0DQ2daHaRyNSDyJW/I3zuODnwohovc5cOO5qt1GzO0u5E+xTgXK5RO/5Ky+USd14HEB3wBDVo/+JvoopiHkFh+RxTtv;25:G+cWr00zkCJeYfln58SE1nyNmZUhv5Y1wkw3Xnmg0W31VJOiRR7wLhOm72TeaZpHfnpBKKc8DHWJQUi2sKcyrv7KLGBqVqBbEc+nzJwT8A1ZyAnfR+D5xiZeqAgcDOCnHoTlW4mkaHQTOgpIONVPYvPU0Fhkqgk6hsaE4rf6eD0FPYPj9G3fPwBKy79DjN40/AmJHjQC++xuMSAvmiIrKaGXrWHqMAfRhmo9mNckra+coWAk2EresukUjkNAcgxL0Hb++6hCIQN51SR0VyxMktwkdQrQHpVMgTkJOtUv3L14SHp5eW4r065jo8xkMznw8p/lVBl+BIzqH1/lIkk7ww==;31:/80VaTlcO5CN66MF5AGR4AU9txwREpK10SNrKbAuacuQiQwXOuY7Liulfhs2Y1WTJdZSP4RkAyJnF3A4j5VNS2LsiEmFwF5kkxle2rfaYetvTBirXuajdtFNOTJ7QI7cTOvPHsRUK1Qv3BxxReDRCuRqkUeo5erLR2tb9DPwAwsZotaBgCqPsL82EUpueChMgzNoDUNA9kvRN0R5Qm+l5Ad+TWD9i68YWh6NeTBYWQg=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2457:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB245797259CD405F45765022ABC0A0@HE1PR0201MB2457.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(65623756079841);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2457;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;4:kEXw0qRAEB5LV9HnHLgm4LyjXKvJ/uCnILXdAlepiyEADluSau1x1C4pT7b1MBNLqlYbeeq+4Ki8+o62wHUUglgPPuI4T/3PEHDYGoVDC4cVZTBAZqaKljWhEGf2+3CHqeDkk5u2sna7S+tLmaZWyTJePNw7zsW+eDIfBoUdijfxB+M2gC1p3UTIY594pXZC5MXuCOUHxbUslMNov4kFFKo6rFQ7FNJnt+9C+8BB8KJ26sOfJmPxg2koD0qHsEP29JDjSYpUg94HtohJSFbpXO+Y5gF7rHB1J5ThkVxySK5A2dvIRUbJXQKQhaEcI3bqxiY0+z9UiYnkHl2l2WiWizK7SL9eHHNHPrVJUf1TKu8=
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(396003)(376002)(136003)(39830400003)(52314003)(189003)(199004)(2906002)(23676004)(74482002)(65806001)(2486003)(52146003)(16576012)(58126008)(52116002)(8936002)(66066001)(65956001)(54906003)(64126003)(36916002)(76176011)(53546011)(25786009)(2616005)(11346002)(316002)(386003)(476003)(446003)(3260700006)(16526019)(956004)(486006)(117156002)(86362001)(26005)(478600001)(186003)(106356001)(77096007)(6246003)(31696002)(105586002)(4326008)(65826007)(7736002)(50466002)(31686004)(53936002)(229853002)(305945005)(6486002)(97736004)(230700001)(8676002)(81156014)(6116002)(47776003)(6666003)(3846002)(36756003)(68736007)(81166006)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2457;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTc7MjM6ODViZ2VESFNBeUs4NmNZdDBMdWU5aURH?=
 =?utf-8?B?d05YdWI0WmRuYTdNbDVrMFgyTmZDT0RHRXFGV0kycm9ucTVuMWhjSlFHZVBs?=
 =?utf-8?B?UXdlSUhUMFpqQnJoeDdIdnZyb240MXRlc2pjeUtSM2E2WjhPck1tcjZ1ZW1I?=
 =?utf-8?B?aVRCTWcwOUg0MlQ3TllUM3VQclN6ZU9hZTl4NWpVQ3FjOEk5dEZOK3VPTnJH?=
 =?utf-8?B?TFUvT1FIUXZ0dkdnRzcvMjdmTFBwVEc1ZXdPY2Z0cG5JMkl3d2U0aVlIMkpv?=
 =?utf-8?B?ZlczRFNwd0Y1ZmZSeW5kOUV2aDlZWlpQend0cHBhVXNHQkF1SWFVTmVUbzFZ?=
 =?utf-8?B?anh5a0tYNDBOckNWNmVaaWlmYmE0cVFRNzdKVlAvZHNJT1djWThEZ2J0TjFK?=
 =?utf-8?B?VklUSHdGN2NCb1lOa085S2dxK0p3ZVJXRHRJaWIrbWx5WkFicjdLNWVseEd5?=
 =?utf-8?B?T0JZU3FpeURWV3E2emtNYUdXTmd3MUU2aWt3VExJMVQwdlBLbERGNWFSY3Nh?=
 =?utf-8?B?L1pXd0s0VnJKQUZyOU1ZUGxtaGE0alBJNGQ0Wk5taXhGdk5KSjlOZkQ4Zkp4?=
 =?utf-8?B?b1pXWk5iSWtXZzJTZ3NwT2JTUlgyNVRGeStHQ3l4Z05iUHpCNGtuaGtRV3B2?=
 =?utf-8?B?cFd0L01pb1NQL0tBMXJ5MXlCMWx5cUdrUlgyajRad2ZWV2JseVB1U3UrRnlp?=
 =?utf-8?B?UVVwcG1lRWZnSm8zbGRKUmJsMmpLcHdnSldkNXJXY3BGZGQ0V2xzVUY0S3E2?=
 =?utf-8?B?dHIvVDVaUFNFTnQvS1BFNVpFL1FkbS9IYVM4Z3hEL1l6aEJjS3BrUERrSkRK?=
 =?utf-8?B?SklPNm9kdkh4SEJNbE9EWkg2d0N0bEFUZlJ2aHRCYnhVVC9VZEttU3NFa2xI?=
 =?utf-8?B?M3JlbzMzZDV2Qjd2UjBLT1lTQndSZTJUbStpczdCWTJOZHJWQlYvamdOSSsv?=
 =?utf-8?B?eTIxWDVGQ1NITzBoTlV0NEh6ak55b2s2NUdKRUl5bkovbSt0YUdkNlBvYjlo?=
 =?utf-8?B?M2M4d244V2NlQjFYNGp2QnpmTmtIY2tjcmJWZkZoZ1U5ZGNLS1pmYUFlVllD?=
 =?utf-8?B?TGpyaldDdzNkaTNjWE5MdlgrYWVmUFdWd2JvaUxLdXpxVjl4T3dEOUFSanY1?=
 =?utf-8?B?Qis2SE14SkUvb3YydVRKaVIyM3VXS3J0dEdvNzN3WlVrbmZHeUoxRExXc1Yx?=
 =?utf-8?B?dlg2bkxvUWpBRGlYSlQ3SXpSdTc0U1MvMzRIZ3RzamZUK2FLWTlhaUpOaDZz?=
 =?utf-8?B?Y29OOXlIYWtLQjgxblcxc3dPazhXY0w0ZEhuSEdGY0UwbEVXcWhORzgxQk5n?=
 =?utf-8?B?cGFZWDRCaE1ncm4xVTdTQWdCRiswb041ZXdCSFAyMTlpM2g2QUVyWUk5YU9U?=
 =?utf-8?B?dkpSMjlzRlFjaEZhMncwdVRzclFFYVViWVZPUTZGblYrRzdxTHBlL0hiaWk0?=
 =?utf-8?B?aUhhYS82QnZsTHZyQWt0aXJJR0JJNDFoNHRLMVo1WFlGZ0tZd0g1dW9hS0Qw?=
 =?utf-8?B?ZmtWSVY2NXc2TzI3SGV3YWNIc3orSVBFWkp6T012WWl1b1Q1d1VDUkdGU0hP?=
 =?utf-8?B?UlExZy9vQi9vUVhaaEpFb3JKWVJpM3RDOE9NdGFhNGtNWHBvNjdDSjZWbWRW?=
 =?utf-8?B?OVUxQWw1LzJZOTlJYUpwT0xyT1Y4NS92WW5JTURYNzdDNjk5VzgwTGxFa2NP?=
 =?utf-8?B?Yk5oZVdUeHVabm11UWFCTmlsV2tPblNWQjlDS3I5aUw5WXNXbS96VVJKbW11?=
 =?utf-8?B?WGhGMDlKUW9XaW5oM3NBeGtkVnduekVPVEVPZEh0d0JGck5lQ2FmWXFIMFV5?=
 =?utf-8?B?KzNmWUR5WHJtM2lienlkdUcyMjBaZ0ZoVUdFSnpzK2xWR3g3TGRYVDdlY1Bi?=
 =?utf-8?B?WENBMEpONzBReUh6NkZONG9XeGhhS3diRkxqL0FUU2dhTG1NNUdCZTRYaHBs?=
 =?utf-8?B?V2F0WGZQTnhNV3NwM3h1ME5TRkZBb05sNEpaZWFPWlp0emI5aUZNQVdvS21j?=
 =?utf-8?B?K3ZaWVlNRmR3Qzh0MG4rc01OWUdIWTFjRXRIUS9MUzZNK0VmU1d2TE1jeHZK?=
 =?utf-8?Q?Y5t2x4Ck0yFR7as1kgaQBm51oLR?=
X-Microsoft-Antispam-Message-Info: MdQn0dMK2OLOtlwbH0wVctcXq3lOWyUoZzcyKWp0npR8k58bslsocC/J4beA07LbQo9X3MELrDaFgBb42+HX7iBL+VRH1ONlO7mkX6l/qPRmO7uRPFoo7zqUOiz+TmFaGG0cvVoZSfZHgxngjF831PwGs3nuqCPDiNd/zDrL/NqqofvXBfJnZegbruzq0jJY9MCXKVWXkxto37vzG/6txBMR1GmwBkkt/gQ5pq6OPlZCnZ9jfjCReSAkcHkgpGWvD7ZYe51ytbaSEdzOftd/U5/4t/CXb0mo086mBzhkKagvZi1AeGXIc3YF/BLx8RSwPD14aDqKS3XjM27CTIiEvkLyzEwNVTi44p9a4Fo06aU=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;6:zurdpa8n+kbfgMBSgCtdjW4qu89EczP5LaZUvmuBKqu4+Wi0c66EEiW/jKi5BYKJ6hqshWA3C73DrYacYh5cAwFiK6LbA25M1iVdB3Um50fiMTHzI/Hi3x1hY8mB4cgMPj0MQXnUoH8MH4LpONHKd1knqkLMRRtqTNc9V4OW9N1H20ixxLgciRJYT/amXDXy2tSBtwxHEeqMzOpmRRGzuU3xxCaAXGtIguoS09KXownb67BMzFQYsHGoKWj08WpSE+HWGGhlXSgN+i6eB2BFKMdNgxttZw5l8SUZONYD4RslzLMAafnl+UsPdV0evfiJ6S3XRP86Hszv2C7YkxHrflH0KIzDyGzUFU3bAJOyLRstTJtAwyuoRoXgK8REYGeWYc1W6uL/8DEYQk443o7rJeuIHQQAG8KLzzngNNKh9zstJIzIcNB7zbACQjEa9xBJU7jupm63kwShYsoOJMvTdQ==;5:GHVApNJ2KBWZnw1JzW3k421ObAWtfa1incZjAIN/Olc8f9n0xxfIEDET18/8U86VG440Q9Yamz0rxKzxrNsFiscG3IkeQVM5HoBRHPzf3qnqJB/FvHQwj/eyk6ykHpaelNrAW+s8IUfM00pw5/U32BnlyASe5xFN00kOhq0jXQE=;7:UvJnmRwk186z6GKqEsGY0FFQm7HxwJYdT9G3HDfrrriwvFJ6YR5vebuZTO4OUicoO7DmE6S/cQCr0qLKCsTiqxXSE4Pti9TrELoONfCiGcxjdwlfMt+jrFHYxJ6lfrHtAU9bQYXOwOADM95SCsM4x1kewWilFKKzIHNFZTsNv6yYcw1vMS4rG7QLtJ3Q43AOckP2WoBoJR1E+Cf7h+OqedipqQPX4AoAHVfT4f+ZWZNjoBkFTlBuGFerXhFojUQi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 06:33:08.4082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03841c29-449d-4405-cfee-08d60cb01e9c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-28 03:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
>  drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
> index f2a2067525ef..b706fd136ca5 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  	struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
>  	struct device_node *parent = NULL;

Lose the initializer...

>  	struct i2c_adapter *adapter;
> -	const char *basename;
>  	int rc;
>  
>  	if (bus == NULL)
> @@ -407,23 +406,25 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  		parent = of_get_parent(pmac_i2c_get_controller(bus));
>  		if (parent == NULL)
>  			return -EINVAL;
> -		basename = parent->name;
> +		snprintf(adapter->name, sizeof(adapter->name), "%pOFn %d", 
> +			 parent,
> +			 pmac_i2c_get_channel(bus));

...and I would have written "parent, pmac_i2c_get_channel(bus));" on one line,
but maybe that's just me.

Anyway, with the initializer fix,

Reviewed-by: Peter Rosin <peda@axentia.se>

(Wolfram, no need to split this, just take it in full.)

Cheers,
Peter

> +		of_node_put(parent);
>  		break;
>  	case pmac_i2c_bus_pmu:
> -		basename = "pmu";
> +		snprintf(adapter->name, sizeof(adapter->name), "pmu %d",
> +			 pmac_i2c_get_channel(bus));
>  		break;
>  	case pmac_i2c_bus_smu:
>  		/* This is not what we used to do but I'm fixing drivers at
>  		 * the same time as this change
>  		 */
> -		basename = "smu";
> +		snprintf(adapter->name, sizeof(adapter->name), "smu %d",
> +			 pmac_i2c_get_channel(bus));
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> -	snprintf(adapter->name, sizeof(adapter->name), "%s %d", basename,
> -		 pmac_i2c_get_channel(bus));
> -	of_node_put(parent);
>  
>  	platform_set_drvdata(dev, adapter);
>  	adapter->algo = &i2c_powermac_algorithm;
> diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
> index 92cf5f48afe6..f60b670deff7 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpmux.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
> @@ -120,8 +120,8 @@ static int i2c_mux_probe(struct platform_device *pdev)
>  
>  		ret = of_property_read_u32(child, "reg", &chan);
>  		if (ret < 0) {
> -			dev_err(dev, "no reg property for node '%s'\n",
> -				child->name);
> +			dev_err(dev, "no reg property for node '%pOFn'\n",
> +				child);
>  			goto err_children;
>  		}
>  
> 

