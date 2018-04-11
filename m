Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDKOo1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:44:27 -0400
Received: from mail-ve1eur01on0100.outbound.protection.outlook.com ([104.47.1.100]:34822
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752664AbeDKOoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:44:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Josh Wu <rainyfeeling@outlook.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
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
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
Date: Wed, 11 Apr 2018 16:44:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403091813.5fb5c18c@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0101CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::37) To AM4PR0202MB2771.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;3:PAKHoSkkE8pOsAV/NfVILIxD7NnDZR+LJ8C09PqH/D3WLfYfeCFpEnm3RI20pFtx2uwXaDm+mqhvppt4b3b0eFQCMUaEEKdMPT53QmB4pXQYaGy7V0jSmHWBTcMPczkvrEutQk4QkTBlPIScDCTSah0Gt0WfhZwJWcYc12sSCh/pSWX+yyhxwl1QlZsdZidv2d/FxuPrXRODDWZqpg5BfdfTZsWljAV/8us3Cg0O/G4+wFgjmPPRoKo16/ezRdc/;25:Hp5WI45poLR+gLYUp/tA9n+SBpPAO0vDmv9eo3Cd2HpzfKetvf66nd12W+7M9zPq17sTS8ZLLFW1x6pcgYOE4+qmrZqZ+lOUCTnA7N7C5xDGW60iJs2zqBoKzIwiWqN42FpEipjs5I9/y9PkrV/1Q3GrVh+QyAt1anw4Y1TDYu+0vLVo3SYTGEU9ixtKTZqHVHd+9R6iptxf98/VABISQVIn2gkkz5gUpUmykGnhFITkxaQ87sPRNO9RKgDmqIJsb7jCFDW8/arvlH9yjf6RlC0qOgsH5a2KXztG3xzHfhH8Wv3M1jlJp9R0UW8Tr2PubuRZmnHZVtaO4bFpd+qIPw==;31:D8UeTI4klILjAnEQ8Pvhsq155Ap/rL6JomYJhv3TwEwGwIiXTqFQW1WSu8RBs+fFWiVXJdiRxMjTc7RqJYKAg1LXAjwp2R14l18UqanyYKUvc6R27a6+/lOgsqz/3RzDvrGKdb8Gbw2V0lA0p37ETBuszRO0usZem2tX6yKtVfyI84j2KC8Jhc+5IBX6TVI20MYBOuIEkyBbjjtqew8tunUfbH4416h34DeCoZK+UIA=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2771:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2771E19D5BB37A9AFC69EAC9BCBD0@AM4PR0202MB2771.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;4:+r+nOoT84rFB8wAEl2qR3bPFVLsaxwKFngLcbiMc5A0PtJG1AGs4kZ8AVNG9V/m0LYi1q6+Z2Nzuj16AypuU22kHKlc5JrJrV0wC5vviGZCF8Xc/iZolBYHEYu4XOJVQ2CVG/7cwJJ6rGcf2y8oIERrV41NxreiSpXfMPydDyutK6+z4v85gRbUQ/9HI1BZ6bNrw480VczpY1+UrArV/JZXQs5B4XTfB+DMf1MZTTkgOWZaXrWme+2XV7o8YQJaN40/Yum7DWpZpPUPgPqdAbQ==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39380400002)(39840400004)(376002)(366004)(377424004)(189003)(199004)(61684003)(8676002)(81166006)(66066001)(8936002)(4326008)(65956001)(81156014)(65806001)(3846002)(6116002)(47776003)(31696002)(53936002)(6246003)(230700001)(86362001)(486006)(478600001)(39060400002)(3260700006)(25786009)(117156002)(446003)(476003)(11346002)(2616005)(956004)(65826007)(2906002)(6486002)(64126003)(26005)(77096007)(16526019)(186003)(105586002)(53546011)(54906003)(59450400001)(93886005)(6916009)(6666003)(76176011)(229853002)(2486003)(316002)(31686004)(52116002)(36916002)(97736004)(52146003)(23676004)(5660300001)(386003)(58126008)(16576012)(74482002)(36756003)(7736002)(305945005)(7416002)(50466002)(68736007)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2771;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzE7MjM6OW1EMVowYTdqTnQ5V2NDZ3haS3FYTDJC?=
 =?utf-8?B?b3I2UW9xRE1tbHBoOGtwRUo4OVdSYkNvTUZCVWpzVzNWU01VU0NJUEZhRytX?=
 =?utf-8?B?enhaWEF6d3BlR1QwYU1MT3FKdG8vOEUzT21MdCtONzNDOTdnbm1qMFIvWkRn?=
 =?utf-8?B?dUtuK3lEVi9KaHJsQXQ5UGJvTERkM3V4OVJ0cjZOLzVhVlE3ZDNPQ0xIclBh?=
 =?utf-8?B?S0JJZ29OSGZBSW1oOUYxTlMzdURlSHVIRGd3Zk1PRURYNW5VZWxLNVh4ODZZ?=
 =?utf-8?B?QkI3bzRpSDBVeDZOV2pUYnVvUzRYTEg2SG5DS1dabEt4ejJpUCtObDBsbVY4?=
 =?utf-8?B?b0x1cjNwVDYxcUZzZXF3Z0ZPdmNGMFBURFF3dHNDWFJVUmt5YmlnNllZSi9r?=
 =?utf-8?B?d0J4SnZtSEQzalF4RUt3U0VMRGRMNjBKUzRvQjhyNm1XQTQ5SUExdkFLb1c4?=
 =?utf-8?B?eURjaS9lOFhJV3dzYkV4aHFQcVB0VjRhTGZDM3J5NFR1OGtoMXZtVVQ4T2ZI?=
 =?utf-8?B?c0xIQlV4QzVsbzVQWmFKTFBHVlBoZjF3OGpIZnY1Q0R6YTdEcXJCWmFaTzZQ?=
 =?utf-8?B?b0ErdzFGYXQxeWRJQUtmcWlVWEk0VktuekRYdnRtcEtpSmRsTDR4YzVKWVZH?=
 =?utf-8?B?N0FyREU1WWtUQTJWRVpscEtQVzFzZkV1WGtaazE0RWlpejZtZWJUVURiZDRu?=
 =?utf-8?B?ckxIYmNhaWQ5UWNtSUVSZFZEdlFDNzNIMytTclJLRk96Mmw4cHN5UnlUSHpT?=
 =?utf-8?B?dHc4Rksrcy9ESVRyUk1wSWNFWFdyVWNGUFZ6VEk5V2xneVRJcmdsejFhNjNT?=
 =?utf-8?B?WWNSL0xiTUJNRU0wcDRlODgxZGVwNmI2ZkRLWkZiR3laemxjWGptNlJhSFAy?=
 =?utf-8?B?dXhhS2dGWUhzYk1mN2ZGSlo2ZlRxbDZJcnJxOHNrWGRxalBlTlN5WUtkOEhY?=
 =?utf-8?B?aGE5QmI1ZGM3SjNOb29ZTXAxWHlRWWFXZnJUd0hvdXZwZHRqL2EzNzQxRU52?=
 =?utf-8?B?QzlObGhDR1NKKzFIOTlNb1hGTlYxRUdpZ25la29CVFJuMG8xTTB4ZmJ2cUNN?=
 =?utf-8?B?ODl6T1dxQmdCUG5UUFI2UUpnSXIyQU5kMVB6RGVrdEpIODZ5amk0N2YzQ1Jx?=
 =?utf-8?B?Y1QzVWV5NU9IcDJMYmw4emYxS0UrUk4zdFExK2kwMnovbGMwRWJ2ZEZ4OHYr?=
 =?utf-8?B?MTd0OUtSZzd1cy9pc2g0TUFOZENCVE5nNnBiU0Nlb2RzMUFINDk3YzUydUJQ?=
 =?utf-8?B?ZDhWOHhMY25wbU5KREtqUG9DR0VWbGpIY3BiMjNrQ2Q3bk1mdWdXVXQ5Um1C?=
 =?utf-8?B?em1yUHM3TlVLeWRuN2JvMm9KL3IzWVI4aVZXWXRITnp2bG5JSjJNajdqZVlZ?=
 =?utf-8?B?TGNQRUtVeWMxeDcxM21FNVFlSUdPVDdLeVIyS1duYUN4SUlNUURsREF3bndn?=
 =?utf-8?B?WGZVSlE2b203WFNyMktVT2Vseno1SWViMjFnZlJHZ2JxZ2ovNEdKcTc1N25i?=
 =?utf-8?B?bDhZd2ZQeXBSY2xrbnBZN3VuQTBHVzFONVB5YnFGa2RmRERiUXpjSWo1REY0?=
 =?utf-8?B?T2VjU0xWaUFheHh1NjNjTTRFYTJ2OGhxbk9yWlNzWDhBZFJBNXIvRk4ybEdL?=
 =?utf-8?B?SU93TFNRTDBHR3RWQ0xBVzZxSDVCWlI0aTVKUWZkUDJuQUQ3OXVHT1Bmd1U2?=
 =?utf-8?B?djIyY05mZStadTdtY2ZpbEd5QUpFSGJrRGJhWDhucUhHVjZzMlVnWTFOK25l?=
 =?utf-8?B?UndwVDY0akhJbjArRG9NUG84bjMwNFZ4bmJQR2JCeVdpbnNBNkMvQmhPRUo0?=
 =?utf-8?B?MnA5d21Mb2IvdXpPS0YzMU9tcWRyNVlDd2hDQzBxNkRaQjUvbkN1cU9qRURk?=
 =?utf-8?B?clduTUx6V2RIRVVheUlZbUNYUklNMll3N24vbDg0OGNEeUY3OE45Y2JldHlC?=
 =?utf-8?B?dXAwSWVFRVdCcXFQOFc0ZjN3U2xYbUF6REpMdWZOd0plclc4MFRpaWRwSkxq?=
 =?utf-8?B?eXg2bW9XUUFqdVIxbytqb1YvTVVKMSt2TWJpRUJDZUljN01ZaDVkbU1vYTdN?=
 =?utf-8?B?elJ6NE5oV3VxcDA3akdtOXBCbXhDSTB0cXNSNitYSVRrdGJJZk9lMnR6OFN5?=
 =?utf-8?B?bEdaQVg5WmQ2NFVZNnFGcFNjc3ZNU2lmdm1TcVVESTBzQ3NDdnRlV013WWEz?=
 =?utf-8?B?ZlROTTFOK1NwTzlUeVBWbUJKVkF4UWdzUnNzZmc3eWxRbVhrUmY1alQ4Mldo?=
 =?utf-8?B?dDByWGFWQWovV0NyZkl3ckN4M3JrVGVlYzF2WVRUMEdCd09obVFRRkRRPT0=?=
X-Microsoft-Antispam-Message-Info: 3v7k/ziiTmRewQNGc+Ib7ewn7WD4vP7/B9UByvbjeCe69nbU8gshHKDInePo2ZbRj/EUdWKyQWskTckngFuLbegIcs339/Ue8niwGObYXpgJvkH3a1RnJoUh/+LeVTppQV9jJoTc1qo5MhCj8lVsaM3BGB3854yP433MTb35+8BSmimLK2NtGUtYyxzji2NX
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;6:148GiHyYHg10B2HhUjZUXRT8qGPprMAybLChdAHlNrXfWzGorlpT6wqqjaMSEBOkDRFDUyf1jkEJfqNkh2WXasM5hgIcgpIWBuXBxDsJLZVDD9Q7w3UTB1kftbiWAZugjFGtOcaywtN3+AXh1xqPQhPG+gPCxRHoWg6zkmGVMsZc+8W+5AYfk07GrEpg/Qm8MfBe4NFrytJCX52emZa+CeGREfLijBjvHZmGP9HyZqJhQD1Q6LCdOqD68dSi6Nh6q+lPCeTYqGU2cHpW0VUk/iys9+REvROLzboidJh+uXKk/r8aL0fIt1u26lsNDASI3lUq2SQLFRhV1bRm+fDy+4Kd/8fXrbXO0QxOEr5dVUBucqlfCO8bTeV796w0CZFhffIJ0KuUGJxmUF1eqi1nm84KKOwrbYOKzGaUXlhecZ+LNA6ZcnTuwrO4AsyFkwIHjx5sXPlKUL46ur44EYIRRQ==;5:uT6Or0qT6M8knsejfh8zHshX/h7FEcQXtHM8oLoCt+NpsDNtngNOjXdzphMqmn4fCwiMEfuYhlmAL+R0L28IXt/6v+EJKqOfX8mMAH85zQCnZCwxd9eW4LCzJZnC86boqFIrOPKFBTGY5g8zmJ12ApqTjokHAGGN1N629ge10vc=;24:Jk5rrg70J4u5ceEMCuo2tElJdgqAO1rCVN96EsjhxnNwkRVVvb8BnwQ3LJoHwE06sgxxD+zJ3ygNlfralh/KaShz7ePMj8zlJqFPaoF9tV8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;7:RzGN4bFmkb04HrT1nbdhEoqZ1jEifhXZjw8OwMW+/9PyhOtQk2elhZZsQTLrDtNC/anZm7ZyCaa0Vqq1EgCHlT77d2znDVQDpE2Uz9Ad71DZ/dkMxlNP65rA6LtKGmLX19KQQ5HQ7WEV6VH1FVMSe70xNGQdw4+0XNuSBxxAWw1S+mkQNSQILc75qkBsaxHQHw+oyCvuAlgve8RMVzVd7PbLHtpO73TQ0dY0YNALwFv00wXgejiKnU2CFhaJh6QU
X-MS-Office365-Filtering-Correlation-Id: c40d5e44-af2b-45bb-187c-08d59fbab4d0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 14:44:17.9695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c40d5e44-af2b-45bb-187c-08d59fbab4d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2771
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Boris asked for your input on this (the datasheet difference appears to
have no bearing on the issue) elsewhere in the tree of messages. It's
now been a week or so and I'm starting to wonder if you missed this
altogether or if you are simply out of office or something?

Cheers,
Peter

On 2018-04-03 09:18, Boris Brezillon wrote:
> On Tue, 3 Apr 2018 08:11:30 +0200
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
>>
>> About that table, someone with HW-knowledge should have a real close
>> look at it! Why?
>>
>> I peeked at all the PRxSy registers and there are a lot of '3' entries
>> for all the MxPR fields. In fact, the '3' entries align very neatly
>> with the checks in this "Master to Slave Access" table. Except they
>> don't, after a while.
>>
>> Here's how the table looks in my datasheet:
>>
>>  0 vv--v--v--vvvv-
>>  1 vv--v--v--vvvv-
>>  2 vv-------------
>>  3 vv--------vvv--
>>  4 vv-------------
>>  5 v--------------
>>  6 vv--vv-vvvvvvvv
>>    v--------------
>>  7 v--------------
>>  8 --v-v--v-------
>>  9 -v---v--v--v---
>> 10 ---------vv-vvv
>> 11 v--v-----------
>> 12 v-----v--------
>>
>> And here's the '3' entries when digging in the registers (the extra
>> dash at the end is for the 16th non-existent slave):
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
>>
>> There's a big mismatch for the four DDR2 lines in the table; they
>> seem to map to only three registers. Other than that, the only tweak
>> or anomaly is that first entry (Cortex A5) for master 3 (Int ROM).
>>
>> *time passes*
>>
>> Arrrgh!! You say "Table 15-3". This is Table 14-3 for me! I believe
>> I'm using the latest datasheet (02-Feb-16). What are you reading???!?
> 
> Oops, I was reading an old datasheet (from 2014).
