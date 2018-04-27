Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758974AbeD0RkI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:40:08 -0400
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:50784
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757590AbeD0RkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:40:06 -0400
Subject: Re: [PATCH] drm/vmwgfx: Fix scatterlist unmapping
To: Robin Murphy <robin.murphy@arm.com>,
        linux-graphics-maintainer@vmware.com, syeh@vmware.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <3a08f0343cb4e7a767601c59a381884121f9b751.1523632202.git.robin.murphy@arm.com>
 <85d48f28-5df7-8c7e-d175-ce651838db53@vmware.com>
 <8850b346-453f-e555-550d-7079b4f9d00d@arm.com>
From: Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <9c6981bc-5b86-29d6-d58e-c8988031c706@vmware.com>
Date: Fri, 27 Apr 2018 19:39:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8850b346-453f-e555-550d-7079b4f9d00d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CY4PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:903:32::11) To BN7PR05MB4580.namprd05.prod.outlook.com
 (2603:10b6:406:f2::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4580;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;3:b9wYrlFPGv8jN/cGefuXNOttBFOSli/LY8Pdtow/ONq3bU/aYV/+qP2JoRSN9E6DWnk9yEjmnUWLjwd0MysJZc5DJyQLEyHM7MzqlQnR1qHTwJMAG4qmSvyXslQ/+F+MqxNbNYWVu/7a98NYdM9GzQFtJbVuDLuA9K0MSFvjRd/HJnPblDjLIFU+NgubGsY+mUvaW3JTFu5ovCtQCfbiC8/m+0dCO3jJ2kPhB4x9p1MY4KSYZLM6w/9bIGpFR0G9;25:aeACSUPyPIoNahSpLEVv9SWjVuadnYhKsKL848uKKV+g2+3JCOUqa8DRirTnzO1jeH9rhuFS7Ou+uTyayT0CtV4UIMsDAe5t6+JEUIkEtw7wdS2mLBskGXD/nJDvBXCgxf1wCsfUG0KPnuXO7cJZIFl+BJjoxRmaTGz9BL+SuHl0SQ7YLAG0oHB77n9KU+REh1b+kRoW96SiCSLNyx2GllRTnc0dZ25+pqJK5COvgpf2+HHFlmk/9EiPb4i9QUGAiZ4IKn+xPB5eVqQDzEsjZPLColbTJJLPP7aJpUYTj4y1yRBUlwriCYKCQuC+7I+2bhg5SqbbE1k409AYEBEqAA==;31:b3QrXiMdprCV/2j2Qq0iP97r89aGTi66SUNl+SWDVkOL4XJ4x4h1LK8zkOZHM4lWPaVhpAfhX2cV9UmjJOqBzjPCdUPw3Y2pQgoPbbMj2sATNxjfEvh/er0y9ixH3I2krtL7751HdbgQekG0XFMn1QDLtLcihmtRCScGj5ZXP8nnh6rWbZaUeUj5wvbW1fxydDy4trGcjGqwdif64VSXP9spUuYKW9sOehQhpbfCcTE=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4580:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;20:dJ/bIcOM33hAgTmmokK4ga+ChNug+EFm+0NeXd9S64fZ6A0DUydIxJuzhydrRaHtWtn3R98yZs+qXSwbrjnR44aA+k2npa3nMeRzEgvnr62L5pbSW3+u/EcOmj1ygqSepiHLo+ot4MTRznmczMUPV8DCKu/Ihvh7gIvXtXHL1tarwhabbOvkKrfUttPQdtupik6LjBNK2J3/5LTvG+eMwcZaXLQC+Dd53HJZ7Eu8dtSVuM7usrj8uGoEsyKxKsDUYZsirvdHI1HmaiWcOLNp7itx4ROOLMN3nYpoGGit6yRwSk+arVI55qGBTKWy/WvQrTg5paQYchRK09hEK0S6zris/H6xfcbgDNq7zzHxlr6vp2ENmaOp0K1HsE1acpJleicGL2z7klEf2BVAwTF5AptABerRPCB9Gnv+g9VG5arqUySzQOzREF46beT6QKFEyDDhoSefr5ke2g82QetyUH/S6zyzUggRnVvqj0yjcnIS7qoMid5i2/MNR0kBNxyk;4:kG4twFb85SHQbjK622VBPyxajMvFRsJGkNEhQfe/xNRZINSIOro2Y05mv92+nXm3GIiPsr9/TVT3bjmRtWStdxURpDVFNY8LzKK2bkQ9lbW5F7W6pW2gYAP0xV6eXhwYcXiK6SJjXoQZoV4z8kaZaNarsziAsHnAsvM6yxLrWEUsKM1GN+4ckik+UM4cI/KhyYppow6lF9sxX57ckgwI6vweKk6BPIAwJ2Djf0Z1tp9gyCLC2fQixE24U8memAVz33Mglt4ElWM/PWKJ9ARlDifNvWNRmlp/J+4Y8sbonka+OTWPe1W7AxLgxW4ji7eAhC/ikzYi5zuzI9JDAOIR+Dupu/wBAyYdflqAvoHReWs=
X-Microsoft-Antispam-PRVS: <BN7PR05MB4580D1C307A86F90FEB4DB8FA18D0@BN7PR05MB4580.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(10436049006162);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN7PR05MB4580;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4580;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(51914003)(81166006)(966005)(52146003)(106356001)(6306002)(229853002)(6666003)(25786009)(6636002)(53936002)(6512007)(36756003)(6246003)(68736007)(105586002)(316002)(81156014)(3846002)(8936002)(97736004)(8676002)(478600001)(58126008)(6506007)(31696002)(11346002)(66066001)(53546011)(26005)(52116002)(386003)(476003)(67846002)(956004)(64126003)(2486003)(2870700001)(2906002)(65956001)(76176011)(23676004)(31686004)(86362001)(2616005)(5660300001)(186003)(486006)(59450400001)(575784001)(16526019)(65826007)(7736002)(6486002)(446003)(4326008)(65806001)(50466002)(6116002)(305945005)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4580;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA1TUI0NTgwOzIzOnBtamprUmxSK1ZVY3hoTUQxaWszWllsY1ph?=
 =?utf-8?B?dG5zOWRXL1VGdW1zbjJaRXJFL3BNc3BSaWtUOWd4YUY1Qm1sdnVESzhITVFv?=
 =?utf-8?B?bSttTUxHenpYRUFiSEs3THBQTVBoODZ1c3BMWk1TSEkwZEZyQ05yR0JoTFdz?=
 =?utf-8?B?MEU2UHlMM0FwQUtiOEdzN00zcEluNU5kYzlHdFVmR2wvZ3hNSlNITXRWTzha?=
 =?utf-8?B?RmpHTTRJUTVLUXp2VkdLKzNKMmp6Qi93R3dPemw2SWdEZGZ3cVJQcGV5WkhY?=
 =?utf-8?B?b1BKT1V4SFVaMGtjQnIvYi9FV085NVovbVB2eUFGUnl5c1pWVnE4YVNhR3Jk?=
 =?utf-8?B?M1lrejdGZzkxbVRQazRCeEVscUN4bjhTaStGTGhEMkJkZDVKemdicTZWZFY4?=
 =?utf-8?B?RW5xdmxjZmdpcFZWdm9kbCtzVURpdWRwcFhIRk9wUExrci95cFB5bCtPdERT?=
 =?utf-8?B?dUd2ZjR5SldldFhTNFdPQVJxeWpiUVZiZXRDSHFjM3poc1JHTmtEdWNOZmtk?=
 =?utf-8?B?SG1VcERKaFZ5MHVJUTlWQlFoZkNTbE5tVnM2TEdEOExsWXFzNWRsZng2SVYv?=
 =?utf-8?B?WStVSWhuaXZCQWZ2Ym82YTNhN3IzWXJyZnQ0eVIwcUh5Q3NSVGpWVFAzeU9R?=
 =?utf-8?B?aG9YV3o3amR2Lzk1Wno0U3ZidVF0WnQyQkhIYXpKelcreTlUbW8rVDJxQmIv?=
 =?utf-8?B?Q3dOazJmQ0JmRDhUZ2RRU3dDYVo1ZzUyWlFrVDZlSzJLMWQybjN3eHpxekEr?=
 =?utf-8?B?RExzQjRzaTJXb0o1aDZSK1pvUlpvd1pmK0FkbXRVcXhhVjBsZVAyemJxNmp5?=
 =?utf-8?B?NU5pcVdOeHhHeHB0aFdUVS9kS2Mwa3dycmM1dFQ1QVowUkNrclc1RWVoSFhV?=
 =?utf-8?B?MFl4TG0wNFBIdTFieDhORTR1RkhOV1NKRG5uK0g3R2c1VTY1My9pdXRrYkxB?=
 =?utf-8?B?TXg2dVE1VWFmTDlkM0Q3VmpmMFlBNjEvd3pLcmFKMExMSGxwY1hsdTdyMDZ6?=
 =?utf-8?B?WCtEZ0NrT2hvVTQyZVltMzRTWXlZVTNGaytvRE1OZXJteEhBVGxvODVsRE8x?=
 =?utf-8?B?Y0lnZVA5bG9KcnBCYUtrWSt1QTFFOFZsWXQzMTlXVHBjc3lYS2V6QnJKMElI?=
 =?utf-8?B?OWU3K3J4eGdrOEZ5ZXgxZzh6Q3lCQzhnbEp1V282Wmx4VlFqM0dIVG16cy9h?=
 =?utf-8?B?Z0ZoYjJ5K2JnVXAwa0lyQUhxcVpDSjhWdjhSdEJQeDhBdDhzbVBoSGxFeC9S?=
 =?utf-8?B?eFVndDlMeFBKQTJFZjg5SmJmTjZGZzBPc0dwZW5zUkszWktQS2Q4RE1OK2Nl?=
 =?utf-8?B?bXVNYXdOOER5NzNWY3RyczVvUzBIR0xlZGgxWVMxRDQvM0dVVTVWa2JZNXB5?=
 =?utf-8?B?Mk9qbGZ5K0VzUEQvelE1WEgwUUFQejRubkdZY0lMMDAyYXlrMHc5SmxUY3hV?=
 =?utf-8?B?NFpMSUc1UEMraUF2YkVOeUh3cEZpMXhzODFsaDV5My8yTnk0ZlBMOGJZYjJw?=
 =?utf-8?B?VkthOUorWlpmTnBORVpRamt6OWhtMjROVHExWW01VmdzS0VqMitHaWxTL2F2?=
 =?utf-8?B?eDRFeFU2QjhNQzVYWG5ldkcwT21LSWdsZkplMnBvNWswZFh0RUdzUE5qdTZN?=
 =?utf-8?B?ek56aHFhclRNU2dFZzBJZ3hqL3UzSVJOT2xSYTEza0lTRTlBYlViRVNpaERv?=
 =?utf-8?B?ejdObHBGeXg0K3ZGbWZLTGExa1B3cUo4dVFmZmxKd2c1MlkxOURXZmc3L3Vi?=
 =?utf-8?B?ajRTd05OVi9BR3pjU1hHWjUzb25UVkM0WnMvZHo4bTRQNlUzWU5CVHhnUVNa?=
 =?utf-8?B?d05FTlRHMGhheUlyNDVkejhvQ3RKYVFnbXJIbmVXTmw1eUhwZHRub0taWHVB?=
 =?utf-8?B?NWFZT0tOdjA0ejJ0a0JIZHRTRHhhVUlha0IyMHlrbWdRejFMcnBmR2g1NmJ4?=
 =?utf-8?B?RU9iamVXeTg4ZGZ5VjFJM0NiS0RZYktjUCs2Tit6UENiN2JpcytSWW9DZ0ls?=
 =?utf-8?B?bHpGSWpNQjdvUkhTVG5VWWU0QWRtUlBkcWlhNkE2Q1Joem5rRitjYmd0dk1L?=
 =?utf-8?B?WStGaWMrZmJvYkJGUTJkVEt2VlVTMlIzeVlia3lRSmJBS2xzSmlSVTlBZ0J4?=
 =?utf-8?B?cmc9PQ==?=
X-Microsoft-Antispam-Message-Info: BCzABfxXNEaTCTdLUNPw16vkIiF9a+jODl6iGDSe0OcsLiE7YIcXXQA18/NzqjRoPgaWRzcuAmStJwXpVOJp6kpDxxCuQOoazYAY8PMlIEct2w0el7iy5UfpQOf18DxDxClUxrLCaYKSvUvsRbXO2+nXOPo3JaE0ysV2oYRNtgaTe7gK8sAJZQm9VFQnLTdP
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;6:ydIvxG9bqQnmexRg2k2j4FR5zEjZGC4QbsQu+uMHvGo1vjg02zNlCha1LvQr/HwoFi590FSJcS8/tAJegfTFWBAGyQEs+P6IJITKPx7hVpdAr0Q26qfPuxQ3tGAVYl/fVTQA7CI0dt9kV+u349W7Ze0ON/hTWveyvBGzzVVPx7QPmqCJHYB9cMUbibzJfauOipyAdIzefz8PbmIhx1gYoZ5r1vvLRB/KsCXOnXH4sVC3RdbqaqSE6peTVHgoBBOnTkhCBT5ZTI96/U1DHKDAGHKaMfct3HpLybnnCAdBqndZ8JM7ON2epmO5XRgAa/pGyr0q8DI7DxruPMkbDi7VaKlapQsbvAc2vL3RX5tXPo2e7yhAVF8XFNwGqeZTPUa/lAxoPceNWC4L+CIBzjqjeoqMc9PgxNtbaJEPNYkkHFD6/L/IsmO2GA6AHxDPaIImo65tUcxRBarnGzx7chKxvg==;5:hmDkF4Bg/+shJFJswQNet7KtwhPXa1igWTzLPjUOb25D0eWp5WVyPlZTOcrcPtTdEore2zPgaSB0KwJsVdHD7BUzrljCC25bbKF1DCnoEcEb3d815jxw1GChVjvBdinnGzhdKexoBEZXelln3Yx7p+MiDiPupXLVU4d9Lu/Ls1s=;24:FzvxWYHUMcLxF2EJzrY5pM/CzLj+VXR4U5sxI1VKS5xrWf5Tznnb7MHXC7FL+wfW5lEza06EE57hcylXQP5gZzydvOM7eBZJAWAymhyfw24=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;7:85vY21/3SdwjdFMz2/VS4J0Nr2jtqHlgWh6x9OhinmzmyPdLT9cof4qGQpVmSMtnJaUl1zA4kWlJJHU2HxeJJAz7pKv00YsidCIHCV4J0ABwqCP3OmPsB4q46WQsmnY0lwO6tDq+1pK3Gyd/pShAU03En51j7vxRdC1IMzPfjTAh/j5t4sbjIM8/au8YUFKPIhorniJ7FYM7nObWnUHiYGnAp6ZT8kc3vdrnlCpzMmSfs9Ry2YXUIuk8A5FwdloR;20:SKzWvfxoX+DT9i5DqRhp9t3sQ1dN0R5HsxHdDymDn//EmfHe5opPK1iFeq0hzvHCfmQdnBTiGRTUWyPeIJtILUMLY6Dd4qgYMTpBCp2KjGtbDxkD7YGEbPWwoU5PKHCGUsccUNNJ7xWAxphih+q91a6SPd5V85kXGFw9pBxxm2U=
X-MS-Office365-Filtering-Correlation-Id: 86ac1b25-1cc1-4ec9-32d9-08d5ac65e946
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 17:40:03.3829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ac1b25-1cc1-4ec9-32d9-08d5ac65e946
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4580
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 06:56 PM, Robin Murphy wrote:
> Hi Thomas,
>
> On 25/04/18 14:21, Thomas Hellstrom wrote:
>> Hi, Robin,
>>
>> Thanks for the patch. It was some time since I put together that 
>> code, but I remember hitting something similar to
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.linuxquestions.org_questions_linux-2Dkernel-2D70_-2527nents-2527-2Dargument-2Dof-2Ddma-5Funmap-5Fsg-2D4175621964_&d=DwIDaQ&c=uilaK90D4TOVoH58JNXRgQ&r=wnSlgOCqfpNS4d02vP68_E9q2BNMCwfD2OZ_6dCFVQQ&m=UACKfhMfw9wac0BNUWXnAiivjaBgY_jAEupre0zXoOQ&s=8NQNd-XBCViYHJH4fHk-RluFYd9CDjbYzXl_BWhC0ig&e= 
>>
>>
>> Even if it's clear from the documentation that orig_nents should be 
>> used.
>
> Hmmm, it's odd that you would see issues - it's always been something 
> that CONFIG_DMA_API_DEBUG would have screamed about, and as far as I'm 
> aware for x86, nents and orig_nents should always end up equal anyway. 
> I would definitely be interested to see the specific fault details if 
> it can be reproduced. I suppose one possibility is that there's some 
> path where you inadvertently unmap something which was never mapped, 
> but passing nents=0 means you manage to get away with it without the 
> DMA API backend trying to interpret any bogus DMA addresses/lengths.
>
> FWIW, the rationale is that sync_sg/unmap_sg operate on sg->page 
> (which can always be translated back to a meaningful CPU address for 
> cache/write buffer maintenance), not sg->dma_address (which sometimes 
> cannot), therefore passing a truncated list will have the effect of 
> just not syncing the tail end of the buffer, which is clearly bad.
>
> Robin.
>
I agree. I browsed the current software- and hardware iommu dma backends 
and all of them seem to set nents == orig_nents.
Still, according to the docs sg_map() is free to erase any sg->page - 
related information and given that, it would be more natural if all 
operations after sg_map() would operate on sg->dma_address. I mean if 
sg_map would truncate the sg list length to 1, and erase all other 
information (which it clearly is free to do according to the docs), it 
would be pretty meaningless to supply orig_nents for the unmapping 
operation?


/Thomas
>> On 04/13/2018 05:14 PM, Robin Murphy wrote:
>>> dma_unmap_sg() should be called with the same number of entries
>>> originally passed to dma_map_sg(), not the number it returned, which 
>>> may
>>> be fewer. Admittedly this driver probably never runs on non-coherent
>>> architectures where getting that wrong could lead to data loss, but 
>>> it's
>>> always good to be correct, and it's trivially easy to fix by just
>>> restoring the SG table state before the call instead of afterwards.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>
>>> Found by inspection while poking around TTM users.
>>>
>>>   drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c 
>>> b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
>>> index 21111fd091f9..971223d39469 100644
>>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
>>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
>>> @@ -369,9 +369,9 @@ static void vmw_ttm_unmap_from_dma(struct 
>>> vmw_ttm_tt *vmw_tt)
>>>   {
>>>       struct device *dev = vmw_tt->dev_priv->dev->dev;
>>> +    vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
>>>       dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
>>>           DMA_BIDIRECTIONAL);
>>> -    vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
>>>   }
>>>   /**
>>
>>
