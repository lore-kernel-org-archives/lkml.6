Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeC2Nhz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:37:55 -0400
Received: from mail-eopbgr50111.outbound.protection.outlook.com ([40.107.5.111]:19488
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752040AbeC2Nhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:37:54 -0400
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
Date: Thu, 29 Mar 2018 15:37:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329153322.5e2fc1e7@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::12) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f982512-ab59-48a8-d704-08d5957a4375
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:783scG93s99gIXKWJf35wZ7FUA7SvZ6RlNDIqaVTDzGwILb7D6MMthAkU8+KeOwpuC4Tmjf2s4WZwU1mlsBBiS8zIr1Cwz9Da2dSvL5navsvw3HKzt+/4U4G1DPrkIj5ocU0HdurN5JjevR2+LuZ+WsrbZhjgksLF+j4yYublmP3zONLb6iF3W0JqW//2QKIvKcYC4cHV9KjoK9ao98bA0QqjQmIEf4zFvnWPAFTPh4Dk4bp8LNsigmWYq/6rxJG;25:rc2a4qU1nRMb4Op/SL6FbqyUaFk345atooVDwWfFkl8lTxUu6a5NMItKebmSXQexwXZGxpwWkVKxp33cmYbKHMDILIK1ckpFgJ2hZ+qdtSVW1s4x4/q6RdJlznhtWLQEOvuuhCIHi1+mkBWwBTlVXVTetLmOhOkJpgtfx709iTr9tfMu2HRKM/1YHBF2W/SCQNn6lHQ+ZAaFJR0vMKSKW9Uxm2EcH0Ba7bCBuOdNkeVHC4or/13fInkxODcpY9MWpyGyI2vJsaRtiqnAUVpmgEc+JW5IE5mpztVmSnGuBFzzgy8FCFxBCe8lfWCPJzIkcydNCDUju6GHvwReX1d1Vg==;31:w2D98MdMwUOEpECWXPj1dcqTpDsgZB6P0yW4LP60NQna+iBuMCrCMIUIbYI7OWVHexzAWY1QPGd2L1la3dWD9KC9bUhMMD8pbNwMLHtHhJ9CgxSt56sTFVmpjnU5SxMxjcZpeTeEmBo6b9tZ+GJpiKfxpqR8mCXpT6qPUe9nRVPgt1ojjIKifAkN/z/he6ZiK95wfNx5oF8DqtG8jWxROPvNA5SKg044vrnFUrN0Z40=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776F8B71E233A167456140EBCA20@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:3Kor14Iu9jF4P4U81A+TUC3Wmsd6KWrmSgefTVjz3ovpsniEAyUVAiz1dt8r3cXWMva4ZP4LbORLuyETuoJSts+mKXuX+vwdctRJRO88N3aeF352+3uzhT/ImEQ06JDQFLUN9BqhrFn0uZPnoSb6qyWgUxq3sHPXya+4UI3Xk+fOeO1llWbuh0ZuPSiq842NYkHBe+R6DTF+ix7ttsRzgj6vdBLZFcP4EGTwjpbvxOzt950T4XfxNAGKrTVCpKYWDqK6w7Mdv/N9mS7efK7kwQ==
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(366004)(346002)(39380400002)(396003)(376002)(377424004)(199004)(189003)(3846002)(476003)(2486003)(6116002)(486005)(31696002)(36916002)(3260700006)(6916009)(52146003)(52116002)(117156002)(25786009)(81166006)(6666003)(2616005)(11346002)(2906002)(6486002)(956004)(16576012)(386003)(59450400001)(76176011)(50466002)(58126008)(478600001)(54906003)(68736007)(64126003)(8936002)(6346003)(8676002)(16526019)(74482002)(4326008)(230700001)(26005)(486005)(23676004)(53546011)(77096007)(81156014)(186003)(65956001)(305945005)(7736002)(31686004)(106356001)(446003)(47776003)(229853002)(65826007)(5660300001)(39060400002)(53936002)(97736004)(36756003)(316002)(66066001)(6246003)(86362001)(105586002)(65806001)(7416002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6TktOQ3lsUlc4QUxObFpKbHhYamlXajVy?=
 =?utf-8?B?Nm5JTXRKTks5R3pNa2U1U3hDMEt2N2tsTGpZakZpZlhEVUl4MzlQd25LdFhE?=
 =?utf-8?B?a1QwQ1c2VWZQNTN4YjMraStEdzlLYW1zbVYzTFYyaXJxaUVOTHpZQ1hUc1hh?=
 =?utf-8?B?ZHJpNnd4M0xnSEtIRHZsT0I0amRwbXdxckVYL2ZoVDJTSlRMRnlLVDZCQlBY?=
 =?utf-8?B?ZVRicjY5dk4vUkRBS0hKeHpnaHpvOTRlbllSWWRNSDlYTExTbDdpb2R0bXY0?=
 =?utf-8?B?UEhzbXNwSDRFejZVc2w4YkFsMmhQR3JQckxLcjJMcnNUL05SVjFzR0V2WDkz?=
 =?utf-8?B?MGc2TFBFVUEyc0YwbU5RRlF6SkNIWS9ySnp2ZmN3eXd4WUNXVnVmZSszTHZp?=
 =?utf-8?B?bjdQTlRWcy9pU3VMSDRkNUt6MzJSa0tnbkJWbXMwaUlGVVp3ZXA0L0NzQ1l4?=
 =?utf-8?B?Q3BWTURsSGdVTytZVDREWlMyMEZuc0h6R080d0Q5WEwrTkFJN3dkczBpZWJR?=
 =?utf-8?B?cUVIS3pqZWJ0YkhEV2VsU3JCWEVyVGJyWnY0ODZKemwvNWxtNFZPZkl3aDhD?=
 =?utf-8?B?ZkFYK1MvblNueCtKYnJMR3B5UE9oVGFBVUZzT09FbmZBSzRjd3FyTWpGc3Rr?=
 =?utf-8?B?UXZMak1ncU5hWVY2Nk1vUUpPUHJLWmU3cmNrcjltMFgrN0ZQMFJhbnUvN0o3?=
 =?utf-8?B?bnFJM3Ftc2Njcm5OVVEyd1pxa0RzaWIvUzFMOHU1SG90WldsNFk5NVBhYkVP?=
 =?utf-8?B?RHgzWTVIZkt4bDhWSDlzTFhUK2d6Vlg2TkhvamhYcHB4b3p2blBXbEV2MVY2?=
 =?utf-8?B?cE9NLzdxVGltczJOVGlUSzN0eUVmaUNDZnpYcmRvVEMyQjVlMUdvK1NkT0J0?=
 =?utf-8?B?OHJkWStoS1NGM0pnS1pCdHBTSTM1TGg5ZTI4RDRONGlmTTFDcTFyMWhCUFNY?=
 =?utf-8?B?OWN3WHFvUmY3ek9tM1YyQ3NCZGt2bUJTYzJQYjQwRkkxNVR5Vlo5dGI1cldn?=
 =?utf-8?B?L2ZHYmZNWjlLR01KWEM1QkNOZDFHd21Va3MzNHI0Tm1NeFZnakhtWHFTU0sx?=
 =?utf-8?B?TzhHUjZvUjVtaWNHazI2dEhrUm1RMjJEeEl4TUFFWDJycmhUaUZtN2tvQ2d1?=
 =?utf-8?B?MVRzT1dxVEd1R0xjN1h2Rldjc0RTMC80azNWZnN4MHg2Y3FZWXpuQitOQXdC?=
 =?utf-8?B?VUxZTTJKN0xGd0RiSkM2aTR4aktvbkJCWjF4MW5WcjMrWmtDRjhLMWUveWVO?=
 =?utf-8?B?OTl3SjhUNGR4WDA4RXBBZU1KL3Zxb1FGTEErZGxqUHdTVnVhRHAyOHhMV3FE?=
 =?utf-8?B?amo5eUJmSFRTSGF1ZTRyZVRhdytRZzFGZlFuZmM1dlhaaHZkMjRZNElRbVgz?=
 =?utf-8?B?aXAyT0NXZnk3YTE0alBOQ0F3VFZucmxucVJXdUE4SytsSVI2RDVlVHpEeTk2?=
 =?utf-8?B?UVV2Vy9EWXNFQ3dmb3BraHNiaGdYUjVodlpnUXNaV1E2R3BvSVhKYWM5TFR2?=
 =?utf-8?B?Ry9ML00wVnNDR0VCYXJSOVRMcm5MMzU1UE5rRXlVTTc1TE45VkltTDFnSDFm?=
 =?utf-8?B?ZlNOVmhkUWtEUWlhbG9NdGtERE82QkpIVHhCQlVFTis5V056aytJM3c1dC94?=
 =?utf-8?B?Rit2NDJ5NWhMaEwrcTgxV1M4L0RPemEwU2NOWlFFUGk4TUhydDRyYzFZT2dh?=
 =?utf-8?B?RGlRb05idStFY2tiRTFheUxGMVVBWjlUUndtdHJuaFFEK21YMStUZ1dxajBT?=
 =?utf-8?B?Q0dRL3V2L2gyaXRpNjRmdWF0NldTaGVjVVdqNUVwL3FxVktQSHBZY09rTHFk?=
 =?utf-8?B?TDZJa0s0YitKd2R4TitiWmYrSHJQMlVJVXlKRXN0Y0xVaDBEbElranZVSS9i?=
 =?utf-8?B?d25qdVNDQ0xaSi9ER0EyendsdVk4Y01JZ1JCU2tFWElrQjNJdVBFdkRXQm1m?=
 =?utf-8?B?R0czcXZxOUgxeTBFa2JwZ1Q1WmxTejhCNmV6TmVjQjRLY2JLQUJPZm1Ea00r?=
 =?utf-8?B?V0psbVF0clc2MHY0ZTFabWtDcm83VHdNUzNmbHdpbHB2WXF1VjNsMjdBakQz?=
 =?utf-8?B?eUhsemlRS2JnWUZmaWhMR3B2TlAvMktHNWZyNzdMeExOeVN3OE5OTkxRS0Vt?=
 =?utf-8?B?MHM3dlpOdnBmNXl2djNxUFhXaC9td1ZUTEVIVG5GVWFPRnlVOVdTSm5VOFE5?=
 =?utf-8?B?dzlrVXFSTkV3QXBVTmxTWXl6Y1ZkNGdQWGVDZlBoSCsxSGU0bnZqMEJUdkl2?=
 =?utf-8?B?dFR4dnN1VFZSd2NmZmJwOGk1ZGpTZmJ1cmR0SUgwN25JYkIvYWdLUTZBPT0=?=
X-Microsoft-Antispam-Message-Info: aABumbJqJdR7EjzDenQ9hG4SwQx6km6OrVlQoCuMOZBRZl56QmzDacuH7VdWR+Cmxmgh5Oo2xPJORJdxScNvGO5eSZCENS6cCHooEqm+CEQPZECD3W5ccjiPcKGDmAIGThgbZ7YELhXz9iUe7yP3b8RJ2C95H8UuUie9xZTIMCNVed5Jl+7+tbM9zvliLV5k
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:ZFRDKQEKOWQBtPLMjXbFzzOCcqYU2LM1xEeFO3UTghBmD1ezqcpiHFRz1OqAgBM7tXaca3wJdu9SCYG/vkawaFlWxqyAuarsQFUN2puISTGEL0/Md92wLnFsvohCFe/YiVmYX84jUjyVudV7bCQSfHRLAY6+AQx16LG1RYyJzBNpDcpAbxzCJaGYf6MKKIar0oyaYOjoP4w5LY4KTUNZ+BVwPv0m1Tct+m4EVzXhbmVG0vN8emawgop67KEDiPYnKVpDx5lqx4p5GoMgoa3xGwKSWizyLSbP8mwv1bbRdmLuJSYkTlZ13UhBplVDWHtqOjjnkNW6sWbr6QqDlj4LE2U4/ipWpohCh+0lHkaRzTPZfDDRAjZ5OR1+3b3M9StMeV50UKgqXh6hQXXyNrN58j8M5JjDUZXsac03Reo3OZlS6AAQj6K9CISCCqTg9vYn27Rk2YBZG+EzmSr2moAvgw==;5:b/UchQidUbvJoYsu97o6TeVN+IWbp17ckrfkHDP98y9R5vJmwlP3S2kmHhB5Ie3ItsQ9aYI9sVq7Hy9gYARjrUrRKcW/HxyLMlU46Fwv4t8w7wpOH+F3Nu36tLp5WWMjRuolKe9+IRAd8YXqhUrvmVVEN32VJI1V2JzXFSAiOEA=;24:RnyuGpP9vea8GLJMNVEmwrrgu+apCfuMO7N5lw4hfC97Olv7dcaCUilrYp/3/jknEADjSu/AUpvasFQSaULHFRzG9IScKg85R5g92OQve1A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:bH9tEgrT9pZLK8ZCL4GB7yVe5XPTZTVu2IqwD/7YHhCf3C+FDLxHdqfNw2MzwzwseS6dk07JJbjCD7jFkeq6tgswhOdLYOfxX/SCQg9wZZyqNaPELQJdPjsQwR8I7dS19sp46mab+fKEyJkELhPrsyjZt1lLTV3DplAbIoKcwSzo3YL0DmecRhl+WZyc/iAqTSc2AdbMjV5d5+pSYrqQo9niU2mXgXPTROiWPH5+0RPeXbFjjhKGXyXGMaiI/Nxk
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 13:37:48.3138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f982512-ab59-48a8-d704-08d5957a4375
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-29 15:33, Boris Brezillon wrote:
> On Thu, 29 Mar 2018 15:10:54 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>> flash accesses have a tendency to cause display disturbances. Add a
>> module param to disable DMA from the NAND controller, since that fixes
>> the display problem for me.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> index b2f00b398490..2ff7a77c7b8e 100644
>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> @@ -129,6 +129,11 @@
>>  #define DEFAULT_TIMEOUT_MS			1000
>>  #define MIN_DMA_LEN				128
>>  
>> +static bool atmel_nand_avoid_dma __read_mostly;
>> +
>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
> 
> I'm not a big fan of those driver specific cmdline parameters. Can't we
> instead give an higher priority to HLCDC master using the bus matrix?

I don't know if it will be enough, but we sure can try. However, I have
no idea how to do that. I will happily test stuff though...

Cheers,
Peter
