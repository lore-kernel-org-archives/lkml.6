Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeDCGvT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:51:19 -0400
Received: from mail-db5eur01on0095.outbound.protection.outlook.com ([104.47.2.95]:21440
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754808AbeDCGvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:51:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d9da5ae4-68d0-df88-1214-f53f6b18d718@axentia.se>
Date: Tue, 3 Apr 2018 08:51:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402222020.1d344c14@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::18) To DB6PR0202MB2773.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e4aa68-3b12-48d7-5af4-08d5992f4afc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;3:2ZdYf5kBXDKibLyckoI66lYaItxwMzAnG8Q5Upz0XI9et+Utoxr6jOKQ+ix8yfN8bmj8X5VF79BqudFivePcfvSyH4uJUen2wRu6Bxw4OXl8iqLUKvweC7CUOb4aW2rDnSdNJnPgZBGeo0FB8jk8V7ENcdfEi8hm/UDHGdTwveTpdMRRYg7Sb3fB2hlSiQkOQFyrWig5Fr5oaPwNcOZoYbcs+ZH2HARVKZroR6abbYW/lVq9Uh/Mb/xavOI0MOBc;25:SvzDMLScOt9m8QLGyNzsLgobK743jODAcYThcyux20eMHbbc1+5vPv6HT6MsenvN6kyaSCU2SyNPqz6XmohX/8A9Ja3XM/I7cCOz8iO7MmfCIDPSdqOGGXmi52e1wT3XFbSnbGgN2Mvr4TIUA2P8Qdto5sxN/JF7uBc0sKmykai1K5uIzOlIUNXPZcBtQmcfnTySyJdKT710H1AQx2nymdrHxmhWKf15lT4xA1FvhhqxdIoFOwRaVkw5wdoV15JFithDStYp+UN2+eE5WsvowUyEwKuHpEWURT3Vo341RmvFkNVejfPMupmVRNZZ/aOCs2fgQ6I7i85ZO6e7MKue3Q==;31:NPVBeUH6FTfYIgcURUKpLvmoAhiq8j8y/RjKolxRn2FiEcCmcmudZ+J6j8yYzyf3vlPuxrAIb1Uei8ARA/OPLqM0EGp+Bh5d5ZAOg8x2+2KbLxN0EOal/tLq8LyOndcZpmmKHiA2p1phdRzk2H20/0eIs9dwkmWAV0jFORTJazp6DAfXTn+8Ipv3f1X+Xsv2MYkGDZUd79jJQd2lEBf+LdfknujdNk9bWS6zlfgZ/ww=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2773:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2773AFBAC58779F5F95ABABFBCA50@DB6PR0202MB2773.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2773;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;4:4wVlRUXNwqo8oW3/NVKhgUs8IAoTw+x2sFF8CvyvWQo22NP63zkdR1tPEI9uDLEJH94NhDcLHcMzOG2tmuMGsb/iHB0oCcgp4xrYn46VWgmqtsjGGu2gJ+HubY7EBJrajGZOn5QlgxbQFSFnURhbd/YivxsqizjBydWf7XM1Q9S6UJsOdvVrTXNn3pEhCnu3QEcCZGbklybhGanQgKpy2104TIuX9JAG4Img45fivE2vFVKt5ZETE3RKC9D4gyrkS5QXuAoZ2CiSzdc9KmRI8Q==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(346002)(376002)(39830400003)(39380400002)(366004)(377424004)(189003)(199004)(186003)(230700001)(229853002)(77096007)(31686004)(58126008)(105586002)(54906003)(8936002)(478600001)(25786009)(4326008)(93886005)(3260700006)(305945005)(50466002)(97736004)(16526019)(106356001)(31696002)(7736002)(316002)(53546011)(117156002)(16576012)(68736007)(386003)(59450400001)(39060400002)(47776003)(8676002)(64126003)(81166006)(65956001)(36756003)(65806001)(81156014)(36916002)(956004)(2616005)(7416002)(74482002)(3846002)(66066001)(2906002)(11346002)(86362001)(6916009)(26005)(476003)(52116002)(486005)(76176011)(5660300001)(486005)(53936002)(23676004)(446003)(6246003)(52146003)(6486002)(6116002)(2486003)(65826007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2773;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzM7MjM6cE05VHQ1V3JsVU5kRytSMG1SMEhjRjhw?=
 =?utf-8?B?bXlDaDVoL25DQzk3aGdaeGhhWjVyNFJ6aHNCY2IrS2NLc0NuWEZVMG5WenNx?=
 =?utf-8?B?aUZqZk9uNGRZMnhmNmFyNFprMkd3U2xMWHlyMFlydk5hTGdEMjl3elNhRFh3?=
 =?utf-8?B?L21MclVYeG95M2h4SEtScjRVYjdnQTcwbFpiYzBQMUUydFVTQ1pYOEVLSitw?=
 =?utf-8?B?dHNPeU1lSk1BYXVIMW5mNnY0U0M2bHlNSVYra3dFUWRtUkNHaXZWdkRaeFlj?=
 =?utf-8?B?V1NvSDZ1aS9KL3UvSzJ2Z0MwdTA4RnYrUTN1bllBYzNiNGJlcVRGL1Q5ekpx?=
 =?utf-8?B?ZXpQZ3NKYTJaMG1jQ2hoT2xUNnFtMHlZNFErcGkxdEdtenl2WjZTR3NnWFRD?=
 =?utf-8?B?dFNkWGJOSDBlSGZkdkNYeDhWWG9DT1E3K0JvZE9OU3NuMFJQam9OblZNcjU4?=
 =?utf-8?B?R0UwR3RzMVMvR3NIV1Npc2FldTJBNVBWMUdURXlDRE4wdXNJMm1FVFVmR2dE?=
 =?utf-8?B?SWF6MVQxRFhkV05kRmM2YUZUU1NiSks2eWRxczhZdWVDakx5Q0tad2IvQ2da?=
 =?utf-8?B?QUVORnVsOFYvTTlLeUtOTGN3Z1IvV0dMUXZIZjdoS045ZFVsWlYwWVpMSW16?=
 =?utf-8?B?RzFVdTVLZ3UveWIzbC9FOXo0T1UvT01YVDY5N0lYRVdYSUpQWFJ0Q0xvRXdV?=
 =?utf-8?B?UjhUUDVqKytiTlFXOEtaclJLNUdkck96UjVsUFBIZVN6ODZTSDVQU3ZobXNs?=
 =?utf-8?B?SERWRVBUL0pSYXdGeFJZeWdlU2FVV0hycGRzcktNOGh5V29wYXlMcGU3ckJ2?=
 =?utf-8?B?czNObTR3VEZwM2lGZ0Z5Unl3ejlsSi8vcFpXdnQzSndhb1hTVE5kazdTT01o?=
 =?utf-8?B?Y0lsWWdBZytCM3d2S2VUMkVSZ0MzZkpDMmVZdnR1V0YxNmd4VmlvWHdOL2FI?=
 =?utf-8?B?c214SHNHcm5tSDgvbmhBVkM4OWkxQ0JoMzAwZE1XbVd0bzVmZzZtSHZXUGlx?=
 =?utf-8?B?L3dva2swWGxRUmEyUSt5MTZSWml1Rk5kaDBjTERYaktENjZrbTNDQjc2SEMx?=
 =?utf-8?B?Vkc2WVhUNGZzclRML0hoeE9nbWI5RVJ3a3lHVHJMSmRRN1RMbGRCQ0xaMnhl?=
 =?utf-8?B?UVBpalR1eStEeE9uZktBYTZBblkveU9iT0lINStaZjhXRE96RnBPbnozQlBM?=
 =?utf-8?B?emhvRUNiT3BoRTMrb1ZLVDhJOHNUc1VLNW93bkwvQ0ZrV2NHaEozVVIvMnBh?=
 =?utf-8?B?U2ZMNmVxOG56TzlaODdudVVLREtNSXFXMlJLaVVDMXp5ODk0OGFPRU5weHpI?=
 =?utf-8?B?bjVWd1FWMUsrV2RhTTNJSm5IaXY2TG5jL0I5SXdzM0diVzRxbmVQTjJNV0wx?=
 =?utf-8?B?Tm9abW8vbUQ1U2VnNTluU2piQVdEcnQ2ZDUyYWhIVmVhaFQwZUhQTkZHTFdR?=
 =?utf-8?B?NTNOcWQ2RkFMZ0toS00yY0NwRkxOdkNXcjVDZU51RWRkTVd1eVBDQVA1Ujhs?=
 =?utf-8?B?TndjWDBGMVFEV2xiT2g1QmhzQ2tkUDhzOGg1SzdNdEljVWhWSThCN1V6V2dE?=
 =?utf-8?B?enJqbzdkMnNicmlLL1BMalRzekdQS3R2b2pjbjBjU0I4NnZpS3dhcjJWc2Nn?=
 =?utf-8?B?Z01UdFd2djQ4c2Y5UmRvSWtjWHRwbmtFZTFUYkRwQ011TVhZWWU1aE5Pd0RK?=
 =?utf-8?B?SlFsVzBBTnFNTkY1RnRYUWJWNVhXNTJwQjV1UzJDdVNXVHBUMzNiUmRnZ2xV?=
 =?utf-8?B?Sno1ZUxzS2R2eTRyZGlyWmNseWZ4QnY3akEzaFlFUjdVU0xtYjRoR3BnQ05H?=
 =?utf-8?B?ekc5dXdwY3k1WkhJeWJNNzE0M3BZQUgwMmcvaHQ4b3hnOWZaejU1R3pYKzZF?=
 =?utf-8?B?bUx1MEdHUkVTMmZHZ2JvcmYvbi9BUTB3eUpPRVdZMDdEbWMvc1FzNXRjYktv?=
 =?utf-8?B?d2dhMGNtK2ZQNW9HS2FnNFlqR0djWk51TmpFWU05bEZwMFRidUJNeXJ1cnN4?=
 =?utf-8?B?T0ZzYW9aTnZaNTVSbzBmS0l0ZmJGL3Z4MndUN0pFdDlDdGd2ZzF5MXA5QkFJ?=
 =?utf-8?B?WGVRbWpScHkydXFlNWZhaU9PNUc4dTlUT0hwaE5jSWo0OFRwN1NCT3d4VDdu?=
 =?utf-8?B?bUp0d3dUQWszNVNlQXhPYzNSZXF3QjNMT1J4S2hJVExybnp6Ui9xM0ZhU1I1?=
 =?utf-8?B?S0x0bWVweVdTbzcxVHk3VEUrd3ZNNDViZUt5WW92M3BHS1h1VGNNb1dodjhG?=
 =?utf-8?Q?/WIklv6JUfGrYaimznPQ?=
X-Microsoft-Antispam-Message-Info: jFrRtL0WBERouUpLm9dZI+jkBpvGs/NbCxg3X63n/uasMRSOBCBCJ9QQg8tMQlgsXkqwppelUlwEfuTKdX2RlBjVBZwsYRZlwVguUBiU80M9NtfjiCug1XnYWYpLV87h4GbfZUPXGXhxx/e1XU049CHPaX/JW7RImVx0hc8rPgCnVFGYC6rz2hX1jPY5Fj3g
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;6:iBtqAFcLdNdaDmYu+kMK2oulT9BdYqQ06SuWJLfbZ+huPLlX9A/zS4pkIYSh7kf7pjkZ+Bf6iPanmuEsZcK8RaUKRh4DBqIi74cB4s5/cPGw7b2aLbZEyB0RjFHNwwexCLTKoNlgBRV8X375uevdr55E/ocAg7XFivW/i61g2D7Rnl3cZ7EZC5fnOVxg/n21mh6ITGRCFMTTWh8EiBdy7RonoELM9VgNgs8SFtYpsAqlnMruUtkgVTQzy0GVe+V3PJtMRkaJ2DYwIy70yr6RGNYFVh0SQinnJQcr70hs52SR3WPLpcGKnLcP5feSJZ+ylZ1sGrEqj+7Y2nKJ9Z0boeQYnLZolTMQoTgpHIbmQxKyicA0/FB3t+u2pxaNuD6jpE2cU61GKqoH7uipjXDVMujSl9u22Tpr6K0LvbHJtqplBrbyRqXROCq9LMKgg8kspa2dYClILeIfyqwiOKJQtg==;5:el97siDBmje/IMPIr/jGik4H7l7VBDumUp3xT3y6k2wlqXXDV4N3QKz2Uwb+x9/+vRWAFU+G1bO+Hu583XCzU4srcJN+vHjQlytFD+P9AaCXolA/WqOkh7Ai+fNvvNJlxA5MZI+HrVf8lSZ78dFRNApb2POkTdYPglz6TRFkFn8=;24:ONB1PLqquF5uWGtBSpQ0PqhWpgt7gImSLQBKtBGPuUVl8PwK8GTeDt9OGiMzbpVlIBt/XlVHUxhl1UrMz0DlmvlvyVpdWR1yFppmiYtilEs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;7:5cOXghcUa9Ey5vB9hLeKW/kcT8TytWWDd20st2h4zPiIXOfmkAPTYtyL5Qre6ttG8qREkWZKUoC2oadm5at7g1TJGSUBzJQzyPgpB4LYss8rP9WX0OeBIto3wiFDgpu1hNd6YgWGJM29GyVoZq+245jW3lgp3to1vdi57VE6yjE9ij0kHRkHldu5EDvYaAiPX8SPm98J2gF8+zR6XBqHkl/c/2bJRtoF5/iwzPGp/zcT8JGB0baxTNCjN1Qd0Uko
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 06:51:13.6014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e4aa68-3b12-48d7-5af4-08d5992f4afc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2773
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-02 22:20, Boris Brezillon wrote:
> On Mon, 2 Apr 2018 21:28:43 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> On Mon, 2 Apr 2018 19:59:39 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> On 2018-04-02 14:22, Boris Brezillon wrote:  
>>>> On Thu, 29 Mar 2018 16:27:12 +0200
>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>     
>>>>> On 2018-03-29 15:44, Boris Brezillon wrote:    
>>>>>> On Thu, 29 Mar 2018 15:37:43 +0200
>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>       
>>>>>>> On 2018-03-29 15:33, Boris Brezillon wrote:      
>>>>>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>         
>>>>>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>>>>>> the display problem for me.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>>> ---
>>>>>>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>> @@ -129,6 +129,11 @@
>>>>>>>>>  #define DEFAULT_TIMEOUT_MS			1000
>>>>>>>>>  #define MIN_DMA_LEN				128
>>>>>>>>>  
>>>>>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>>>>>> +
>>>>>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);        
>>>>>>>>
>>>>>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>>>>>> instead give an higher priority to HLCDC master using the bus matrix?        
>>>>>>>
>>>>>>> I don't know if it will be enough, but we sure can try. However, I have
>>>>>>> no idea how to do that. I will happily test stuff though...      
>>>>>>
>>>>>> There's no interface to configure that from Linux, but you can try to
>>>>>> tweak it with devmem and if that does the trick, maybe we can expose a
>>>>>> way to configure that from Linux. For more details, see the "Bus Matrix
>>>>>> (MATRIX)" section in Atmel datasheets.      
>>>>>
>>>>> I don't seem to succeed in changing the registers I think I need to change.
>>>>> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
>>>>> it.    
>>>>
>>>> You mean 0x4D415400, right? ("MAT0" != 0x4D415400).    
>>>
>>> Bits 1 through 7 do not matter, so even though not equal they are (or
>>> should be) equivalent. But I did use 0x4d415400. I simply used the
>>> shorter syntax since that was easier to type and conveyed the relevant
>>> info.  
>>
>> Ok.
>>
>>>   
>>>>> But when I try to write to "Priority Registers B For Slaves" it doesn't
>>>>> take, regardless of write protect mode.    
>>>>
>>>> Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?    
>>>
>>> No, but did it again and checked, see transcript below.  
>>
>> I don't use devmem2. Is 'readback' information accurate or is it
>> always what's been written? Because when you write 0x33 to 0xFFFFECBC,
>> 0x33 is read back, but just after that, when you read it again it's 0.
>>
>>> BTW, how do I
>>> know which master is in use for the LCD controller? 8 or 9? Both?  
>>
>> It's configurable on a per-layer basis through the SIF bit in
>> LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
>> masters [1].
>>
>>> And
>>> which DDR slave is the target? 7, 8, 9 or 10? More than one?  
>>
>> This, I don't know. I guess all of them can be used.
> 
> Looks like I was wrong. According to "Table 15-3. SAMA5D3 Master to
> Slave Access", LCDC port 0 can only access DDR port 2 and LCDC port 1
> can only access DDR port 3.
> 
> Can you try to write 0x3 to 0xFFFFECCC and 0x30 to 0xFFFFECD4?

Given the matrix dump in the other mail, it is not surprising that I
can't. But if I change the matrix from the default

 0 33--3--3--3333--
 1 33--3--3--3333--
 2 33--------------
 3 -3--------333---
 4 33--------------
 5 3---------------
 6 33--33-33333333-
 7 --3-3--3--------
 8 -3---3--3--3----
 9 --3-3--3-33-333-
10 3--3------------
11 3-----3---------
12 ----------------
13 ----------------
14 ----------------
15 ----------------

to

 0 33--3--3--3333--
 1 33--3--3--3333--
 2 33--------------
 3 -3--------333---
 4 33--------------
 5 3---------------
 6 33--33-33333333-
 7 --1-1--3--------
 8 -1---1--3--3----
 9 --1-1--3-33-333-
10 3--3------------
11 3-----3---------
12 ----------------
13 ----------------
14 ----------------
15 ----------------

which I *think* is reducing the prio of accesses from all DMAC masters
to all DDR slaves, and then change the ULBT to 1 (SINGLE) for all
six DMAC masters, I still get the same display disturbances on nand
accesses. And I can't seem to tweak the LQOSENx bits, at least not for
the DMAC/DDR case.

Cheers,
Peter
