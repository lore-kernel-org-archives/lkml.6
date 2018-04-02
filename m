Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDBR7z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:59:55 -0400
Received: from mail-eopbgr00124.outbound.protection.outlook.com ([40.107.0.124]:17088
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753157AbeDBR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:59:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
Date: Mon, 2 Apr 2018 19:59:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402142249.7e076a64@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::24) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 350a4810-5e56-4c5b-e761-08d598c3840b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:LXYDplA2ZYIwnG0rjqcki3qCM6ZLAcGkay7n0iuyLRZl8PC3OUGDoBlcLDZ92C4diQetH1BGpo8ztaMI6dVUXzGjyWg65zPZZPHIgiXyAM51REpGFnMwG5c9jGspVTlCmTTElqP4aATSYXuOuRcppMov61SyWADWN7m+da9Flku28fRcCPawSWP4IGBbfWdYy9hFoRyHlz1gczDvv+1Eipnrq0nMIXJtzy4RwkHEBEtnuH5BzIbbY+eHFzsygcuE;25:1YHfgvkXmRGkvlS0lN7uy258QHqxC7e/6evOWMuKWCcwtc4i8yIzxScJkoACK7vG5s0YoifWIeF2g/uVETnk+Tf71eWH9MySM2wxg30jOlNjXimaYHnyC78NNbWzpfIvmlGK+0sjP5+Ir1WyeizrtNt8oxq2TVnbli/pp6scipvAKpS/pU5uB23arVwfPDYLhbY/DZpivLVD66qXX4y/DrgddRJYF6h9Ap4W9T9a97UBfyWkBWo6YHFm/e2mPkCVBXpM5bIMWovbBLfZyiiEB7R0en3+iXaV1RSKyE9oGwP24/6t+cb/9ffZlUNpU4Ge42CVpHMTTVOzZ2CaVHNXEw==;31:HOgoEbk5o5CdAnDZGsk0uVOJ6iNPGQn3blXFRdQIK8I3+Y83fpJ3I3rli+vo1aTlvIPv+uDfGQrhZ4xyHQMLDXVXeVvW011l0ecVUjWa/gWYTbziEWt5JJzqi6Os5eTNSV/+QId2lYXiIUC2AsPIt2RuXAu6r2ZZktG31apX+WWCrTWySJpwpWOWNLumC53oFlqSV98S2+NE6T66G0KK2p/b1RNcsC/CW/fuAI8ptIE=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775BCCCE414A56DDE0979A7BCA60@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:NzQNb5lZpzsUzI8pFgDkxdARZdyJMqWe+z89Ts22xHAFW0/1tRpr90S71iSrseXL0rPhprtfj9m9DjGEbChg9S/Qb6aNXcyldiZDTpThHe22vwhLh1POF/REqRnNbTHjxShijvkiAKDrclpEUpZ600V404mNxged4V0TC7ClZBS+/F3GbOk5HP3QsN5p5l4cnC2JCzEFvS3tZYiCRnZA0xan1W08ToNuB4S4i3UAmsSKLWVIkJYKfRvlhWC5GN2Ah5FZA6C4xUYWyZkUgW/jbw==
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(346002)(376002)(39380400002)(366004)(199004)(377424004)(189003)(6486002)(86362001)(575784001)(64126003)(105586002)(6116002)(74482002)(3260700006)(106356001)(3846002)(478600001)(2906002)(77096007)(229853002)(446003)(68736007)(31696002)(4326008)(25786009)(186003)(26005)(58126008)(8936002)(16526019)(117156002)(316002)(2486003)(486005)(59450400001)(97736004)(36916002)(386003)(76176011)(36756003)(52116002)(52146003)(486005)(476003)(47776003)(7416002)(11346002)(2616005)(6246003)(81156014)(16576012)(93886005)(50466002)(53546011)(23676004)(65806001)(7736002)(65956001)(66066001)(31686004)(6666003)(39060400002)(6916009)(53936002)(230700001)(305945005)(65826007)(54906003)(956004)(5660300001)(8676002)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6ZVdLM1ZoWTg1clpDMGUvUms1OFhmYzRE?=
 =?utf-8?B?cmJsL2lJT253dlpVZ0NwRFZxRFE3Q3lmL3U0WGg1Y2p4SnVlc2dnak9IZm5G?=
 =?utf-8?B?QkwvVHF1eWpTR1pTRzJVUDFPYVRSSFRQUFl0a0pzN09QZWdzOHRFRzVmcSsx?=
 =?utf-8?B?cW1oRW5pMHBPSlpveVZJaDh3bUFnTFkvc25LSHNuR0QzNEUzS3B0dEJaZWNp?=
 =?utf-8?B?T1ZXcXJpM2dsMUNoTEkxYzE3a1g4ZFd5UXc5amtIcjVhNVo0WTFVUXoydXRD?=
 =?utf-8?B?bndzT0ZHd2lxcEtrRjlZVzl2eXhob2xsS2l3a1VTODIwQWFIOXJodFpPTUtG?=
 =?utf-8?B?OTVDZ3kvcW1xdWNiNUI4NnpnaUIwUjljTmVqQlhsNUNVUzlwMy9Hd1YwNXhr?=
 =?utf-8?B?MGIxVzhrZmdBYU5JaDFVdFNuQnpBWUg5WUtRUFBRaHZnY1o5R0J6RmQ0a2hY?=
 =?utf-8?B?VklQNXVROVhSRnRQWGtqOW9Tb3l0M1ZFVDFjYXh6VE9TNExNWVllYTVoWWIz?=
 =?utf-8?B?V0ExZUJQczVsejh5bFlLMFVxcmVDTFJUeUdlODBkRmNZZHFHZnUzR25ocWNG?=
 =?utf-8?B?YmpTYzFHWXk2S2dzUEJKUE1DODdBOTZ3UlNVMVlRRmMzeHllTitLdXgwMVNG?=
 =?utf-8?B?Z3BuZDhHcnFVZERGNk5KNnhSdWplWFdOTUVRQ3U0VzB0QWl2bThlS1JBU3E1?=
 =?utf-8?B?VEc3QlB2aldDMk85T01WSU1JRFQzcE5NRUVMREl6Smkzc1VwMEppWTltNk5Q?=
 =?utf-8?B?U29KNFcreTdEZjA1bFNuUDNiQzdPQWxsYVAzUzNaeDVQTXZjWHZlOG1lUG1s?=
 =?utf-8?B?b3BIbm9WTlFOQU5FYW5IdWg2bWQ3aEVSejBpWWFBenUvZFlyZ3dqb0VqRmxz?=
 =?utf-8?B?NDNMZ01oTDlzQWtvTUtMZXJBQ1NwOEc2OGQySU5FMmpac3pOc3NYSTBsUjVB?=
 =?utf-8?B?R1ZXcFA0OTJGZU9TZENuQXlib29wcTRaWDdmUGVSSno1Z0xUYVV3eStUR1RZ?=
 =?utf-8?B?dnUrYzErZHZYUEQzU0pWMjVXU2xUbzZBMGUrMlg2b2d3Zk5iNEN0UFY2ck8w?=
 =?utf-8?B?WmZNMzNNMEdKb2s5ZStLRjRXeCs5K0JBMi8wbXZtdWxSb0xnNmMvNWs4MkRJ?=
 =?utf-8?B?QnBLUUxXRGpFWk9jazUyUmJxaVkyMEkvSmYzTDQ1QVNPSE1tUGVqM0ttZzNj?=
 =?utf-8?B?dVNBUUhybGRXQ0ZPMFNVM0Z3MTdKRzNORlRBVjROeTduWTU2Zjk2L0lLdnVB?=
 =?utf-8?B?WVNydzRnTlRDK1VBbEpLcnc4Ym1oZ0trL2QxNE1PTS8yU3lFSHZmd3JRTGgx?=
 =?utf-8?B?dDJ5Y3BkTkN5bjlibmN4b1JZSU9QZ2Nmd25lbFJTaUJSRDRocHM1WmhaT3NM?=
 =?utf-8?B?RloydFhtOVB4M0pySzJ5T1hYeERWbkU4WDJpQjk4c0pSTStzVGlMNnFQekJq?=
 =?utf-8?B?TTFZQTBBUWtLNE9QUG5ETXVVTWdaeWpUenhCek5DcTIySXA0VTBlN0xDTG8r?=
 =?utf-8?B?VjRGcXJSYk4yeVdnL3JtTFJUaitrb0ljbldjcTRCNEpLN2NMVldMRWo1cllD?=
 =?utf-8?B?NGxEeEhqTGJqUk1FOUU3TXpweGNkd0wyQXdRbTN0bVlJOTY5L0paOGNaQS9E?=
 =?utf-8?B?c2pLVmpJUmZSUU5MbG00K0dmdnUzNzJKbnNxSjgva2s2WFVGWVl3c2hDMlcr?=
 =?utf-8?B?eTJwb2RpYXlTTWN1eWVFVXk5M05RRzNDYmY0RGlsR0NmYVB3SlROLzlaZENM?=
 =?utf-8?B?NmtRbUQ2dVR4bDhJMEFvR1lpUWZzM0NiemJMbXFBM0VYd3FZMCt5aEM2bWFs?=
 =?utf-8?B?TURMRHFvKzh6elE2SG0rRzhLcGh5QUZybEFXWnZyZnJVRkhZUGtLRHliTExi?=
 =?utf-8?B?bkdHSE92eVE5clEwQktDLzVJZHNkSExOUllJSWJORC9rUVdBSzNCbkI5ZWFs?=
 =?utf-8?B?UlcySDhtNkpYU0VTaEczOExZMVFucUlUSmR0K3Qwa3ZaNVJOV0Y1c2x4M0sr?=
 =?utf-8?B?ZC9Ha2x3WC90MUhGWEI1eG1USys1Sy92QTRiZkNPS2tueU1vUVVGRXdTbjN1?=
 =?utf-8?B?RTZXTjk5RDFBdG8rY0I2SzA2MWdpWm9BNW9QMDU1RVlkZWloWitzdCtITHkw?=
 =?utf-8?B?S3NnQ0VZOENraHkrN2RVcWMxY2lIRHFvSXFiU3h3clV6UTM1NVRUR3h0dm5F?=
 =?utf-8?B?eVhLMXVMU3JIT2tqLzg0RGpaUTMvRFkwN0d6Z2NvWmZ3MU95aVF5YTZ4OXNL?=
 =?utf-8?B?aStXN3A0WjE1ZlR0OGNIY2JPMWo4VS9Kei84dkhoMVlXUXlWMXBleTJYU2NQ?=
 =?utf-8?Q?1qbxv4yEsEjo/4QhWE=3D?=
X-Microsoft-Antispam-Message-Info: qwK+ZaXRZkRFVVW4dtwNYYXu83hhhHeoQV7HVuHHq/bcRgKXJ/neQQEhX/sRUC5Ttj6ajeqgDU1Y2yuUO9cGLhM/hVQPvxGipsGU6FVD/Nk8Mb74palKvBDTWXZCdTYQGnOyNAPI8z0z2itc4fOHprNx5MxehFl4sPczh6Nm2Fe+U8HQtaxi5GYKHhFWLFRF
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:iSSz648lzjdZIo1RJ0WVP8NYDC7Bnc3k87N/40fupdaNbjDSs5gBsyNuugZm6zs35bvEw7b8VmhIpx4+sDjjO3vGi3xW+Ee4WlECbCiA92X1KZO1kZHJ7v8VplhhuaJqaSxfMHUTjrj7Tw/ePgrHbXQAcDx2aA2qzJ0Pw98XCaOhvFZ3ktyd1eUUhARglNBGhIYIMBMYS+fLd+186QHN1iYumXpKwTbIq3sXtAOXB7BLiKpa+sYHBDKnfK0B6n5EMU0/kL4YKIdE52wpkjDnWSWWJeyz9+BVgehM4tPnKoXFQSnkW8J9SAjDue5GJ0ZktaUj34jFtex5oORWwgPf2nQt2AuoFeSW74+qVzqs3p0wOIr55RUKH05xt/p61UGyA/cm42SGym3nYVelzUOOCJqIkubKjhqX0gr7JfWijSWo4djqbaN9lHiumht6YLM7ADkiOYnYC7/Nvsn3HLF/Ng==;5:dhj32rwl39gc7czoryn0KT52d/oWTCdV6i7RW3TUE6o+P0aCJNOzdywS1yMmIzboCG728By6q/tq0rKBv2CxgdBSUJfe31ouHBXrcUUKK2rtts+WRqLJjE+Icp1G7NDVQ3tNA8cJBG73Te5AQjHuMfTZgY7SxZLWc6zVeYMTdu4=;24:Q+F/bnJUwXb/Ybb2KajZLYViYZ/KdwiJm48m/olToAARCRw84ZZnY0Txaa8poLi8VyBRP+mG16FyuB/5TrwkQEy1xYA90v9c7daiw22nxt8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:tv36T2c9SLzg8K/CVP1+glwsz8Wj/30CHTPj7409hs35XMyyW8WElwmpCNo5/dygXzYhva0EtIRQbJA7yDHu/N5qcJOY7QwV/ySfFGUb3W6KzWO04iH7jCD6f6Aivd5LsArl5mdsg2H3YAKbpsd5bpU+ancJI7O9jIBHluj1TrdCBssPibs7zxJZ0w5hN86rExA22kMWYIg57OvP/ufboNWNG92RW4O7YlLH9j2GeAoPKQY2E1GFm/95abYmfweT
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 17:59:43.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 350a4810-5e56-4c5b-e761-08d598c3840b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-02 14:22, Boris Brezillon wrote:
> On Thu, 29 Mar 2018 16:27:12 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-03-29 15:44, Boris Brezillon wrote:
>>> On Thu, 29 Mar 2018 15:37:43 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>   
>>>> On 2018-03-29 15:33, Boris Brezillon wrote:  
>>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>     
>>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>>> the display problem for me.
>>>>>>
>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>> ---
>>>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>> @@ -129,6 +129,11 @@
>>>>>>  #define DEFAULT_TIMEOUT_MS			1000
>>>>>>  #define MIN_DMA_LEN				128
>>>>>>  
>>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>>> +
>>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);    
>>>>>
>>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>>> instead give an higher priority to HLCDC master using the bus matrix?    
>>>>
>>>> I don't know if it will be enough, but we sure can try. However, I have
>>>> no idea how to do that. I will happily test stuff though...  
>>>
>>> There's no interface to configure that from Linux, but you can try to
>>> tweak it with devmem and if that does the trick, maybe we can expose a
>>> way to configure that from Linux. For more details, see the "Bus Matrix
>>> (MATRIX)" section in Atmel datasheets.  
>>
>> I don't seem to succeed in changing the registers I think I need to change.
>> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
>> it.
> 
> You mean 0x4D415400, right? ("MAT0" != 0x4D415400).

Bits 1 through 7 do not matter, so even though not equal they are (or
should be) equivalent. But I did use 0x4d415400. I simply used the
shorter syntax since that was easier to type and conveyed the relevant
info.

>> But when I try to write to "Priority Registers B For Slaves" it doesn't
>> take, regardless of write protect mode.
> 
> Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?

No, but did it again and checked, see transcript below. BTW, how do I
know which master is in use for the LCD controller? 8 or 9? Both? And
which DDR slave is the target? 7, 8, 9 or 10? More than one?

Cheers,
Peter

# devmem2 0xffffede4 w
/dev/mem opened.
Memory mapped at address 0xb6f50000.
Value at address 0xFFFFEDE4 (0xb6f50de4): 0x0
# devmem2 0xffffede4 w 0x4d415401
/dev/mem opened.
Memory mapped at address 0xb6f0d000.
Value at address 0xFFFFEDE4 (0xb6f0dde4): 0x0
Written 0x4D415401; readback 0x4D415401
# devmem2 0xffffede4 w
/dev/mem opened.
Memory mapped at address 0xb6f55000.
Value at address 0xFFFFEDE4 (0xb6f55de4): 0x1
# devmem2 0xffffede4 w 0x4d415400
/dev/mem opened.
Memory mapped at address 0xb6fb5000.
Value at address 0xFFFFEDE4 (0xb6fb5de4): 0x1
Written 0x4D415400; readback 0x4D415400
# devmem2 0xffffede4 w
/dev/mem opened.
Memory mapped at address 0xb6fef000.
Value at address 0xFFFFEDE4 (0xb6fefde4): 0x0


# devmem2 0xffffede8 w
/dev/mem opened.
Memory mapped at address 0xb6fe9000.
Value at address 0xFFFFEDE8 (0xb6fe9de8): 0x0


# devmem2 0xffffecbc w
/dev/mem opened.
Memory mapped at address 0xb6ff0000.
Value at address 0xFFFFECBC (0xb6ff0cbc): 0x0
# devmem2 0xffffecbc w 0x33
/dev/mem opened.
Memory mapped at address 0xb6f79000.
Value at address 0xFFFFECBC (0xb6f79cbc): 0x0
Written 0x33; readback 0x33
# devmem2 0xffffecbc w
/dev/mem opened.
Memory mapped at address 0xb6efe000.
Value at address 0xFFFFECBC (0xb6efecbc): 0x0


# devmem2 0xffffede8 w
/dev/mem opened.
Memory mapped at address 0xb6f9e000.
Value at address 0xFFFFEDE8 (0xb6f9ede8): 0x0
