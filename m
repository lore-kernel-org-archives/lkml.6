Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755013AbeDCIOo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:14:44 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:46892
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754897AbeDCIOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:14:41 -0400
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Josh Wu <rainyfeeling@outlook.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d9da5ae4-68d0-df88-1214-f53f6b18d718@axentia.se>
 <20180403091522.1a498544@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8e5ad32e-f6fd-a8c1-8c04-7fc0d67dcc37@axentia.se>
Date: Tue, 3 Apr 2018 10:14:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403091522.1a498544@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR02CA0072.eurprd02.prod.outlook.com
 (2603:10a6:802:14::43) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3a701c7-9740-4f78-99bd-08d5993af0f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:8e6j56Nm0z3B9VEKu244MZN1s1Fy691zvjvvCgmSoMk7eY3q/2WUM18UhSKUhRo8sik1g69cfNRhP0ZsUp+vTASZXUSIK2z5vQvpbXyvyt5+84zBEsQ5tqh7EcSwhtY1s2swbjvsbVhdXdySJe7fWM7Mj1UZ0/GA7B+E5R7O1e1aS4vTjjBpBmbP2K2NMZqRkcObDgHFuGicmhEczWZ/zi8v6B5DQ5CDze4CcqBVmb4zNtVjAxLu+8TurEfQ4JRz;25:Ghzq3g4tzdNeJ0Q0qf/cY+vMlI8tsXIIPbq+04q5T4jPuF0eDV3DNE73dfAlzMvGdIqBNpQ52CltbN4ynvmwPG21w5137ygSNNhIcAYz0VFqWCy8JLMqHPKpEXht2xSfG1Mdj0pxB31BOQqh+tUi2sJaCcXCwm/icnitAj+CETEthKJ0iYwS+QCudxgU3YlNtzK7j9MTn7SSTzTU/DnqWE4OeBzQuz1H1zqhPGAYQQmzKCh/1bpMIPJ/fGlbG4Q7yeP3bMFK1nHDnyOcOmAqggBQhgODm7Z2CSa39tiai7dBMPzRn4ailkAA+Y2QGu5ln2F26CZ+eUS5UJaA1XmAHw==;31:c5N4N7S1lWlBjsNZH4qWmTROM+WEzJ/LfPiVR1NMoGhpTw4HvAgm2n6zLe/tqXkIP22L/q27x7Oc6ObsfPbdRngL7IxW8QgtuxGGKM4OAXaqyzhOXsULM6tPSsTB2z5z8pxpRZrm7xjXOna8qxk29O5/021dfoRP9bpccX5HMghhWZFvlzCzREGnx7dyIScHnYZsr9fjSIj8DRG3NRrfnLHTXQGINFq0e5xlDbiv1aQ=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27762B44CEB7D028EFAF056ABCA50@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:oH5/jkmFLP2wwneeCnej3HxnyhrYndQ6SBsENJZBZf2QViihW6KhpnKhYE0zoeo082kWuh2m7gXDvb+DUI7HbwmdsmWUYm0ouELka5NmEwUCLR7SdOMII5OaQVEXa/TZ/cPAZQfm9ots9hxZr+VbyIkZjIaP3tFZfEgcxSU/v0PplYT7bCGaACp7ShXhT1q4CIf3Ig5zG6DVVj1RLe3v1n5ETd5GnErtBDUI+ZMORAVoJpWnZ+6ZWgyalNYje9peTDnglPZy37kIKkeNtxbxKA==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(39830400003)(396003)(39380400002)(376002)(346002)(366004)(199004)(189003)(377424004)(117156002)(6116002)(53936002)(6666003)(65826007)(25786009)(7736002)(16576012)(54906003)(486005)(476003)(11346002)(8936002)(76176011)(2616005)(486005)(59450400001)(316002)(3260700006)(58126008)(6346003)(3846002)(52116002)(305945005)(956004)(64126003)(93886005)(53546011)(74482002)(36916002)(386003)(2906002)(23676004)(4326008)(50466002)(230700001)(2486003)(52146003)(65956001)(31686004)(6246003)(6916009)(39060400002)(446003)(77096007)(478600001)(106356001)(65806001)(26005)(8676002)(68736007)(81166006)(66066001)(6486002)(5660300001)(31696002)(47776003)(81156014)(36756003)(229853002)(105586002)(86362001)(97736004)(16526019)(7416002)(186003)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6UnF1UzN1WHgyVXZ3T3ZjQXhYYmwyd0F1?=
 =?utf-8?B?V3BFNFhvUFMwajlhS0k1aDNlUUViVk9kdU1VYUdWOEJGUTZ5SDdLckduTGZQ?=
 =?utf-8?B?Vjg0YXgvUUhxSTlpcGtTbWh2RkszZHVKZ1FRZFpCRUxScnJBZFo4S3ovY2Nh?=
 =?utf-8?B?SFJWZnlpRFZoRVJKVGtqbWZUamZMUkEyLzhQcUNqdk1iZGVoRmpIeU4rb3M1?=
 =?utf-8?B?UlhTZmI1SEFmZXdIV2JvR0g4YnhqdlF4SU5Hd2sybHBIcU03aUEzSUswdHhm?=
 =?utf-8?B?bnRBUjlNdGFPVStyMXFMdEJxcXM1RlJPTXVHeTVNWXYvYWFVak5tQU9PM2sz?=
 =?utf-8?B?OXo3ZTE3cjhCc2duT3I5V210MzA1N21tQUJnT2d1SnVXSDkxdmllWnNQSWFK?=
 =?utf-8?B?ck5aK3ppWWY4bVYwVkczeHBuRFdtbmZ6RUNGS0NkOHRqelFGMmFNQlhHbHRF?=
 =?utf-8?B?MHY1UjhYUXI5SXY2bHdxUWwxRExZSlBldStuVXJQZkVrcEsvSENiSm43b3Fx?=
 =?utf-8?B?U3BkeHdNd1p3RVN0dWtDNnI4WnROSnoyK0pPU1RhYjJocE14eWhwdEtISmwv?=
 =?utf-8?B?Z0lzMmVBN1hkcENhMktVVDZ0eDc2OFVreFlSempYNXhzMitVYzBqZTBwNUFj?=
 =?utf-8?B?Uk1TVmxCbFJVMFZzRVZPakRpV080TXJaMHFoSkNNR1Q5R1QzY3pEQXBYWXFD?=
 =?utf-8?B?V1dFNFJqU0dsSlYvcDdSZDdEaldUZ25JZDFaTml3R3RQaTVJVVdVVGgrSkpt?=
 =?utf-8?B?cS9RUzZkSzA3MndLOFdKWS82bDBhcENDOGdwby8zUnE4QmVRaERONGVsRlhj?=
 =?utf-8?B?K0h2d2pQd3B2aDAvMDZzT3UrQnBVUGVOQUViUTZkVHM0ZkJYSGt0cTR3dlg3?=
 =?utf-8?B?T3ZWNWQzdUpDRzdVa241WllUb2Z6ZXpJZ1c0alEzNXdCang0Q25ZekQwM3N4?=
 =?utf-8?B?R1N0dFFPNlh1R2sweDBzVkxMMlkzSUJTaTl1eERMN2NvbEhScmRTYmNDdDda?=
 =?utf-8?B?OXZ6c2tmNVBUVDM0YmR4Z0hVd256K0ZzNDFlMEM2TnowRGRWNGFQZ2NCanVi?=
 =?utf-8?B?VmFKbkhPT1RWb1V0S1FPTXJpR09nd1VUWFczWko4emFsZUhBYi9oYzJTcTRi?=
 =?utf-8?B?QWl2M2FMd1lYdDlqNDltVVJyaW4wNUFYMEVyOU9QUWs1Ynkya0NLQ3JiclR4?=
 =?utf-8?B?SEFEdmMwbERUMUxCM2NXSGhxYUNFTm4zUDdPNGJvdkk5U0JFOFAwa254Z2FH?=
 =?utf-8?B?QkU4aW01N1ZIVU9RRDRsRTZjU01mdzJZU1FYUkhaK2dOaXRPWkR4MVprMFVZ?=
 =?utf-8?B?UDg0MWd5SUpOejdWUTVqeUl6S09tOGxmVHJEQy9ZeTgxOU13Vzh2WURrVzhO?=
 =?utf-8?B?eUp1cDIwODFSSlpaN1FoTWlnT3hkRU9RYXIxZHJDRHNKSGlmMVlDa0I3VCsw?=
 =?utf-8?B?NCswcjlza1hEN29zQmN4UHF4OVJDNGhHRnRNYkFJeHlOSjFlZ0lnT2d5QjAx?=
 =?utf-8?B?NTNmYW9xWUZJd2NDNW9hWFRuVUM2MEJXU2tqS0FIV0YxTmMzdmJOckpoSUhX?=
 =?utf-8?B?T2pNTStYdFE1d0NPUm1zRTNEYkdYK0pnMWFtVWc4ODQ1WmRSME9xUEFiaG9l?=
 =?utf-8?B?eGVldVNCM3VVeitUNzl0RWNRZkNwRzhpalNWK090M1VLcGVqRnM2THpyNERn?=
 =?utf-8?B?QjZETFhPMU84ell3ZFdtM1h2UHNDTmp6RHpTcnk3aGQrNTd3UEtmdDRhMyto?=
 =?utf-8?B?QlU2U1BsWmNlOXRlOGdKSmJVQm9nN2J3Y0ZKUkRtTUZJNVNiRG13eW5xVGdJ?=
 =?utf-8?B?L2FxQVBIeU4vblBpempYc3J0U09ZN2syeDRUaDI2WXJ3Y29OVUVzUVdzd0s1?=
 =?utf-8?B?N0V2cFovTnBWb0N5T3VmUG9KNmhZS2NiUTdyR2VOZlhSOGJWSU5hN0xoU2Iw?=
 =?utf-8?B?REZ5aG5SVWJNM0JYZ1NDVjRlMmViK1A4OFo1VmdMSU4zUnVjRW9Hai9xR25X?=
 =?utf-8?B?Z0gxbzUrZ3BqSnlObHdaa1pyT1hmR2crQjViK2Y5TVkvMnZRclhwNXF0TCsv?=
 =?utf-8?B?WEdJNVZaek4zMmtoWDBudFc0a3NmMUd0MnN0Mk0wQnVucWlvaFlVRGNOUXlt?=
 =?utf-8?B?blVlZ3dpOStvdk9FZ1JmN21hM2pWYm9wdjFGS2JXdXBlMHh6S3RyWU9jQVZD?=
 =?utf-8?B?TTNZaW1HTHhIUFpvNTV0cTNEWXY4ZEEyKzFuVWFHSERyWGRnTHlJZjhDM3lS?=
 =?utf-8?B?Y3Fydm1HVERjdkhPSk1BNnVHY1QvQjlsb0pBYmxsd09QWHAxdGNaWm5BbG9n?=
 =?utf-8?B?QThYVUwxc3VodFEzV2w5OWRrM25PRmNNUU1FUGQzdXdIbk1MdWY4N3MySVh3?=
 =?utf-8?B?cVJTVU1vQnlKVGhlSEdrUTZ4c0hIWXhFWFVJWXlSekJQYkR4OG04ckRRRXYr?=
 =?utf-8?Q?fssmUHWnz/zSM?=
X-Microsoft-Antispam-Message-Info: 0ON8AKOrGjG7DBKdWmOTcA9BFwEFlgw8gRqrkxshlDFO98UFhDIV5wQ5S6lDerbbfXqC8g28wRHkBfi1TGzdNaWSfcSQ9X1dRwUbfXMnp8Y7l7NG22JyjAQYiFSX7N8lZV/KBrJM0tllQNtvX0KvOPZJ+Y0fmbNlbE9BmzZLYaSVLUM2dSUtkxvpKGurkCBz
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:lxCeixAxBCRIj+x4OXwPUAM0tw4N3r7Y0EsUxKW9OQ2aI6Fajc0V5eYs43DR0M0qI58WtBSGmAMidS2znBnFZ3J2WVO4xu6wMPpwjRDtfhGGiFDhehm7cws5xJljqq6z5c3woihdQoeprNMxacMefWtmn/jjrp1ZjmQWhl3lER84iH7YN17CPhcRk1sMxOBF6DmO/7Bjo1eXIQAYmVmheaFnuzu28rZhaDNmmI7iWtX3RC6qudpI9UHOhB1yWALGDPmVFfJnfLWn/b/W2K7zGc48IC+LqbtiIKiqZvHUkcTQN2Zi1NlQsQXsGHMDkK/v7U5K6Y/D4ZRUkiintEw1FbwC3fA9X/snkoNOpMarfJDPZi3AiHieAs27bu11I7Qsxj96D9sc9OeRMF8T/w50n5lrfNpgQfruw57l7yr514F5oU1XRoySgfGjbQ8fqrIpCC2QpA6oeHmlbW5NAE2+eg==;5:xLsu4bE0iQlEtgf6ZuuG103YmBrQhwwnnicaefh/5yzvgTxk2EjhEIvVoXrbNc7dVNF6QyAA1JQISuDa2VjP+AfxyR9ZKYlFlCy1juUfzaAZK4BFfXTuaD1/4Ucy0gzc1shyvqO+GU5Qp0lK22yHFpiiciorP6188kXE2+T/GU8=;24:V+Kie6wxMHn1cKDueqUmLpOgtUjfsSwuI2nUD9L9TQX2+/3aGZEBSR4nPq+2fpzzyjDHSkZPj8b6HoNlQ3+vjLY9deIDuz6h2D8tQAzA5M4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:naz9iX4ZwMmp89TL8CE/Pmu7y0YAOuUCP5OBTTXxd7qryKQyoyP8g1jiHxgda04lUj03zaUxl8JEPFJrZ74ttr0Chl9FUGGbR0UQLffcN/ddwEHIk1jKVj3h7zAcx3m6X9vxI37zU/8jnqwdp0qHwwLuF6P13qdGizyp4Q5L30sy8x0PeHUgkzm6aNauiKmyTy6kO7QTaAMoQr5ahXlxHCjKTe2zH3iDzMsCKBXClk2r7tVze7GF+QRlJos1DEBp
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 08:14:35.9902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a701c7-9740-4f78-99bd-08d5993af0f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-03 09:15, Boris Brezillon wrote:
> On Tue, 3 Apr 2018 08:51:10 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-04-02 22:20, Boris Brezillon wrote:
>>> On Mon, 2 Apr 2018 21:28:43 +0200
>>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>>   
>>>> On Mon, 2 Apr 2018 19:59:39 +0200
>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>  
>>>>> On 2018-04-02 14:22, Boris Brezillon wrote:    
>>>>>> On Thu, 29 Mar 2018 16:27:12 +0200
>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>       
>>>>>>> On 2018-03-29 15:44, Boris Brezillon wrote:      
>>>>>>>> On Thu, 29 Mar 2018 15:37:43 +0200
>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>         
>>>>>>>>> On 2018-03-29 15:33, Boris Brezillon wrote:        
>>>>>>>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>>>           
>>>>>>>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>>>>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>>>>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>>>>>>>> the display problem for me.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>>>>> ---
>>>>>>>>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>>>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>>>>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>> @@ -129,6 +129,11 @@
>>>>>>>>>>>  #define DEFAULT_TIMEOUT_MS			1000
>>>>>>>>>>>  #define MIN_DMA_LEN				128
>>>>>>>>>>>  
>>>>>>>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>>>>>>>> +
>>>>>>>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>>>>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);          
>>>>>>>>>>
>>>>>>>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>>>>>>>> instead give an higher priority to HLCDC master using the bus matrix?          
>>>>>>>>>
>>>>>>>>> I don't know if it will be enough, but we sure can try. However, I have
>>>>>>>>> no idea how to do that. I will happily test stuff though...        
>>>>>>>>
>>>>>>>> There's no interface to configure that from Linux, but you can try to
>>>>>>>> tweak it with devmem and if that does the trick, maybe we can expose a
>>>>>>>> way to configure that from Linux. For more details, see the "Bus Matrix
>>>>>>>> (MATRIX)" section in Atmel datasheets.        
>>>>>>>
>>>>>>> I don't seem to succeed in changing the registers I think I need to change.
>>>>>>> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
>>>>>>> it.      
>>>>>>
>>>>>> You mean 0x4D415400, right? ("MAT0" != 0x4D415400).      
>>>>>
>>>>> Bits 1 through 7 do not matter, so even though not equal they are (or
>>>>> should be) equivalent. But I did use 0x4d415400. I simply used the
>>>>> shorter syntax since that was easier to type and conveyed the relevant
>>>>> info.    
>>>>
>>>> Ok.
>>>>  
>>>>>     
>>>>>>> But when I try to write to "Priority Registers B For Slaves" it doesn't
>>>>>>> take, regardless of write protect mode.      
>>>>>>
>>>>>> Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?      
>>>>>
>>>>> No, but did it again and checked, see transcript below.    
>>>>
>>>> I don't use devmem2. Is 'readback' information accurate or is it
>>>> always what's been written? Because when you write 0x33 to 0xFFFFECBC,
>>>> 0x33 is read back, but just after that, when you read it again it's 0.
>>>>  
>>>>> BTW, how do I
>>>>> know which master is in use for the LCD controller? 8 or 9? Both?    
>>>>
>>>> It's configurable on a per-layer basis through the SIF bit in
>>>> LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
>>>> masters [1].
>>>>  
>>>>> And
>>>>> which DDR slave is the target? 7, 8, 9 or 10? More than one?    
>>>>
>>>> This, I don't know. I guess all of them can be used.  
>>>
>>> Looks like I was wrong. According to "Table 15-3. SAMA5D3 Master to
>>> Slave Access", LCDC port 0 can only access DDR port 2 and LCDC port 1
>>> can only access DDR port 3.
>>>
>>> Can you try to write 0x3 to 0xFFFFECCC and 0x30 to 0xFFFFECD4?  
>>
>> Given the matrix dump in the other mail, it is not surprising that I
>> can't. But if I change the matrix from the default
>>
>>  0 33--3--3--3333--
>>  1 33--3--3--3333--
>>  2 33--------------
>>  3 -3--------333---
>>  4 33--------------
>>  5 3---------------
>>  6 33--33-33333333-
>>  7 --3-3--3--------
>>  8 -3---3--3--3----
>>  9 --3-3--3-33-333-
>> 10 3--3------------
>> 11 3-----3---------
>> 12 ----------------
>> 13 ----------------
>> 14 ----------------
>> 15 ----------------
> 
> Is it really the default? I thought all entries were set to 0 by
> default.

Yes, the datasheet claims 0 to be the reset default, but there is
a note in my datasheet that "Values in the Bus Matrix Priority
Registers are product dependent". I was referring to what I see
with devmem2 from the shell directly after boot. I have no idea
where the threes are coming from; they could be reset default or
from some loop somewhere that simply tries to write the highest
priority everywhere, but that the write then only sticks in the
allowed entries.

BTW, the sanity of everybody screaming "I'm super-important" is
a bit questionable...

Cheers,
Peter
