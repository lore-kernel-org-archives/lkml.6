Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeC3Vnh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:43:37 -0400
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:40480
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752486AbeC3Vnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:43:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
From: Peter Rosin <peda@axentia.se>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Josh Wu <rainyfeeling@outlook.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <68b5f229-638f-e589-36e0-921eb9101848@axentia.se>
Date: Fri, 30 Mar 2018 23:43:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0601CA0029.eurprd06.prod.outlook.com
 (2603:10a6:4:17::15) To VI1PR0202MB2781.eurprd02.prod.outlook.com
 (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 612e809e-e259-410a-5fa3-08d59687486c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:YWXTTuSqROlBNnUDs/TqscqRwK0iAQZRL2/kYrER3kwvUSOaFCOpQyNH6940yN5ukNxjsp6YBeFipY+JN+aSZRROy9kLvKNrQ/HbnNoniKRIX1YBC1lmoWRkZe4QkVW0uCLqbWtv50GbT8mkqsG1XYjyP4s8LKsulyY5zo5LfW6qakvXLpCHCIl7cBduMCknHAMMsrOpCoXHURZXksNkvtxWCu91Jy0U+iL2PWwYN3fLliMK+ljYQ/k2MHrFvQIl;25:jvHR/M5h+RZgSAZyl0D+ol47ZHTQxJUrJBrwJdhkWVvGJCa4IGIOPZWjr+SdAIbKeSutWMMnwgA2GIEE9oG/fONBNT/4zbDB+/dIsgt5cKql6LuiY3xI3Ve1AWbyLCNUP1OSYU4EeABfvzQka5ZJkf6KCjOgpzH3vzlgWC70I1Pqovd0PuJPLultwMRP6nIFbGX6ENuPlybP228jDFW8rh9bPfZP70Vzf0x4021PypNFXojVuG541qoiRCXi8bTkTJ4OY5LlW6RkiUjKwXrPM/N2GKSH7LGJjc7Qm19HLAiPqzY77huwzDxBg3ap/dgQBWXzulsSMLcWrxKwPZ91Iw==;31:1XV8OCZZjAFL6Q9ka1jOECtEjD8EdU3kCl0FJvIhwh8CB0zHZGDEGYvdtXFsTVOovsRL6hkgYl2YX5a1W/393Ctm3Q7gXSDgi8c+4tGZCxgGvkAXuLCJzdLMBp3x2mDc5X5jLDGfHMc//QZLzp/f2idKfhzbBp4e2DPrBZwBPaf2UbdLOF51NxliM90WLYPz2Jzgn/0F0rTrrEonrsPLiHvGLUlyxg1b4mJOryBiDIg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27819911AF83682B2289A61EBCA10@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:Ftrsxf0Aov4D3JSUhbvg+RKm+zS7uGl5rbEzGo9c6YmH01Rmcq5tWHSsFCc2aTWnqWABDqGTXEnTZ+2GYAxICjDMVyyBoNRcE4AAtDpInP0z1RAYIfcEvXlu5Zjtld/mx3vqJaJHFIGasv4cm6/05+NNNVlidcQ7iSKZigSxzPKucYhqcggYpnikhhReDqcz0lVGIq3lJ2QM3wS0kI9GsWGi8XfHrYlUQf/76dnMbfsNisEANTadik0WH/t75XF7RVyW33syGWsMGumnufv7Aw==
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(376002)(39380400002)(366004)(346002)(189003)(199004)(377424004)(6246003)(8936002)(53936002)(86362001)(305945005)(966005)(7736002)(58126008)(6306002)(68736007)(229853002)(117156002)(8676002)(105586002)(106356001)(956004)(11346002)(93886005)(31696002)(486005)(39060400002)(81156014)(2616005)(476003)(486005)(4326008)(25786009)(446003)(81166006)(74482002)(3260700006)(6666003)(6486002)(6916009)(47776003)(59450400001)(36756003)(65956001)(65806001)(66066001)(3846002)(6116002)(2906002)(52116002)(76176011)(2486003)(36916002)(50466002)(23676004)(52146003)(230700001)(64126003)(186003)(65826007)(316002)(54906003)(478600001)(16576012)(31686004)(16526019)(97736004)(7416002)(5660300001)(77096007)(26005)(386003)(53546011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODE7MjM6VmhDVHhYajhxNUtHOXR1SXlKaTR4Y1ox?=
 =?utf-8?B?NmJvVFVVNVc2Q1hWd2llWVFPNEc0TktzaXg0Qmh0bTUyQmRPUlYrZlFHVzU3?=
 =?utf-8?B?S0pkRVc1djdXeHlSTkRmSlRnNHp5R2JBUlVROXZ3bS8wclN2MFl3b3NtZWhH?=
 =?utf-8?B?WEIwanFXS2lTU1ZhNy9lV29Rdmxlb2l2T2svQ09tQmJwc0xvMGozOVpXc2xl?=
 =?utf-8?B?V2RXRE16cUNnbDJnSmltWi9mN2NDVHU5cmh6N3QyVmlWYmhKMG9CcVVIS1cw?=
 =?utf-8?B?STFqTGpTU09vRERKbTlpUSs5R0k0cU9PK3FVdlZTQ3hRNVgveVZ0RkpkQXh5?=
 =?utf-8?B?TDRzM2pqNERrOU5JM3FZL05uR3NSUVl5NEtOUk1wdXJ2L3ZicGRBeHdpU3V3?=
 =?utf-8?B?Z3dYb1JiS3JBZEpzWDQxWm9uRURmc0h4eFZxVWlYUkdiUDV0MXFYMUIzOXY2?=
 =?utf-8?B?MmxtNHpOMThFdng0V3RLMTFnblRvQ0s4NDV2bFpPNS9odE9va0l0dE9OR2Zx?=
 =?utf-8?B?YWd1UW5qbG8yWDVvRTA1NndCRlNxWWxNWi9NZjI2M1AvODhleXA1Y25YVS83?=
 =?utf-8?B?TDFKY2xpNDZQMlR2aHpLSUFmUm1BcnlLVlpxeU15SkdweW1CMVliQlIvWm1G?=
 =?utf-8?B?N1ExbUZMdXR1VVM5Zm1tQ2lqbmdlSU1aWUZsQXg2YlJqMlJKYm15NG1iZXZN?=
 =?utf-8?B?aWFQT3FEQll3NFRVYm5ncyt6bG84UEdrcHduMjFvNFphZ3l5OE53WWZGU2R6?=
 =?utf-8?B?eGkwYWZ0QWpjZGh0KzY2MXhBRWZWNUVyNzRTWGpVQkJQRFRPNEpTVk5oY3E2?=
 =?utf-8?B?NXAxdFcyU3NBQXpob3JkMzNGdTE4RDRYRUl2U1E4anc3bDE0R2RZKzY4QUc1?=
 =?utf-8?B?U2RxU1JDOTVpTmNoTFBtdEJkb2NOL3BVc0twZkhuM1MrTTllTGFublRhUk9L?=
 =?utf-8?B?UEZQQkcxZkpvUGVBV1NzK1NsSVhtYU1uTXR0UmdoV1R5bU1NWGhsYktKZWQ0?=
 =?utf-8?B?ZjdyUnUrMDVzSzV3K0FSU2Q0V3IzQ292Sk0vLzVDSTh2L1JGNnNwbms4ZnNJ?=
 =?utf-8?B?SGpBL1FWbUJLeUNQdXNLenhQNVR1OXRTai84RUEyRG1Ec1kxOTJFem14VUc4?=
 =?utf-8?B?MTlKaWNZR1ZFdkVLd1VWWTdJQ3NUOWNqN01GY1RGNG44Yy81OVhXVEQvRk9y?=
 =?utf-8?B?UVhpWFNhUGhacklHNHI4OGJWNlBxN3Y2ajBNOTJJTWNiUVZwQy9hZnltOXl6?=
 =?utf-8?B?YURDRmllRmw5SDdLMjNGNWNVVGxuUk9yb29oelZXa0kvcHJ1T0Z3VE1KRFRB?=
 =?utf-8?B?Z0RTS2Vzb3BMam1lRjhka1lmSGxjUTFUM2o2dlFzTHBpaEZCTzN5eFNXU3Rs?=
 =?utf-8?B?TjAzNlZvVFZUWUpTRVVjc2VQYW5mT1A0NXFUbCt5dHBDT0dVUmRCZFh0dXBJ?=
 =?utf-8?B?ZzBXNmpzYWRVaUZoblMvTDNNVWIzK3o5WFNFYkNHMVlCZmtqK055aWQwcGw1?=
 =?utf-8?B?VFdnUzVzTHNXbzJHaUdJay9XbTEzVUNHMk1DVk4zRnNSc1JueFludGcrTTkv?=
 =?utf-8?B?V0FVcEtNZ3VMbWFxNXhwNFdscXZOdW9OajZXT0lFQ2dIZmZxYm1yL0s4QjV4?=
 =?utf-8?B?VUlucThJS0ZwS2UxR0xTYzk3YVFTRnU3bnUzcUVZTUEyNWIwUWVlS25zbDhL?=
 =?utf-8?B?eW43d0RpYUs0MzZhWVdmQ3JKR2JFQjUvdGtQRVl4VjRHM1RkVUtoTzNuODll?=
 =?utf-8?B?bGIxS0N2U2licVBDcDNwcVRMYWpmMWV0U3o3enlIN2ZobUhSOUI1S3FJS25j?=
 =?utf-8?B?Z2NEMWFOQnVrYVNBY2l0SzVReG9aUkJBcndEYWdBTXBiMUJQdWxQdFp0cWZZ?=
 =?utf-8?B?blNmeFpkTk5XZUVmcnEyQTRHZVdmSXFUdkJFWE83RisyTkFha21pc3NGSlJU?=
 =?utf-8?B?N2wvdndKaGk1eUlJTWtkTTB5Vm8yeXFRKzN5SHN6dDZHQXhZaGl2ZnpYOUFh?=
 =?utf-8?B?WFlaWlE5eStKdEdjdExLNDJIOG9QY2VMS1FibDR0cUtKK2poZ0dGMkI3WTFj?=
 =?utf-8?B?bE5wSDhQckVIOUV6OFMrTGNYdWhhcUhNaEJDK2ZhMXowY2hhZEpLbHFTWlda?=
 =?utf-8?B?OXNwZi9CTE95NmNveWQ1TXNyMlRiWmVyTGg5a21Oa1M0OXFDWGE5Mm9OQ05V?=
 =?utf-8?B?bitCNkNhb0ZBWGFTODNwaXdrZ1FrUitFQWJEbEtQamVCK01BVUZsVlVkeTdU?=
 =?utf-8?B?NnZ5N2NhL0tMUnp6S3ZxS0RmcEFKQWRndHdIZzNpVStEalBYcXF6YjNCSGI3?=
 =?utf-8?Q?awafeRstCAPCuVUw9FqejfV11N+W2CNNLG3ByeN?=
X-Microsoft-Antispam-Message-Info: 3+jBRKRO17DFo8C7aYiU/ybjCV26V+Too/DIK7ufirD6q++ryeX7MS4+4WJ9DHR2Qfj+Q2zauho/aSxeTgkiWfnbqe5mT6s1qXaJZyyIzVfgVXSMC7bgxt5Tvxa/LXA4UXwdtPo1P7x0AoZGroG0+jYTGWbxJmoRu8m+7zPPJU5cpl/iabuXsOsGL/McoT3H
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:e/egQVtfs26TtutgEMHGOLc/I6OteAlPXpNCs3lGXZQ7W1HQt7jnPlN2gfBpUPL4TVtVPaKNqGaUijPIMDrAwyh1uTDPOmWXTZXkr2p+TWKvBx+W7eR8gQ7uztkqAuh9cmtZckGYysXSXq4eiooCFpKpEb+Y9agbwI8Ap9ebK8FG6WCJJ5hkFbnZUvjs0MVOWvpPdABZPC3AccrBrFOBNb5pHxsZIuQVD/mh733Rg7lZIzWQeim42i22Xsu9P5v9IfzOgI4hxZTMFHENO/vLu5tDHDVMXxFGp5I8ZnLhWY1wXqk3UF5P+kXALt4YUR2wzWRSFzXzXI0Gx3qsjx4sKWmbLix9vykLeZPe88xGSt3fSyo/Djf4tAnXD8hLr/JRQ0Fd0RVVMV33PwYejWIQ3CREv+Yvhd1Qwp2GvmZdMDpMgz75ub1w2VW/lojU9pH2YNx7eZfYdpHcBhT7DVKwuQ==;5:zQRk/GtTjePTpGz4E8wEwoGs7V8nmgBRwhoAr1WCB9ylXyArdQstpL7Z1c/klS0CBrl7SdhQekmG+xzksEJa1LvcqRcUl32Tq6DdJV/tnH+uUdkktbrEIV8LHGCjnyNFhw2dP7oji0aI9DOULsD/hE5+Bl/7KzddxcKTyN9QKjI=;24:Gdmu0Sp0A6F8P1IyB4eqCTX2IVSm5NZzqGJuFH8GgFaSMuKcPqde5vXUKc/XR/pp+WKPNOkCt536d+RiNQAT/Kh+TlNqkma7nkLGkpGPqrU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:KpKOj/eWE539VawkOythCEaY167DRiU83uWy38UMs7mf2f6owt05Ecx4hOXC5rXxBGvgJf7yqaPPHyhwQscymm+mHGmRVWRRTkTYf8dYd8Q0SZCBWZAmtUcLPqhr4NqFIb2fjfXD8Lgo2OLnzDLVdrbhk0pCVD363igEC22gONHCr8tg1/kwUFF0LXFu63bJw/WUiyk4psRTndE7AlQFE5O7xAAwiSMgEz29lgAz5hjJAIO4U7rb3P2WXjdHSw1F
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 21:43:31.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612e809e-e259-410a-5fa3-08d59687486c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-29 16:27, Peter Rosin wrote:
> On 2018-03-29 15:44, Boris Brezillon wrote:
>> On Thu, 29 Mar 2018 15:37:43 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> On 2018-03-29 15:33, Boris Brezillon wrote:
>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>   
>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>> the display problem for me.
>>>>>
>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>> ---
>>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> @@ -129,6 +129,11 @@
>>>>>  #define DEFAULT_TIMEOUT_MS			1000
>>>>>  #define MIN_DMA_LEN				128
>>>>>  
>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>> +
>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);  
>>>>
>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>> instead give an higher priority to HLCDC master using the bus matrix?  
>>>
>>> I don't know if it will be enough, but we sure can try. However, I have
>>> no idea how to do that. I will happily test stuff though...
>>
>> There's no interface to configure that from Linux, but you can try to
>> tweak it with devmem and if that does the trick, maybe we can expose a
>> way to configure that from Linux. For more details, see the "Bus Matrix
>> (MATRIX)" section in Atmel datasheets.
> 
> I don't seem to succeed in changing the registers I think I need to change.
> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
> it. But when I try to write to "Priority Registers B For Slaves" it doesn't
> take, regardless of write protect mode.
> 
> Can the relevant bits only be written when the HLCDC is inactive or
> something?

Here is someone else with what seems like very similar problems[1], however
also with USB disturbing the display. I can't test that (easily) since a
mux in front of the USB port was unfortunately wired incorrectly in this
first attempt. And USB disturbing the display is not a showstopper around
here, since USB will only be used for debugging etc in my case.

[1] https://www.avrfreaks.net/forum/sama5d31-ahb-bus-matrix-lcd

Cheers,
Peter
