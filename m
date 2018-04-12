Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx49MhMQRKdExpYnaE/aWbWSAVfjvPflx9RDWSG2VY/d6eFkh+nMQqw7DxCuOfRyyToqseIuf
ARC-Seal: i=1; a=rsa-sha256; t=1523572276; cv=none;
        d=google.com; s=arc-20160816;
        b=Zo7ugoLssDB39KxHclI6slE6N/aO5eNOq0G9kPZWNW2ZpHteCSyg0DtwbVqWt7080Y
         BGUKSY1E6KGSoJ183IPVqigQDar6s/gAxWYiiKNtDHwsgNPqbIslHsBjUu/4a3uC/XvA
         pBFX7JImOHfvtE47M9FldOnRk5PYNn05FWP9vwrkoYyL/LOAZa8RpZfxcqBj9bGw06D8
         LxivItTyboqbl2987tXib/WY4c2YFSe8/2Td+91q+5IFKVtDkXIKzfsTQvqw9qVGUoX/
         W9BlIK1BUouAMVZTX/+FOkQkZpwQoZ7PPNeH5rIugQ1IVaxYlEdyaOyZlb+p1Q8jLT1q
         KMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=WbS5EKmJaf3gzxNCFRP87Jp8VI96tcoI6iwp4+Ve5ek=;
        b=DXPBvByH3JNbCquwRAyo0fBZzP9My8aSvFwa0T7/Zhczy+WkiE4EPH70y382t84KF4
         HrnfKOMfHcBuXuGFX3CbR/cVZpo3wfJKWxtvbEmMHBG1QVMtieAIXxVPcrOUv3y6FX80
         Sb2aCv0D063FWpK25+q252/onZhl1nlSJRYK7r0WgXYmRCHUlM7mlHVVMXoLuEAZ6YrZ
         UvOGgzf2esq4T5/hip8vhUtgvDgjWTASYUL4B8o6M7W0CiG8x5RFd0Ax+Jjwq2gd3YpN
         diD6BSiZHiaSQGJsDY5Ef3NOdQWwouxsbJV30FLzq433jQ0pQ08PlOd0QbuSo0HgY0YP
         SgQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=W4Ehldti;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.1.99 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=W4Ehldti;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.1.99 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
 <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
 <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
 <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
 <c2923ac0-5e28-eef0-e32a-1e25ce550a82@ti.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <36e0c96b-89ec-2372-825a-71ead1a43473@axentia.se>
Date: Fri, 13 Apr 2018 00:31:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c2923ac0-5e28-eef0-e32a-1e25ce550a82@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::28) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:lhpzXxIuRS/hM+ysqKVenTDRMMEFKvsBvh2Kt6oCunGilSpFrCqpXXcCLoQAdtWtMkyZLWAKnpi1GrKRydintaEyVroEyxYQg2DjMG12Zi6yuLmyjMl3mxE86ImCoXizR8ZAO0SDG73TyNdAlTGwkFQQyXxeEW0gDq+JWP29F9V4c0LmTjNgABnnvm6F7pi64BhbuO5wdhT7DeSGtCo5MWTKLONOIzR9dui7qimgYsEEO2Z26+TXywlsvVVKS9C+;25:voIJ3NQ+xVuKVFohFpyZkHJvU+wJ4cDqjq8g2JNn3rAZEh5ZBJtuNG21P4rjHHqvMyMbrGGeH0Nfqj9p/aZZXWXZrMU+J7qDg3374Oc6SRUs0G6OnQO0Rc6xILVKQPwHMIizA3+hYwC4kauEo7v/41U3LThKucxgnrFGo7nRMYSQHqJxuvbeupJWpv4SAnz/CYHZ9ahDBSkoodxrwoqMPxMGTegk6u+XEZxCUrw346G+2MJ2pe8FPKwQ3qfJwLVIIeb8XVyepBCE/sqXjOsIlBAXmIyX9LZQ32U2QQQwIwwSy1aZcpl4wYwNMSERWOvGWRQg+FFAX1HA0HJA0glgdQ==;31:7LTVxbQpOA30myG0Xh1i5i/TFTowVtQ7CbYUIl+7DwiKmV9mtp8GpxdQTxfHZCDNfCofBLHiEO2Jby/RVk1tkOu8XqP94ClipF6dfGEngIlY6RaeiJWdWczQgCVjnatUs4HrsofCfb7YVZ9zumDv9XNfTg8F1OzWWsQ7QGUt1LH692l7/dLG8p31fY3BiBAqta4mQboZZGLDsyDsHTzrYyOTRCO0Pzu9AM1Are4Z7rI=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784D984003537529DDF37E9BCBC0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:YCU2ImaXVNeysIsl+DeNiVG2nBFUh2Hm03OMAV21P0dXTvlxnSlQOe23S9nMSe2ns5pXXenqbodFj3CKSNolwEOMYLbp5BD/8RhvFXcXFH1XKKNAk9aX+93EGZsuaGMJyPaUWXJnC94StTqdXeaNUlhzgtTKDSA4QCN5Llj/Cac4l+1Fp2/bADJBXfllMMmt9QVQa3sSc1BrEU+hy+JxHvuEMTdet17ig1xKCfuO/JWDTFxTHkHk12EMW3nQf++agtU25JukrbxFnYb7eztusQ==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(346002)(366004)(39380400002)(396003)(376002)(199004)(189003)(85664002)(377424004)(186003)(16526019)(52146003)(2486003)(53936002)(8666007)(36916002)(23676004)(31686004)(77096007)(65826007)(39060400002)(68736007)(26005)(50466002)(76176011)(2906002)(5660300001)(52116002)(74482002)(6486002)(65806001)(65956001)(478600001)(66066001)(229853002)(47776003)(64126003)(36756003)(105586002)(6246003)(106356001)(31696002)(16576012)(86362001)(117156002)(316002)(11346002)(476003)(7736002)(956004)(59450400001)(53546011)(81156014)(305945005)(93886005)(3260700006)(110136005)(58126008)(2616005)(25786009)(6666003)(486006)(386003)(54906003)(8936002)(97736004)(7416002)(4326008)(3846002)(446003)(6116002)(81166006)(8676002)(230700001)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6SjdsekxRZit5NzRjaGNXMlo0UFVPWVZX?=
 =?utf-8?B?KzlvWWUxT3phVm9WVjM5RFpWamlnVkZQajhPa05zTzRNNWswcHQ3NDgxdnVu?=
 =?utf-8?B?WVhnMldzdlVSUFVSOXR0ZWVWZTc2c2dsNDdtdUoyb3dITjNvWTZhWVlnVnlW?=
 =?utf-8?B?TXBFLzlBOFVqYWd1bTExeWljc3ZlaVB5ZGUrTkUwWWptaEp0UHFDT1hJenh1?=
 =?utf-8?B?NnBXWTlmNzRlL2haU0xDSlg4eUh6RjFOdGJMbW1WbzFKa0JBelpFQzg3UTVR?=
 =?utf-8?B?S2kzS1JaM3c0Q1gxeFRKck1BTDg3UTF5NGYwNTZGVFFYaHQvdUFSV04yVk56?=
 =?utf-8?B?WnZNTjNVaXhQNXEvb0hVTVJORytzbUdIbmlOelBIcVU0UmdGazQ4VVZSeHBU?=
 =?utf-8?B?eDdRcWptQytnZWhGNHI1S2M4WEFBTHRLMjhHbVp5WWlpaEp6VDZmTjMxZlp2?=
 =?utf-8?B?V0NiUHZMcWFqOEE4alJjczhxY2Rya09HV09iS2FUbUNPWnJJSVIyTHQ2YUQy?=
 =?utf-8?B?U0dQcEFFZjhjdzQzUno3dmErT2JRaW9wc1FMRGM2WXNQL2JXK2NFQitVekJo?=
 =?utf-8?B?Q0dJL0NiZi9BYnNSTHUvS2k3TXEzMjMwUFhTSlVGMjl4a1RVUUkxekhRUnhL?=
 =?utf-8?B?YW9HUmc4QW1mUUk0eEw2SGdDUXloWktva0RRVCtrbjVocTEvY1MyaW5hTUxa?=
 =?utf-8?B?TzFockkwakxzYXdQcXRlUTlhMlhvNm8vWi9nUTM4VERickNiZjdRcSt6bTFz?=
 =?utf-8?B?MlZLME85QkJVejdrRTBsV0hhM3ZRY2ZzdWxqMkQzVmNYNVhINEIxM2hQOURF?=
 =?utf-8?B?Y2tkQ3VEcUVoQVBVYy9LaU91YkYrYXNUOXlVYlIwKzBFaExhZkRpTGRuMlll?=
 =?utf-8?B?cXZoa0Z3RU1XckRXUDZQc2ZJNVhwQWZRQi9GWXhmTUZvbzBqM0JhTmltella?=
 =?utf-8?B?ZTh3WUg3WDZVb0ZHZ3huUElqd2dvUkdQZytyZmZHRS9qQU5sVTZ4a1g1ZHVt?=
 =?utf-8?B?N012bWsyWDNsKy9hTHdTMGcraVNjemZEeVEzQXJiK3hqSG5xMkt3UUdQUDNt?=
 =?utf-8?B?SitJRS9RdzIxa0tPU1NnZVo0alQvUGt3RTFKT0wwYnk1SENRUGFlMzIyWHpn?=
 =?utf-8?B?UmJ3cFVab2xwdHZIVWc0aVk5SGhGUTg4dHJZb3NRaTJVMDMxT0lwN1dlMDdm?=
 =?utf-8?B?cDk5eHVrbWpPOHorMG1NbXZlY3A2WWNMcWx3WW5kbGpMOXF5b3ZMTklYcWZH?=
 =?utf-8?B?SldZMTNWWkVjSjhKYUlXVXkraWVyK1VjOVhicUN0TE1aSVN1WlpxaW5uOHU5?=
 =?utf-8?B?Tlh1dEdLRU9BOGQxdm1XTDFZLzB5Vm9KSUNPSVNDSVpjOGl4YkcyQXQ4U2NI?=
 =?utf-8?B?U1FwaWRTckpxYlNrUk1mK3RhR29ZdkszRjlveVloRUZMNTBBck1MOFBSRXdh?=
 =?utf-8?B?Q0llVHB0d29TYmpyS1htWjZwZ3FFTHlzbFQvNEwvS0lLZnl0QVcyOTRNSXlI?=
 =?utf-8?B?UzZYSHR6ajc3WDA1eko4NktkTS9ib3JMZStkREFlTDlZRmY4VnhnQVVxbzJl?=
 =?utf-8?B?aG9RYXV3RG5rbXZVTC9FK2p3L2ZKS05xZWpIMnRsdXBuOTRGaUpsaFpRY0ZI?=
 =?utf-8?B?U2pSMWNzUThJdmxsWjVhdUhDZEVLZUNaR205MUQ2WFJOcEsrTXpvS3FFUEVq?=
 =?utf-8?B?R3NRM1pxenQzY1RYYUl4bVVOVERjY2MrTUxFZWUxSThDSnlwOGpBKzdZQzU3?=
 =?utf-8?B?SmtjWk9GSVBjcytTVGZpOUlKd0NZRmRiQTlJR0FiNE1Gc1ZzUGgwbkhUdE5U?=
 =?utf-8?B?cG9LMkRqdWpyVFVJV3pnT3BsKzBOR0NNMVI1RjRLeG9iS0V4L3lPcGQ0Qmxt?=
 =?utf-8?B?aHloL3g5N1dwWHQxQjk1UkhkekY1NFhXTDIySGhNTTRDSVo3bU9PN2V6TlBi?=
 =?utf-8?B?NSsxN1lpZW5DMnBtUjV2cEU1bnZWVGs5RWorcXVZTHZrYmhQb1NNWjhINDRM?=
 =?utf-8?B?RURYbTVHZnBNVTROcFpaUzFFY09US0RZTVR2WGtUSUljeGFINUR5TTJwdG1i?=
 =?utf-8?B?a2gzakNnTzYvcFhxdld5OWhnR1VRV0FVcFQ0ekVhWVo2eFppblZ6VSt5Rkg4?=
 =?utf-8?B?U2V0QjF2ZGpMYktxbUFZWFRIaDlHNitibmdpWUh1RkR0NkQ2MTRLdkM2aUE0?=
 =?utf-8?B?OUlXSnlOWnNyN2F2UnBRM01hSTlKTWRFZjl6SURBTi9Pb21TbVpWS2hkbDQ5?=
 =?utf-8?B?dm1IeFdOOW1ic2ZmUE00UnBHSndRYTliU0ZBMFd2RnZZRk1XWFNuNWhxVkw1?=
 =?utf-8?Q?fQ04XyqSHbWxTkJF5B7sbzsH3ZeC2VU3CJkmp21?=
X-Microsoft-Antispam-Message-Info: Nulvcaz7GRXwb5hj7lVTeKALun9lmLrjxH6Pwy4ed83WIAvFZuociDXWuhROCIeUkuvLBsa3TwxIwyYX5KfFpXne4Sg88tDRXXHwmYqjdojjmeQSRJFFfLJ6BKaTAPaDvSTqoJxHzOTbLYzh5Dgf16BdSnfc9SLQEVxTyJr/0pF9ltL0EED/yOgUHPybuFIl
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:3hgBBwXh134BcaufK74AXv7Aig31bFxOE2LybFFwanMBzlC/kI5vAM6kndAAheLrNk0gZYo2BsAxZkA5PtSG3wsJy8on/SjJPovU3lKFP6iqp9Njj6eC3Y1r7A/Uqyi52GCj/R4jtYcuQSOR6LWKRKAtbh+HpMLTb6dBDbOBe16mIy6vT35eeog3DxNGShyImAoHBCvBuK9QW62gdX3uYFosKXDLG7+TqVUK4pO9G/U8l/s60zSYloKE7L5q+VZHT8Hc5lpExCNcRaYY477FZeHpUiEd0+7bSUvFjxZ+ukGWFlTEQ5u3nPhyUeUo2r04jtKcM4YxVFbYjlySHJBCBrf19nY0zrR6lIQDab/cnXHIOk3zTRzFNmk7aAwbP/2NlfJqQJjH6WzO70U4fvefKvid2+mAOVAoq5nUbieuN5XHAL6Q+5lNswseDgpEfkhtlwLglwX/Y8zoFUbBNrhlFg==;5:6vRG8i3ycsYkBwu3nirjYqwwgXEPKt8AgUah3KQfuOWJuW8OzmXOOcDTdKhsk/wt1XtzONetYBj0MfH2emGNFCxiWlfTr2icoB1sR92DWi4IjjqflVxCh8vnKrCnIh/3cvlAyw49ydMlDbr5mPQ0I8m1La7iDx296tMo1C8cGzw=;24:SQTvmPUyom5UaUbC7PFlSUbPWyjvt6B6F77j30M/PtIg5fWwC8GnU1J+GYLpmH/y53RyRIbfgehkQJ2xtMI7eEPo+p5sKvk7CvGU5BmEeWM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:c+yeicRxVKq8w4JEo+G6gXX6dLo6S7X2o0vBuQ+kr6uXNBzOGS7jH23KKwuyKWZ/+zRHM82sV04d/b4LD0CC5Ch1DYfjw20eGf2Ur5WYLD2qspq058xIvCLi6vUnXW5Z9o0TGz3ZaD1zaT8epptaJcckc4Mgdcezzohv9lObKudqK6CfEUwO9Ljg5kKjBHGH/goQThZhsFPV6/8P3wAuGVchS1jCxYUE/1r58iSAWJojXsq6I4lokaEcWWNCMTz9
X-MS-Office365-Filtering-Correlation-Id: b25803e6-87b2-4abe-cbb4-08d5a0c516d5
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 22:31:08.5529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25803e6-87b2-4abe-cbb4-08d5a0c516d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597581323150011823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-12 17:35, Andrew F. Davis wrote:
> On 04/12/2018 09:29 AM, Peter Rosin wrote:
>> On 2018-04-11 18:13, Andrew F. Davis wrote:
>>> On 04/11/2018 10:51 AM, Lars-Peter Clausen wrote:
>>>> On 04/11/2018 05:43 PM, Andrew F. Davis wrote:
>>>>> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>>>>>> This is a current sense amplifier from Analog Devices.
>>>>>>
>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>> ---
>>>>>>  drivers/iio/afe/Kconfig              |  3 +-
>>>>>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>>>>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>>>>>> index 642ce4eb12a6..0e10fe8f459a 100644
>>>>>> --- a/drivers/iio/afe/Kconfig
>>>>>> +++ b/drivers/iio/afe/Kconfig
>>>>>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>>>>>  	depends on OF || COMPILE_TEST
>>>>>>  	help
>>>>>>  	  Say yes here to build support for the IIO unit converter
>>>>>> -	  that handles voltage dividers and current sense shunts.
>>>>>> +	  that handles voltage dividers, current sense shunts and
>>>>>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
>>>>>
>>>>> Could work better to split these out into separate drivers. Maybe a
>>>>> iio-shunt-resistor.c that does just voltage->current with the
>>>>> appropriate scaling. Then make a a separate lt6106.c.
>>>>
>>>> I don't think we need a separate driver here. There are tons of circuits
>>>> that all work the same way and all require the same properties. If we'd add
>>>> a driver for each of them we'd get buried in boilerplate code.
>>>>
>>>
>>> Fair enough, then it should at least be renamed to something generic
>>> like current-sense-amplifier, as you said lots of circuits do this, not
>>> just lt6106s. We will have then have support for:
>>>
>>> current-sense-amplifier
>>> current-sense-shunt
>>> voltage-divider
>>
>> For the compatible "current-sense-amplifier", I would advocate the
>> properties...
>>
>>  sense-resistor-micro-ohms
>>  sense-gain
>>
>> (or something close to that)
>>
>> ...and not input-resistor-ohms and output-resistor-ohms which are way
>> more particular to the LT6106.
>>
>> But as I said in the cover letter, I didn't go with sense-gain since I
>> thought I would end up with requests for non-integer gains. There is
>> yet to be a comment on the non-integer gain problem, and before there
>> is a path forward for that case, I'm reluctant.
>>
> 
> Why not similar to what you had before with the resistor:
> 
> sense-gain-multiplier
> sense-gain-divider
> 
> if either are missing assume they are 1.

Hmm, how about sense-gain for the normal integer case, and then divide
by sense-attenuation if needed? I.e. exactly the same functionality as
you describe, just different names.

>>> compatibles in this driver called "unit-converter" which is still a
>>> misnomer IMHO.
>>
>> I don't remember you having presented your preference, and I think
>> that goes against the established bike-shedding protocol?
>>
> 
> True, how about "current-sense-from-voltage" ?

Doesn't cover "voltage-divider" (and we don't need separate drivers
doing the exact same calculations, that's a maintenance nightmare).

Cheers,
Peter
