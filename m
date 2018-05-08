Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbeEHGgf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:36:35 -0400
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:17186
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754281AbeEHGga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:36:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] i2c-mux-pca954x: Force reset on probe if available
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bc56d669-b02f-a017-844d-e095bbbcb7cd@axentia.se>
Date: Tue, 8 May 2018 08:36:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0401CA0050.eurprd04.prod.outlook.com
 (2603:10a6:3:19::18) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:fvIm9G/fB4MIC967+xXjwirQcXUHzS2sCfzxTFhjWpNakmRjufxlS157CErML46c7Ncj1fVmIZAnv7KaGdDVwtxRfm6O3Ew6qMeKlwJY35qWSwhMVHMczhY+G0B5OoDBNgFUBjXUGHVSh9czCKz8yo9lCN5Q7T1a5GC/Cc9df9OGmV9y4vHUqF/1CM9H25XIm74kYB5WdBG2fJbSoo4GZcZnp/XS9/b9U9l05XcX3Y0tBbLkuNnSDIt0kGb25dyl;25:8DoTW2TbXbjnCo2Kk5Pl0RfH/iXHuJljhFNZ7LZYTLMHH9dEAOSAXfscNcPaznzCX1Vn8LahppAtvvEiSnI5oADSN4USp43XEYwc40wBJhaWV9qF81YHJnMSaRw4WTmtxZlcHqJW5ifdd0pC5way2tX3LVQ5K2Y+p/+/SpKyUXXJAwOME7s+u1iS8EPZe0if8NR61MDqXJCJ7OnB1pvnTUHn49hn/yPOq/II5R/gGTsrSptjRSGdmcaawHVD37i7+TUkzje+IF0ceGPKcs/+KlbDgdZXsQsHPvvt3zC5OK+wGynNTv4rt7ELBxv8eLfkSq0m6mXQCb795okSi9Velg==;31:zUYac2vkG61RROgbajMzbmwC2pnQb7/AuZIDezhX3si2teODk2m74zA5yUdJ2IztwnLT0VJ6gQg4y+k3SeZX66eDHvjIrMX+YrXZDwDSoaGAPfq0+B2/Rr4JqJo/aErVc5Et1IKxJQNbRzfyd2EYqp4INYLLxKs46NaKiqu7PZD3KdYSe2ObqO0W4TPc5xRAg4YiOC8ItgmwJrJ6NXNn8ONjSvsK5Kf1C/XORW4tWXc=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778F399701312614AFF3984BC9A0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:9KiM+mJ67n5veBrTkwg8eu42IyegIRY2lTPOVk5fLEDyKHldbC68Hv04Igc3vUZgRGZAoazo0hNhA9yN5EXGBC0m6neGcCz4ui/A1r5eJC1JpEKLQA06e0MJXZUwxRh4QeyGovVpg+CDEXRdlz3aNP7V2DTgkACV/wfN+8y6FWEfXTSsciRRMxCr90bGPKhbv3ssWQ2KiKE5qgqVaN1IsIxwBxwmXDgea325IQ/aD8SxZbYsEjggIVS4TtnlpWalvQQE3XqPl5o6BlumW4xrVQ==
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39830400003)(396003)(376002)(39380400002)(366004)(377424004)(189003)(199004)(31686004)(68736007)(305945005)(3846002)(81156014)(6116002)(229853002)(16526019)(7736002)(6666003)(230700001)(81166006)(53936002)(8936002)(386003)(86362001)(106356001)(186003)(31696002)(6486002)(97736004)(53546011)(6246003)(105586002)(4326008)(486006)(2906002)(11346002)(446003)(117156002)(478600001)(23676004)(36916002)(2486003)(52146003)(316002)(59450400001)(956004)(65826007)(2616005)(16576012)(50466002)(476003)(5660300001)(551934003)(3260700006)(76176011)(25786009)(36756003)(64126003)(8676002)(26005)(58126008)(47776003)(77096007)(65956001)(52116002)(65806001)(74482002)(66066001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6MG1IT0NwOEN2Zmw5cUhZSWR2b1o2YTVB?=
 =?utf-8?B?Z05qS0VTT2Nmb1EvbHB1Q2hoT3RpZCt2N3hDS1ZkU245K0FwMVJWc3Zhdm5r?=
 =?utf-8?B?SUI5L3RUdXNLajZBeEU2OFNXWG1JZGVDaVc4dkxyYVRDY2cvK0tMUndPTmgw?=
 =?utf-8?B?d0FyQ3Q2SUdkUVpWak1PRnBmK2lnYzl0SGRpbU9SM2crVEVMOHlEZjNiaENl?=
 =?utf-8?B?WmV6Z3dGbFVEZnhuWS9MdWhnaXNzSG1ncnhuM2dIVVlyMTljQXJVcC9FckQ3?=
 =?utf-8?B?aWtyclpuWmVqOVhTRWozcmk3MXFvc0grczQrWC9TV3hxTEF5TnpLWkNraUI5?=
 =?utf-8?B?R0t4clY2ZzMwdUkrNk1NZzlPUVpucCtFNlk0T0Y3by9HMUlnNXVWemF2WnVm?=
 =?utf-8?B?eEZzSVZESS9QSFZ0QWt4WUp1dlhDU25XWTU0VlN1TVI4blJzUVFGZVBZS2Nu?=
 =?utf-8?B?TksxUmxObkdpTEpTdEtpYnRpL0ZFNk9wVW10TXF5Yy9OQUlET0Y5VndPR0lW?=
 =?utf-8?B?R2NwZUs5TVNqWlp2QUd1ait2M1l5K0E2QWQvNjkrVE9OM3hBN3lNSkEzdUIz?=
 =?utf-8?B?NWdOSSt0dEh4R0pka29XOGxiZVdrYmdPZ3ppMWlwdHllOG9OT1IrMUZUcksy?=
 =?utf-8?B?VDNFMXd5VG9qbzYyQmE5U05lbmhqWVZXbjFMUDY4bVZYTDIwTndPdzd4RE9D?=
 =?utf-8?B?Mnk2algrQ2lQZUtvTGtMMEpYTTdOb1dvVUh3Z0lYVFBta0xRZjZhOGl0clRF?=
 =?utf-8?B?UXBmaFNtNHdqOFlIS2VqVzNSRlVEQTEwMldxSDZ5R1FHUjMxTmI5WnIvMm9P?=
 =?utf-8?B?VlVxWk53SjErQXptcWdnTU05WlkyUU5uM1cyUjVrVmROVzVhSTMrUHd4elp0?=
 =?utf-8?B?MDl4c1h6RVVreDh5R3dhcDRTaTM2S1BKZzVWYVFTT3Vmb3VvMmJIZUwwK09x?=
 =?utf-8?B?QmRpUUFSWEI1dXMxcHhDbE04NGRoUjZwS1FrR2dOTEdMRzFHc3ZnVHNxQWZH?=
 =?utf-8?B?WXlCalptaXpFdmJHbHZvOC9YbzZzVkZXeDIzemxwY3BiQW1IZEFIZjhnK2hh?=
 =?utf-8?B?azcwWkxKU0JtZ1p6YlQ5VGdFeHNrc1M4UGZuUlM0OUg0WHlENHQvc0pmbEc3?=
 =?utf-8?B?ZzRDYWhGZ0loYTFrczJGR252Y2o1blJEbVBsaGZYa2xxOFJqSlB3TnNCbVd0?=
 =?utf-8?B?V1BNVHVZd2d0VTBldGlHS05JR3BNWE5ETHdZMks1WEdRbFhhanpHbXJHcGhU?=
 =?utf-8?B?V0h6RzlIMzdrSmM0amRrTEwxOUR4VWY3a2tXWW9oM2hyZHdFeURBb1llSXJC?=
 =?utf-8?B?bjNMUUt3bFUrS1ovalJiNGFWMXM3RkdWSGgvbEtxZVlDVEpqaXArSkhjV1VO?=
 =?utf-8?B?OXFWMXlCMkFFbS8yL3BLNU15T1pXMWtHUDlaL3J5TEZzQ3Y1Z3JmTlZ3dTRv?=
 =?utf-8?B?VXNkRlFDcmw4NnArT3RKRWc0SE9OZ2ZGY0VvOFZjdFJvZFJxNE8veFgxOHY1?=
 =?utf-8?B?UXVOMlVITHg4TisxQU1rSEpramJGQVloQWFmRTgyRzBKa282MER2ZkNnSzd4?=
 =?utf-8?B?YTFDdE9CaTE2Tmp6S1VHU2Nqc3pUcmpkVFF3YVI5UTJGWXRpb3ViYThUdExC?=
 =?utf-8?B?V1RaeFFVR3d4bkpJaENnajhyc3RyWDI4NEh1VVFLbnQzb0R0SURjQ2tDSjE0?=
 =?utf-8?B?WWMwOGlDVTRRdnN0OVVNUlB2Z1AyZExxcXg4RlBPS0doQnpPcm94S1Rad0Jn?=
 =?utf-8?B?bFJ4OGdMeU9aellma0RHTGhBcXp3SVBCK3BscHNIR0pKYTF6aE1lcDhmSVg3?=
 =?utf-8?B?ZFFlQWhOSERWTTRJcXUyOGEzdVUrbXVHWWkyS3pmQWgvY01kR0lpUW1VQUFy?=
 =?utf-8?B?eUVpSGhCNUlZUkQzbnJmeURCYlpEVi8xalNlNWRUVmNGTzRENGJjSGJrSVl6?=
 =?utf-8?B?K1p4VzJDUGNPM0hxWWJuMWl0M2hXc2lPLzF1bFlYT0Q2TmJ4ZXBqVlpuLzdo?=
 =?utf-8?B?ZWZ2eVdUeHdyN1BqcUUrdmk4N1d0dXExQUtqWjc3SVFYT3M5bVRwR2kwM0Vt?=
 =?utf-8?B?RnJZaGZVNS9NazRtK0F5Y1pEbGN2aHp6cEl3MXBEc0tLQXFTMUhnOTMydVJH?=
 =?utf-8?Q?HpdYZbkaL+wLHEhGbM6WGPX0U=3D?=
X-Microsoft-Antispam-Message-Info: FlghOCEqsqJaq3Rzj//hJs5/UreuAMF84BuBlXBK4HLvkj68xjtF9RRjanQn+qNhA3gFBlMjaPh6RPkAfVIWUbIl3Cp8w2pjHsp1XQ1YN+zgzKzbOegof+1Zs+bS1F4GoHCWdO3t8zYwPcZFZ1GdZ79EUfxHkogbJUrku6lyeKoqhpoYrHznZQIc2bn7ymzw
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:jFVdihtRFcbIoQrAEW6lQgr7QpUSg0eG6iLBjB5El3+EA4/2iBAU9wHTbiyd75gy0nzZVOYoep/5rmMw0a+JTtrjEI3WzAveK3rcyT4L+L/c2onlhpBrk+EN0x7u6vjr0cr4r21Mh9tKNNik8PNOWY8CCEDuRmTLlpjnDjuYvgszeducgfFo/dpy5N2mp5MNq7/4ronTRysx5HK/b/AeO+ic0Te0uxAZRxXtlcktSVY/2Ot2MsnNy7T6+XWMeq2lsDEOXQRnmMvCTO9gB+msK9RMH6WA4Gu9CrcEbrGOwnjL5BLubQ8Fi9lbXwqh5ov6Tua/J3igti5dXThWp0FuFW/VWjYMzvqScTb9j3uAkOPG29l80qQA6GUurQOmzDz9Vgspeh/bPLe7ZZ8fgdjMbGZPtl1P3H4Ia0Bm/9clqFFcy1WBCaIoi+x42tZ/B7fJJn3HXCbEGP0ZT9evmfTubA==;5:/KZV32nivXRE93scUPLXQv0u/OuaYlZGwPEbGk6sOayUnh2X4ni/J30xwNVZow5nSh5MnuNOSvzWsDjiC2VQ7kVYPgjadT9Zg6WeBjiOW5kjhfBtQpGEzBFkFidZLbVwlWPVX1XDkyoZUUbU1zKxo1p5bQGDBBovotRcz6Imp3c=;24:tw9A3oaWe1idhpdFlzJhLqS3rc1QE+yYh5gp64OxumQBv2GEBziszJitPil5J87G6abL4IthYyE7fJsNAltBNc8oQ6Buxy411BjTZUn0gUM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:8JXV0/AcGudSQhlT50t43CISCjql7A/QbPjbW21LC/djm4W/L3uI0HJ2hRF7IztLfWSdYn2j/aS2lq39TpXZSgSGbNT07gaxUESXEYAiQ0+zcQLlV3wxkg9PHAL8i5eJdPLi2gqJrIMjjKZX3TAg1kMd2GsfX2XJ+jhXomD16qVWEvn6VJIjZEXSdlORH0twZn6jd6+tdHGqHjcm3UY8l3Wc5LyXVwiCNKThLdYb5GX0E4lOBZG+wbtn+dUZ+hEf
X-MS-Office365-Filtering-Correlation-Id: da28bacd-9d18-4899-600d-08d5b4ae0682
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 06:36:26.8059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da28bacd-9d18-4899-600d-08d5b4ae0682
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-01 13:42, Mike Looijmans wrote:
> Instead of just hogging the reset GPIO into deactivated state, activate and
> then de-activate the reset. This allows for better recovery if the CPU was
> reset halfway through an I2C transaction for example.

I can't see any problems with this, and a reset at load time can certainly
be a benefit. Some questions below though...

Cheers,
Peter

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 09bafd3..13e10d0 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -36,6 +36,7 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
> @@ -389,10 +390,17 @@ static int pca954x_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, muxc);
>  	data->client = client;
>  
> -	/* Get the mux out of reset if a reset GPIO is specified. */
> -	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
> +	/* Reset the mux if a reset GPIO is specified. */
> +	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(gpio))
>  		return PTR_ERR(gpio);
> +	if (gpio) {
> +		/* Datasheet specifies a 4 ns reset-low time */
> +		udelay(1);

ndelay(4) ?

> +		gpiod_set_value_cansleep(gpio, 0);
> +		/* Datasheet specifies a 500 ns reset recovery time */
> +		udelay(1);

ndelay(500) ?

> +	}
>  
>  	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
>  	if (match)
> 
