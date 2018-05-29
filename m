Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeE2HKw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:10:52 -0400
Received: from mail-db5eur01on0124.outbound.protection.outlook.com ([104.47.2.124]:10810
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751444AbeE2HKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:10:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
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
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
 <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
 <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9ae5fc1d-9f02-9742-f801-2252389294eb@axentia.se>
Date: Tue, 29 May 2018 09:10:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::25)
 To VI1PR0201MB2462.eurprd02.prod.outlook.com (2603:10a6:800:54::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7026125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;3:IgMDNpZX/1eGeiDXizSPET1zJONrVdglAwjdsZHZIdp5WTa46PyCqdd3lQPaYBxU266kRbpFD8xhJ+DFUeKE/ckDXOvYkgINk0QCvimJ3xQixVz9JAAQ56DDozoS7bBgMU66idM3ZCM2lgRGPsx0QU0rUBfxmbpFm45mwG+9M8HgQ/B3V0jIPiCkLjOyPnPjIak89DRKzgDU+PGOTPY42/jfm+1IR6xleBOEXG6x/JA3JrNi9Iu/5UZsu+fBt/D1;25:TZtmoyVmSnaVVg9wLoaDYX0TNBak8Nhd0IcNf95K8K5RYMelJNhc0FXzS4FKYyIRkQPk34mxxyj+DF33p0e++pnn4eBPZkSJpVCb1B18yImGnTrEQRWkKgkOIRQqvGP1Gh5j/8N9HKuBahqVaLGkYgWNepFRTU03XnaFGyf1H6AOk3Es0FoG+bJaRyY1exT9Cv++fYIJi/P82eWV+V/bjd216ZIBMGOMba/heKKp2zvgLUKAtYfFgMbguUS51wkGWBKg3OIBxD9gppVbB0vrnMGgyzMzkfMpSRW4f1svQbgjs/KEZTz7mPijgpl4HBlRbxC1lDFDTPkD67Q7a6a+rQ==;31:1fJeMMHjhz1t5iScTuDVFPu8xI5NA6d52/YSCM3QwPAAaiJOX1YJJE8GcFEECwSNI1tWGudgZKJl6zEZ6EuQ24y4lzGb05AUKd3u/+PKhvS069Gqlo+QaPbNNsdwvFadB0UH2aBudDpkFZQ//fRL00FWXkwHFfTB45oypQE8E3Z4K9A5Jbli4pISWeNlO4MOw0lYuypQAoSPvDtz0/cddi4QBPJSjRDCtPLDzs6GN60=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2462:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24629AEA11BE37E0CE811062BC6D0@VI1PR0201MB2462.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;4:gGcfjFNESm6NmfzZw9qv6LBfzUgcC/mNrxnow48nmw/dK5FbZ1J/7mZSuVG5iXsPT2/9UIx02c+Q1e461vPK9l1nSIvNix8BEoYYVbAgeV9rwcKNwEK8/dMpRXEbW7DGumZFN1FVjWW0UPrfenJaGu0/3amL/V1VVosSnbP+Tg2AAwZBqrdNvorls9pwFhapfiA9hW88y+FocbKEONv787182tCUAhJEiU6Sr5L8PiE2T9QK8idOG3VAk/RNm8z6KVXSpuY/QLBoGTaBvMUs5g==
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(7966004)(396003)(376002)(39380400002)(346002)(39830400003)(366004)(377424004)(189003)(199004)(39060400002)(446003)(5660300001)(47776003)(11346002)(65826007)(77096007)(64126003)(6246003)(105586002)(7416002)(58126008)(25786009)(3260700006)(6666003)(2616005)(6116002)(316002)(16576012)(7736002)(81166006)(6916009)(31696002)(386003)(8936002)(2906002)(345774005)(54906003)(81156014)(4326008)(53546011)(86362001)(66066001)(97736004)(36756003)(8676002)(305945005)(3846002)(230700001)(65956001)(956004)(575784001)(2486003)(36916002)(52146003)(23676004)(53936002)(31686004)(229853002)(50466002)(486006)(65806001)(26005)(508600001)(93886005)(117156002)(6486002)(186003)(52116002)(74482002)(76176011)(68736007)(106356001)(16526019)(476003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2462;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjI7MjM6L0laQkh0THpPY3NGa3gyVy9ueFhhUlJt?=
 =?utf-8?B?ZlJPOEtySjUzS2g3aFh6SzZRdk1UcHRkMERsTHpQSkx0dnpSRlg3MGovd0xj?=
 =?utf-8?B?TmtWc2xFZ1k5QjY5eml0QVRKcTlXSDYyd0R4MEliU3RKOW5uMWpLWnZSb1ZZ?=
 =?utf-8?B?MDMwNlEvbHE4c3ZrelQyTnBJT1NYdzFHUDgyUkNzMzE2WG1Yci8zbFdadDUv?=
 =?utf-8?B?ck9BQU5Ic1N6U0VMTWI2V1VldTVVYXhXWFRKOUxWaTVIOU5JT2xSeHRFd3VW?=
 =?utf-8?B?UVRvd013d2F4YXM1RHFGOXhFbkM5SUxRbUxCL1N2MjhXSmpVcW03WWY1RUJU?=
 =?utf-8?B?cjRHZ0h6Mkp4M0x3M2l1cUNNNkxPYzd0dFQ0dGVlYUpjYWt1K3FrYm4rUG52?=
 =?utf-8?B?MHJ1UzQ3VTFwaXk1YXFTV2p2R0Fabkx2bEphVm5DUGhvakhNT08zTHV3bE9E?=
 =?utf-8?B?Z2kvS2E3SzMzUkRPSVFpN1hTeGpWdm84VlNWU0hBVnhmN3VWeVhyVzRERExI?=
 =?utf-8?B?YjNqWHF0eFpEVFN6dkgxUmdxVmdZOFJOd1J1RmRHQ016WDhleWpuZ2x4R2Z6?=
 =?utf-8?B?M1FuSlBOYllOMkYydlhpekIyZEZtcmtUMmZoMUJsNlBuUHBVcU1GLytzN0lI?=
 =?utf-8?B?M3JnM2h6RHJwejdpVWs5OEd6WU53ZUVHR0JmNzF6WXREZms4aGkzRURNVWdj?=
 =?utf-8?B?dHJPVmpIcHhCblM0ODZrRHZmTFJydUhoS2JnanNMOExKYVMzQkNZRjYzaGwz?=
 =?utf-8?B?UzIvc0Jhbm1hQzlQbWxRcVdmZ2NWeTJXNFBJQjR4djVaOWhjejRDYWZGanNt?=
 =?utf-8?B?azRvRlAyQjJpRkNOYlJpeWxaeUVuTzIydmdIWjRCN2pJYVA4QndrL0oyelBV?=
 =?utf-8?B?N2ZBQmZuN0RBRzRTVjQzdG5pTnZmNFRjWm9NU2UrVXduaWIyQ1NyenJNNzdH?=
 =?utf-8?B?TWEvS2tUUDFqQW14NlZzVGs3OXV0b3V5Y01LamVwd3ZhYmhjQ3Rrd2hBYUtG?=
 =?utf-8?B?Q005SS9KcnpFS1Q4bUpBejhCOG5kUzAzVjhPazh6a01ML3ZMMFVmT0NQMU1F?=
 =?utf-8?B?aFp4WTlEbHMrdnY0RzF3emN2ZHlMalVTeGRkdmd2WmwvOXc3bndFU2FlUHpX?=
 =?utf-8?B?UHZCeHp5amdUZ2Z3WFJja1VHck9OKzBzUE14YWRGdUNTQWk1UFdPNHNyaWUr?=
 =?utf-8?B?RVRVcCttTllJT204cjliNkw2VDJ1RWFodzNOeWVnclRVTzlrZ0hnZitodUwr?=
 =?utf-8?B?dzc2VnhTQ2k4bHFBOXJ6cUYraU80UGhjR1pSdEFJb3BKNWJhWnRpVmRHd1Ni?=
 =?utf-8?B?dW55YzZqd3o3azhZckx6YWtkb0FOeWhzU0lBWG5MVmxSRFh0UFdRdDUyb2Vh?=
 =?utf-8?B?MEFIRWhHZnZqSkJNcTJPeDBYaVdhQ3R0cjE3RmJZUmpmdXBUNVM2MS9LQ0RQ?=
 =?utf-8?B?UHF1OXFKT0tEbHZFeWM0RGpQMjJpc2V4ZWlYa3pHSldVSllzTFAyR3A4UVcv?=
 =?utf-8?B?T1k3OUZVWVlobWFwV3Z2U3RRM0UxY3hCV0U1ODl5aG9BajdyNXpReUhJZ3Nk?=
 =?utf-8?B?cGlDaXovaDc5YnNWSGZWT2dGWFpZRjRwZzVqK0U1aDhUazhlNlhNUklpSndI?=
 =?utf-8?B?Z2RNL2ZmaWhPK3VmNSthU3JWOWtDd0xsM21rd2o4dlBxMHlSbXJZZ2xTMnVm?=
 =?utf-8?B?UGE3ays1aDhsekVkR296OEZUQ2NObWVZYTduajZZaEYwaVdtRzhrQnZnbDVE?=
 =?utf-8?B?ZDFad3c3dFZ1cnJJclFNSFU3d1Nza2pRU3IzNllLN05pcHhlRzhZY3ZqTWx0?=
 =?utf-8?B?NEpnYlljS041N09GZEowa21NaW1SeVNMUHJ2RVJkQWRrLytGcUhmMDRCVUtk?=
 =?utf-8?B?cURUY0lUZGJ5MlhYdGdtOFEzdlRRN0xGRDNlK1dtUmh3V2l0dW1IZGZRVjZL?=
 =?utf-8?B?YlpXYVArN1N2dEFNeTMrY1FubTZrYjcwSSt3OGZXSXN6eXBzbWRXSExKMjRQ?=
 =?utf-8?B?OGJTMHpYa3NRTFpEbDUvNXhqOERidnMyeTdnT3FkZlROdzFRMENPMFhwWTRO?=
 =?utf-8?B?SmV1NnV4N2o5ZlVGUjh0amFiTVVqQ016bnBrejJUSWNOaGdFTE40eHlnNUtC?=
 =?utf-8?B?amE3QWl1cHJmeElQQ0ZoR1RFVWlOSFFRWnNFV0hCdk96Vmt5ZU5tVng5eGth?=
 =?utf-8?B?RWkvS0xKZklyMmZxUTVMSnkrSmlFbnllUnJRaFN5d2IzS1JUbmZnRXduWTZv?=
 =?utf-8?B?a0tpQlJRaTJONXFSQzhMZitYWXJzYURFeHlIdDFRdkFuMU4rc01xQXU1SVhN?=
 =?utf-8?Q?uehJY0pEQ5jX+Ppgxw=3D?=
X-Microsoft-Antispam-Message-Info: /avNMdDriGuWDUl31wpL9tmyBgHTFqpV5l6M7KAvHKCg8gPXc7ETmU5iIjnfTLqmB35Vrfbaf9HS9bvg/gIkMDSSOJyvO/q0GnOMoJBD6LmLJumHWi73gc4V0MTvBzu2VtTajNu07e4bvdLtBwg9t+/dZ+niYjFP+8Z3Va6PVbo6vIrRR7XTFJi7+gTYmNOi
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;6:/1DZKuKz9G6pdHfoK2wNQiB6ZNNznZnnqUwtScqnV/EmM84zEf/ZptDxlOSxeoAZLCqz/jpk0QjVC7CJ4HOHyDgxAW5WImVmdUfdSnXhpX7utIsZp2cjDcJkEg4iEQhaUnTEomS3J55IuJN9lcvTNFSJzgo2T7ILZfF+1B2gJvRGEKAh+VWQc1IZUIOvddnnyGGvHd4y0i33iwR3XqVOaWBABNvlaNgVoxEvlcbbrJc24Z1GWCHfFp91Qv3sAe0ZGKq05fDf3CrQcDkqfkrY94gsp+81dit/+s+l4PJkxrUAoc3bN52IorOeYtsdRvh2fC8H/yGROBto1yC2F1Cv2ygNX1nhdvpq4jL3Zvg1PciHYAoGKkLS03uv5LHFlp0BpfllbR/fraL9dL5PPHEMMi/SsKuYbGF3A4g9YIiFZU50irwT9aIi6Neu2FvY1nG/YsECEUIq6mDabeLTMB4yQA==;5:MZmv4YUO4l3YpWKGBJ9pg8TJvDwp+PPR6o0iteT6v23Dv2dpR1IS7Q0tFhHCLS/TJfkHzZnTiBT+0ULa7pWacn/NXVq1uwbd/eqFYNMcIBzW2knXiorICZGnB0aEG+08nMISaRl5c+i5F3gz0U+H/lZyIl1hPsKOj35XUG5vkFI=;24:JX+p7uW5TZahS0wWfSS3V2hXbJcCgG5GAVcsRFq5unvXR7jxPgnuPQ23D5cApLCDXcYkEemRcSJsalBms96Dn34+6lV+jOHFGrH0Yypxm8M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;7:aBfjz/Msk+quyMaLNhfrpl2pz57D851j6P0RfusmPPQZs3H3EMjtpOx5TvfYMzBlQnc8abqgFbua4CNPTsP2LQgWZWadcwMMueQCsa3eNAkB2s5D5sM73GKWr75Yi1KK268z3fEBJRb9OBForKpoloKlfOZQPgPlPIJgX0KLPTke1Ulni5RTPQ7COBPwiN9wMm1akQwj69knjLfz1E/1qsDmrun8AMtcGx/GHGh3TbJngjfhP9t1vrvCjV2Bjq2J
X-MS-Office365-Filtering-Correlation-Id: e31e74ae-5afc-46f4-c1c6-08d5c5334ca8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 07:10:45.1050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31e74ae-5afc-46f4-c1c6-08d5c5334ca8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2462
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-29 08:30, Eugen Hristev wrote:
> 
> 
> On 28.05.2018 13:10, Peter Rosin wrote:
>> On 2018-05-28 00:11, Peter Rosin wrote:
>>> On 2018-05-27 11:18, Peter Rosin wrote:
>>>> On 2018-05-25 16:51, Tudor Ambarus wrote:
>>>>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
>>>>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
>>>>> (7th slave).
>>>>
>>>> Exactly how do I accomplish that?
>>>>
>>>> I can see how I can move the LCD between slave DDR port 2 and 3 by
>>>> selecting LCDC DMA master 8 or 9 (but according to the above it should
>>>> not matter). The big question is how I control what slave the NAND flash
>>>> is going to use? I find nothing in the datasheet, and the code is also
>>>> non-transparent enough for me to figure it out by myself without
>>>> throwing out this question first...
> 
>  >> [...]
> 
>>> and the output is
>>>
>>> atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
>>>
>>> So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
>>> or how to find out. I guess IF2 is not in use since that does not allow any
>>> DDR2 port as slave...
> 
> Hello Peter,
> 
> Thank you for all the information, I will chip in to help a little bit.
> The Master/channel is described in the device tree. The channel has a 
> controller, a mem/periph interface and a periph ID, plus a FIFO 
> configuration.
> 
> The dma chan number reported in the dmesg is just software.

Got that, that was why I added the various additional traces in that
horrid patch in the mail you are responding to :-)

>                                                             Here is an 
> example from DT:
> dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(1)>,
>         <&dma0 2 AT91_DMA_CFG_PER_ID(2)>;
> 
> you can match this with the help from 
> Documentation/devicetree/bindings/dma/atmel-dma.txt:
> 
> 1. A phandle pointing to the DMA controller. 
> 
> 2. The memory interface (16 most significant bits), the peripheral 
> interface
> (16 less significant bits). 
> 
> 3. Parameters for the at91 DMA configuration register which are device 
> 
> dependent: 
> 
>    - bit 7-0: peripheral identifier for the hardware handshaking 
> interface. The
>    identifier can be different for tx and rx. 
> 
>    - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 2 for ASAP.
> 
> 
> So , what was Tudor asking for, is your DT for the ebi node (if you are 
> using ebi), or, your NFC SRAM (Nand Flash Controller SRAM) DMA 
> devicetree chunk, so, we can figure out which type of DMA are you using.
> 
> Normally, the ebi should be connected to both DMA0 and DMA1 on those 
> interfaces specified in DT. Which ones you want to use, depends on your 
> setup (and contention on the bus/accesses, like in your case, the HLCDC)
> 
> Thats why we have multiple choices, to pick the right one for each case.
> In our vanilla DT sama5d3.dtsi we do not have DMA described for ebi 
> interface.

Ahh, *that* NAND DMA configuration. Of course, how silly of me...

This is a setup based on the at91-linea.dtsi "CPU" board. That dtsi should
have the relevant NAND/DMA info. Also, at91-nattis-2-natte-2.dts describes
the older HW (with a 1024x768 panel) that is also affected, if you want a
full device tree to look at.

Looks like I didn't make a selection, quoting from at91-linea.dtsi:

&ebi {
	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
	pinctrl-names = "default";
	status = "okay";
};

&nand_controller {
	status = "okay";

	nand: nand@3 {
		reg = <0x3 0x0 0x2>;
		atmel,rb = <0>;
		nand-bus-width = <8>;
		nand-ecc-mode = "hw";
		nand-ecc-strength = <4>;
		nand-ecc-step-size = <512>;
		nand-on-flash-bbt;
		label = "atmel_nand";
	};
};

The reason is probably because the sama5d3xek device-trees didn't at the
time of "fork". Does anybody have any suggestion for some extra properties
to try in the above nodes?

Further, I forgot that I had actually upstreamed linea support for
at91bootstrap, so relevant NAND timings etc can be found in lpddr1_init()
in

	at91bootstrap/contrib/board/axentia/sama5d3_linea/sama5d3_linea.c

Cheers,
Peter
