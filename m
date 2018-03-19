Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933948AbeCSXKH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:10:07 -0400
Received: from mail-db5eur01on0131.outbound.protection.outlook.com ([104.47.2.131]:34405
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933861AbeCSXKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:10:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <99548eb6-1958-b2a1-1f2c-ba995f8965ee@axentia.se>
 <20180319184850.GB23774@roeck-us.net>
 <11684f49-dee5-7037-f5c9-5bb8becf114f@axentia.se>
 <20180319205056.GA11941@roeck-us.net>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c0d428e6-c141-1f9e-3fbe-42ade73a0f3b@axentia.se>
Date: Tue, 20 Mar 2018 00:09:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319205056.GA11941@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4e::22) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17900e3f-9fcf-4350-3a97-08d58dee8a5d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:+6wqv3PmuweIcWvXtQSzdkStqlGtVSggh+WdVkNxm/EUptu/0wC+tyy3GWewBCKMmrm9yEVGJyGsLlMxbL4mhLQ4fuN1udpqOS5pXb7YKLrn7lpkq2j06hx44Kg/RKgbnX1dzeKd0oyf8avfdPc40nvYQrjPtvk64nV650MSZBxt1PnS6F+U7mNaDE21amHBm9qGP23VmhQyHoYQpWFw115nI/2Yr4AdVsly5D8+lPW40qZNkpicrAgHw8OG/0X0;25:uYJqNA3pm5qOTT6isqtUyhnl9snWk6Yx7YGoo9SlCbQEysf0y8YNA/mplO+WcBgxGabaZRPtmKcfWFyClHSHrdjIDrl5ZzlVDK1n8YxnmuJ7egH2eMHTY0sBaU+nHArn1VJVSYjnMFkAaVaYxDs4afTXEForzeF31XBCv85ZJ58vvpVqFd0SdPhKH+nS+QbZnX9BDt3yWa0XuWo8LRRbopntZxjVcU9mvYEX/P15HimTu3+F97IHGfXvG2EVE0Wgg9gGoKsd9+VeEHhWdEPH1ITtYg0S8TWmQZ0x4OpVaZWqWO9HfD3xSJIIYVi6UzaWcrzIqTLmy2EBtGPidAh0+g==;31:qGVgH/clUefW8o4QINqZAHLArMCzlU0AUgoknxLJENQS8UCj7YOPKx+snagf3+0hh4J2l0r0JkjENanf1StRq7j/yXqqZQQdlWbgeWUptAZJbeqyTGU3IMn+Q3tQPcNMvnb97E+wsm8FyJv+i5cyMU8FBLvZ3j61cacM6NLbiPs4wsAs6He9398AnYFG+7mc8h1/pYQJzz6SdQXVQ0BNxPu5Lihg4O6grN6h8ya6C8c=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27807A12B0AEACBE71F59B64BCD40@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(264314650089876);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501304)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:T9pHd2z5zUgLxP3NHdMZrsshQADsMibDG453WAGDNkJF4WGdy5pb0lLoTfj/0rPNQkfRU64h/kbbCcQpo/bltKeGWMaM18pKhdgvYwc4BorHbL1C/lpwRcNmCnQ3j1GSundvgAEBV5TxFTU1Tb1Fw58G5q/ATfnhsB+Mc09/bDBFKHiFB+gb0uEXnmu+RAhJOCmlTVgdtIhfy2O0qX21LTxVj7Kw/aH5xvONQ99EVlZxj48fwQoS5TpKdYFSSm/xQE9tgVp35RHW+5RF+DMGeTcPdEtvXxdBoyuO+9mdVfRgEjaXCMnvOipPg5qwtS5xrrxYGscyAlDA0IKZRYJkHhV/n5stRTXEOSgwJ5cxDRg=
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39380400002)(39830400003)(346002)(376002)(52314003)(377424004)(189003)(199004)(36916002)(52116002)(3260700006)(53546011)(6246003)(31696002)(65956001)(386003)(2486003)(25786009)(2950100002)(36756003)(117156002)(6666003)(16799955002)(6916009)(86362001)(74482002)(15760500003)(68736007)(16576012)(230700001)(93886005)(52146003)(4326008)(6306002)(316002)(97736004)(65806001)(66066001)(58126008)(47776003)(53936002)(54906003)(105586002)(5660300001)(50466002)(6486002)(2906002)(3846002)(6116002)(186003)(76176011)(8936002)(64126003)(81156014)(229853002)(106356001)(478600001)(26005)(305945005)(23676004)(8676002)(966005)(7736002)(65826007)(16526019)(77096007)(31686004)(81166006)(217873001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3ODA7MjM6T0I5TXp4bWM3NVF3YW9GYzFuYzJaanRY?=
 =?utf-8?B?S252dUYwZU1JZmFaUXdzK1hrNEh0Wld2TFRrNUo1RDNZQ3lNL3NXZ3BPajYz?=
 =?utf-8?B?eDNScVI0NkxGTHJxMVdaQTNuM01DVWkyNEM0b1Y4V2ZNQUJUNjl3Ym1Yejlq?=
 =?utf-8?B?d2ZUaGJOQmJOR01vZWc4Y0x6V05UM01HTXRpc0k5QmJraU1pNCtHdEplVDlq?=
 =?utf-8?B?U21zbkFScWI1TTRmZXpFcUVjMkt6ZEZKaTFTK3dmWlB5UWhMeVAyTFRuREpQ?=
 =?utf-8?B?eDYreWw0V05Jb01ZRTFzZHVwaHFRYXBqUlpuQTJXQU4xSmRqa1kvWUdXQzhJ?=
 =?utf-8?B?WFVjRjM3cTJNREtuV1FYc2Q1bklRVFZuaUl5VWlxdEN6bGx4YnVITGJic096?=
 =?utf-8?B?dTNQWStOZDM1aXBycDdpZjVPc0NVV083QW4rUThydE9vTEsrcTYrSkxlT1ox?=
 =?utf-8?B?YTJEMlhxWnpNTm8xellIc2hraHJ6dWFQc0plME04c1lNeitjMlZzQ3NQTXkw?=
 =?utf-8?B?cjl6alVjeWhscEdPTEJXRHk1eERjNU1vUktFaVlYdHhkc1FaVWdUY2xqdG5F?=
 =?utf-8?B?Y2N5NFFRSmNJNUcwNmpjYUFYdlpKNEhpTE9VR0Voai9qVmEvSGhiZXZDQlpv?=
 =?utf-8?B?VzVuRW9hTkkyUitDeEtwQStBaE9oSE1wcVczaTd5UW5EYmMrZkIzWjZtNERk?=
 =?utf-8?B?YjFZR2wxVElKVHZSY0p4cHIzMVd6aXdxc296ajVaYW44YTQ4VVozZ3RnYldU?=
 =?utf-8?B?UDJXU2xUbk1NVXhxb3FLZGVWQlZSZVk0KzNScURSNHF6VE9QK3NJQ2pHaytN?=
 =?utf-8?B?ZldhYWFFOENKRWZSeU9PSXVGTFBqLzR0WVBjWWU5cXZUTTZhSGdDeUo4N3Jk?=
 =?utf-8?B?TmdWL2VDV3BZNDdoTlMwRG1ndlp0OFRWaXphQ2RBak0vV3VEUUtvaEZDb3ox?=
 =?utf-8?B?RDVKcXFoZUFHYkk4TkpZVGFOK2wrVC9zZFpjbll2MkJEdkMzaysxUnFZYk9V?=
 =?utf-8?B?TmtOcmRaK0JSVWo5MnlJRDR5V2xDL1BKdGhFaGQ1YlRzN01OaTYrNzBjNys2?=
 =?utf-8?B?cGtXYzkzc0NwakJPL0h2VEdDelU0VUNkbVN6QUlOV28xSEV0QVlhSDdyclY0?=
 =?utf-8?B?aDRsN044amtzRVRaa2NYVytOam9XRXQxZWc2QTZGdlpWNDZKdUw5MytNQkxm?=
 =?utf-8?B?THFscVB1dHQ0dmczbURadXlpdnJtY1lHNFN2S3EyYU9DR0ZNMUFwNytWWjVL?=
 =?utf-8?B?cHNZbGgwQXdXSi83eU5ML1lqVFg1U2p3MjBEWEY1V0pDNHE4ZUVHWXhTMndI?=
 =?utf-8?B?MDl0ajRSWVNMa0x2V1NueUJpUi9wK3RlSDhhcGZiY29XU2lBVUVLb0FnUGhM?=
 =?utf-8?B?eEE1U3JOU1JFQ2srN3JQMmMvVVNGcTIvNzdFQmw3QUtucTRXcW9vVjNNTmJJ?=
 =?utf-8?B?NFlqdEoxR0FDdVI3azNTTXJSVzhuSHJhR3lqc1RGTHo1KzdMZ29xL2Rpa3ox?=
 =?utf-8?B?QkFLVFhCL2V3R2J5ckMzaXgrWWZmejVjaFpxSWI0RG5HL2VaUmM4MVVqZ2FX?=
 =?utf-8?B?eG1sQ2V3WFhmWUhLWmFldGI4cmZwMUovT3NlSU1QL0N6cWVpMjZWY3hPMW5s?=
 =?utf-8?B?bkVpdzEvNTl5cnJpMys2TVBlNWRXMUt5cXBUL1F5SVlQWDRoYlZFdUJRc1Qr?=
 =?utf-8?B?ZXdRWU1IMEV0VEVjQzM5dEFFS3RWbmU5QVU1Sk5qQU1NU2V2dFRMTU1VK0Jn?=
 =?utf-8?B?ZWtMdFJxajRrYWFZVnFnRG1NKzR0UUd3dTR5ZlpsVUNHZksxekZlZ0hCaDNT?=
 =?utf-8?B?c3lTZ1V5ekR3Mnozc0tESzdkSWNoZTdyTWxOWHgzOE9yZ1d5eXJKYzNka1BI?=
 =?utf-8?B?MEJYazMyWnNWMzUyTmRqdjAreTBtSmp5ZG1kcE53VXF1K2paUHE4ZXQ0WDM0?=
 =?utf-8?B?bHdEZkR1S0F0NG1TRXMwUVZUWDlJd1M2dVRKMERydzkvV1lOTVdUOU1KR3hn?=
 =?utf-8?B?UDc2N1hGZU5kUDZRRnk1TlVJTzBvRUk5LzRxSzVVNEM5Nm1SSTdxeTRiYmZr?=
 =?utf-8?B?YnBaSUxRTXZHc0l6cXh6by9Wd1NNM3RmaWVVdnlFTVRiMmt2SWVXc1NnRjcw?=
 =?utf-8?B?Qk9WQ3pVakt1WUZoUkZUelJ1RXBoM3ZPNHpkWGkwMElGbWdqUThhNUFKTCt4?=
 =?utf-8?Q?afN15SMM0hoyopnTk8x/B5iK6EGmjGune0XqJfqFBE5g=3D?=
X-Microsoft-Antispam-Message-Info: ysSxw/8WuA1B1h1lnYSn8Pctfnh1dHSPq/o/FznK6uwOQUFbRA7RvNJunp5vZejkiIwW3kziZtV8udz32baiNRx82H4o5TRColUPm/90OePV97bkp46a0XjZ2fvsTK/IHXj/WtWPqcJO2ig2Vb/ZMXc8yWeWzzcW1PC08J6rcZmARUcXaLyJVY/WTEW0IVob
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:pB6L3r3Tz74PDWggY7PQCp0XqlUajG3jiVFD+QboDMHVwN2cBs9n3teoe0Y5yhaSfcoyBNOH4H7Qzz65xoLdLiaO/NAKTx8PcJlM0Nwe2b7Hf9HGBbteCWTzjuGRItbEN4MIz+pCIiW5eRrfSXJmEPdGtsrj+YP13MWJAKjsReQ/sFcdvSrPun/xSPod5y2xcNvzsh0qdDnthPxtNnjmXIxN9rhep24ZwhDkLbd1vpyqe3AHZiwVX9NYsish5OyhU6LKhKDEk9BHwKrkNm3YXgXclIfL//vP4gsFTV1S4evBvCfgGr+87r/oPLHkOL1QAm92I+6tlKtMw9s1CgW0a6DaYN1mtHaxze1BfuoGIcw=;5:FKrnFLVtL8iNj9Ogu12zHf9qzZujKM4IR//SDYwEry/Ql5VBTQS8KFKHuW38Sh+JbAh4Qc37d10WAj8zb9A1AqSN8A5Bsv8AJ2fV1mZ5K3F3GSPkE9bu2l+k8TFFbdORGfwtBa0oWQdXAdyW9leQ+R1RyPbJ7OkBj/5G6/7GX24=;24:BkJTT9LHcrFeFBPzmDuoFK/AMm9Sh6SFPVJqXa/Oz4XwxWJcuQ2MzYgtxm3EBnjvuBKiJ5ppN8A1CK8MMyP4X6AvlHMXVbjDaJlWcgS+M7M=;7:fUf9bkV6oznoj0dzSXV7EIM7SU2sab6ir8oNj0M4HPuVFomaoE0hMoU3D8stlDbb11lsbfTny5APYUrVV4bMVQikkaLVMJ7MagsL7vfTcdxj6ZhR8aXIFY/1Z1gcwaTCTiY2+QxVIYrVu3eaLc5fy4cLvLsnVTk3M0GdnhLQXAIT9SIu8A9LNp3IiV84JvooCIIbHMJAEOLxYitOI/7xGufgqkrs/dnrEAEqyFu6f1DdTN8Zmxfof1UFQAjV0IOx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 23:10:00.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17900e3f-9fcf-4350-3a97-08d58dee8a5d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-19 21:50, Guenter Roeck wrote:
> On Mon, Mar 19, 2018 at 08:55:55PM +0100, Peter Rosin wrote:
>> On 2018-03-19 19:48, Guenter Roeck wrote:
>>> On Mon, Mar 19, 2018 at 05:47:05PM +0100, Peter Rosin wrote:
>>>> I also wonder if NXP will ever release a chip with part-id 0 and
>>>> die-revision 0? If not, an all zero struct i2c_device_identity
>>>> could be used instead of manufacturer_id 0xffff and that would
>>>> simplify the pca954x driver code a bit more. But I guess we can
>>>> never know the answer to that question. And even if we did, the
>>>> answer might change later. But it would be nice...
>>>>
>>>
>>> That would be nice. You could ask at i2c.support@nxp.com, but I guess
>>> it would always be somewhat risky since the standard doesn't restrict
>>> its use, and some product manager at NXP might decide in the future
>>> that a device ID of 0x00 would be "cool".
>>
>> No need to bother NXP, PCA9848 has already claimed 0-0-0. Sigh.
>>
>> But while I googled that I found old datasheets for the chips PCA9672
>> through PCA9675 which use a different layout for the three bytes in
>> the device id. They have 8 manufacturer bits, 7 category bits, 6 bits
>> of feature indication and then 3 bits of revision. The top category
>> bits are zero so it is compatible for NXP chips. But since noone else
>> has implemented this, it is probably safe, but still a little bit
>> disturbing.
>>
> 
> The PCA9570 datasheet is especially interesting.
> 
> "9 bits with the part identification, assigned by manufacturer, the 7 MSBs with
> the category ID and the 6 LSBs with the feature ID (for example PCA9570 4-bit I/O
> expander)"
> 
> Maybe there is a magic compression scheme to squash 7 MSBs and 6 LSBs into
> a 9-bit field, or the category and feature IDs have quite some overlap,
> or the document would benefit from some proof-reading.

Hmm, I think I'll put my money on the compression thing.

>> I also found that NXP apparently uses the same part id (0x100) and die
>> revision (0) for PCA9570 and PCA9670. That seems odd.
>>
> ... especially since one has 4 channels and the other has 8 channels.
> It would be interesting to see if reality and datasheets match; this might
> as well be a curt-and-paste error. Of course, it might as well be that both
> chips use the same die and that some pins are just not exposed on the 4 channel
> version.
> 
>> Example old datasheet (2006):
>> https://www.digchip.com/datasheets/download_datasheet.php?id=1098812&part-number=PCA9672
>>
> On the other side this has been corrected in more recent datasheet versions,
> so I would not be too concerned about that.

PCA9671 is still using the old bit field layout in its most recent
datasheet (2011). I couldn't find anything newer anyway, and the
link seems canonical enough...

https://www.nxp.com/docs/en/data-sheet/PCA9671.pdf

Enough of this, but I'm going to send a note to NXP about the issues
we did find.

Cheers,
Peter
