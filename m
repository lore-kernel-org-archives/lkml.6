Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934566AbeCEL2s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:28:48 -0500
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:63873
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934548AbeCEL2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:28:46 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
To: "Liu, Monk" <Monk.Liu@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
 <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
 <BLUPR12MB04494D7F15FC7D557D58488484DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <f40975c4-c5df-c06c-9a6a-a96705232461@gmail.com>
 <BLUPR12MB04491D607CA17302B4E5524584DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <210b7a03-f309-8ab6-0f23-17377660e664@amd.com>
Date: Mon, 5 Mar 2018 12:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB04491D607CA17302B4E5524584DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: VI1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::34) To CY4PR12MB1301.namprd12.prod.outlook.com
 (2603:10b6:903:40::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d96c9e11-808a-46c2-e5c9-08d5828c4172
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1301;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;3:dBoD94YDt/pcRTZKU/XEUiC55ms+yPWcr1VkCerVYhg5UKAwy+ZMKqUgxPeSGmKvnlCXxNPGADqmJY8FfVTqZfU/2d7ux1VN96c+PK2hfioAzKvQFa25GemnuG4tQUXL1Mm7/Eh2Wfo6iHiighhYsfmh+4AVpIJaDI8pO3xkHDxOlcAc2cb690rE+1MT4Zu73SNy3jnNVtniJYQHuiZckLElhertcwIiZRnmDpW+ozmctx43rTcr3+ucqHLk8P9u;25:ZDNRi7XJr44jNhpzmpYZCCn0ryDGI5JoGNxWtsFkVY3mNni1guWLBEb3AqyZi8IBWe+gJrl5DQGTgpJ+tXJ5HmPbWfVQTtRp07zYggK7ewkEYPhwLM4QLDJFidOlVfX+RkDQuc79fdexnO9cvk3Q5gNlbSi5J8FFln08i2DK3bAhOIu8vchi3KHIn3vCmpjRy+d0nusBkTX+FQaBK/F8+5SPZ0N83cn3xcARP546A4Jq6X0FM7BKyQP+zsoFqHIBAbx+Vi+8gD41pSLE6G4II6V4/Mi93ZUttx8ikaRZBnbVmIYb1dgoC/27ISjhv+rGDp/HltomjjEutqwNx2jFTw==;31:bDPn5fXC7f7e+aZHitYNsSfLbiPUAgeMW8zMNfZQf+Y7Esa181g7q6NxidI8Ibofjd2/QU2Q68qbJNRqzOBQBvvjEovOorHXpW7q9wZvqGYpDpWOzp3GfGnYUzcg66PpKIJ2oIjieVx08mbodZtSO76dLUQICp1BRUe7gmsWYkqpb3qEEWhTcct26kHgO/4LBK09Kk6BMesWlsX6INVO+3UhJ9TWIrbp0diDlNPau7U=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1301:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;20:A2Z735wxb1hwCYP3LgKqTWdHnBch2eQUQ18VzhkUiY0Tnz91TdhKE44Ed8O49bV5wpzPq3QKv3eg8MDdyXjBsXUDkhmnPiMjGkT9OTRLLmmMHkdvbWKwn6C9dnxcBMKhkRqpBf/LbbgHwg6KYw/inAJRGzB9aQqiFw7Wzuo4Hvn2YjfELDYKohst34QqBHblic0P6Dmf4xWNcuMVvUhoz0lz3/7gHobPX1icOArct67p8eEeqoMokoMXsoO62p0ePoA88eAnnAuDZkXA/gjalwV/VTQTFnT3exSpp44iFBzWsu7iR8Hscp2dOFgFXziEBwFYW9jI+MdRAtlGgL2POd+LAYElFjxGGWdp7I5Gli8EvBLK3F6g+CaEEuqSKxaKqZ3byrREJ4nviH7FlGQNdtYhfviNxQxxtFcWSjQWK0kJ+kMEZ4Z0iUCgsRKZMOZcS3ErEeWPbU5ncDCET9uYADCKoEta3JiM1JCv3ug7dZHx9Z5nGz6cUWajrwYKS5AS
X-Microsoft-Antispam-PRVS: <CY4PR12MB1301AA6AE1B81FA96791D77283DA0@CY4PR12MB1301.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1301;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1301;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;4:BLFf5d/vAgBDvd+3wuQDwwarp/dxIQjUAs+m7Sa1FMeksOBfYHGcs/okceEjSixmBvh5ozkT9tc5hxx8+Yf0aT8eKqAM1qI0ze7EePPycmxschhJPtPbiM6iXBelXmSAOYqFFnlZYNC+zwh7i/YDH/ldY6TKZYBr7HGPmInzKz/uXytG58CJXDa1iehbGlxTpJqKk0Im6O3UCR4N+EvdsdS9MMQfB43yoHKFWQYd0CvhPAQVPBfM3qQjeg9nzT/ZmsivhVy02XCaiRn1QW+qKM9fALQhivK9gQV3dudMqiBldA5FNwpLALeobYSbnWm6mrYeJ3RsJXeQBVIwoKjTA1fhod8rKKXdMKVJrjnzCgadT3mYRfuky2XsGa39trsli+eZN8XHn8D8/HOMmJB2YJ+8BjRYGljiR9HsMai4FWiE3nO5kD4n5hE0XjaOVqwH
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(189003)(199004)(13464003)(86362001)(31696002)(6246003)(36756003)(6116002)(1706002)(65956001)(53936002)(65806001)(67846002)(2201001)(25786009)(6486002)(6306002)(72206003)(2906002)(76176011)(2486003)(52146003)(52396003)(46003)(23676004)(52116002)(478600001)(2501003)(2870700001)(966005)(105586002)(93886005)(50466002)(58126008)(47776003)(5660300001)(110136005)(16526019)(81166006)(8676002)(186003)(8936002)(81156014)(316002)(65826007)(68736007)(106356001)(305945005)(64126003)(59450400001)(6666003)(7736002)(229853002)(97736004)(2950100002)(53546011)(386003)(31686004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1301;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMzAxOzIzOk9Eak9ESmxrZHUydlhPY0R6QmhncytoTldx?=
 =?utf-8?B?bkJZUjJtbFIvV0RWQXV1ZXJOb2RQU1ZuYnlEWndRaG9UR0J2a2RMZjZHaW9F?=
 =?utf-8?B?QmI1c1VkZk4wQmYyRHJHenpvdzBhQXRaSmxqbExiQ2JHbTVLSTAxampmY01z?=
 =?utf-8?B?bzVzd2lWK2tEQzNMOVFpRFdnZzN3cU04eEJCR2ZVbmw0S3J3RDBobmVuUWZl?=
 =?utf-8?B?NUVxRTJmWUM2QTJIQ2NkWHpvenNneE5pMEl3MmhzTUYwNXVqak15cURlc1BS?=
 =?utf-8?B?aEFEbW5wQmFSZFd5M1pITEU4MytQYkdyTnRmTFFUOWx5QzR1Ym9wYkFFaFc4?=
 =?utf-8?B?ZGFicEc4TDlNTERDaU51UWhYUG1WZ1gxREdLMTc5dmp5b1dKTWZ1dlVPVmJx?=
 =?utf-8?B?YkR2eHJ1ckZHMTF4NUdEVmRUYTRiRm51eExsSVNYRnZQMEVTckR4YVVWNlMx?=
 =?utf-8?B?VUk5anViZjZLWjdqRmllNDl1d2d5d3FFZTFFYnFNaEcvcEdrZWd1OERkN2dS?=
 =?utf-8?B?VS80QTRvVnBQeUJocHFZNmxUM21taFpRTDNrdjlpd2V5L1ZEeGJVMFN2QVFk?=
 =?utf-8?B?YWNCa05hY05OUVFFM0x4cWhpRXZvcTlFQXBhRXBPY05pL3plUW1hdnE3aFRp?=
 =?utf-8?B?SmxpUUJsWWNIaG9JRURBaGhpZFppcWsvc0JEa2wrWmsyaTRseUl4MnZ5a3Iw?=
 =?utf-8?B?MlhJcHZBNlptaFVQdTkyTEVjb2xEdlI4d2c5V1hZeUx2ci9mUUZ3VTZ2YVk4?=
 =?utf-8?B?UllPK1h5WlJaTHI4aGhnVDU3RXlsYXlhdXRUVkxvaTFJeE5MbFdWeWk0KzJP?=
 =?utf-8?B?NUZPOVNwZEVyR3VXRWpnZXQ4dlVHN1NKU01Qb01rQWRkdk1nU0h5eHBhandH?=
 =?utf-8?B?dEhmM0JUc09OMTZkWTM5Y0FmZnNWWkJHdENONkcxaW9ZUlJxMmdiZnNYY1ZT?=
 =?utf-8?B?USsxV2diaGVmQTdrTUVvdUs3dDN2bDFNN2xpSnBWSTl4K0xrbzNxalRrYVc3?=
 =?utf-8?B?NW9qSlJxKzB4RUR4dFVkNEM2QTVFSUQ0bVhEODU1cUJuVXhjSkZjR1hEVU1o?=
 =?utf-8?B?V1FFaElJclYyeDRhY1g0SDdHajRQT0ZObWVzZ2Z6RlNxVm1SbjJLbmMwMjMy?=
 =?utf-8?B?SWFiTW9XNERURTJDZ1ROMEs4UCs1aUVkQnFhZWtIRVMwb2x2NWZvbnVPN1Bz?=
 =?utf-8?B?YVRpWTBET0gzSGlLVmY1ZEFCbXR2eUs3ZGpDZklQTmdxaFNaZ2JWbi9uNGZN?=
 =?utf-8?B?L0dPbEx4cnl5TzV5VUp3ZWVSMkdKbk94cjVTWUZxeVNnU3Rna0hJVm1qb1Zt?=
 =?utf-8?B?Q1hINjVKMzZqNVhhWng0VG9EY0prZ3hYSldlWUlzeDdLdDRNMXc2TFQ2SUxU?=
 =?utf-8?B?OTVHTHVzdDRFTi9kdmRxaVNQeTJkc1JlQ0tJZHhLblFrYlc0QTdGRmsrUjhq?=
 =?utf-8?B?LzFIMExhWDN2eU1ZRlluOXp5ZVdIR3c2RzJ6WWFqaEVMMGFHTFAzMmJnQlJB?=
 =?utf-8?B?YjNYZkFnZThCNHNDNFZ1SnhOL3VPdlNpL3VTeTZXVDcrM0QvNGtwNDMvZ3Ju?=
 =?utf-8?B?dlk2ZjdMUEprWTZzUUdleGtXamI4dkl5V1JMVWgvQ25aZnc2NUZ1eFlDR2Yy?=
 =?utf-8?B?RXZsL3pWRHZOc2FSN0dLR3pHSmo2TitDVEVLZWxCT3U1THJqb2IrTyttcXY5?=
 =?utf-8?B?Tk44cW5VU09jckM5MUIvTytDZUxoMzNKbWdaUE9XTXlwTWh5blRQeW1jajNv?=
 =?utf-8?B?aXVWRERHcHZIZUVTRXF4cmNhaFpVOFBkZklSWkplWFpMaEM5bUFMV3c3R0l2?=
 =?utf-8?B?TWVTS2hKMjgvS0pZYjZTVFNiWER2YlYwNDF1elBlNmdYa2dtTVFHeFIySVNs?=
 =?utf-8?B?cFlVOCtqUFIrdEJPbEVMYWhtc0h6cmtHOXN0QUtQQ0d5SGdJeXptZVdSeStS?=
 =?utf-8?B?YjNGV21oU3hSeUdCcVBGMUV2WDFHY25sZktlQnpobTRINnl6b2UvSzFQSHlt?=
 =?utf-8?B?dCthWnpCWEZkK0pHNVlydnhCWEhZcnJzY1pzQ2wvNjR6S3kwd2syRHIxUXVZ?=
 =?utf-8?B?dFUybm5seVhjamZoNG5LZUFxQXZKSXA1TEl6L2RHcmJWbmZ0L0t5aUJWYUdr?=
 =?utf-8?B?OEE9PQ==?=
X-Microsoft-Antispam-Message-Info: rVageNvEfc79D3KkRCho7pBLVFZKxjX0vYBXRjBCZnTDQvWvXF4WluODpr/8QMpm0atQ4m20OabL+suPUSi/YV3MunWscvskHO6wXqfUCNRW46sqv38lW/4XW8TvdX1+croBTHLeDGLLbAHbC6ttZ8GvoLBVFNq+XReLtCWjk61m1OsVdxGRC1C5tRo3EpkI
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;6:a28DjM8I3KMcowf5Gt7ENhLkDzkK268XczsduHkXa3ncLXIgUs7c0d62xMdeVJPCzOMlftPcLEtaOZm3gtzuH0cG10Dau664fMxG3dAQoIEWcpMbbCtVn+UmG14yRBm5dfBw7r9+Ys1QoKgh99N0+0sv3J5I7iGA3Cg16e19T2J16++es9DR4v4b7XVIO21236GG0GLaRg5sup659iu44qWeSdoBfzhLbnlF8BeogxqVu3UgogtDjwLzmawcIk0Sj3HmtFIWFDaXTLbiiz4NxgpI8DF7bWtxaH4W8Z1KvlqdjtCY3UtH76X5q+Li2Yp8TVsAU8KAHho5SE4zlQQSTkipsSHVPEesYYlIsdkk7hg=;5:PAFCl9uRZNTPLH8qLzfdxUEogMn1mqzK1/uTq9c6tPsYcUBoEcveKNK2vc9kurrdJtPeevTKnPUBMYcszFlLPEMaWZ61tXgRGUoTReV5K3mnNpmdsjE3R77tWA9gWuVHXqjy2bNkQpWMQqCdCkh6Dz3ACVnJlbK09ov4Wy6o/y4=;24:4MLioU4WzLvsTrADIEFs6AxgyL9mBAekkA1vLksmpnnrNBV93HgoRD7yiG//OaXNZ+fTxhijP0eZqF3kqgvcGIP6HrO9icTL1ULF84+Q+Wo=;7:KqM3VDu8hhE8VAGvP3zw3P6uGvAsNCzvGHTlqDGa4TlOjU/clDJDxcLpBVHsjbNTkm9+loGlJUSoUyFeBQbwOii375P3SZeLpiDycFF6+JbNoX3p4PdjRCOZ1IcEMCkzcKAJkMtNJS1/yteEaTNtBCQbQf5oVha1PgpFpDI9f/ePLSj8bLLgeLxuQrq35E6tRvgQrOVEpdXuBDLYoNYO2ZM6JQ4m33gkZ7uzUkk8NAHcjainiDcSBX3TztFBk6PB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;20:LSN4c5s+OiLoglt+4fT6pUpTPxmPXNi3+QGuZfBmdc06Em57pQgxFyiDPs31gpFKLKR4p1HoT99taxGyKd5pOnxfm+GNE1uPsjzQnHKD5F2B1yYvgGx63naVZvwnTa2xoIUJZUZ/Ey7kcfTmzwowQAv9C6UWTm2QcS4UgGMtweu9eG+Y7CllKbxbseMhrIad2Q6/vdI5KgE/X/uomX693wEBaUCIlkLGFn3tFlHRMUweMSKUCXwwwTGL88cXu/Mf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 11:28:43.9107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96c9e11-808a-46c2-e5c9-08d5828c4172
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.03.2018 um 12:25 schrieb Liu, Monk:
> And by the way, I add "if (staged!=NULL) BUG();" prior to "kfree(obj->staged)" in reserve_shared() routine, and this BUG() is actually hit,
> The stack dump shows it is hit during the vm_bo_update() in gem_va_update()...

That is expected. The staged handling just makes sure that there is room 
available, it doesn't guarantee that it is actually used.

E.g. we can end up reserving a fence slot, but then find that we 
actually don't need it.

Christian.

>
> Besides, the whole reservation logic still looks a little weired to me ... especially this staged part ...
>
> Thanks
>
> /Monk
>
> -----Original Message-----
> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
> Sent: 2018年3月5日 19:22
> To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available
>
> Am 05.03.2018 um 08:55 schrieb Liu, Monk:
>> Hi Christian
>>
>> You are right on that part of obj-staged is set to NULL in add_fence,
>> So my following question will be why we kfree(obj->staged) in reserve_shared() if staged is always NULL in that point ?
> Good question, I haven't wrote code that so I can't fully answer.
>
> Maybe Chris or Maarten know more about that.
>
> Christian.
>
>> Thanks
>> /Monk
>>
>> -----Original Message-----
>> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
>> Sent: 2018年2月28日 16:27
>> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when
>> slot available
>>
>> Am 28.02.2018 um 07:44 schrieb Monk Liu:
>>> under below scenario the obj->fence would refer to a wild pointer:
>>>
>>> 1,call reservation_object_reserved_shared
>>> 2,call reservation_object_add_shared_fence
>>> 3,call reservation_object_reserved_shared
>>> 4,call reservation_object_add_shared_fence
>>>
>>> in step 1, staged is allocated,
>>>
>>> in step 2, code path will go reservation_object_add_shared_replace()
>>> and obj->fence would be assigned as staged (through RCU_INIT_POINTER)
>>>
>>> in step 3, obj->staged will be freed(by simple kfree), which make
>>> obj->fence point to a wild pointer...
>> Well that explanation is still nonsense. See
>> reservation_object_add_shared_fence:
>>>           obj->staged = NULL;
>> Among the first things reservation_object_add_shared_fence() does is
>> it sets obj->staged to NULL.
>>
>> So step 3 will not free anything and we never have a wild pointer.
>>
>> Regards,
>> Christian.
>>
>>> in step 4, code path will go reservation_object_add_shared_inplace()
>>> and inside it the @fobj (which equals to @obj->staged, set by above
>>> steps) is already a wild pointer
>>>
>>> should remov the kfree on staged in
>>> reservation_object_reserve_shared()
>>>
>>> Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>> ---
>>>     drivers/dma-buf/reservation.c | 7 ++-----
>>>     1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/reservation.c
>>> b/drivers/dma-buf/reservation.c index 375de41..b473ccc 100644
>>> --- a/drivers/dma-buf/reservation.c
>>> +++ b/drivers/dma-buf/reservation.c
>>> @@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
>>>     	old = reservation_object_get_list(obj);
>>>     
>>>     	if (old && old->shared_max) {
>>> -		if (old->shared_count < old->shared_max) {
>>> -			/* perform an in-place update */
>>> -			kfree(obj->staged);
>>> -			obj->staged = NULL;
>>> +		if (old->shared_count < old->shared_max)
>>>     			return 0;
>>> -		} else
>>> +		else
>>>     			max = old->shared_max * 2;
>>>     	} else
>>>     		max = 4;
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
