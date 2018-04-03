Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDCGLk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:11:40 -0400
Received: from mail-db5eur01on0109.outbound.protection.outlook.com ([104.47.2.109]:65269
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751726AbeDCGLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:11:38 -0400
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
Message-ID: <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
Date: Tue, 3 Apr 2018 08:11:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402222020.1d344c14@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::31) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b77ff2d2-9163-4345-c47c-08d59929c05a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:1wrVFIN9JqGT9DlbLyaoV95C21yN36Bc8zjfoKEs4CAP4dpf2vhEUfGqBursSxnBGPv+id48Af6WzqNy1xiWB9yEXoKHqWGDHdW0CDpEAWHnlmPVOkcXrmW0sAyuK1lLBDHpBK0i5WIRN3FUktnLumm6e8WI7A5OS9J0ym41jSptKUfqR0XaA2x7Xo3OLKhe8QIBkg/5kp2Z30kOXf//RTrvMYQvgCeb2FwPZUlGTENqeIMCi4jzeYyRLxEZodMq;25:HfDRxET26aJ+m2yfiE2yE5mg3bMYHUQmAhdJA5wWxolK/bZrabmVcL1D1sYfWsAEUZeWDgIgtGhdrOnekQI8zYtLIuQY8nSE4S00WoPF4fGl9v+lqdOLhJQ0Snik3aSk3Z9F9rvzknQI+8htELcc3gWEe03g+TIZnFaq8yMupuxO+JyVcXCt9QyvpcW6nMdD4nsf6C19zbuck1i3K5tvVbjFkmK7v5+zBbyujr7H94QwmtWyE0BtX+4N05HyN+k91t4NpkdnewLwo6IJ4+dtAQqsq2zacZDSe53Ch30q8jcaoi/CEx730/lcs5g2/j9GeMbJjvIDSZeQIuDP2l4wyA==;31:lAXHkvrv00qYmAyq605JhciDIbJQZvzXkFWB2oa4887c84gTEbfZJOfWHO6/wOOO/xBkO/3jQukibTWU1q+w+9aB6KNYP+lNyJfK2bS6ShPvZ6yBAfekq6F4WeXZwzsDNnrhdFzr1zs+8lYWMeLkyl4noagOdf33cg8JxUor08FtmgrJQnCuZU53tTsn21iqf1RAVPpOS9YRjCdexJTfsejn6lC0VrONHt4YRZeAQAg=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27803033A32D8DCD0148FA43BCA50@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:yEeiJqpnii6Ql1JmpNEyCSN4Bo2uD+pK/vJg4EMwCAyQREeH9+btDrWDh+TwGp/rTAhQky7qGopaGMJXKPecKHAWESiBnmdL5ZfCUhasVofOt/F7Xik9riDIvnMly1ywoCGFFRc+SB11P7L0H5UrBhajuJrl1YFDTrLfQLYAQeESozpbc4MR71iTQ3Z//E+3YlpKgmo6SQlMaf3qfplGCFeAhFoSlce3QhoPzUXJdl/HuTiDk5WLgwZYOi/ocGFRcaKwAmJR9OPkFwGpcNLYfw==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(366004)(39380400002)(39830400003)(396003)(377424004)(199004)(189003)(36756003)(77096007)(6116002)(3846002)(54906003)(50466002)(64126003)(31686004)(68736007)(76176011)(52116002)(59450400001)(6916009)(2906002)(4326008)(478600001)(186003)(16526019)(52146003)(2486003)(230700001)(23676004)(26005)(36916002)(105586002)(53546011)(386003)(3260700006)(25786009)(8936002)(7416002)(81166006)(106356001)(5660300001)(81156014)(8676002)(7736002)(229853002)(65956001)(446003)(66066001)(65826007)(47776003)(6486002)(11346002)(6246003)(16576012)(39060400002)(117156002)(86362001)(31696002)(53936002)(476003)(486005)(956004)(97736004)(486005)(74482002)(316002)(58126008)(93886005)(2616005)(305945005)(65806001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3ODA7MjM6TnJBQjR1dFFiRXp1NU1xbGlLbElZTDJG?=
 =?utf-8?B?ZzFwTHR0R3VFYTlqZjc3S0xDVE5DQUJzd1B0bXFaNkdWY3k3aFNxdnpwSVVx?=
 =?utf-8?B?U0N0MGlOMzRaSjJPdU1EY09pK09lSzFVd1JqOWVUTHNKNkJTK3JyNkIzM2g4?=
 =?utf-8?B?TlZ4VHJYMHRERERncXFocmRtTEJRM29qb3Nac25Hd2JwL2orY0Zjb0JWVXY4?=
 =?utf-8?B?OHBpdzFNQnhmME1yY1dCSGV2VFk0Q0pVV0hld0VhVWJxaWk1RE9ORDJKdUhT?=
 =?utf-8?B?cEsyZHZmRlNQVFEvRHY1TUdqTTloS0tsbG9xLy9GdE5VdHZ6emRZeDdJcWVv?=
 =?utf-8?B?dG1WMGk1L0NlS1Fid0U5cnpKckxMSDVwOUFLQ3BKZlludE9ZQmtEQjJIakx3?=
 =?utf-8?B?OTc2UG9ZVXdlYUVlcjk2MXc1bTRCY0lBVDIzQ0dwVzZqSHFoV0xFL3JLcGhm?=
 =?utf-8?B?aEFkQ242c1M4N0htV0J1eWkxWUxkL1hjQTBIR1lMOG9UQXRraHpyQUhNT0Jo?=
 =?utf-8?B?bjhNR1ZnS0xCaWV1YkNjT1FLb05wd2lnb3dhUnZ4dEdyeDN3bGR5eWkrVjhB?=
 =?utf-8?B?aThjTXlUOFdoSHI1MzFkeUZleEwrd3BMcXpjcHVTbW94ZTZwWk8zUDl5Q0Jj?=
 =?utf-8?B?ckNhbFAxU096cFRYMFNLTnNKTnkrZElHZEhoRHpFeDAya3duMWF4VVlPaW5v?=
 =?utf-8?B?YVcvaEtsWW9Hd3V3SThYZ0d5bE05SmRScmZES2xBbmhSS081ZmhFYXladDdT?=
 =?utf-8?B?NVo3dGxRS1VhMTc5YjZtcTU5VjBtaXFncll5cUtzVHlkM1dHTEVtRjQzYUxt?=
 =?utf-8?B?dUJVa1JNa09RRk1MN0k2VmpPdjZZZzB4QVlvVEhqNDVXOXhQQWJtWmg0c095?=
 =?utf-8?B?OEpLeXdGRm1xWHBWRzFXL3FLeU9oNnp4SXg0Qk1KUHAzeDVxYzB1Ty9MblRa?=
 =?utf-8?B?V3JmdGpKMWNoSnR3RnA0REdjZzNhTWNmRUNvM25WMkx5MzdBQjlnOG9TMUpo?=
 =?utf-8?B?WHZob2ZkQUltcXJGVTFUZnF5MnRMWTU2WUZBOXBud3ZPcE9NSXBZczdNNmVN?=
 =?utf-8?B?L2JTWW43b3NNaWwzZ25LVTN5dHhKU1dyUnQzaEUrVjI0TEJLSTl1Y1ZxT0xu?=
 =?utf-8?B?NXpoVUg5dW9aWDZTcXQxMDk2SzVEcTF3YXNKczJTdHpzckhKa3J3bkZSK2Vu?=
 =?utf-8?B?blRNS3lPZWJlT2J6NVhYSmFHb2RESGFCcVg5SGR5cEtQQmRuQTd2a05RY1pE?=
 =?utf-8?B?M05XK0pJRWdjTVFzK1dibWI2SUFkMHhsTEtSa1BqOWYzanNwZW44dVBKNjZw?=
 =?utf-8?B?LzBZdlRPdUJPeHNaemdXMUlBNkVnalFYSHNyc1c5Vm5MTGorRldBSzNKelYr?=
 =?utf-8?B?UDRyYzA5Qmhkb0dSZFdmOUdXYVlLYW1kYWFiYkV6ZDMwZTJHNUJ3Tkx2OW5K?=
 =?utf-8?B?TDdyQnZlZ2pGS0cydXBiS1VENW1iaXliTjJGb1cxYmxVNkg0Umd1MEVic3Ew?=
 =?utf-8?B?QUFjRmZZY2cwOE9PR0phZDE4SHR3VUZJWmVFQWpKOXBYYm5RUGRBSW9rbWJP?=
 =?utf-8?B?U2ZyUGFNODllNlFmTWF0V3hidXFuZEM3RXpCYlFQMnhManFOK1d5Si8zdEFw?=
 =?utf-8?B?ZG03OW9uMkkvbVBIUVRsWGFCT05tVjQ3Mnh5dEQ4MzFIZGJDdCtGZGV6YVNj?=
 =?utf-8?B?TWhNNS9sdFc5VWpoYkV0WnBwcHlrQTN0R2UrNHZjMmMrZUtEY25FMENKOGNo?=
 =?utf-8?B?TE9tU0lKblY5Z0ZxVTNBWUVEWUVjc0NNdVBZRDB4TkV6ckZBMXUzRCtpdTFt?=
 =?utf-8?B?dzJRTWMya1FlWTRyWFZKaW80dUFidHhISmJ6a200U2dOMEdOeGpiczlCMGUx?=
 =?utf-8?B?YVROTWxTL1hYVlNkYjB2NG9NUG9rNE5STXk2cG5oSG5VU3RlNFByMGxPaGNG?=
 =?utf-8?B?L0x4Sk05SFJIRlBkL29wOHJqZWw1cjRGSHhybThPMkJOT1NoWFJUWlVHUzdT?=
 =?utf-8?B?bUZpMWYrNmZlUGdKUkZteDI0ekl5YWQxZ3ZneVdPWjRzdlB6b2FPaEdDTTli?=
 =?utf-8?B?UkFHd2ZrSlBLWmh2aVFiWUY2ODY2RkF5Tk9qQWgzS2ZCQ2pHTUZBbHdMaUdR?=
 =?utf-8?B?MWVVTnRyQXl6SHhIakh0VlNXZFZlenRTRlZseHM4U1F6UUNyaElpbnFhZU9W?=
 =?utf-8?B?S3owOTArN3hGeEhQUUZrT2VRS1dKWE5rVFlxYng0bnZpVUFmQktJeVVLcnlR?=
 =?utf-8?Q?WolRUj39rUxDdSf/WRAi?=
X-Microsoft-Antispam-Message-Info: 5AqS3CLtytg0PK61lSe0vb7EqMm0gRVolPU4JRbadMAPCsOp+A/R/r9SwvmqGzl8Pn46TQwLIu206MpA5vRAwtdDiwJ4zJhNC1FxlohmVZ3+CbkI/qnDjiEUN6rccIwIVqu9iEYHEnsBCTQPf54YuDbwNoKOiBbaAdMPWqcG29HX9QADdTes0yy2gQaLc+zX
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:2PZdIXzejru7KgEs7Rer38fzq3nsdyIWhE4e7R08WNnMIYyDH9gL/4bLJp0gfDfFl6eabqHpgDD2hWHZ4gIfwDFtwdEoclIrT+Th2dtQzceRRzlkBJI90eOlNUik7RxN5gP6UFJ6+MAB/nPmRuB2kvUcAuDfCVdFKntwRdQ21eIWnhc2RApepvyYMCBBq148T9/fz0fCpGKJ61iVfP0UlekAlE++JhnLvkv5M9xdvnB3zuLIGfLup0cSkF+VxyLj0plIigBdPkS2Hx/LOlVu26nNIA/bL7X8IIog4NdwF4622xf+b/UJ5YNFtyZE0Nn/a+kk078GLS+FFjcF3keHBYGT1WzVMX/UuhfszD4dsh81rtVF5PQvBm5K7shG5nsIIhJ57r+Arr0YgmiINE+NhQ8VEcJMXBII7Sh5wk4TAz+cNeOu1z9pFsqotGGR22zTNjDT0gqNosQ4hDDckRoFXA==;5:pLBPm7fU7wcLkSisgCjeUFtHvh+Q8Gg/1mjQ50y684iPDJw2A8E8MWT+RPonbUXWqI7ciN3q5sZXXQtpHP52dvEkUeLKMsKLQuRS00Jl/xRmGh1Zfc/Y4uiXe2wgrYjpclWBXckz2cjcottoNFAsp6brYThOo5kot7PZQrwMSrM=;24:VY4pUaYuOeoNbgI33MTFPzXPIt2ifswrg0erEFa3S+hapSfpuIBrTv2I2M4Xj0EL5H/W/UjA5E6PVdAtsyRHgTwe0YBjoCxXZ5+LC4ir71Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;7:CrFK3luRGUi273BG28fzGL8ZXxSdeZbGeVQTV2hW22WawHboyignKdNC/fPYdv4q8FPlvXz4GUIM7FTM2CFjFk9fp2B1w4L0V5j4qv2CF2VGuQZtWXl9d+diySH2eqHnqjLSbUmeYG5Ahf7h4x6/QFl7mR1Pk1Ve4GDz7m8OO6RYmS4JeEWp5Zxl43YtWR5CfzcYXLXHWcVaYgUQ+K1a+yovEzCgn8mvDqGAkshMQXjTdsURAOYqSTvNIvbAItXO
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 06:11:33.8144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77ff2d2-9163-4345-c47c-08d59929c05a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
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

About that table, someone with HW-knowledge should have a real close
look at it! Why?

I peeked at all the PRxSy registers and there are a lot of '3' entries
for all the MxPR fields. In fact, the '3' entries align very neatly
with the checks in this "Master to Slave Access" table. Except they
don't, after a while.

Here's how the table looks in my datasheet:

 0 vv--v--v--vvvv-
 1 vv--v--v--vvvv-
 2 vv-------------
 3 vv--------vvv--
 4 vv-------------
 5 v--------------
 6 vv--vv-vvvvvvvv
   v--------------
 7 v--------------
 8 --v-v--v-------
 9 -v---v--v--v---
10 ---------vv-vvv
11 v--v-----------
12 v-----v--------

And here's the '3' entries when digging in the registers (the extra
dash at the end is for the 16th non-existent slave):

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

There's a big mismatch for the four DDR2 lines in the table; they
seem to map to only three registers. Other than that, the only tweak
or anomaly is that first entry (Cortex A5) for master 3 (Int ROM).

*time passes*

Arrrgh!! You say "Table 15-3". This is Table 14-3 for me! I believe
I'm using the latest datasheet (02-Feb-16). What are you reading???!?
Is that something that adds to the confusion?

> Can you try to write 0x3 to 0xFFFFECCC and 0x30 to 0xFFFFECD4?

Will continue experimenting...

Cheers,
Peter
