Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4+tH+8qQmaKJn58oHcmdZyxAK2ttbWJkj1yRw3z7xS6cBSgQwKdvXFVFvcWZ/kNynoaHnb/
ARC-Seal: i=1; a=rsa-sha256; t=1522778959; cv=none;
        d=google.com; s=arc-20160816;
        b=g659Iu6SX/fiuZabVemu8F91xGuT/NS0DMo2XquWAxTnRDVBPUCT6jON8aLPpaQS0O
         JhQ7mt2qGJn1FmEyvrR7Giecz/LCKSo6q/ocq4uDiSHuNv79tZP2gbTTLvorq7XjpG2Y
         IArlfx/ULj/xniggmjPNTEE9N8wPFbwuiBjmkDxyf4C/ZT33mPYCBCWnOOaSAbSIzDhG
         kOx7AInnF4gmxMqhqwExcRerNyIrO7i7MdVOqvXidtSUkZN7VY2nbS1Bi4nwjFW5N5/R
         v0BONQwVyzo9BziSJPLNa8CH3h3nqrYfGJln7xNqaCwfc0A6XpVhMIvEpiVSbM9hPJmJ
         oIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=4X3RlFRgO9smCX3w0GyCeZjmbHIljZybzvI8ooHs7nk=;
        b=zgr2BE8tsXGf498P4bcJpXNBbkmAy/z0nHbILeTZgudzZcrMNhCRHWcAJ5O6Dr9NeJ
         6HBDqivfuxfI2efQpnzY0ZnewBYv8f40mO127mQ6z+lqZqOOhVgkw6IzAaZLlv6AGq7/
         oTdjXAc00ZoDuCEL1QNSxQNSOB33xDknELlYST4wosd/2xQoHP8We05aC7nBxLuNeqK2
         GgSqgin7VER/7h/QI6uvELBkI+LeS6A7BNsPytMcssS/zPAh1W36n1dFUXjTgwvaPXeD
         JrZk7RVMzFgSJZGJZo8hNN7DmwnS3pvoKgTWR9ABwtv4iDcLLRwkLYInEzVLiNzJ2XT7
         wg4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=uNM49bWj;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.122 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=uNM49bWj;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.122 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 0/2] iio: add unit converter
To: "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180403153635.8228-1-peda@axentia.se>
 <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
Date: Tue, 3 Apr 2018 20:09:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::46) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cff8df9-47e0-4320-0248-08d5998e01d2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:hPmAcHn2bqe2/Caor8u+pycMFzoqyfdCluNhBBEcy+o9wtVGIVOoK+A1cWOAc5lTn933jxT+2QCfakK7BliTrPuvU5RmJ8yMvoVB8zrAzLGFpg9n9z8S7OtdWa+NnQcD68UZycnHLSchRGmqainOtuFiS9x/CUykCci7lAMxe64eUP0qNVvZrEdsovrHeS2QspEP3Z+Ty9Mp2hQhSTxGTigv+8CNlEPfzwD4SNrgMbBtNQ+AFewUsaCFrViA6835;25:HwlR3twMwVBLOyOT7fahQ3jtxGF9h9IW3VfuMnbZX3MgB263LVICu64d1C0l9qkxo0U9gZfQ1KLR7jSS47BAqg6MsvPa2yr2g1QENtxvnYkz/3oVLe9VhG2RRd4CYewtuRRO0BADGKgXKiU6xFW0RrMtuO+JjcLBwP7NAWntTswc7k4Bd0fCAia0X4eIv59HG2YRSvMboatAbkTLiv9IX6segsb5tQ1n5D+ALXiP3G8Uym8XwwgAW14hGJAxJoDl86AokpLOaKnqkKkGEfdYZpNlM63B4PTLUEAPr6vytDJVsh+qnZBkNCsVMBfllii2/WQ14g6o732tFJzWGE2Qcw==;31:LYB67fM7fGwCN7eqtJ5K8ZiAv0qCAhT28LhP0xhe0GKtETbl5RG1eDORvaT5lVvfFhGXm0PXttkhrzccvVyVHMftFBw2xPEIfn0VuxSOvPBbR0uQ9B9QmEfT6hQ9rj3Y6QU5jyg9F+MmAiioBAxGDBa5IQnWOpgAw7fzqmemd+uRUBAOZ627AxHy3OV7hceIqn6Rt60U3/S5OMAjVjO828fVr3zXMdP/RHGhAInmniE=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27751F00D6FE366823FFB7F2BCA50@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:gRAeiSAPIDw8Wkfa4afaTS0AG7InwCeJG0B9sgQ1zJ0rTYbMBxQo+5+EKoOuNFt1jr2iPG3O3PloMTdAHYLFDloGGOeuIYG22XcTur5FjXu2w7aLpybei0vDljQSz0kS5R0eFTVvoWbAz/XmhEzOu93ZpdJ3m+XdyX82sAgPYX+0TqZmN9FTRjP6bakJlRJ4tfXAC8Oolkwwhh0y+ndyZGLnZpf1GkOctWMou2VW+re6E0EAdyqeDClniTCsDxkO1ZmNVIyYw4d5WvLgv1KdwQ==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(376002)(346002)(396003)(39830400003)(199004)(377424004)(189003)(86362001)(6486002)(105586002)(6116002)(64126003)(3846002)(106356001)(478600001)(74482002)(446003)(77096007)(2906002)(229853002)(3260700006)(186003)(26005)(58126008)(8936002)(68736007)(31696002)(4326008)(16526019)(25786009)(117156002)(97736004)(11346002)(2486003)(486005)(7416002)(36756003)(76176011)(386003)(36916002)(52116002)(486005)(476003)(305945005)(6246003)(2616005)(65956001)(50466002)(53546011)(52146003)(81156014)(47776003)(23676004)(16576012)(66066001)(7736002)(31686004)(53936002)(5660300001)(6666003)(8676002)(8666007)(65806001)(54906003)(956004)(65826007)(230700001)(81166006)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6bUtCdDNyd0Q1bnJ2NlNPYUNwMDZxV3dh?=
 =?utf-8?B?MEVYU1NWZlh4RXdEVUdFdkZMdWt3cDN3T0dTckliVG5IWWVKQ3hFT3JyYUdj?=
 =?utf-8?B?MGpCTkQxcXl4dW1pNW9MaWptOE95dFlsYmpNSVJBSFhqcWZRTWtGOElpcDNF?=
 =?utf-8?B?aWU3SGZndmdheCtkblA3Y2tzZmw1bjlBMGIwdkJVTTB3ZFFiQUVwZEIxZWd1?=
 =?utf-8?B?NHRjTVRiL1BxYVZ6RXpPVFo2NElTemJydGVkSkF4V2tQRytLc3dUYVdaQVNj?=
 =?utf-8?B?OU1PekNYa05tc3BTREpYdWtVVWlWQmxSN1V3Y1JIVFYxY2ptMmVpbU15WW52?=
 =?utf-8?B?UmVoaHRrOFN6WEtBemlMZDhQNGRrNVpCejEwcEJyY3RsR2c1MTdwYTJxSm03?=
 =?utf-8?B?a3AzMk9DQ1JCYzIzeWdqS2txTjhoS2liM2hwcElHOTlUMVZJQVJQZ2haYm1U?=
 =?utf-8?B?S0IybXM2RHVTSkZpY0MyWnFYQ2M4VkU1dXJUNzkzRE1YSldiMHRvVXluYzFj?=
 =?utf-8?B?SFh6M0ZxT1lXRFJUemFQSWtXRUpuQXhtMFNnWXcwaVlENGxwUEg4Vk9VZ3pR?=
 =?utf-8?B?Q1FmV2NYaTJhd2wybEZNdHhwUXZicjRPMU9JN2pCYXJhejVWd01HSHY1SDRB?=
 =?utf-8?B?Rno1NXZVR1FrU3ZFdnBLMkdLZ25xNXkvblNHMG92eXlwSGpUNU5WaEE4MSsz?=
 =?utf-8?B?VUxFZFB5ck50YSs0MVZEUDhtZ1c2QnI0Tzl2dWFIRGtIL1FtaXUxdGtBRVlr?=
 =?utf-8?B?cTZNUGhXNFU2YjVMT3FWVGk3SmZHUTlTczhQM1hNRVQ1UWZtaHYzSVNKMmd0?=
 =?utf-8?B?aHZQTm1sNEs1d1UzV1pLcjd6cTcraWVTN3dOcWVqTloxRUplV1hreTArc2Fy?=
 =?utf-8?B?RjlUb1RWR1RXR00rNm9vaDg4ckRlNUthM3diY1M2NThtZlFhNTczZ3hDWU9M?=
 =?utf-8?B?d1d6aXRSaTNzdWxYUTVCNGlpcGNibVJCTG1PYXBwTWRWN253bzI4aXpBU2Yz?=
 =?utf-8?B?SUF6eW1vVDJlamRZa1M4eWxtN2pQcGdZVTRVSGYxMnlodUxTTnh5K255Ymcz?=
 =?utf-8?B?bmQ4U3poODhtanpsT1dGMXpOKzhSck9ydWppL1c1VGVhY1lNdnRFdXl5dVFx?=
 =?utf-8?B?dkZsZWQ2Rm5XdW5XYnI2Z2UreGEzRjZmdXJGNmZXYVpLYTJEM0FqNzhtamMy?=
 =?utf-8?B?SGZBSGIyaEs3NUgwaGJ6Zi93czBDVFJxR05uZ1ZOaG43REtkTHVMdEtXVG5m?=
 =?utf-8?B?ZXhJK3BLWFFWMzQ3TUhLeXNBZS9TczNBSU12citHcVFsaER0UkJ3YkhYTW1U?=
 =?utf-8?B?elc2RXZ5MW1zVnhDQkttOHJhMXNnWG5oZWtTYWVsQlBqOTFVNlhmSlArRHVZ?=
 =?utf-8?B?TzIzQ0U4OVBlekNmOWpZajF4U0dUSzNxZU42a0V4NmZkcHBXaDhWUFhTS280?=
 =?utf-8?B?Y2VDN3c1eUhQa2N3cEVIMVF1MFZHZzl3aWNIL3h1ZDBmdTFmeVdNMURSQURT?=
 =?utf-8?B?UW1tdUVSOUhKVm1TcituZHNCUjhienl2UHdMTFZMWncyWmgrUFF6Z2lYNW1t?=
 =?utf-8?B?VjJoSXpFUDNJUVBuM3NLUWt0ZWRDZGduYnN5MTRuZHNITUR0WmgxRHNmdUdW?=
 =?utf-8?B?WFBoUGlWdWVpZ3pIOUZ2Tko5eTlvekVOdjQwTTQvakd6bGF0bGtIZ1kvcVJF?=
 =?utf-8?B?NzVxNmJOT3lLSjNJWEozZ1dpbzBGUE9FejdzY2RkWnIwRmd5dksxSVYwOExr?=
 =?utf-8?B?NHpoeWpmWFNqMmhhblE1dUM0RERCNzhqRGlmQjJqVWNyQVZPL3E1bWhUWW5Y?=
 =?utf-8?B?VmRNU3VybGlDSUg5d0RIOUQ5V0ZSODl0Z01OM1FKZFF5L3g0N2tvdHh2dEFt?=
 =?utf-8?B?NG1CM0JlajZ4ZTMva1NKcXZvS2RhbVd2NjBmcDJuMExIcVBrcWpxTjBuc1ZS?=
 =?utf-8?B?elFoaWNUWThKSGd1d1hldlBqWW9tNWlQakoyTHQ0UDhVcnBHbE01R3dmNExD?=
 =?utf-8?B?TVFHMElZclVYbkFPMzRLVGhIR2kyRnVtbGRTdXRJNjN3ZDM2TVhPTmFGaHBj?=
 =?utf-8?B?S3lRQUd0MFI5SVlYblR6ZHZ1ZVpGZWI0V1VsMnl2eWRKL1ovM0hhR2VHSDJW?=
 =?utf-8?Q?B1GEvYsIJbL+D2jorAJ5Q1AanGCc8g+xou5Se9hhHb+59r?=
X-Microsoft-Antispam-Message-Info: bVPrniAYjFM8vQ5TpKauEKELgvSSBnF5cn2YIoXIDz43HG243P5l0pUEtAvaF/LooxCCY0hG+6hUHfYaloMg8JVOZPFGouM90W0v8vGh9xx05/Njg0x0ze50ZTBohSRVtsYli2MygGpZ90coxfX2Hsa90Y8jD6z6X04s13OflGs8UW3Hk+fHwrhhLiWOoZLD
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:h4RXnG12Dk8cnVFCcYLIy8WMf/TOoC+18gDicWe/O92u8RWNw9JpImjl2WmhkPa9N3gwut0XaBsKV3Kk5/ZIUdxW8ldMvOyVhsuYykgsUDL7UXFz/6z3DztZ1ou7Myc+Jo9+uCQ+TAv+7XhMlHglJKtmTM2aSHpzjy0dNw/hp9XOtEMt3YOQWsQ0gQkyPMihSC+xuosuPo6fUcy7u2ZwulObkxW7QF4uJOfXrE8E+mcDs5cLk4hgh0fK/1RLaHMk2snY5ZJMhDezZ+/hGD93nC+wSEdR16MNpF7T85x8TmoBCSl0z+7v2pnWPxyWt51r487Pi28hgVy7fj+jZlhJ7LBd0wwdtnrEdsZ+7p69QCkx6oOYW4KzHIX8uMaoQ/kWSxq0ksAy/vAeadzQdSCRZqhlRijjo6W8rBv3bSGrkF12RTfTY1RHuFT4Na01C8MBXhFqsH7O0d7/nnAXOxFD3Q==;5:2t/mMSD/23dtNykXt5LOS3hHxu+P1BzBdh5TCgwo0DQa0YSaO/WuxIEsSWIK/r+Pt2jSs89qEv2mJcn6RvsdSrSNCdbenY5FgK96x1DIDQNEIuAbiJIYhQx79m+E4ZZzIuooW69hRHJZlnbxWcfHSyekm2CNuDQpOypyRKv8lKI=;24:Ym8ptNZR+PReS9MHqlv0Owzq5avSOk31AmPNdhZMm7Ch0sZmfjItgNaezv1RpJ8y/Cakk06K/2yux4NUnonzPu1+Kp35vqW6OgybqaCbaDE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:cUqwTiN9SucnyHR0OOWORMgcHTxmXC2D0JSkZOQpox5m88jVZG3Hl/cHR8AnunVsQhxVRxnKzoaFkE4FPcPvzq9J7e+vg9n93n15zpHaM+NfpIVrUxru0QunJC6RIruBZvtdtaAfLVSrSFfC5OaW9lbvgKfC1/kaV87Goc1uMFUiN2yiHOApzXY4M16zAKBqp05W7xMOFqH8IBIhs4FNVje3EEUmyL4/fLlWvuNa0Qi+3D72u3S+11PkHaCQ4ZeY
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 18:09:12.3364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cff8df9-47e0-4320-0248-08d5998e01d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739875121160497?=
X-GMAIL-MSGID: =?utf-8?q?1596749469954541792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-03 19:41, Andrew F. Davis wrote:
> On 04/03/2018 10:36 AM, Peter Rosin wrote:
>> Hi!
>>
>> This driver implements support for voltage dividers and current
>> sense circuits. It's pretty generic and should be easily adaptable
>> to other linear scaling purposes...
>>
> 
> I really like this idea, defining channel scaling / channel type
> conversion in DT will be very useful. So much so that I would recommend
> this not be a use specific driver but instead moved into the IIO core.
> 
> This would allow defining these channel conversions in the device node
> itself, so as to not need a separate node just for the converter (the
> conversion is not a device and probably should not have it's own node
> anyway). It would also help with enabling this support for buffered
> readers/writers and not just devices only supporting _raw reads/writes.

In my case, the voltage dividers and the current sense circuit are very
much real, and I can point my finger at them on the board. Sure, they
are not ICs, but to not call them devices is wrong IMHO, and the ADC
which is involved have very little to do with the voltage dividers and
the fact that it is involved in sensing current. This is not an argument
for not moving the functionally to the core though, but that has some
problems AFAICT. Because you need some kind of clever and generic
binding to make the core do its thing, and it might not be easy to come
up with something that fits all devices? And if we do put this in the
core, that opens the door for more complex unit converters later on
(non-linear etc), further complicating the generic bindings.

That said, I'm obviously biased since I want this to get in sooner
rather than later...

Cheers,
Peter
