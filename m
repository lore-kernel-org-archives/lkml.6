Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeEOJTc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:19:32 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:15392
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752807AbeEOJTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:19:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH V2] mlx4_core: allocate ICM memory in page size chunks
To: Qing Huang <qing.huang@oracle.com>, tariqt@mellanox.com,
        davem@davemloft.net, haakon.bugge@oracle.com, yanjun.zhu@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180511192318.22342-1-qing.huang@oracle.com>
 <2797ac27-022c-0818-388c-e4a6131ad1ca@gmail.com>
 <ff9c44ca-eaae-cb3e-4c69-e9e3cbb72ca1@oracle.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <1ded7d49-0ba2-3594-f840-74d7cf37a0eb@mellanox.com>
Date: Tue, 15 May 2018 12:19:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ff9c44ca-eaae-cb3e-4c69-e9e3cbb72ca1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0105.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::21) To DB6PR05MB3255.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3255;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;3:hSE62gYySKMfYWVay5tN0kPkXSU9WTDYpbUobc1A2fhd9TT3QWvdglT2u5wNnZPTXPohOfS4ai+Yd/4mM/ZyTNJ++qMXl8DlbbLxoYSVrhX6Zlx/Vy8a1N05qVEL4uKdWlQZi9BQSwyxgIo8nqutjb51Fvwe13XCYxdXQKZ0rbDssMK8rqawKLFcdPkPmplg3CMHkkA+UchZ3/Hs1wMR6gKlD6id3UhSVjGYPpHPMN0hiFGl9EDp4tTBW2+HBxvv;25:tCZftxM//tLcUuh7oAINpYz4sYE1B3Ex9Uri8W76j5+4ohx/F3S/WhuLfZnFodd+YHaQcmZ4yv4yAIyNrt0FI2Nag3g5eUyDoeHYSHcDS2YAkzNSluwvRYAhwPGR/jqODa0SpqYu0N6xxJCMdKNxiaqPJYzjfzHCVNS31xXEDwX3ojZnGjeGrVy/thnQJ4RhfGWInDEdG96XBJLTQXzbeY3ADW0HYkJT4gGBH4UZOvqSt11LPewqYrdq+xnrEgq+txbOWF88uVNhOsi0UxoUAPSvaMSahRdzht6bHotebEc5Vlw65wKm1ff2gm+fja6L4ry9w3e+c4vGIyh7NUfwYw==;31:8SVRQWdXt8Fc5TdFyHIA+CDHnceGRdGS5r7STdEVtT0Rtlhwq7B2NYBeFQTcHf3FoZyXGDSXK8x6s59NjMdhySzyd6FkRAW/ogWPGfPOkP5ElrVtsSX+w9s2MzxOKV2GcAnmrX+6iBqq37jvX8gGhEfBLb3JqT75oq6XWOPcNQDn/gXpUPt/rqqox6u0/OG8ZV91ZQ+u8hG2fuh5JKvHOdzr/zDg7IFr/E2euwdb+O4=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3255:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;20:gTiyWbU1Upn5PbiUkpRLlVnj4kErTkkRecg28A2PhMt2ctUlObDz/BkvLyjzliY9vri8tHSwQykTyahVn8uKTtBT3F36H7IpqwodUSNQsMQi1YRD6DuMsJHQrMqU+iTBEftCZumd85XiGZUmbvZpR91E5K9K+lelbPT1kGHAvg4Duy8WGlovWlGmyoGa8CNyLyhu+AAth3OdK3S0S3Q8OEznVJjOQVJyu3sCTn0AGwpDDJnfvQKMpVxOnTkEk451h6GU41XVqVtAzX1J/ycWpJ6g0a/TTv8yHRQ662vvE0h5Cdc8M9o3F3GvPb2fdFaUZ3ov2d9T+SQ5AaS0fxdDtglotETMoaN6FRb1AHgVhJR4Xl9salA+2zzSAWjmpzSxDZfRueH6VEZs/Mm2q6SPIbTMZBZ+hxwww9MoYw4Bxs21PX3bp1BzY9Q2fuozX9cmeLmCSBMoRtuEQ5RMoq/S59vo4+D+M+bT63Eh3/h/rp/tYIpKHOh2O4nDsry9NvXk;4:zHQXXId6+y0LyxIVC0b5uAjZQIKrrfnLPXmEAkoj70ZruoyH+2QE1osq5VB+K51zUmNUpfO/FL7rfQqaxuZ/cZkYd9ODn1GInGVqw2cmLUgSC1mxYcKTZgSRihvagbd5VbIizXl451nOfGOH/PBzgYyM/9TqPUYmJjBRU1YpYxyavValpmKRqpJe51pfzYYQDRs+VkGqI14vqJrah8YQWPV1xTIQx5Fjj4gvyGCYuOgTUWFaoE85GpA7Tx2F4Ipc5AnpWwhNd/GLdugHeQQmzv2QIhVUbvVls+aUZrup1CRZSIHT8CvOzuUuA7dTHZ8Uv/XenaQOcwv4TOoHCbWAKGYNlwOVEGA8qoyyE39hed0FIKeNtWMwMwrN6cxZLtob
X-Microsoft-Antispam-PRVS: <DB6PR05MB32555AA9AF0B852205EA5528AE930@DB6PR05MB3255.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(788757137089)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR05MB3255;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3255;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(396003)(39380400002)(376002)(366004)(346002)(199004)(189003)(59450400001)(8676002)(81166006)(81156014)(106356001)(105586002)(6116002)(3846002)(31696002)(2870700001)(25786009)(76176011)(2906002)(50466002)(31686004)(966005)(97736004)(478600001)(64126003)(8936002)(86362001)(2486003)(4326008)(52146003)(65806001)(229853002)(52116002)(65956001)(67846002)(47776003)(5660300001)(66066001)(23676004)(16576012)(7736002)(305945005)(58126008)(6486002)(65826007)(6666003)(446003)(386003)(53546011)(77096007)(26005)(2616005)(16526019)(6246003)(53936002)(6306002)(476003)(956004)(186003)(316002)(11346002)(486006)(68736007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3255;H:[10.8.17.116];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjU1OzIzOlduYXNaMWRKU2ZPMXlIbU5yZlk2dEhYYVpp?=
 =?utf-8?B?VHFBY3pxRlZxbHNsbHNuZHdjdEhML2dRRnc0NFFNUENKVWc4RWx0WFM2MG1l?=
 =?utf-8?B?dVhOd3BSZ1haRDl5U1dRbitMbzdtMnhoTFArakxlOUo1aGRMRklobjN3TjNq?=
 =?utf-8?B?VkRueVFnZU9nOW1taHBIYVVWRnRld0JtVmZnLzN4YTByaG5wVStHaTM3QmN0?=
 =?utf-8?B?MGRqY09FZTVJSHcwTHkwMFZLN0ZlbHdzemV1ZFZoWHVDNjZwbFZ4YmIvUlZB?=
 =?utf-8?B?ZkpZLzJEQ3NvVWNNOE03Z2Z0Y3JOSCtwZ1NybG5TOWVHRElPOGNLQ1l6czdF?=
 =?utf-8?B?NG4vT3IrUk5Nc3dRTzZtb3c1b0dndGdOMEpIRENZQWlVRks5V3Q0V0grZWVn?=
 =?utf-8?B?YTUvL3NPQkNDLzRhdWZpMWhpbnF0UmRzYlRkR3I4Y2t3c2dHd3NoUnlHaHVB?=
 =?utf-8?B?QnRMM1hiNXFpTUlqVHB3MjJGK1FwejMzSlRGajRsTDE0cUIxaDhBTEpuTHA1?=
 =?utf-8?B?cGNiQ1BTOTl5NG1xZVFvSVRGV3phRklBRkJvNmpQdzBnQ1c0UEhNbXhIbk9W?=
 =?utf-8?B?Njd6d0taWkgwRGloQWpLVUlwZTdVc05VOWhxTkJpTUQzRnVzb2MwdzE2bXh1?=
 =?utf-8?B?SXI5RERtU1I2VHFDTUkzakZtVkRIbWFLaW9HclUxTitDcGc1ZHN6c1hlTDJk?=
 =?utf-8?B?S3lrbjFTUTk1ZVZSSDhvSU16K3JYWFFoa1J2Q1dYNW45bVRra2NnQlBIZnQ3?=
 =?utf-8?B?eEFjcGFTM3hhd3FTQ2R2Vks0OE9VRW9TWks2cWhrZzh0Rml4TURMbjFhQmEz?=
 =?utf-8?B?SGQwTUtzWW56OXkyeXJWS0x6UGJQWGZRSmZ0UjNRZzRpR2ZpdTR6Z0M2dmJr?=
 =?utf-8?B?aGpRSFRxK0hOYnMxM09wN21OQVpPVkcxZGtMVGdVVW1iKzlqbkg5ek0yQUNr?=
 =?utf-8?B?QnJ1b1dLTVNFNlhTeVNQQ25QMGxEaDRMcStXM2FDbER1cGszblQ1UWNtMTc5?=
 =?utf-8?B?b1lzK3NJdTVSWGZ2ellmSkhSR2NLTzNVVW03UjRicDl4Vms0aGVoa1pySWVx?=
 =?utf-8?B?TWdRNFYxL2xXZjEvaC96b2I4ZEhuTm10a2svUkNVYnZOVmpCdzloYUtIdVQ0?=
 =?utf-8?B?NmdOSVlYclhYMStQN25qdEV1cXBuSFZDckVUQVFlbjNvTWQ0NDlVZ1VxTXZw?=
 =?utf-8?B?emZwNGVUZGZEc3pQbW4vYk9WNmZ0ZEFXR1lQU3FIOGJTSktxS1FFN0NkMkxP?=
 =?utf-8?B?d0p3RmZCWTdjWElCbHBQZGVmMkxLTXB6M2F3aVZLVzd2OWl6OThRTE9CbmpQ?=
 =?utf-8?B?Y3A2b2NGQ2VGZkhjTDBSSmJhUnYvOVd0K2QvejRjQW1QZTJHVTBvUmxkRklm?=
 =?utf-8?B?Umg0b29XUXlOTS9pR2V5MXg4N0ViWlpnMGsydnlCOTVTV1BLNWNScjc0K1hW?=
 =?utf-8?B?aUdpUm5YM1hTaFFjZzkrRHh2dTJqMUtIQjFPdzdKa0ZzL2xVMlNlcCsxb3pE?=
 =?utf-8?B?SXo2Mk00a0RocVZsQ1JtNGpaSUdsMmRiZXlkK2dYRm1pTHJSTjYvQlFCWGx6?=
 =?utf-8?B?T3pUaDVnVkdUNThGTWhVTGZ2QlBDUEJTWTU0aWxpcGlMZkR0djY1TjRCbCty?=
 =?utf-8?B?ellNNFMzeFN4Slp0b0piUjAxM255K24vaC9TTHY2OVFPSEw0MkVNREhOQlFo?=
 =?utf-8?B?MHErQjdpcEdVRnZ0aDZXandSMXlTdUJaRzRjd2sxU3l3Z1BsMlBCdWpWc1lO?=
 =?utf-8?B?YlpzWGNha04wMTY1S25DRTZQRm4wM0NmRUdHTmZuQklINHA1TmY1bTFjVlBB?=
 =?utf-8?B?M20weExxNG5MbEpEOHRldGtVU1VLZXFWcjJxTko1RXpXZW45bVp4YnBldEhZ?=
 =?utf-8?B?MjNPK2lobDdGeHlmQnlXVFJ6WjR2OFk3cm4vYzlDQ0ZZeDBFcjd3eElVUExV?=
 =?utf-8?B?UWZrV29lbm16OXBRaTRUWFZ3VUJRL0pZZ2ZxUzIyZWVZdHJMT0ZyMWRhS2gv?=
 =?utf-8?B?MW9lZ1pWTVprejQ3WncwRkVoYWwrV1V3M0Jpdz09?=
X-Microsoft-Antispam-Message-Info: t4YjanGjeRt38BMQdONKal+stZkMeWtK3uVINyI6M7LXJmi27ByQb0XcjeNEIspNNB4fFOFPzWAUnhHJ+3iE8BR/vzhg7zGLNfE0lQQ4fngyiBd13MfssTQGAWly0h6vZelQPs5DL/QLFHW1/Zm9Z5mJOYUclzdvBL+rllpTsvgApNjVHgcM4mlo1AEaZTiD
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;6:abrIxmnjNykue9zyDIb1stx+VjrUtwpWDSiQI6/YstvmNgC465MotXgA+2MRXbHSvBR74b8NwLx++7m5ggDa9h4MPvxJFtpu1is2Ten82ppwDca5UPx79XKdGPkbQBRnpsTCETRxrIRI8zt9XaIFFPgIoinHoLm6Xp91EGCxIYh71lmWQkaJiVzd7OOdjaqXPK6UR7lGnnH86tolxZpLgJGv+crAUmhKxxsN+MpS9ET97n/oP92LmAkZn46m9UQsojRM83jiHkmGAwspbS3ND55ECDkQIQ923EQWShYgloA2PIMgP+e1+Ho8YwuzaiqsG7HtqcQZfAAhLvZvwltePZxXOERTAH03Aj6nVYlXGo1gsJHc0qEVA4l4BqqrlsfK0aBNbwGwuvN4YOeC0y8VDcdvX1if6+15rCRxw3/OS1MaJF/qnDnlQCyhujVHVGMLxbQfelCM/H6+Emu1/MYtHQ==;5:/1dm6rm4el5OMKUdT7m6NYfETsaaxqKgPFzMgLXPT9Fvvq2kXJoIgI7lHE6l0sBO7dP1+hDzF9+U4Qc6CxXkNqe1sGLr+P1ZGRVzD3nNReGoY38pbKQWuroD7mpPAdPgxbSCXa+RqoG4Ho6u4bkKHQ+AQNxuxTtNEdOMUaePYT4=;24:FfK86sDUZYuA64EzBRPdTWYFhiVgfdf39PjrGjsqxZkrffTuG9eV8n0SujmwmX/CIzZqlACuOL5TdU5d7hV2fvQ2HANb+7ZBfmWwz14SQIg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;7:OLlV/d907mkATH+HNhnL70MXkrhmoebfS+fNL2G1aXe2Zxa40sh99JhACpN/px7C2iVlm22Md51RXnJJ+o5dZzaWayZesAiZzLH5XuyTicassgYV1JqOOYAI1sfVRrzbC8Z2X3NpJe9YCma36S9BUZOscXX0ybVotOZb9aQ9ALY71bxPibIZ2H8P2HuJDvmLzVcUFWYvq3NIsCz8uCNUAprEGuWWb+LPNa6gJS/JKGHuv5QZmLdnjNFy2++2XfVj
X-MS-Office365-Filtering-Correlation-Id: 3421f503-eb05-440a-d651-08d5ba44f180
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:19:18.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3421f503-eb05-440a-d651-08d5ba44f180
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/2018 7:41 PM, Qing Huang wrote:
> 
> 
> On 5/13/2018 2:00 AM, Tariq Toukan wrote:
>>
>>
>> On 11/05/2018 10:23 PM, Qing Huang wrote:
>>> When a system is under memory presure (high usage with fragments),
>>> the original 256KB ICM chunk allocations will likely trigger kernel
>>> memory management to enter slow path doing memory compact/migration
>>> ops in order to complete high order memory allocations.
>>>
>>> When that happens, user processes calling uverb APIs may get stuck
>>> for more than 120s easily even though there are a lot of free pages
>>> in smaller chunks available in the system.
>>>
>>> Syslog:
>>> ...
>>> Dec 10 09:04:51 slcc03db02 kernel: [397078.572732] INFO: task
>>> oracle_205573_e:205573 blocked for more than 120 seconds.
>>> ...
>>>
>>> With 4KB ICM chunk size on x86_64 arch, the above issue is fixed.
>>>
>>> However in order to support smaller ICM chunk size, we need to fix
>>> another issue in large size kcalloc allocations.
>>>
>>> E.g.
>>> Setting log_num_mtt=30 requires 1G mtt entries. With the 4KB ICM chunk
>>> size, each ICM chunk can only hold 512 mtt entries (8 bytes for each mtt
>>> entry). So we need a 16MB allocation for a table->icm pointer array to
>>> hold 2M pointers which can easily cause kcalloc to fail.
>>>
>>> The solution is to use vzalloc to replace kcalloc. There is no need
>>> for contiguous memory pages for a driver meta data structure (no need
>>> of DMA ops).
>>>
>>> Signed-off-by: Qing Huang <qing.huang@oracle.com>
>>> Acked-by: Daniel Jurgens <danielj@mellanox.com>
>>> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
>>> ---
>>> v2 -> v1: adjusted chunk size to reflect different architectures.
>>>
>>>   drivers/net/ethernet/mellanox/mlx4/icm.c | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c 
>>> b/drivers/net/ethernet/mellanox/mlx4/icm.c
>>> index a822f7a..ccb62b8 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx4/icm.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
>>> @@ -43,12 +43,12 @@
>>>   #include "fw.h"
>>>     /*
>>> - * We allocate in as big chunks as we can, up to a maximum of 256 KB
>>> - * per chunk.
>>> + * We allocate in page size (default 4KB on many archs) chunks to 
>>> avoid high
>>> + * order memory allocations in fragmented/high usage memory situation.
>>>    */
>>>   enum {
>>> -    MLX4_ICM_ALLOC_SIZE    = 1 << 18,
>>> -    MLX4_TABLE_CHUNK_SIZE    = 1 << 18
>>> +    MLX4_ICM_ALLOC_SIZE    = 1 << PAGE_SHIFT,
>>> +    MLX4_TABLE_CHUNK_SIZE    = 1 << PAGE_SHIFT
>>
>> Which is actually PAGE_SIZE.
> 
> Yes, we wanted to avoid high order memory allocations.
> 

Then please use PAGE_SIZE instead.

>> Also, please add a comma at the end of the last entry.
> 
> Hmm..., followed the existing code style and checkpatch.pl didn't 
> complain about the comma.
> 

I am in favor of having a comma also after the last element, so that 
when another enum element is added we do not modify this line again, 
which would falsely affect git blame.

I know it didn't exist before your patch, but once we're here, let's do it.

>>
>>>   };
>>>     static void mlx4_free_icm_pages(struct mlx4_dev *dev, struct 
>>> mlx4_icm_chunk *chunk)
>>> @@ -400,7 +400,7 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, 
>>> struct mlx4_icm_table *table,
>>>       obj_per_chunk = MLX4_TABLE_CHUNK_SIZE / obj_size;
>>>       num_icm = (nobj + obj_per_chunk - 1) / obj_per_chunk;
>>>   -    table->icm      = kcalloc(num_icm, sizeof(*table->icm), 
>>> GFP_KERNEL);
>>> +    table->icm      = vzalloc(num_icm * sizeof(*table->icm));
>>
>> Why not kvzalloc ?
> 
> I think table->icm pointer array doesn't really need physically 
> contiguous memory. Sometimes high order
> memory allocation by kmalloc variants may trigger slow path and cause 
> tasks to be blocked.
> 

This is control path so it is less latency-sensitive.
Let's not produce unnecessary degradation here, please call kvzalloc so 
we maintain a similar behavior when contiguous memory is available, and 
a fallback for resiliency.

> Thanks,
> Qing
> 
>>
>>>       if (!table->icm)
>>>           return -ENOMEM;
>>>       table->virt     = virt;
>>> @@ -446,7 +446,7 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, 
>>> struct mlx4_icm_table *table,
>>>               mlx4_free_icm(dev, table->icm[i], use_coherent);
>>>           }
>>>   -    kfree(table->icm);
>>> +    vfree(table->icm);
>>>         return -ENOMEM;
>>>   }
>>> @@ -462,5 +462,5 @@ void mlx4_cleanup_icm_table(struct mlx4_dev *dev, 
>>> struct mlx4_icm_table *table)
>>>               mlx4_free_icm(dev, table->icm[i], table->coherent);
>>>           }
>>>   -    kfree(table->icm);
>>> +    vfree(table->icm);
>>>   }
>>>
>>
>> Thanks for your patch.
>>
>> I need to verify there is no dramatic performance degradation here.
>> You can prepare and send a v3 in the meanwhile.
>>
>> Thanks,
>> Tariq
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
