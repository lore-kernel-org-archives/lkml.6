Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD97C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D44215EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="s4wlN8GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D44215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeHSKNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 06:13:21 -0400
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:25675
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbeHSKNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 06:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tIbT4TP+aKs1HgF8gu/vwADlIFmyo6IGVLqnAguP/s=;
 b=s4wlN8GUJ6h266zei59ZnwUzx0YRuAiUdPZGaoj8m86/f9oZm0ozcLGqxNVyz5h1t0HEMEVOBVNmZb3wsLyJMhMFOwgIpqVJevkBCNuwV3VoetkBtfJW9OegBnEthaVqrfu3FOJe19sIXZsDW/5CWC5NGKhoYmvUR2tsNGMBgAk=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Sun, 19 Aug
 2018 07:02:45 +0000
Subject: Re: [PATCH 3/3] iio: potentiometer: merge calls to of_match_device
 and of_device_get_match_data
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
 <1526896150-27134-4-git-send-email-Julia.Lawall@lip6.fr>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0a8aff9e-51fe-96a5-bcab-cc472be92dcc@axentia.se>
Date:   Sun, 19 Aug 2018 09:02:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1526896150-27134-4-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0387.eurprd05.prod.outlook.com
 (2603:10a6:7:94::46) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ad4cbe-91dc-40b3-40f2-08d605a1c484
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:IizvUaq5XEUZSy8t+W0GmA34OKpjY6bfdj22MgQ40nvC9vBEqv94B86D1QzaS/Ri9nWTSKW30sRRV+3rfJR5rktTtw3Xwxo0PbtG+GkX9Dy3wE4jrUH2aDzE7/9Vb/jJdiC8zHXgcd+HTFJvu6Z73JTgw6FBEU2YiZwGxCxFu2Va10Wp3qbTBy7wMk+3xSl/11SfVEnV7L5Mrwg3psbRZsdHTUp69wNP5C1fnN06RE+4Sx5b7bfFD811lUsPq+Rf;25:BfpbWT9VWAm+lCJuBc6DOMLo63rTLtqi+ypGD1lv8S3zcmAOba9vKPQ4BBp9EsTDf73DZRae8X0mm/bYqvokSgLa7OQrjOlnDljgX7l+TCMFAV9VEGCCy5/ihajEdWILL5qXXgxYDi3Yv7qjw8V/GOsxNlCbRAFQmmKCgTn+ycBL3DqIHNDx5o7/y0O/Cdn8/KzYdZr6H/rSBC+UfxjQRtRAzdPocBwQcPwzpF+vZZ8EEDZpIM3o5/4Hhup4Ko86TpiLkFHqa7NHQi4mMkK52Qn0fB2SWW7jFbCfiBftko6Bm8ZViQiZ4N+G0h3kYs1y7xmrjWraGWRD/mJ5WS/JCQ==;31:iBf1VenuNworgEKpjdA7O+fHLAznDaZSIIwtlurze5ByLS2VWplLZYqWqn78V8NRwlny1beZsZXE2Xubo3QtJdEQaExOxhLb+QjZvpusokXFDfuzG6o0mR3Jie4L4gnYHbMa9cFuhq8WGnBTd0944mE2Hxb6eddXjA/6vk0IvJ9SMxJQrC7s1eK20LdG1UDj41+4jJqb6+gbdaIkLno/+bWhnfysR9sV8gx5x9NpZ3Q=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24524F288E580C222FF25188BC330@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:S/9wMnX34jWivzvyum64f2AL83w5mu9QzFP2FUccPrf1THuwj9bxAMKJmG7jeNr6XSC/Au0ZWqAvvHDokC0w1/pbu7LhZM8yhuIe0DX5oGSKRZbJtSELLEIw4JK7tpqQ9ur2TIu+NiJmxDDhA3L6Zu0tNRooL30NNanDWEQm0WAShUuOv/C3A3MqNJBgAfwLxKLQPcQLKzCSRmVCEdSCT07KtXJvqbMTQ9k5k7Kld2yHA526LUfN/wYragWEa81IgkUFQ/4tNZcSlIZVZzUc/w==
X-Forefront-PRVS: 07697999E6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(136003)(376002)(396003)(39830400003)(366004)(199004)(189003)(36916002)(52146003)(54906003)(2486003)(23676004)(110136005)(97736004)(52116002)(53546011)(386003)(14444005)(476003)(2616005)(31696002)(3846002)(86362001)(446003)(6116002)(11346002)(956004)(26005)(230700001)(58126008)(76176011)(77096007)(47776003)(16526019)(65806001)(65956001)(486006)(316002)(478600001)(16576012)(66066001)(186003)(117156002)(305945005)(3260700006)(25786009)(7736002)(50466002)(229853002)(6486002)(53936002)(68736007)(65826007)(39060400002)(5660300001)(4326008)(6306002)(64126003)(2906002)(31686004)(8676002)(8936002)(81166006)(81156014)(106356001)(74482002)(105586002)(6666003)(6246003)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6Y0MwT3VWRkZjWmNjbDRTNXp1NTIrTHdI?=
 =?utf-8?B?ejkweHRGRnBRemRKRGNqeTFmTFhNQ3owNUpmNTk0VzBMT3JvbHVNa2hGZ2FB?=
 =?utf-8?B?eGpmcGp1WFp3T0NrK0ozSjdkNzFJeTJFTTM1d3dkemJIL2x1YUpuc01mNm9S?=
 =?utf-8?B?RE5XTXF1aTZMM0JzZHlkWEgvN0FRWjZnVmxxeFB3a1RZREo5a0RCMjVEMDY1?=
 =?utf-8?B?QmFEbXpEV1pjOWh0TVJQOFJpN0NxRjd4bVFia21PSmZHOHV3WmU0MTcydTZU?=
 =?utf-8?B?WUMyMHJpaGFHZVR5WWdheklJSjlOanA5VWtyZnlJcU5qbjhPMC9NQVA5WWdJ?=
 =?utf-8?B?clFqaElidU9TUVE4djA0RkNha1l5clpRTFRNOHZCbzhoTXIwcHBLMHhxTUZj?=
 =?utf-8?B?YVJscHcxbFh2eXVvZ0xxeXEvNkVKWUpUK2d0YzRMbStlRzJtM0NLTDlxSkEw?=
 =?utf-8?B?WGE5bGJoSFhMZlI4Vk8vL05nQ0xHQWdXRHZFVU1RazdFMHgzei9kVXQ1cWVY?=
 =?utf-8?B?aU9abjkrMDRnQlFvcmphL0Z0cERxQ0xmNTBNWUFiZmZWbVM1TGZtYWxadnh5?=
 =?utf-8?B?cnBWUGF2ZHR5emxYTUFreURUSXNjSmVIN0dpby9YRFZxMStPZnZmczhxWnph?=
 =?utf-8?B?VGpoMnZqQmtBNWVuWERlY1U2NktBb0FCSHFnOWZPUEFZTS9iRFZoMEpzclkv?=
 =?utf-8?B?NW5OenpSMUtFWTRLQnA5N1pyd1BJZ2hlSGFxZzVuVkxQTVZ5N2NRMlk3eE8v?=
 =?utf-8?B?ZkdBbUh0VFlPMlVjdW0vR0VGMnlHUGg2anRnT0lBMFppNE1kWVJ4dG54cWlL?=
 =?utf-8?B?MENUV2lHbmYwUFM0RFU0amtCaVFMODh2aHFHdDNxSFpDYnlDVnhPQi9ZTVJJ?=
 =?utf-8?B?b2RJRDg3Y3FHQUpqWTNjZzBMV2dqSnVPTythcERvVDRsZHJZeVZ0bFFPTHV4?=
 =?utf-8?B?WVc4bEJ5OVFJT0w1MFB6SEVqWDUrQVUzT1MzK0hIWjh4WFhnLzE4YitreWJm?=
 =?utf-8?B?S2pqWDl0bSt6Q3pVcUdMb2N3TERUbm8yYml6LzdWUnNDNk5mSW9NcWdTMEVm?=
 =?utf-8?B?TS9FbjJkMTdicU1IRlVCQlF2aXhGZkpmYzMzejZVT3FwK0dKQmc5WXBFemlR?=
 =?utf-8?B?bm1HVklUOTlZUTZTaHowZnJKSm5LQ1ZRTTNSdkpYY2ZPR25aS29MMmVnTVZO?=
 =?utf-8?B?VlcrQnIvMnA1ckdZM2pKOE9IWU9td0lCWWZ6NkxVNlI0eS9zTmxpUGFKOGlN?=
 =?utf-8?B?K2NDUkpFYVMvYzUwYk85UW5nWHlUNWdLVDhudWV6NU1BcW5ZRGRZOEgxeE1H?=
 =?utf-8?B?N2FsOGp2NzR1Rnh6TFplcGRHZ2oxRmdhWEIrWVV3Mm9aZWN1KytXVUREYjR2?=
 =?utf-8?B?S1UySTBWeU1DbnVKWlR5bnBpQ1BtQnR2QUtKMHhLNnFnU2pHdWMvQnUrLzU3?=
 =?utf-8?B?M3hLNk12OTV1TURENVllT2pjRDR6RlJlUUVTK3FpMGFQRTRoUitOUG4vTW9U?=
 =?utf-8?B?L0pEMTd1YmxJejdia0JUT3R2U2d3Q1d3YWpqL1M1eVhXcHJ5cU5hbHp2dHB6?=
 =?utf-8?B?OWlDYmx4aEZMVVZYK2krRm8veW9jZHlCd1ZrelQ0MFQzRWg1czdHNGt2d0Nl?=
 =?utf-8?B?R2JrdjcwRGgxb2FWZU9ScFMvK3duZTVnc0FtRUZBaG1TeGhnUVhxaStPeGZl?=
 =?utf-8?B?bVJhWFl2V2FyenZCbkVvanJ5WjE2bS93UUU0UmpvZGpPUEdGVEp6QzBkSWVU?=
 =?utf-8?B?bTFWczVPRk9zaXUzbmtIRk0zUFpzaThMNGowWFFvZGltTTJQZ0xQU095dUls?=
 =?utf-8?B?WGJTYmN2N3ZBUHY3Z0RLVlZaeWVFdThkdkxGWFdGODVaeG9BVkxnd0lJQlF1?=
 =?utf-8?B?Z0hBeDFtQ0htL3ptQjVKL0kwUHJsc0pEaFViWUxWcUQ3aUx3TmZFMWNaMkpu?=
 =?utf-8?B?S242YXBQRTkzTnZLSGJqcTZYMkx4STFmMkkweldzanlCQjhTa3dKMVM5SVhn?=
 =?utf-8?B?Z3pEdWRneDhnWlhhbytCRTljRFBxUWtVMmpYMUlTZ1VzRGFIeFJOZnZNdGpv?=
 =?utf-8?B?Y2JPaFpkeVZkMmRxSElpRS9PaFIwd21md0lYZ2M3ZGNKb1V0NUx3OEQvay9l?=
 =?utf-8?Q?3qZl0/ZX5crDBaVrsRmv6HeStIHJak+3j9l5dqgz1tEqft?=
X-Microsoft-Antispam-Message-Info: v0psRbywpkxX/hu5kmurnhUKu3cYTGMH/gPIF62WC/jmlwnktJd4UUm3zDYTdrY2IA7J7xOIPseA2ReGskr777CW/yibNlG+5HXdTEohXJPyVTMrTQ9OetTbq/UScfDNnrQrChmy+LkijYK3DVMTHNJCaswxwVyDsH8XGnyftQbzmrY4VXVt0uwXtL4Z1LTdwwCQ+i9JxcPpXT3Au6aKnB/qAH/HKnVn+Tg/fdFw6/YM4GSjq2l3Mngd+MYrRBYxzDpieWUuzuHNRUmPqh+MoVg82xBDPsMumczdaPLz4WEQIyGAdLMWKwY9EV5d0Z3J1pGOQJXUq0nX6mm017QejA==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:fXDXlgGJdjEOyUJHhfeVhuWBzVEERubVdI1StANcO0gdzgZSq5xrvHmgiYtsVCizMRwhiLbfA5aGEGZYT28gBeImCKcw46iZjQvzi68oPMJCMGYCQNrfvGib9P6DJR/ybU6C6H6cR2rBzHTb827i6ubrSZwMJ2xNofV+Lpujcc9BWUITSfOYzwp7RN1FJ6bhWjYcXEBCDG2pF/qWrgRJ6Rugeu5F3WqJE1S2qr7ITZcdsdrYhoeDUZCauGoDGBwK78ayyJjcnLA3+oNKsNkUsfEO2dFnzlWMcGT3gzqmXyfqHatpEgpdis8qXkylkS7aMNcD1W8qEoQg/diA6/p8pPKBrXsnNEsqqt20HSNZ6Oi+LzOQXo0d0caU12q1uQm5aGnc5CgLwJxq6d9O9fxthrFwQOlsaA1pJ/JNJ+vdTtemHkYQjmszGz4PK22MPO4J2Ggqy90QBRrEhH3gEPd+WQ==;5:9y0mdCMFQqPaaBfjMskH0QoXkJmIyaYbKVI79xo4VmlRDutnyn1zyucp13nroy+Kly8P0EoHyTg+0M/U5PHYmbKoXNJVKqwF8YSA2cvqZ2LWnR6IJ2vUZjiYEdoDi4BD1OmxVlYpuUcO/e7HMg5ItAkoA6W/XUZFni0rb06o3KM=;7:Y81kBPkJuwbvPTyrTY7ErXaP4Ez12R3jqmEmsniCTWmVm8IUvaES+a64dSr3Sl9Ag3PFZ2XKAq3avjOHoEkVH+7/mj5lLBeCTy6kR2BTmZ+p2zjYOJBtzknDwjF7FJIxmfNXXrlaccNRfc0iRbEgSeM9urmx35e6w0xDLYKtJejYYAr8o8IBVDI2FYMcFExh9yNCJ8fgeCV3Lmlbq60dyeqNIBzaJ2k16el5A+Nfj+ooCKJN0FMHj3eapIA/9ZDu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2018 07:02:45.8442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ad4cbe-91dc-40b3-40f2-08d605a1c484
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-21 11:49, Julia Lawall wrote:
> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.
> 
> The semantic match that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> local idexpression match;
> identifier i;
> expression x, dev, e, e1;
> @@
> -        match@i = of_match_device(x, dev);
> -        if (match) e = of_device_get_match_data(dev);
> -        else e = e1;
> +        e = of_device_get_match_data(dev);
> +        if (!e) e = e1;
> 
> @@
> identifier r.i;
> @@
> - const struct of_device_id *i;
> ... when != i
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> 
> ---
>  drivers/iio/potentiometer/max5481.c |    7 ++-----
>  drivers/iio/potentiometer/mcp4018.c |    7 ++-----
>  drivers/iio/potentiometer/mcp4531.c |    7 ++-----
>  3 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 320a7c9..c051ee0 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -147,7 +147,6 @@ static int mcp4018_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct mcp4018_data *data;
>  	struct iio_dev *indio_dev;
> -	const struct of_device_id *match;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_BYTE)) {
> @@ -162,10 +161,8 @@ static int mcp4018_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> -	match = of_match_device(of_match_ptr(mcp4018_of_match), dev);
> -	if (match)
> -		data->cfg = of_device_get_match_data(dev);
> -	else
> +	data->cfg = of_device_get_match_data(dev);
> +	if (!data->cfg)
>  		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
>  
>  	indio_dev->dev.parent = dev;
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index df894af..d87ca85 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -360,7 +360,6 @@ static int mcp4531_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct mcp4531_data *data;
>  	struct iio_dev *indio_dev;
> -	const struct of_device_id *match;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_WORD_DATA)) {
> @@ -375,10 +374,8 @@ static int mcp4531_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> -	match = of_match_device(of_match_ptr(mcp4531_of_match), dev);
> -	if (match)
> -		data->cfg = of_device_get_match_data(dev);
> -	else
> +	data->cfg = of_device_get_match_data(dev);
> +	if (!data->cfg)
>  		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
>  
>  	indio_dev->dev.parent = dev;
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> index ffe2761..6d2f13f 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -137,7 +137,6 @@ static int max5481_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct max5481_data *data;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> -	const struct of_device_id *match;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> @@ -149,10 +148,8 @@ static int max5481_probe(struct spi_device *spi)
>  
>  	data->spi = spi;
>  
> -	match = of_match_device(of_match_ptr(max5481_match), &spi->dev);
> -	if (match)
> -		data->cfg = of_device_get_match_data(&spi->dev);
> -	else
> +	data->cfg = of_device_get_match_data(&spi->dev);
> +	if (!data->cfg)
>  		data->cfg = &max5481_cfg[id->driver_data];
>  
>  	indio_dev->name = id->name;
> 

