Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeDLHSn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:18:43 -0400
Received: from mail-ve1eur01on0137.outbound.protection.outlook.com ([104.47.1.137]:62255
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752498AbeDLHSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:18:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
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
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <36fd2204-50dc-329d-ff13-0dd11490cda5@axentia.se>
Date: Thu, 12 Apr 2018 09:18:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::37) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:GWxpe53bdsUisjOmqBmOGoLKgi+vx6ztkLDHZsoI9UNaFtfkPewz6O0eqcBewLwT4fNdnmOXxUEUtcI1KzR9E1DJSTI76HfEiSSm0Gi5aZ5lKWUyKF3Jj3pX1e9K4ahzWlS9u+IDzU1WSpRpChWkXPBr2o96mHz6YJoRnQQz/UHRK0NiT99XDuIS4h+2MtVMmfFP0Pyc2JKglE08slv7LTE64TK4x/sP1wBQ+E+77cg8l/cHyeHCi/xnWlmFi+FG;25:YV+bR+DIHebNbYMzQWDbW3w+543/tHY1N4eOdniC6eybCYG3OgX5J/CAOWF/5BMNBks8j35nEVa7Mtp9mg4zCGqGIKEwwi4kxcGDkrfU9alcJNQbS/0NAcjKtgGCvW7gW2wJBodGmpcdYO19yakNcTQTm48ZupzmxNWnqcGnPjgZ+UMBvzBV/TnGQAajwetbH/uQjVDMCzOYfDtU+WAIC3WUI10fDvq5698jH+uWQq5SO+NR/4OlT/yc7A9E891BZXGSbYPglZnqe96dZdh1vp//uIZS7C1WyAYuRRX84t8HFyin9lu+VeTbgirH4fSqM/SUYUDUV2aLIN0B2df+XQ==;31:50vfO/hPvq0aaarFAlLMc2XTg7kuhBGShAUw+qOWdKdsAjbRWezILIQEvCH4HRkuWzslMsQkX/k7ZQyuq2lZ43wQqt6Y/amrUqxanHT7zVK/h31QWOp87QxOsNa7kxAUky02A0NWzUSSRZTxyz8jBpX8XRXp6eREYT2reryaldGGGXod6SCni2m1NafNHQVcF/Oy+m9Pc0AyQ6MbEqNIucY9kbb9H4F8YwRii3vNFBc=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775D5CC4B6D1CAA500BD15DBCBC0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(15185016700835);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:ODRy1Rrahc+P4Q8doA3xCm1TKk1jhb/0Q2CBHwhgi41WZtVzrQfdzRokdgpVEIOzPM0G0Ib3QOk1sXACrkatAqdIMmAcI+yBp6C8nckum/E8O83EQsm7y/pRoG1xIh+5NWJ0CH1gfzlPeHV1g364lOJFXG6aSR68REYiFm7YBAC3GEb/i1Lz4xEtKJgBWu49ML8jjgX55xbArJBgOMIAyTfxfLFAfF2t7xKk9Ff3fPwxl8VwB22Da4qC3oqno92eXF24D38mag9jWLQVS5KaZ/tQDsEU3UfvgghYHWMz8R4TDkmLY0eLFFGXoff1T3zdo6vgocLuHIjO7a/RG88IcDn3/Aq1ahZpO05DwGwPCYY=
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(39380400002)(346002)(376002)(366004)(377424004)(61684003)(189003)(199004)(26005)(23676004)(76176011)(77096007)(478600001)(186003)(3846002)(16526019)(2486003)(65806001)(47776003)(65956001)(3260700006)(25786009)(106356001)(386003)(59450400001)(53546011)(2906002)(966005)(446003)(66066001)(74482002)(956004)(81156014)(117156002)(2616005)(7736002)(8676002)(52116002)(68736007)(36756003)(486006)(52146003)(36916002)(65826007)(81166006)(8936002)(476003)(5660300001)(11346002)(86362001)(305945005)(7416002)(58126008)(31686004)(110136005)(16576012)(316002)(6666003)(6246003)(64126003)(105586002)(229853002)(93886005)(6116002)(50466002)(54906003)(6486002)(31696002)(53936002)(6306002)(4326008)(39060400002)(230700001)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6dHlhM2o1VGtSWGNzd3NNWU1rUFo0QjJO?=
 =?utf-8?B?Sk9DQ3FqdjJ3clJRbEhOdnNDd1dPMEFKNlNBTEtWdnh4b1E0REZsRFVQVEJu?=
 =?utf-8?B?NUNWaU5zRXhRY080Y2tmNHdzVVVPOEFKaHJ1K2Fya0FTcW96eU9JcmlKVW9V?=
 =?utf-8?B?VWU4SjA0b3hIRTJNSzVyRDV3b0g5NGcyeGkyeHV0RE1tQlZTOTZLeVZnT2hj?=
 =?utf-8?B?eG9QdkxGZ0RVcUNDMVYzLzBvL0xpL1pOc0hCVWUvVXNpRnpLNlVLVHNSOU1U?=
 =?utf-8?B?bWJDRlJkUjBhMDRIeXBTL0lQTU82UUQwN0xTMk9WdThESlFsb29IanRzcTc0?=
 =?utf-8?B?UUFrMWVQZWJVUHg2YytNL0laTjJoWjNUNzlHMmV1VjVPOGE4VnczczRpUzBs?=
 =?utf-8?B?V1NHQllSc09xZ1dPelBoNXNKM1R1Z3BaWE0zd05CUUorU0phWEdiRGZ6Lytq?=
 =?utf-8?B?UE5PbThSWW5Mc0Y4azNaaGp1QmdWczhuNHJSWFgzZWJFaG5ydURtb1k5dUlw?=
 =?utf-8?B?di9BV0xibEtpbXV6d2tyM3NDN0dXa0RyaldHUHJCZEh6UE9HeUNrcHVWeXZ3?=
 =?utf-8?B?OEVEaHMyS01uTXdjRDlOZ1RGOUtRc2UwbnlabWQ5SXdQaVJHSWN1MTZyMzVp?=
 =?utf-8?B?KzhjMFkrQlBkR0s3REw1V251eVAwWjMwd3Y5NnhMdzhqZklKN290RDBzTlhW?=
 =?utf-8?B?ZnhJMzl3aXJTWS9pWXlZR3pXYUs4NGpFN0dJK2hKRjZ2WVlPcTRCVjZkdFpD?=
 =?utf-8?B?V1cxeHo0NERJRmF3TVZQZCsyQzVyR20zMkM1MzVZZGRXeG5xN1gwZVI2alBP?=
 =?utf-8?B?b0JXSDVtUVVvQVltZVVQdmI1VVIraWg4cXRGK0wyaFVvNm1Sb3V6L2w4Q1lG?=
 =?utf-8?B?a2M1NFVOTnZtZ3dTT3BjTzIzdE9BazNiQ3RDOHVuQllQNTV6M0xTT2liNW9Q?=
 =?utf-8?B?OWo4eWc0Vmh4QU1uOW1XL1pRdkF5ZzJtd1QrWEpPdkRZRE5LQ0JUcktpQ3VE?=
 =?utf-8?B?cjVqQlhzSkhRVUZ4d1M0OGNNTWwxNHovMnczOFc3bXRMSEx6aHFwY2lhTXlm?=
 =?utf-8?B?eDhOMDFaczV3Q0RHSUQ5dndvR3ZhVWJqcFgrZ1M5dWxSdGtvVTU4RXhBY2pQ?=
 =?utf-8?B?ZzNUY0d0alVMT20zS0JLT0NnbEZPUDhtUXhXUVBVSlJOVWczTVJWVzdNMk9o?=
 =?utf-8?B?RFprNVpmeUVvaEJURUpxL0srYks3MzY2WmJmVDJJaDhhZEQzMEFzRzBZdktV?=
 =?utf-8?B?L2tPV1hyODh6aXBPR0lmNnhPbVZXRVMzQys2RjgrbjJOeFRxQWhjZ0l4QnY5?=
 =?utf-8?B?cjRiUEF6MnNkYmxWTDBld3BGLzk3MXFIbVNseWV4am9MSG5yOTVVcHUzYWVK?=
 =?utf-8?B?bEdSbEVZTjhITzRiMWoyNlY5dHpHTE1XYWdoZEJZb050NjZvbFl2NFRFaTRT?=
 =?utf-8?B?aG9kajljNjFTODM0M2RaREVTREFaZkpxM3ZFZHFZNVZLZHVnRDZncXk5ZXNj?=
 =?utf-8?B?NDcxc1F5NU02Yk84dHQ1SkRtZUdNZEhCS2lBbS9FZllqdEhnSDhiRzF4emFw?=
 =?utf-8?B?MmNDR2Y4MGxQVGFrWVkwMkdGTytYSDNYVHVJSzdoNTc2Z1hXdnEyeUNkMDJ3?=
 =?utf-8?B?emJjY3VlVUR1dzFxN285Q29RdmpuTE0xU2NwQ2dKTlZQWG9DZ2dJUTdtMlMy?=
 =?utf-8?B?VGdsYTg5anJQSVJxZTI0elVmK1hCUFIwdmd0VnRXS3VTTm10QldxcEpZQUFN?=
 =?utf-8?B?WjU0ZU9ZMnllaWNQSUpDZ2Fjb1VyK2Nwc1ZYaERCVlZyVGJiSVhDQ0ZmRUs0?=
 =?utf-8?B?Qkt0dW9BaGdFZStvZ1F2RHpzOFI0YmxJU2tpaWxWL3M3UHc1akZmTGF4ZzBN?=
 =?utf-8?B?ZE1UdnEzcnk5anFYMlgwQWp1cXZ4WlY4TUF2dTRYWU4zeVYway9uTXVMZHlM?=
 =?utf-8?B?Rms1V1lDbkNxcXFmd3FxOGw0d3h4ZHNxcEE3TXZiWU5JVnhWS1UvTHRiYnNm?=
 =?utf-8?B?U1lLazkrNWthbWxEZXpWbVZSQVFWU2wzaVQzSFE5QXlmTk92VDFDcUQ4OTVm?=
 =?utf-8?B?MDRteU42RW4vNkFTdGNiMi84bnUzSEcvRlZzV05ubVhha05tb2MrZDdXOWJI?=
 =?utf-8?B?TGtXUktvQWRwRkx6cHZnU2NJWTJXdFhRZnJ3aE9iUzlUaDU3T1Vmem5pVzBl?=
 =?utf-8?B?V1JlVWdLQk1MMld1ekhuaGVMdlJHODM3bTRPeVJkeGx5ZTVYaXVwTXowcVRr?=
 =?utf-8?B?Uk9SSE5haWVhTWtvZk5HZEhBTDllOXIva0hzM3ZjajhxYUZBenlJWnB5YzVV?=
 =?utf-8?Q?bbZ/ytgtkqI35RGFCVCRHh/wgkBvtCABWdTjDEj?=
X-Microsoft-Antispam-Message-Info: XoMduB4ZUIQSEHvTMOjFLrlGysPwbgGzGm0vBztMSCj0H8Pq3pFtb79XqGHbGRHimkXJDNMKNxoaF0i2tidIliL0AoSTmzfiAIqKYtHw5t+jFY+y2CckEPjtTHGa+jWCwIAqQX5s0zT7zJmqnWTR/C2/IUKt9G+5p+opHy11b7yAH8HEI50/NSdOzYhIcSob
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:jyAuBOGvWowIO31uO3gR/MdYi01kvzrNkOzauXVI4J62Jdm88JB10f4UvVIuhmekyR/GYjdx8xZ4x1z7DCA/RmVo3oZX6r+3i6heyj2lHdgtM/Q6GE00zl5yu/jTXtQwlDFkGyxfKgvkSRkHRoF56cqpPV0K0DVmdr7x8tGAxd/xZ5YYaZritQHq4xwCNQx0AxfT8PubUdQE2d/7LNcmoTwjLgfKsILzbbRIawiNXvrm/8yTVuy9cIO37uQ4CllUapzrCj87RCZwH4sA12GFhLoHTtgp/4MJHMjcMB6wCgIgH7TIYwpG3R7r4Zfuy9A3CPS/brE1bHdfB0K83iq3Ij14fVQKMGe21EbMPhMVFlo6sJsebYOOzhVuKmoTk4QoxFwyL+CXYz8Uifh4U1xVb6ophF3HONlrlgJDXyb1351IN2M6BWPRG/IuyeRXnb5OyaWxc2JgbL+76nA/lVqX0w==;5:lggEPeVWyw9HyOVldZYz5lg7uJ7aGAa1SSEdbQnW1KKqb0StJzBdN7EzSor2I6isCJhwgTJaUJ9szutKsskekL3X8oaWHxHmXLQJz9Rq9gYmZxP5I9y6v06gRzzUunmKBVOeYhNky2YLOr+qQ3Au5ZMY6Xtoz/pRbs4oDN4lRZ4=;24:6VJoS+IJbn9d5k7rkMxU7aVzQyXJmYxGb3CbCFKa96t0HSWRMzyxELU5NiSX5UxHPNaNH73d7hWaXMYE9AviZxrPZc/jYn3eO+uIz2l4VjM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:rcCJdL5qeNeUduRtZpvDYigcEFgfplmg5d3xdzINIvENKOmuBZUwjepF2wiNf+xIkdnrAlfhK88tdgYZiA4JnhI4WRkxcnsUL1lsP2lPFc6KXTeh9Dk1BYtl/H3ULT2SQ6kddrDYG5FEHaWmu4/r3tcxNqasO2A9Q8oY12E6zVkXok9Y4uQvcofXQ0MnL2dnjxfBdbOCqmd0VOtm5j61hwGZtd2TdFr7Od0nJw4aXPo7ZhWC206j/ljc5H4TK5eX
X-MS-Office365-Filtering-Correlation-Id: 0e7fb683-f226-4f0f-0c78-08d5a0459c23
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 07:18:35.4117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7fb683-f226-4f0f-0c78-08d5a0459c23
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-11 17:34, Nicolas Ferre wrote:
> On 11/04/2018 at 16:44, Peter Rosin wrote:
>> Hi Nicolas,
>>
>> Boris asked for your input on this (the datasheet difference appears to
>> have no bearing on the issue) elsewhere in the tree of messages. It's
>> now been a week or so and I'm starting to wonder if you missed this
>> altogether or if you are simply out of office or something?
> 
> Hi Peter,
> 
> I didn't dig into this issue with matrix datasheet reset values and your 
> findings below. I'll try to move forward with your detailed explanation 
> and with my contacts within the "product" team internally.

Thanks, I feel that experimenting with the matrix with bogus documentation
is harder than needed, so I'm waiting for that information.

> However, I have the feeling that this sounds a little bit familiar to me 
> and that the pins drive strength for the NAND Flash *and* LCD must be 
> positioned to "Medium drive" at least for these interfaces (register 
> PIO_CFGR).
> 
> We use this particular setting for our own vendor branch and found that 
> the LCD and NAND Flash was far more sable on *some HW boards*. Here is 
> an example for NAND but you can find the same for LCD:
> https://github.com/linux4sam/linux-at91/commit/99d9e4c8848a2f16cc5b34bb27e588ca7504b695
> Obviously the "drive strength" property added by Ludovic has been 
> proposed but is not accepted yet in Mainline and this is why you don't 
> see it positioned here.

Ok, translating this from SAMA5D2 to SAMA5D3 (which is what I have), I
assume this is PIO_DRIVER1 and PIO_DRIVER2 instead. Peeking at those
registers they all contain 0xaaaaaaaa, so I guess all pins are already
"Medium drive" on my board. Also, looking at that sama5d2-ptc-ek patch
it seems possible to adjust the drive strength of the nand D<x> lines,
and I don't think that's possible on the SAMA5D3? The NAND uses D0-D15
on our board, but there is no alternative use for those pins.

So I can change the drive-strength for these LCD pins: LCDDAT0-15 (only
using rgb565), LCDVSYNC, LCDHSYNC, LCDPCK and LCDDEN (LCDDISP is not
used). And for the NAND I can fiddle with NANDALE and NANDCLE.

I.e. PA0-15, PA26-29 and PE21-22

I tried to change the drive strength of these pins to both "Low Drive"
and "High Drive" and it didn't have any visible effect on the display
artifacts during NAND accesses.

> If it feels like an issue with "crosstalk" it might be the reason why. 
> For overruns or underruns, it's true that I would say that it's not 
> related and that dealing with the matrix is the way to go.

It does feel like underruns and that the LCD controller isn't able to
keep up with the needed tempo of the display output. At least that is
consistent with how the artifacts look.

> You can simply test this using devmem2 and see if it's better.

See above.

> Hope that it helps.

Sorry, but no disco. Thanks though!

Cheers,
Peter

> Best regards,
>    Nicolas
> 
>> On 2018-04-03 09:18, Boris Brezillon wrote:
>>> On Tue, 3 Apr 2018 08:11:30 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>
>>>> On 2018-04-02 22:20, Boris Brezillon wrote:
>>>>> On Mon, 2 Apr 2018 21:28:43 +0200
>>>>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>>>>    
>>>>>> On Mon, 2 Apr 2018 19:59:39 +0200
>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>   
>>>>>>> On 2018-04-02 14:22, Boris Brezillon wrote:
>>>>>>>> On Thu, 29 Mar 2018 16:27:12 +0200
>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>        
>>>>>>>>> On 2018-03-29 15:44, Boris Brezillon wrote:
>>>>>>>>>> On Thu, 29 Mar 2018 15:37:43 +0200
>>>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>>>          
>>>>>>>>>>> On 2018-03-29 15:33, Boris Brezillon wrote:
>>>>>>>>>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>>>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>>>>>            
>>>>>>>>>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>>>>>>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>>>>>>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>>>>>>>>>> the display problem for me.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>>>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>>>>>>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>>> @@ -129,6 +129,11 @@
>>>>>>>>>>>>>   #define DEFAULT_TIMEOUT_MS			1000
>>>>>>>>>>>>>   #define MIN_DMA_LEN				128
>>>>>>>>>>>>>   
>>>>>>>>>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>>>>>>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
>>>>>>>>>>>>
>>>>>>>>>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>>>>>>>>>> instead give an higher priority to HLCDC master using the bus matrix?
>>>>>>>>>>>
>>>>>>>>>>> I don't know if it will be enough, but we sure can try. However, I have
>>>>>>>>>>> no idea how to do that. I will happily test stuff though...
>>>>>>>>>>
>>>>>>>>>> There's no interface to configure that from Linux, but you can try to
>>>>>>>>>> tweak it with devmem and if that does the trick, maybe we can expose a
>>>>>>>>>> way to configure that from Linux. For more details, see the "Bus Matrix
>>>>>>>>>> (MATRIX)" section in Atmel datasheets.
>>>>>>>>>
>>>>>>>>> I don't seem to succeed in changing the registers I think I need to change.
>>>>>>>>> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
>>>>>>>>> it.
>>>>>>>>
>>>>>>>> You mean 0x4D415400, right? ("MAT0" != 0x4D415400).
>>>>>>>
>>>>>>> Bits 1 through 7 do not matter, so even though not equal they are (or
>>>>>>> should be) equivalent. But I did use 0x4d415400. I simply used the
>>>>>>> shorter syntax since that was easier to type and conveyed the relevant
>>>>>>> info.
>>>>>>
>>>>>> Ok.
>>>>>>   
>>>>>>>      
>>>>>>>>> But when I try to write to "Priority Registers B For Slaves" it doesn't
>>>>>>>>> take, regardless of write protect mode.
>>>>>>>>
>>>>>>>> Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?
>>>>>>>
>>>>>>> No, but did it again and checked, see transcript below.
>>>>>>
>>>>>> I don't use devmem2. Is 'readback' information accurate or is it
>>>>>> always what's been written? Because when you write 0x33 to 0xFFFFECBC,
>>>>>> 0x33 is read back, but just after that, when you read it again it's 0.
>>>>>>   
>>>>>>> BTW, how do I
>>>>>>> know which master is in use for the LCD controller? 8 or 9? Both?
>>>>>>
>>>>>> It's configurable on a per-layer basis through the SIF bit in
>>>>>> LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
>>>>>> masters [1].
>>>>>>   
>>>>>>> And
>>>>>>> which DDR slave is the target? 7, 8, 9 or 10? More than one?
>>>>>>
>>>>>> This, I don't know. I guess all of them can be used.
>>>>>
>>>>> Looks like I was wrong. According to "Table 15-3. SAMA5D3 Master to
>>>>> Slave Access", LCDC port 0 can only access DDR port 2 and LCDC port 1
>>>>> can only access DDR port 3.
>>>>
>>>> About that table, someone with HW-knowledge should have a real close
>>>> look at it! Why?
>>>>
>>>> I peeked at all the PRxSy registers and there are a lot of '3' entries
>>>> for all the MxPR fields. In fact, the '3' entries align very neatly
>>>> with the checks in this "Master to Slave Access" table. Except they
>>>> don't, after a while.
>>>>
>>>> Here's how the table looks in my datasheet:
>>>>
>>>>   0 vv--v--v--vvvv-
>>>>   1 vv--v--v--vvvv-
>>>>   2 vv-------------
>>>>   3 vv--------vvv--
>>>>   4 vv-------------
>>>>   5 v--------------
>>>>   6 vv--vv-vvvvvvvv
>>>>     v--------------
>>>>   7 v--------------
>>>>   8 --v-v--v-------
>>>>   9 -v---v--v--v---
>>>> 10 ---------vv-vvv
>>>> 11 v--v-----------
>>>> 12 v-----v--------
>>>>
>>>> And here's the '3' entries when digging in the registers (the extra
>>>> dash at the end is for the 16th non-existent slave):
>>>>
>>>>   0 33--3--3--3333--
>>>>   1 33--3--3--3333--
>>>>   2 33--------------
>>>>   3 -3--------333---
>>>>   4 33--------------
>>>>   5 3---------------
>>>>   6 33--33-33333333-
>>>>   7 --3-3--3--------
>>>>   8 -3---3--3--3----
>>>>   9 --3-3--3-33-333-
>>>> 10 3--3------------
>>>> 11 3-----3---------
>>>> 12 ----------------
>>>> 13 ----------------
>>>> 14 ----------------
>>>> 15 ----------------
>>>>
>>>> There's a big mismatch for the four DDR2 lines in the table; they
>>>> seem to map to only three registers. Other than that, the only tweak
>>>> or anomaly is that first entry (Cortex A5) for master 3 (Int ROM).
>>>>
>>>> *time passes*
>>>>
>>>> Arrrgh!! You say "Table 15-3". This is Table 14-3 for me! I believe
>>>> I'm using the latest datasheet (02-Feb-16). What are you reading???!?
>>>
>>> Oops, I was reading an old datasheet (from 2014).
>>
> 
> 
