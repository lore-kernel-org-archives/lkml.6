Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeC2O1U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:27:20 -0400
Received: from mail-he1eur01on0095.outbound.protection.outlook.com ([104.47.0.95]:51482
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750732AbeC2O1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:27:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
Date: Thu, 29 Mar 2018 16:27:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329154416.5c1a0013@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0038.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::24) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb018954-fda6-4621-43cc-08d595812bd5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:6UYr2pHCfViYucTvdfPeBjGS0e0L08dtLzkxfT7L9fVeA/o4yZchKFuBiosjP0p3+fiDx+gJBFyS+kVe7pz57dGLaS606VlGeDyXjaa6FqDg0zynQGkTq2EFMHp/Xswy4+VkjoVqDaaz/z/XDe0o3FvTimjXF64naDq0FBfBxOIcxSE2MTZSFqdOENWskJkeKw5fJcqqCK3GTWupL3+mh2XwwK5tX1slOHdSBXJdsYs0FhSr+bUdOSSi7mauikie;25:sR/UomWyec9UeIxsdZfJXCLgx/YzeGuodhJ2LA0Hd1SMKh2LCaQObp5cwRqQjwu61BPSNb3e4bGnHim2OEhd+LskqgFiTS5XpCudwO7r0gi9msg6P0cfUOPKx/k6Z+dh3shzPO/NBe1PZEnzlEpS4HGyNeSQxCmwN4Gtu8sAoxg/3Ha/Zwuq44XSINRVmCfqt4CaqUBlCtjMwCipiaKF38BvvbvK7MwrkTmuzgqnwXKQ8X/fwvMEx0iAVbO4pfh3W2Dr1v80ieNS2sPHXuaPMwsRwUrzpwKTkSknXattredCEwd294tIm+RMNIuRpids8uicFmzVJJnff7/XayjVjQ==;31:WOQBGByg1B2Vjxlwvn1iBJPyjHpQwZYQYbUy8/sN0QlwfTnCo5s+AYSuI17zQuE6zfPpRXlQnmuDfwBD+uZhYIHwImm9R2onvD4OStw0k7aT8+bvwZfKlgoGFQ6i+RM23zEVTFIyX6+KkngNCzr1O+V4cv+dJ8Jpr9gbgjn4OdLnYxN4z1p6yDCuM8DrmwtrKTG1BlukjbbkmQ33eO/De2PdGrVy2BNQzbSO9m/TU+g=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770F8F5E80ED791288FCCA4BCA20@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:NnLzn1I8ziZ4HHmahinLOen7dnhHgA/bmHwMJb+1bUXR3QDsprVUP6jUFy+KMCZ44W4CcipIV9ieuHktpjbFF6Je0dkjYt0GBLNDIXMrMMOwCdmQERThUyIMSZ18Bjw9sFUoWybcNr5po+Sk0LU8S8tL1FUfs4f7z+1LF+y/5MxI/tbl3HdsDe9V+JwfIKTkkNepKvfJzzlW1c0usp2rNSw9jJfAJkhOS7WWYM8ODtqPaQWWQ7C4NhXarCsmicToVueiS1m/B7GufP34yNoq6Q==
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(39830400003)(396003)(376002)(366004)(199004)(189003)(377424004)(186003)(16526019)(52146003)(2486003)(54906003)(26005)(6486002)(68736007)(53936002)(2906002)(8676002)(81166006)(81156014)(31686004)(64126003)(86362001)(8936002)(316002)(117156002)(3260700006)(106356001)(25786009)(76176011)(74482002)(77096007)(16576012)(36916002)(23676004)(230700001)(6246003)(6666003)(105586002)(97736004)(65956001)(66066001)(6916009)(486005)(476003)(478600001)(486005)(58126008)(65806001)(59450400001)(47776003)(31696002)(3846002)(93886005)(53546011)(6116002)(50466002)(386003)(305945005)(11346002)(229853002)(65826007)(52116002)(36756003)(7736002)(446003)(7416002)(5660300001)(39060400002)(2616005)(956004)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6SmRxcWFuaEszUVRRb3JjUzZGYnZSM1Vs?=
 =?utf-8?B?OHdUODRGQmpyRXhqY1hTVjFlYTdEU3VkQm45UldCaGEvaEhCRENDaWpVbENz?=
 =?utf-8?B?eWRTMlVBTUN5YWYyMVdCNVlCNnQwTk1GSlFOU3BnVFEweGQwbzIxVmlFUkFW?=
 =?utf-8?B?eXYxV1g3Wlhhb2s1M0F6MVRUbElLdFFiY1pneDlkUWZZZG4wRC8xZ3o1RWNv?=
 =?utf-8?B?REd2bzQzRGxaTEk0YzNHZ21LOHVJZnIzaEh0SHpzemFza0R5Nzk4cExkcDBt?=
 =?utf-8?B?aDNDNEl4K2NwT09aWEtEckpoeE9vRjRsK2krblA1Q2hmN1dFcnArcVBWM09r?=
 =?utf-8?B?WjBNZFpxVG14Sm1IWnFJVlQxSmpZZTdwQVQrTTJYWXdCSHZ5eEhlenJ1VjhO?=
 =?utf-8?B?SjhTOCtNTTl3OWtESXJDeEdGVkpGd3p5MnFCYUhJVGwyUG1aWkxELzR2MHRm?=
 =?utf-8?B?SVFoZEU2bHNadmIyc25TVksxTjJGWkFVR1diMUFwckZSZ05ZbzNoQUFUWEVu?=
 =?utf-8?B?ZmR2VGtmY1dkSVJ6MEhyOWYzUUorREpXcEtQQXRGTUR6U2hmaDBMYk5RUlAr?=
 =?utf-8?B?NEJHSW9WVzBtYVI3ZFlsQUJ3SVZZZVpNTVcrL0NZZE1BVG9zcU93d05nTG1B?=
 =?utf-8?B?amlXSFkxbFNWdmJHL1BoaW5yTkJHaExmQjFmOUlVQVllVEFOUkcvK3p2cnJi?=
 =?utf-8?B?SytXWllnSmVJcHdVWHlQeEVQN1NYanp0V2F2Y0RQeUxOMGlVdUpPRG5iVTc0?=
 =?utf-8?B?VE9rYVFiVGpqK1crRVU3WmEwWkRYcVlGMTYwcUdaUm9IeHR1VWdnRVJXdzJI?=
 =?utf-8?B?S0hiRm1TRG5wRHk5Yjc1TXFCNHlrd21RUG1xZnFrNGRQVi9xTXAzdUhFTm8r?=
 =?utf-8?B?N1p5TSsyNWhBdDV2RVlwaERiYXhmcG8yd3FoODI1aXp3S1IybndsM1gwMTJ4?=
 =?utf-8?B?K2NGRDBNM0JVTndVTHJQbm9icCsxZGdpa0hZb3E3WXFQZGduRVJ3Z24xZTVC?=
 =?utf-8?B?dHlISENWcmNsRStSN29vWmhwVWhRMFVuNllQVlo5RXNVZ1M0R1g2c1ZiSjkx?=
 =?utf-8?B?MGJ4YXJyYVhOaityKy8ydnE3VVh0dEhTSllUMzdoZ3ZKdUZ0c3pTS1hYM3M0?=
 =?utf-8?B?OXY5TTFXN1NKWUk2SDdLdjBqUU56SXphNmt6Z3h4RmdQa2h6dUkySTZCSFo0?=
 =?utf-8?B?RmZ6UkprSkViYnVqZVc0Zk1wWFpEaGc3OTRFNFQ3aElPcmZmRFR6TUo0MlZ6?=
 =?utf-8?B?WTVZaW5ORzB6aFI4cGVXVzR1a2NuQWF3aW1XOEZZNXVvRTJEZDhCVFZIazg3?=
 =?utf-8?B?VjRyeGE4d05IQllzZUt6VnV3azRmQ0pYR0NmS0RZTCsvbFpYRWhQaTZRdDRx?=
 =?utf-8?B?STFzUUZ4RmlJQVV1SE95QlZWSDdNekptWHhzWTd1cHFWK0RqYjVrMHhINjBQ?=
 =?utf-8?B?U250SXlXSVhHUGxuazV4S3BPb2paNWdMaWhOQ3psdXBGd3JRVC9rTUQ5YWUw?=
 =?utf-8?B?SEhjWUNTeHp0Y1VqWUs3UzNhSGw3Z3VmYmxwaURmU0xWUDNEQ2R0MmZKbXFH?=
 =?utf-8?B?Qk5hWHBIRkh3UXQ2UjFKeHlwOUdvbWVvNEwybmJ2bVo0WEVsdVducHhJQUk0?=
 =?utf-8?B?aTRVMFc1d3k3d2JiS0V5NDl3ZUZCRHdqd2hnYzlHV0tRTVNPbTZaTUc3d3li?=
 =?utf-8?B?WkJyTng0ZTN2dlZjQ09WMTRYQ0NLZ1VORVpIRXBkSG1uVm0yTUx1eEZqTmc2?=
 =?utf-8?B?TExVVlNHbjZKZ3VMTUdJMEFMUlJheGlEbnNOUmJGMnZhNmRRUDZLR0NiT09O?=
 =?utf-8?B?SGR5cFVacjA2U1BYbENzTGZLQjFNR1NOQzBlYW5xZmlGZlcwcG5oV1Z2WUxZ?=
 =?utf-8?B?Z052UkJNL01kU3RyWVptL1JzME1Fd1BzcG9pYXdMcmRRSURjUXJZRWUzZGJm?=
 =?utf-8?B?RzdKVUhoRTQ1aTdOY1g1ZGVGYWcxY0MxUzhiU1JEWThRbUxkUEJ5dHFGSitH?=
 =?utf-8?B?N0dwUVhqZkN1ci9sMmNacGpuanNZQ1VJRnFDTENFNktXbkFScXc2RzJOQVc3?=
 =?utf-8?B?Rmd1bkt6VWdaYzJuVzR3dWlLaHRQNzJnWVhyRDlqT3FFV1ZmZkZyYTF5UjJ0?=
 =?utf-8?B?T2liTkl4Nk9KMnI4QzJKNmFSZG1wdytaWFFIZWxRNFYwREVmWllTbzBnQUtJ?=
 =?utf-8?B?dDlubmpXZ2k0bTA5NCtBMnFBYS9CZmJDL3QxTEE2TlZOVnNDTkRsRlVFRzBF?=
 =?utf-8?B?MDRIOTRpN0grQXZwcjhRRkFuWmZRemhBQlRzMy9KNmpWNVlwWk5ZUGhnPT0=?=
X-Microsoft-Antispam-Message-Info: yUN8ycxAqr3LWJA4CRMwOdiBISyFpq9jPnqphm0ptErAGgcJPdBY1evJenkA5u/7k/XLVecDIFZK9jUF9rwD9y6k214Rd2GOEmOoxNqibLYsifFJl6SwnwgZLE8DrYZEKtxSCtWn1PX9/LKumdE5cCz6qjYmZyqjrHDPx6srrH25zAiTJHYFf6Yu06c91VAz
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:CbkkSNKq7x0KqBuViVk8I8uz7x12YH09f/df1zeJE0JTfDQ3fbwp1M95wWo8oicDNIKjZlhdVNimkC8Fz366+mHeXxrh/7TKxTY/qz6/Wvzbwl9PDal/MTM2yz7QJW3CrfQEoi6vKeo4e5F8bb+tu7kkmqzJAkWQ2/y6oAhJLoeDIR4KWsaMVgeWPoYHJeCXl9aDqbK8pGW+jFUpXhy5wnHZyjWlagMCzF0rq+4Ub1WXRkOVtfhna4d9OxeDdd9O7B77n8IT8H6N9kEz70mCb6dB+ztYeIOANcPoTwueycsHNNgl6tYZpWxhKganuBzXOy+sV9yYA5x5L14TPDftg69xWpl3WmbvJsseFa6JzCmqRD5VOw/QpeM2ilEDEsZUY8QZ+1rHC16yvX3BM7YBlEtwHKGWImZfV+OHI5AaPijXysGKA00uP1RioFixmVdGCnOLNmEW7oKqa7RNGts8vQ==;5:jkEepjx4nCLhgaFzxwLYcKds/++BngRNN5yrmRTSay/HonUP6oZir3cJ6IVsgXQe9LfOcpaWp2nL86NVuK+spS+2che029Abp9/ZDtLrHHHOxA91lNkkBatiNhWaQmpIUsh5Q3Qqn7pVti/PUMD4EiRKD0J0J8pCsyUrdjtx5yY=;24:jUVDCRJnmYs6dDiZrtsV9D+0z7cEGtjtyK0F+xk3efw20S/DMaPBgrAorZgXECjkCL7FxKVPkMwETmb0hk/hUXWlLw9lRJXa2ol26f4FnlY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:TMFAqwS0/Zw9D0XSzh1qOC9IzDhNnC7mqjGiPRakYYFu2cQNjpfSofF9p+yORmz+OTyfZWcqb2JdlzRbzBsN0FEy7DpZQw7evUBE0dAXAoQxeGdkn9+7pibRfuFwGpP0u8z7sCfcwm51VSNEo8hNLUMhByLI1CYQM+xDyj7mfUE49/PXY+d8duqNBIOl0bgw8zDueEct64YyF9qFqyXClWnRMKbIN5YKxH14Bhi7UXs0BiqM5jzzVQNn4nQZRy0t
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 14:27:15.1941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb018954-fda6-4621-43cc-08d595812bd5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-29 15:44, Boris Brezillon wrote:
> On Thu, 29 Mar 2018 15:37:43 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-03-29 15:33, Boris Brezillon wrote:
>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>   
>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>> module param to disable DMA from the NAND controller, since that fixes
>>>> the display problem for me.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>> @@ -129,6 +129,11 @@
>>>>  #define DEFAULT_TIMEOUT_MS			1000
>>>>  #define MIN_DMA_LEN				128
>>>>  
>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>> +
>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);  
>>>
>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>> instead give an higher priority to HLCDC master using the bus matrix?  
>>
>> I don't know if it will be enough, but we sure can try. However, I have
>> no idea how to do that. I will happily test stuff though...
> 
> There's no interface to configure that from Linux, but you can try to
> tweak it with devmem and if that does the trick, maybe we can expose a
> way to configure that from Linux. For more details, see the "Bus Matrix
> (MATRIX)" section in Atmel datasheets.

I don't seem to succeed in changing the registers I think I need to change.
I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
it. But when I try to write to "Priority Registers B For Slaves" it doesn't
take, regardless of write protect mode.

Can the relevant bits only be written when the HLCDC is inactive or
something?

Cheers,
Peter
