Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756817AbeDBUX3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:23:29 -0400
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:43232
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756795AbeDBUXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:23:25 -0400
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
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8e35701f-1bfa-c9c0-62e6-48ed19d7ba37@axentia.se>
Date: Mon, 2 Apr 2018 22:23:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402212843.164d5d21@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::31) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85f79887-bb18-4975-6497-08d598d7953c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:wwohZ1zsW3FQlcVdGtYp6Eu0Ws5FhB8aEizKqNfRqK6hOZVQFNvCRJbA7fGaYBUTUkxwQGe017FrNmwvE3zD4tXwRQ9Vky76nZOhcEyqDXeGRVpHlECWw0IgmaE5QgecUJqaOUPT3rWvZM8pyptYImqUGAhI8BadagsnHEQl3alRDH+v7fJAu0WWerq/cvIBpjLnxxIp02T1ntgD4FdNYQ9k/+gTW5NGO86LOro2BLa+hMHDObAIW+hVKoQ629Vb;25:XU4r8am5RdofvpK1R38VGr10tFEwls15skw4WPiCSMosO/aWBAcNRlmqvrqRE5CuYlaOMfKh9ECkDPNv5UjiINGb8SK5XGyPrUhsUSVcDo6e2Idl12xwZp5uXYVun+fZfLzgSs+jeSTABJyQZLUeN8Pfa81jlIQ3OL1WSIbmM/S++DtMxkh84iXhtHfUKUIvyTCNEjP9bFuysoxxEX2kLUNsZA6lhqy541fICwOJZw5BQcOss+jI/IQDbveDz2PrcekDuW4whPh/yA5UCO4E+S15LK4wh1HnwYSpkISHZltqFT9gHglfUMn2Z0abp7Ac/zbg091vvQmEsrCEPw7BGw==;31:WTqUgDwXSUCfvCy2g4gRafQTZhVABlGwv1h3tCQPvl8R5fyrmaDQ7fktgJnSjDfnLsN4tzVSIE3DuK+Aoo6ltFV6fzLPGmm+FmiqIvw8XYKElAnY39JppaE85Ani93jQP02SvGVdclYl0T5xL2gKKYhrQzJumP3a61tFneXB5WDkc/ok8du9FHe9lrvbP7Dc6Lq8CGfe6jx9jO1viO1vcHyfLpMS0HIituWG8Jtqs2Q=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2780595A0762B26953DA862CBCA60@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:FGtsJq0+gBp71CZq4AkqkSGEtOOkD3yuVWHS/d6LXXrWyLp76c1XrQzFwBpK2iK7WiaS9UkEGS40bqdvNkDb7fqXnPmLDBcyQDT0/es6zT9I5aALMjon5PaK/oL0UfQCEjaq3PM2/Gy8qOHFgAl4FZu+lNOLIR04sL9MeEB9aOJIGzvMhjfQvlmVMgMZ9j/DTz2laeLVE3RBp7Xp/0u6/jBPNL6RlT/rfewo9g4G1Wg9Sa0vLVii6iPtIk2Fsg5n8wnVw7cgZv5OZ8YE5MNrKQ==
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(39380400002)(376002)(366004)(346002)(377424004)(189003)(199004)(7736002)(7416002)(6486002)(47776003)(65956001)(229853002)(65826007)(66066001)(5660300001)(65806001)(386003)(53546011)(106356001)(8936002)(117156002)(25786009)(3260700006)(81156014)(81166006)(8676002)(446003)(956004)(486005)(476003)(53936002)(97736004)(2616005)(58126008)(74482002)(305945005)(486005)(316002)(6246003)(11346002)(39060400002)(31696002)(16576012)(93886005)(86362001)(64126003)(50466002)(54906003)(68736007)(31686004)(76176011)(52116002)(36756003)(77096007)(6116002)(3846002)(186003)(16526019)(478600001)(26005)(23676004)(52146003)(2486003)(36916002)(105586002)(230700001)(6666003)(59450400001)(4326008)(2906002)(6916009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3ODA7MjM6NVV6MndpVHdkWmk1MFlwdWhPNThjeXgw?=
 =?utf-8?B?amc5aDgwdlFkcXFxamE2Mm9FNWsrQ1l1RDN6U01haWw1MUs4U3dqbzBxTGhq?=
 =?utf-8?B?UStaaXZnbzZEMFdUYzdUQlo4YVRleUw4SVEvd3g5V2xwUzJtY0gvbUtkQUha?=
 =?utf-8?B?Z2gyWWFsQ21jQWk0all3dk1BbEU0RDZZcVd1TTE3T2p4VlZSVzFtdDVqb05n?=
 =?utf-8?B?ZFRxTnR5RFJyVjJybHVHSEFTUkVXRWNrcnBlYVh2dzlFYzdSL0NCY2RxbUp5?=
 =?utf-8?B?d3dDTFV6dno5TFNsbmdxZTVHYmpjSisyTmJIMlBrcno4eDlkZFRyTWVleGJP?=
 =?utf-8?B?S29IT3MvZGszMUkzUlRrMTdXOUwxdG1vWjRhYk1YRno0YlAvVnhMWDNwbjho?=
 =?utf-8?B?MjNlc2Z1M01Od01PMHBKUHhVL3R4VlN5Q2RTaUpsbFNEM04rZHh6Wk5LRUhU?=
 =?utf-8?B?bmdaWmlYOE5PYkorVmZNQVNvbVdoU2dWeTJ1TUVmYWlESXhOdmp5N0NSZ0NG?=
 =?utf-8?B?NDBOWVdma2hpOHc1bkE0UVdjc2xBZUNjVUZpVjg3ODAveVFsZk54d3EvcmNl?=
 =?utf-8?B?dndXdi92Q3hoNTQzMFRaem1qTkNnWTAwcmFOakY4MGRzNUxFcHkwa3JaTGVV?=
 =?utf-8?B?U0pBMXRmbFluM29mM2hWVkVGdHlaNDJlZ3ZteThvUTN0d1BBYmphcmYxV1lC?=
 =?utf-8?B?U3ZlM3QwUUxYcXdzZGhtdlRxK1U5YzJlbndYVkxwUno1eHRHZ25mVWY2TXd2?=
 =?utf-8?B?TnVlblFCamU5c2F3cW00V0tjcExDSUFFTkg0Q1NUcDE2ejBXTHU2TE00VHNO?=
 =?utf-8?B?VTA5UGxWRVhtOUUyR2ZROXB4K3ZBUlZ6VDBkdHhxNHdySVI5cC9rUGZoemdT?=
 =?utf-8?B?SmVCMUFNVmN0cHJTUjlLYU0rNUt5S2srMUpGR1hLTlBLcHJuUWxTcnBva0s4?=
 =?utf-8?B?MkNpckdUS1YvM2V0anpqblB4M2RzcWloUlBOUUVCQURmcmFpS3VJcTZQZVJE?=
 =?utf-8?B?aFdOYkdqYUc4bk5LWnRDS2Z6NEZXcUx1ejFVdDJGNktXK1V4bGc1c09HbEY2?=
 =?utf-8?B?a0ZWZnNHRW4rMW0rL2VEN1dUbmM1WWcrclVCNWI2QlVmcUI5Z3ZhMEZyQ3dz?=
 =?utf-8?B?WTdvMy8wMmZxYUUrcnN2UUFEUzRmakR3UWZIRThlZGZZOE04WEg1UVBtWHAx?=
 =?utf-8?B?bDJocFZEOWhEWG1iMmcyVmVPNlVmUHFya2xkTnB3aXBXMzhIZVM0bVZuNUpk?=
 =?utf-8?B?bjliWHhmbXNoUEs5MGVCUjRsajU4RWdyc1luMkFSVEF4QmtFc2lSTGVHY3ky?=
 =?utf-8?B?eDk5MExsU3RkTC9iL0pKQSt2bVdudzVRWXkrMlFDQVhMNlYyQTdsamZtN1k5?=
 =?utf-8?B?a0VuWmhoTVJHcUpLZmQ2Zjk3QzNXUEtkdkpJdHQ2ekpFRUVuTFhST3dReTNm?=
 =?utf-8?B?bG9COHI3SmVKWmM0aGVVZjBoVUFLVVNQam5EdzdPS3EzZHRZY3g4YVVrdURV?=
 =?utf-8?B?QzFlNmFPbU5zblhEMkhxRGJwS2FpWitYdmhNcFN4M1RqcjNmRE81YVJhajkw?=
 =?utf-8?B?eHVsY0M5Smg4NHl0WTlRM3lnMjBQanNKdmMvRkUva3NaREJNWDl1Ukp4S1kz?=
 =?utf-8?B?eTVpMHBscnQyZks0dXVRbjhkK25mdmhSSWtjVkduVFhiZklhbWFlRzZ4eGFB?=
 =?utf-8?B?VGdEUGd4eVMrdnMzL2hqRzRVYUU3OXhEdHFjR3hKSXhUWUl1bkZWcGZYQ2Jl?=
 =?utf-8?B?L29pWWxPQmI5a0dsR29aakFEVzlreE5mYUhkNDk5RGlJR3ZUenpHVzJ5VWZn?=
 =?utf-8?B?ZWo5ZXhoa2VsSDdsUEhtZkdDL2lYQTNSc2ZFM3lVdFVucDFqY2ZLU1J1OWht?=
 =?utf-8?B?MTV5dVVPaDZDM1N6SUlhVFFKa0dsTkVsNmJvOGJyNWk4QnMxdHQrZ0dsRlNN?=
 =?utf-8?B?NDlDUUxKeE9jekhtWGdOODN2bnh0YmVRYkY3L3VSMWl0MGVaejRlVWd0dHJn?=
 =?utf-8?B?ZTYrVU5xaGNUa1NPUnc0TW8wWlJsc01rb3J1dTk4NmJRZUM3RzAwNFFicE5o?=
 =?utf-8?B?RGxTU0w1eUpLREVFV0RqdVBoZkxjT3hOdVpveENlM2RQYUM5UjBDRkZ1WkJK?=
 =?utf-8?B?N2hhV2psQUVFMjdFTHRVenVmdVcrMFRXNnEyaElaVGhKTlVjeTRSVDlHNFNu?=
 =?utf-8?B?cXhLTVNJUlBWcXpNVCtNeGsvK3o0WjVEU2FBU2gxS0tKYkxkRGs0aEJUMzVC?=
 =?utf-8?B?a3hCYWs0MDk4WjFXWiszY0xvUFpWcVhuM2ZvTGpPWTZFWVJCV1JNMVp3PT0=?=
X-Microsoft-Antispam-Message-Info: Gjsg4KcrQeQe30KR2qhc6rYmfihuK5ZRKa5mZTg+AB3RY9ryugTx6MLt5LGu9CBNqA3wFlM8jrCgRuU7qKo01wv0419aHk81Hn671748xtS3DmDZN2swZdVc22mmGIZ7vtOeOva3po1kJPYRuuHjA23C7Smknqj8OMsRSqJ2AhczpWbvRcDcdMulqW0a5zys
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:NIA0v5ZOPqheg+MrR2TekdXYewvgfNb51AuLjLzPJ+k/22bGr/s36P9SL2wXu2fR1RRyh2r+TEx0fxXkvXdH2T8hFpxf0696LElkX3yA43DutrdvD5HwVtpZNWVoGdf62H/nN2C85OjRxoF/25+ou282/oIl6noxy4wJ+Vs/XlKJVQi1NIEC3b8n6rWatTRUQ9cb3iaRwIpaCeQ6a5bKR4eJSiaTNlebMN6V3axYWRnA6IEpzXqTU6zA4Ha0qc+zhIqS2SSI7jr5naHNPQIeHikI9TUblZOrLoIbyKW3tQSzVcVBDm67vO0JBP2qiTCXuBdcaCEEKyU4TLr+JqSXALcrjkMcNWXa0462O9NixYxR2coOhN/auQmh5pfx/ebr70RSOT8BuYXjr+TP8fwQkVLeuxKKilFc4Eum12uqrNOs5aDu864eH2bZtHS+gLs2GyxYbsiuUiiV6ohX4eRfZw==;5:2bXUrELRbhtUOxaN18fkDFjVe8onBW07w/nNMhyIeMSb7v52hZvBl5EctD6geHuC0hxbRT5ogO/lKR0EXVLktf/T73EBVYK5T6uHceVshajYssyEnD1wXqLOlu5suBbSFOdvpsv0hykEZt0BTWdif44IjM1C7ibQNfJdfhU0X2g=;24:UHYynaboINv+5Ys+8GOy2AKA84ydgZsERtAQU+K9WraU87HQMVwq7shVy5TiiOdRvtL53KIZ8AVI8j17rXaV9Ieq2qXkvtHoIVTcL0QwgoQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;7:4HfPa76iJEODCrO0zH2FUXTbBsVUv3Jn3XDdYFel2yNAlKE9joyZ1RMdD7RvZ3YBFImAfp+5xMQ5GoO8h8X3DB2YpY/up+37aHY6cGPKyeFO08Z7po9xf7sj3TWRfdYUsAh0LHiqtR0YzRpPabJVMApDYrUw4dD/c/GaQjU0mvSKvZt9zJEttDQ5kr2xt+eoOKBFLCmxZ1LjUeN9ECTQ5NKbuDX46WWHBCSkwIkSBp6nkkq43oGG21V4wQwiOzkz
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 20:23:22.1165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f79887-bb18-4975-6497-08d598d7953c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-02 21:28, Boris Brezillon wrote:
> On Mon, 2 Apr 2018 19:59:39 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-04-02 14:22, Boris Brezillon wrote:
>>> On Thu, 29 Mar 2018 16:27:12 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>   
>>>> On 2018-03-29 15:44, Boris Brezillon wrote:  
>>>>> On Thu, 29 Mar 2018 15:37:43 +0200
>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>     
>>>>>> On 2018-03-29 15:33, Boris Brezillon wrote:    
>>>>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>       
>>>>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>>>>> the display problem for me.
>>>>>>>>
>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>> ---
>>>>>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>> @@ -129,6 +129,11 @@
>>>>>>>>  #define DEFAULT_TIMEOUT_MS			1000
>>>>>>>>  #define MIN_DMA_LEN				128
>>>>>>>>  
>>>>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>>>>> +
>>>>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);      
>>>>>>>
>>>>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>>>>> instead give an higher priority to HLCDC master using the bus matrix?      
>>>>>>
>>>>>> I don't know if it will be enough, but we sure can try. However, I have
>>>>>> no idea how to do that. I will happily test stuff though...    
>>>>>
>>>>> There's no interface to configure that from Linux, but you can try to
>>>>> tweak it with devmem and if that does the trick, maybe we can expose a
>>>>> way to configure that from Linux. For more details, see the "Bus Matrix
>>>>> (MATRIX)" section in Atmel datasheets.    
>>>>
>>>> I don't seem to succeed in changing the registers I think I need to change.
>>>> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
>>>> it.  
>>>
>>> You mean 0x4D415400, right? ("MAT0" != 0x4D415400).  
>>
>> Bits 1 through 7 do not matter, so even though not equal they are (or
>> should be) equivalent. But I did use 0x4d415400. I simply used the
>> shorter syntax since that was easier to type and conveyed the relevant
>> info.
> 
> Ok.
> 
>>
>>>> But when I try to write to "Priority Registers B For Slaves" it doesn't
>>>> take, regardless of write protect mode.  
>>>
>>> Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?  
>>
>> No, but did it again and checked, see transcript below.
> 
> I don't use devmem2. Is 'readback' information accurate or is it
> always what's been written? Because when you write 0x33 to 0xFFFFECBC,
> 0x33 is read back, but just after that, when you read it again it's 0.

Looking at the devmem2 source, it seems very likely that the compiler
optimizes out the read and thus outputs what has been written.

>> BTW, how do I
>> know which master is in use for the LCD controller? 8 or 9? Both?
> 
> It's configurable on a per-layer basis through the SIF bit in
> LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
> masters [1].

Ok, I only have one plane (in this case, i.e. no cursor, no overlays etc),
would that mean that only one master is used?

>> And
>> which DDR slave is the target? 7, 8, 9 or 10? More than one?
> 
> This, I don't know. I guess all of them can be used.

Right.
