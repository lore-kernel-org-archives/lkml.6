Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeEWKRg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:17:36 -0400
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:13831
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932180AbeEWKRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:17:31 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] gpio: zynq: Setup chip->base based on alias ID
To: Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
 <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
 <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
 <CACRpkdbCsUBMcHg+xGOQCBmhoJsqh9VjK+4pjhG5Hf6Fjzwjww@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <3165bba5-31d4-2dd4-bdb3-851889595e2e@xilinx.com>
Date: Wed, 23 May 2018 12:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbCsUBMcHg+xGOQCBmhoJsqh9VjK+4pjhG5Hf6Fjzwjww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(5660300001)(4326008)(26005)(2906002)(77096007)(106466001)(230700001)(39060400002)(6246003)(64126003)(63266004)(186003)(50466002)(478600001)(36386004)(336012)(58126008)(31686004)(446003)(6666003)(305945005)(54906003)(110136005)(316002)(426003)(47776003)(65806001)(9786002)(36756003)(106002)(31696002)(81166006)(44832011)(81156014)(486006)(65956001)(93886005)(11346002)(476003)(126002)(2616005)(59450400001)(23676004)(65826007)(8936002)(2486003)(86362001)(76176011)(8676002)(356003)(229853002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2853;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT009;1:EQz3yiinvD7T7IZn9qfBA3hX9mu23OwKd01D0r7h6HGDjyjSw/v/QTny72hot5WKSEbG8sYRmOmX2H7ZqlbSAHl7C5sQOASzBwFwq+Qi9YsbnLPr1s6m7/PKqH+7yTh3
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2853;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2853;3:3ejCLMWEz14ug1C0bt9VbvdSbbPhlyHyqp+B/pHgNbIqhMeUBT8Vwp2iO+fy49vOsH+4f7RW3yAEsaXsfdNT4GapGbK5SMkWy3tKzYqGJ4RJsiZ5G+pc++YaY691rj1BfCCHaYJpCbIGX+mYJw7oZKbb6SWII9rXFFA4IJbHFc9oRMm7naixX95Sh8op9Puk/p//VSo+T00VQIqv5bq7TQ6gfbAXxetHUIDLo9QThP3z5zLlf9lEG7ZP9+LHGzRpLH7lPlSQ97tsBBGcZvRM3y+mF6l+/vlIy2Smwi2f1PLRWor7uP+h7pYhTsOguCNpLAAQdrFMudjcKohn1dj/WIFzKGsE4eFYo/MEL+j7a90=;25:BWBKuIR74ePQnWHml5Brg3v72GIPWUTOaV5V+Z6pMPhoMO0FVMfGZ6+KUFl53CseVFD/V9rhy5UcanlxFNEp8AU4pe+lGcW5DevYha+hEwdODy/2EILU6cVXZpvqtLvpDXW/caKLcziFE+533WZorLdjLXh/PExYgT+FAGSpz9favmGp3kdGjNOIiAs8z2G+iFPAMfg5f1GEEUMzI5PrDOdm5kPgaFhH4mg9nhzfwiDiwHVGb7vugpKiGexZ3IN5MN1ZNXAwDNRQl26emXUujPRxbhjncvobCiYqnbcRwX3Hd9uDxHslSLYhqeeISNfWGc4E9YAA+Q/f6FWxhL00iQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2853:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2853;31:Hzg8LPt/tDD6T5Md3QYzN54rssVyuGpQ+A463hv08/mrOieklJ0bPNa6E6a6dS/LahJfoWavRI9hTEmjNvmtViV9d2D+N4/gq4W7ERzomL+1o/O+4nsmEKdFJp+ygTCyJLdqUKx2UUSKbCd/rYtzH/+wuRZXYugcwPO+LSy+xRHnZb8LrgXnEi2LVz6EUGsT/VDnZ0zUlhlg25lHXaZBiKlvV2BTpSj/l6i7swKg2iw=;20:u7w/ENKivvbyOpRGQofUq0r2Pb7lZ+/zsTl20MZqutmgoOAhlRlRjiQW0Y2XuLraVBYRvsb5efT/pNLcNB9qgrpMQ74srDkMGUv3L0TDQbFGW8g4vgEpLplfsRG8cokekV1uVjLYIhAqd1boo0psP+zgmpg112710SuTAykFKOuQH9Uw93Dwj3DtgY9sU/svu+7kZ9DCRXAq7Va/Wc4lUU9iVV8+tAJ4h8EH1/OjFI28q1bAJROuo5BpVIml9jZ+pdat1LwxhVQaKbmjkBiV/TK5owY8Gs3T0D23oNWm7WJGlRwdZccnUsxQ79bofrEmKaIDjT1nzT38UmFt0/5PZm4DZn/vpXBsrOUa3zACXpePDeaiHBuub6KR13U0aTTGBZfyTVA0pJ5sEyIfp/hvijjzIQpmQIMHaNgAJ/6XppnXA8wAvuXyZdDygpvN1GsYkTHfjGCeGmk6KFXMgAC8lIB61z+YJsFPDMSi1pMWZTA0Q370Z6CbRIxnPsGC7JLU
X-Microsoft-Antispam-PRVS: <CY4PR02MB2853E50D744EC2DF008F13ACE26B0@CY4PR02MB2853.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2853;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2853;4:XQZaMiASSSBUZC1GO/y/9sAR05LnizQSF73mZCf1JdRNEOPk1Sy7OeLASCnzYLTUaLALdCcuGmfKmIQOi+XgRRV5eVruTLA7d/yTFRw9UYxTt1oNKwSK+lzU6B0nzN8Lz7hAlcrApbAm/WH6kiEuvfJxSQ42Womn8Ge5feRbzqnsQHxA0JjNoKW5vRTTuIU1CFJeTy8V8satfm93SZywMZ50biAna6aQO9jOE6XGT8UX7pv6fepbcUbRJ0rURvnSpu24ya0p52WYDyjZ8WygKQ==
X-Forefront-PRVS: 06818431B9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyODUzOzIzOm56Q3A1TjY1WERSTVhlcElvYnN0K0ZuZGpU?=
 =?utf-8?B?ejRsMndEY3RzTDQxOWVYdFFiTlhYVTJGRTJadS95bTB5aTd5Snkwc1FuYlFP?=
 =?utf-8?B?eXZ0bGZLczlHT2s4Umt4UWZoL3RrVGxvbDF6OFRZdVhlc3RmRDFkbmZhaGJm?=
 =?utf-8?B?M3YzUFFBS1N6T0FkcTFObE9OdzVPOXRwRGJWQzB5YzIzb2pyYU1yeU0wUXdW?=
 =?utf-8?B?cXBrWjZCTkFVQnlXYjcyc3A4VWRDREhYQ1VzUHptVDZSUnN3WU1WRThNMmhR?=
 =?utf-8?B?dlp3anVXRW5pWmgwZjBmNVUrQmVHbW9tdEVMOVpzeUl3QUduakJ1dnpqUmpU?=
 =?utf-8?B?Wm92VmNPLzNUSkp0YzQ1QkRLd012cXZhOHJJMU81VXkrZmRqSHNrUGxSOWVO?=
 =?utf-8?B?bysxZFFpN1pwZS9nZVVodDRjS2JqbFA1cWxjdk9rR29PV1JkZE5VQUljY3dw?=
 =?utf-8?B?YldFbkRyVkR4eURtdEhpUGt4ckNQUFROMWpmcmgwUEU0RGQ5VzZtcjZab0Vk?=
 =?utf-8?B?dW4veldPaVRQODVHWUZ1S3dYcjJVVy9BL1owc1MvQlcyUzhzWG9USGptM2wr?=
 =?utf-8?B?TlU1dGRiejVmNVAzZ3l5RW1CNDdvaGJxSEZuTXBHRXlYWEQzcXcyM0ZrQ0w1?=
 =?utf-8?B?b2d2cStuVjluejhxY2paYWNBWmNCRmRQallzQXhzWFdFbnY0WEV2UDdobUhH?=
 =?utf-8?B?VzF6Y0JrNGJMWFNTc213cHd2UnlVQlBqcUcyMXhNT05jM2dHeWVPN2lKamVU?=
 =?utf-8?B?ZWN4NXB4VCtnV3Q5aS9LMnVtQjNlQ1FNTlEvc3czZ3F6eGZLVkVMYmthWDhX?=
 =?utf-8?B?SnhRdWQ3bmF6amd6bW14bVF5bHQyUHRLNSt3bmhWeWFxUC8zZmE4cGxtZUxj?=
 =?utf-8?B?dUpkc3lDUEw4NERxcGlBOHI1ZnJjT042L21QaUFXTDNXUGY5R21BYlI4eWZQ?=
 =?utf-8?B?YVd4MkZLL1NxUkNpWlpodUNaN2pvM1YxUVVzYWlyMmcxdGNwM0FSdDE0N1Rz?=
 =?utf-8?B?TXoxZnlPRVhJZjdWMTQ5dmN6NDBMWGowR0lxVjB5Ni8vVHIyVGxRbWhZTUE5?=
 =?utf-8?B?anhKc0EydVp4OXJ5V1EvVXYyd0Q3Rkw3RzE3OXlVa0xyOXdCREVhYmtTZUVF?=
 =?utf-8?B?czBmTEcrdUV6N3lKSkZnOEJnZ1AxdEI2N3dNUVZDeDI3c0JVY0ZnUFc5Skt1?=
 =?utf-8?B?b1pBZG9vZVpRRUhuS3QzTVRQK1kzNU1RaERDdThzK3drVmFsNnBNWUNEQWRD?=
 =?utf-8?B?bzVwcmdhMTlVeUNCYWJCaW10djFHUTAyWnA2N1ZiUmpjdktHM3NrQkxCNFBL?=
 =?utf-8?B?dy9XYjZmVC9WUFplR2hNRGFjaHFNQzMyRnNYZDNIRU9iV2xuSzFpY3ppYVRD?=
 =?utf-8?B?ZXVxdDVvUTBtbmhHWStwREFYdlBKZTJLQU1tcVZJUzIrMkFYbUJ3OUo5MHdD?=
 =?utf-8?B?aG1YRUFqd2pnbTBiN2JlclBabFJqNXlzaEZFc0ZGL2I3L0Y0TS9ZNCt1cU5T?=
 =?utf-8?B?bEQwb0xtUnFIaGRQeC9rV2N5NXgyYVUzVE53Y0pRakVQUjRQWk9PbG40THZO?=
 =?utf-8?B?b1V1dTA2b3pjS1g5M2QybkVnWnBob2xtRjJneDFVaG55QzVnMDJhT2dwdWY3?=
 =?utf-8?B?MlhWRk1vcUZOMU03WGIxSGgzQkJWbTFzTWNlR2VUQ3JDMWZRTm9FWEs0cmFD?=
 =?utf-8?B?UUpNSE42Q0Jsa0FLd0VROVJtdC9CYmxBc2dMY2NOSmN2ZnI2dDIvbjAyN1Jt?=
 =?utf-8?B?Y3hGdHhuSDBSY0RKSTh0M1BvdkJOb0xUcldFQWFCOXBVWHVOM1Y0bjdCb2g4?=
 =?utf-8?B?Y2tIZ0hjNVlkYjRLMWErYlZZZmJjeVJPMFFyTG53T0IzZ0E9PQ==?=
X-Microsoft-Antispam-Message-Info: vvbYI0AZghbRqkrAfHBvaf6qEzo0xqoNw2BvqZixJwQwQXmnV9XyRvhRdyV4elaAfIeRFxvYaGXoyk42JOddrM3ZqdYKIuAtvdNork+ntUwQd/2qpwJId/payZPS0K0sUbxIJtXVldQUAnOjyOblkDyX9jg9DhFfhcxCYqVgc2tGs1h45VemOUXr0p97CbDF
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2853;6:uc38XlujlU13NimMZYXUnekNaouGz5qcAUr8Rb4U49KFShumYz+I+LUT8J60gi/wUKTZFCVvfXxVRcxJc2jaymv8mn16Q/a2KdpX4Oy5vfKr4Nmx7QnGaXbP4GG72BpDOHRQ/HQVQTv7VgElx3YVTBE+tv68emfsYmVHl5RprSr6VBKAdoDlP7zrrIj0pBoNUF5oIF3vGhkwLxs94NwA3F+jtxYN5Ug9bE4voJ1F9IBrf7B0AXPw8Riitpxeip/J0DC7CTRVp5FE3Fmh6YCAyT7zhWbuxwOdvmpj0pQBAzQJZE97hoBiPRZA96Tvq0IAMh7/FUzpc4TWJMHF+ZeLKtmlmT5qK3B7HI58WLmhhj7NQJaS1yXmFynHlBGVcACBcZ3wDyYzxYH/u80JXBD77LOIvQdyCxS6+tY0OdRwSrdq6vhuQDmXMuZwcvvgsiRee8mZSbfgO5r0TfIFhek0jw==;5:ZGrGs1EmogyxpDiRHMa63GALuos3ym2eFvlCodsk1XYZRvvwR0BOZ5d9akwXa6Ien5vcO2hNVCIB+K0XzbcV+g4B7YW8Piym7BzCibJYlWObyxvUHGDy/MiInr6G4gpTZfvWft+G0V+Rw+4CzqS5xgWeVjzAbnTLuNOu+DMuFVw=;24:AX7ZYPgE2EBTq2gjeI1wE2yLaeHoFeA+DWK/QfRJ10Fv/jWTzqRz04lzF3hGrZw2mdKYO4lb+DnhxvKhY2KAZbVaWxlvG4JlPhlmqOFtJSI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2853;7:ztV5o8JnFcpYM+nAUYJTY5laEYuAH3RIlltZsgnpSNyAP3DXvxysxOZl5JBxZsH81IwsYpKhHGWrJ1Cp2YdJn8sCbqGdvfx5lXZBpPyzUDUmh0FPSAn3wizpkjnx9GbPnmFVniekTzFdpkJDkfxD/9wUl01JJz5bH+DTwRMKgMUgzd2qDwdQB45XRvoBL2YeVulQfLmobslc+YoUujx+Yzt2YZBUxWxTBvkzExtHsZjgiMpBQSd9h/aI1Fz78S+X
X-MS-Office365-Filtering-Correlation-Id: 7e37313e-3674-40d2-39da-08d5c0966334
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 10:17:28.2287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e37313e-3674-40d2-39da-08d5c0966334
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2853
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> If you take a look at
>> arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> which is Ultra96 board gpio-line-names are filled there for the whole PS
>> part. Definitely take a look and let know if you find out any issue there.
> 
> It looks good. I even managed to boot my Ultra96 board which
> was sent over as price in some competition (great hardware!)

Wonderful that you get hw available to be closer to issues.
Maybe it would be worth to give you some guidance what to do with PL and
how to add more stuff there especially in connection to GPIO.
We have pinctrl driver in vendor tree but my colleague needs to upstream
firmware interface first.


>> zynq/zynqmp gpio controller contains PS pins (hard part) and PL pins
>> coming to logic.
>>
>> I can't describe PL gpio pins because it can be whatever even I have
>> done that for one fixed hw design.
>>
>> Interesting part on that sha1 you shared is how "NC" pin is described.
>>
>> gpio pin 35 I have on zcu100 as "" but it should be maybe TP_PAD which
>> is really just a pad on real board. And the rest of "" gpio names are
>> connected to PL.
> 
> How to handle anything routed to/from programmable logic is
> in a bit of mess right now, I understand this work isn't the
> easiest :/

I am happy to discuss this to find out a way how this can be handled.
There are several things together.

On arm64 how to disable/enable access for NS software.

Maybe also separate pins PS pins from PL pins. Right now all are
together and not sure if this is ideal in sense of DT overal for
example. Separate nodes would enable better flexibility. Also if you
look at partial reconfiguration you can just route just part of pins
which suggest list of gpios used there.

Thanks,
Michal
