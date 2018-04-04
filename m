Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeDDOkT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:40:19 -0400
Received: from mail-eopbgr30113.outbound.protection.outlook.com ([40.107.3.113]:52192
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751255AbeDDOkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:40:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 2/5] drm: bridge: add API to query the expected input
 formats of bridges
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jacopo mondi <jacopo@jmondi.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180326212447.7380-1-peda@axentia.se>
 <fcc47402-d758-4062-0565-f5977b85b206@axentia.se>
 <20180327130231.GO27746@w540> <1811029.jLvDxETu2H@avalon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9463e10c-120f-28f1-ef38-b0c8acedd1bd@axentia.se>
Date: Wed, 4 Apr 2018 16:40:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1811029.jLvDxETu2H@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0073.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::17) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea78f72-6e63-4986-88ae-08d59a39f761
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:OKt24PXEpvI7WU25Su+O1xPUqdcsSIqM4jYelAGFTdev1Ixw37YKfEjtrtCUX9grh0WQwIKKZxDEoYo7QBTDjk4pA4vxZC6NZx5YQbUcRXiZUs5sBFN46qa1ZWe5hG0fAxoYBqXkoCf4uySZs5K71gOctP3izRNdU70kM6spEKOgP12YCbnDN0fgf0Tjpd2mgV8klcqb+iX5UuLB2L7AtdvQfkTUmo53NUlWerS6Sv6RsmUuCaENa+2o9u/ca0aR;25:g/5OtvLBEbNB7KtHsoE6xzI2tDTLDpqRvL8LUThsBn40bS0RagQrPSH9PWdKOMpPhaW5rPoikne0jOaO+MFc1Pvo96JUZvelvX10BjJ+KeBhwP5eWftdNlQrryMGQTAdKX4+hLUSlIOui4w4hCFOEXqHDjbI8CXkEGYsN1topGbYXMUCgtCF+tIjAvMYOTJsGABNGpmrYOASISp3o6Ui8w0kouSknHlNC8V8Jz5id2GK0wlOzPgOQWRvoKTB48anBB3LK9+RCY2DfZS4+Ws9Rf0IJEFOodhlyYt4qwu0unwoFC2aLDhsj+mTmK7k6DsNBU1jcS0iSY02gDF87lal/w==;31:e8vA7ZBJxtWN2lrJ6oooKtEd2PCiZCzyrWDylyZBQf8z9tPLZA2ENyqRP75tHa9GHRFZ70UjuK0bcCDkQKV8os1ZdGbOaXmGd1pR4DJEHu6sO448QSdxanCV6C5dhEMUb7RerN6fV8LaUEZh/8H29t/iMVvmC+NhRArKMq1sM4Ix6ZjWdNF1i3UGZCCfPyY3I68lYMMByuuJKAoXPqDVAawVy0+bi78Q4u4qHwAn8EA=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775526A34E9613F8BFC32C7BCA40@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(100405760836317);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:XbLQOfiBWDVIFjbuB9bO6FJtBvWop8q5J5DqzlusuZf2AR2uFTRTnq+DXiKcjYofagNCqgOTIaehLm/bQgqsIzmck0bJCSmJlm9YhEtjHzp44bePPOtjNO1/aNE9jfgLdEvLvefKjuqIcmTsnih8zPFqeV90KEwdxvwdX4bDvigHxo/N2Al4DBu5VCvV2qb1/8PJF656SjWDz2EM762ONT0TiW5EB4i95jcdbpDLAvRo3VgbF/iE//+UEBiXYawarqyGz7WbBJhS6YG9aqXy0lk8hDbw4QS+JzizEfgLT2idrZiQi8Mnr0OByfewHhPK
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39380400002)(396003)(39830400003)(346002)(377424004)(199004)(189003)(86362001)(6666003)(105586002)(6116002)(345774005)(110136005)(64126003)(3846002)(478600001)(74482002)(106356001)(446003)(3260700006)(229853002)(486006)(117156002)(77096007)(2906002)(6486002)(8936002)(186003)(58126008)(31696002)(68736007)(16526019)(25786009)(26005)(2486003)(97736004)(59450400001)(6246003)(7416002)(386003)(76176011)(36756003)(36916002)(93886005)(50466002)(4326008)(2616005)(305945005)(52116002)(476003)(81156014)(52146003)(53546011)(47776003)(23676004)(16576012)(11346002)(66066001)(7736002)(31686004)(5660300001)(53936002)(65806001)(8676002)(65826007)(956004)(230700001)(81166006)(316002)(65956001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6eFJoSHE1SmFPK0ZxZnBRVEpNSGVsc1VH?=
 =?utf-8?B?NEU3THFvYWJsVWJjcFJXZVJTclh0WGdXYytaUVVFOTBTSGtCNVVhTDQwREsw?=
 =?utf-8?B?UG1FSUgzSmZPSHp5NU5yZlJzd2dzWHhpUWJFSW5ZTkJGZjMzS241aWdnc05K?=
 =?utf-8?B?emQxMGlQYTJoTm9HcXdMQUZJelArQ2FIbkZ5bnZaZkVIbThTKzJNSDFtS1BF?=
 =?utf-8?B?U0lsVFN5SlNZMnRkalkvVGVtUEhGYnRZamxraS85Y00zTkIxaEJzY3dkWjha?=
 =?utf-8?B?aXJ6VjJnQTIrdWN6ODFtcGgwelFneEhLZGNWK3RXN1VlblZiSnZqZ2JuTmZz?=
 =?utf-8?B?TndJU0pXSHA2aURDUGducXhscC9FYlVzWVU4TjlJRUlLVk1zZGRSMjZ0TEUz?=
 =?utf-8?B?cm9YT2hJK3pEbldBbWdZT1VlTzVjaVFOMnczTkdQeENYdFNVbDI5VG5wNUdF?=
 =?utf-8?B?dzdMQUhycE5PclFWdGZVNXI5ZmhMS2g2cklpVDlHb25xMzNWdkpSZFVxblNT?=
 =?utf-8?B?SS9zTXAvaEVJdUgxLzRqRk9Wb3Jld3kvS0JmZGdBcnZqU1QwQ2ZsbmdsRk42?=
 =?utf-8?B?WXdCMzFtNW8zWFJoTWx4NHBYMlYrS012YUFSMUFNZ3FwN2RKMFl0K1Z0OWl1?=
 =?utf-8?B?Ujc5cDJIKzc4blpQUlJEM3RwTXlIS3ZOTk5OT0dPVFpQT2lkdFNRSnU3YndP?=
 =?utf-8?B?djF5UWhweFJGcWZvdEZ3Q2dINXNndTdJVWZLUHBIV011cU1mTmFvOGlGb3BZ?=
 =?utf-8?B?WTcxM01DL2tyZm8xcjlKejFOU3RabS9yNzV5b2RFaktxMU9SYk1LYWNnSUxG?=
 =?utf-8?B?K2FPRUpyQTBxNmFpODNvblU3Y2dtV3NPenNKK0JPbTJTK0NObk1xSlFock9G?=
 =?utf-8?B?ZTVkLzROL2VuK0tSaU9NYXJxOEhKQTVuN0JMQ0Z3Mi9FWjNaQkVzamxkSlVS?=
 =?utf-8?B?bk12dDIyQSt0eitwS1hWNitJc2FlOTUyTHh2UUd6ZWMrSGZ3Y0E4ZWd0aVBM?=
 =?utf-8?B?WWFMOG92Ny9KWm54SmwyRFc0eGpXSDZVbG5MSjl4WlBINXBoRytOMlRiUVUy?=
 =?utf-8?B?d0UwMDN4S3AwNkI2a0NtbklTZGRidDhqUlNpdkNuU1NvTmw0ai9xSWk1cGp6?=
 =?utf-8?B?UkdrWTBHakJvN2lVeFRnZWFqVDh6MjE5MmRtV0JxTFQwTjlxZEJZM2NiN25E?=
 =?utf-8?B?K3hPckpKTTJXWitWYWhwVC8zSjdCRXpzR1VaRFJ3dzNQc0RvVXFEWkdReEk1?=
 =?utf-8?B?eEZyNkg3clJPNUhuSlg0WGREaEpaSWNDcUVxTWt3N05UbWFjL3ZMbDJqOU5M?=
 =?utf-8?B?TlFRQWhwMlRuVXhQRnZPU2Y0OTBvRUttZUpxTmJnYitkU1VDcUlpRzdsamFu?=
 =?utf-8?B?OE8rb3l2VVN6M2JzSGpUeC9ua2JFc0gwWHV4ZGNXcEJwWk9GY096MUNEcGtS?=
 =?utf-8?B?YUhIcHp2M1hkNVhHcUFWeVhhM3JpQmFsaTh3NjczRUxodHZoelhzWDdyRkVh?=
 =?utf-8?B?NWxZT2R1eUZpWDEraFlHR1ZZYi9WVkRJbG02NWdyUUxOWFQ5STZJSmY5RWJl?=
 =?utf-8?B?QWVBcVc1Y2lNM0g0bmZRV0pZeUZBVVIxOTc5bmxSSjRQYWtscCtNQmo3Y2lj?=
 =?utf-8?B?UysvYmhYdHgxUFdxdW1kMThHT2cvOENiNGo1cXR2OExocWVKcXhiL0tuMmdW?=
 =?utf-8?B?dldXbnJPTndsZi82KzQzaW92MHhzYUlrTjNuTUpTSjBPT096N2dZcVlXdlZt?=
 =?utf-8?B?VzZXb2FtNys2ZU1JUytyZnhHSG1kdTdrZ2Njd2NVcHBib1FZZnJCb3ZKYytY?=
 =?utf-8?B?UmVoeVZneE1uRGFMSHhoRExLL3BRRnB4TC9tdW9FQ00wb0xLbHROM1ZoU2NZ?=
 =?utf-8?B?MzI5amkzeS91SDFlQXFMZURtaEp6QlNLZGdiUDBvcE5VOFpPV2RadXY5SFNh?=
 =?utf-8?B?WUwxMmVZdGZKUy83bkRuWmFHSE1IcW1aWGxyd2REN09aTzZtU1ROaTlyd3dP?=
 =?utf-8?B?QnA1QzRuZVB2Q3Ivd0w5QkJwc0NqMWpsR3pQVU9kM3VGODZPMjE1SmNSOHlh?=
 =?utf-8?B?Z1FYTW4yYnpTeUI4TzZQa1BSdUpXbHhnNFJkVkVFOHhVYVJqZW1XUEdnWlox?=
 =?utf-8?B?Q0E3ckRQNXNhR3VHZnJzMWdIZGRtTGNYTUNDVmp0YWMvSWlBSVhBZUZLL2hD?=
 =?utf-8?B?c00vR1kxbVErZkVhU0tBVnphR3lERUNqdDludEtZTmVjWlNwN2VYL1hxUVdN?=
 =?utf-8?Q?PpaehFYlNZWPB4aLS2Se?=
X-Microsoft-Antispam-Message-Info: YysubOjNiyOCVDuVtVU6yarQas7OKhrZ/W6XUSL5qACV4Rl5fkBgDV89zNQOZfqdX2ZZJnK8It2m9X+07BDaR2jlPqfx74mjIad+3djgARpWigLn/CA4OYhtSqTs4ui23pGmQo2u1ptkacUyHKIKR5jX/mmySOF19QoRh840N69AaYT5LCNXNmIpEibi3jkN
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:rPFjPW40O70hG8VY56ax/TAG8ciXssH4/Xje9V/k1tJuKJpUn7K2ojAITviDUvAQIPiw5Ocu3ncYC5xmE58NSTJmjpSl2unWAIjYEAyxXHsysmsEGSUKopIsL4g8b2OTnoe2dDE+sQeFJ8iwBTYXhuXPQvCkEmfQdlx0l0RNa58SDTAVF+Gw41xvY21W4g9QanCxH2euP6x16rjX2AWCt0DtQEGBmmWwSZfGpFVrQ0A/gcpgJMtxH6+Z5sIC/XMVeysLAIcB4FUBR1v17Wgg3ZPGYl5Erum/3LOS+0jFzerOTGzIpWSY7f7S2+YFkYTc1Rv9FzL68VeKAevRY2zTVQmfqGMjOCO4H9jYQ8RkPGyqLYcDpVWAFDt8AC2B9YfERqu2z1tR4XwLmD6iuW16OgOzYFwVx/ysBcpOObT8opAofQMg/jIUAJKjMvW9hJOOY/nYczPPZxgq1+oeMicAyg==;5:ogVSAKiUdjR9GgJpK7G6jH5dZcixXg+BrblLlO4JM4AqRh8TjND7UCxZJmkXvUMEjPT3ZlJUUCrlEuZg2JhZ5igAV4LXyOPEoenFjhlOKA6Yqmw5mPYtLYu7eIhSbvWlY47logiYbrekNjQ3Wnq1/+imw8da4wEGjvGn/vNZNGM=;24:oL/S28hkR9mc1O5yLFhaQ7+HfB+vh87CEPS4gSnsfRA9HorZdcTyP3vzPVjU1ZpsJe9TCLYnjupMarMjeRckgdCbHbwFeFw4ynCp7Ge99I0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:+Sp/v8c69WrFfVWTe4OYCbr4F7oIqybxOjrrAMYjp2si6srGZDDqhmxT+Ili4v/XD94MrelhEYLyzZrvVhTEq9nudEOlqj0CVtCI4Zf+NGDJijeLn0wCMGuIjt8qNvo/rPUYJ0O59TeIXOsTBW+jHnpJPVlK2yHs3SnET5bY15DpVxClkcvDem1XbFitKFSeyIUh8I+/H3vBAMW1htCfDhg5RMXMs5WkZEouHO46k6jjWzzam2ijljN/sG5aBPf+
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 14:40:08.3377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea78f72-6e63-4986-88ae-08d59a39f761
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 15:07, Laurent Pinchart wrote:
> First of all, thank you for the patch. This generates more discussion than I 
> had anticipated, which is both good and bad. I'll comment through the e-mail, 
> and try to explain both my initial idea, and also where it could lead us.

*snip*

Thank you for the long interesting mail! I will read it again, but my
immediate reaction is that I am not the man to attempt anything heavier
than static format information in drm bridges, and that I will hold off
any further work until some consensus has been reached.

> Finally, still regarding Peter's case, the decision to output RGB565 instead 
> of RGB888 (which the LVDS encoder expects) is due to PCB routing between the 
> display controller and the LVDS encoder. This isn't a property of the LVDS 
> encoder or the display controller, but of their hardware connection. This 
> patch series uses a DT property in the LVDS encoder DT node to convey that 
> information, but wouldn't it be equally correct (or incorrect :-)) to instead 
> use a DT property in the display controller DT node ?

Right, it might even be more correct to do it there? Thinking about it, I
have this in the DT

#include "sama5d3_lcd.dtsi"

&hlcdc {
	hlcdc-display-controller {
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;

		port@0 {
			hlcdc_output: endpoint {
				remote-endpoint = <&lvds_encoder_input>;
			};
		};
	};
};

Where the &pinctrl_lcd_rgb565 handle tells the chip to not even bother
routing all of the rgb888 signals to pins and thus not waste pins that
are in fact used for other things. Maybe it is possible for the hlcdc
driver to look at that info and suggest rgb565 instead of rgb888 without
anything further in the DT? But maybe it's difficult to peek into pinctrl
bindings like that?

Cheers,
Peter
