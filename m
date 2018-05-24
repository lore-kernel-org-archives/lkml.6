Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969543AbeEXL7e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:59:34 -0400
Received: from mail-db5eur01on0069.outbound.protection.outlook.com ([104.47.2.69]:20208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966710AbeEXJpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:45:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH V4] mlx4_core: allocate ICM memory in page size chunks
To: Qing Huang <qing.huang@oracle.com>, tariqt@mellanox.com,
        davem@davemloft.net, haakon.bugge@oracle.com, yanjun.zhu@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, gi-oh.kim@profitbricks.com
References: <20180523232246.20445-1-qing.huang@oracle.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <bc652655-29de-a34b-a78a-0de19fc20df5@mellanox.com>
Date: Thu, 24 May 2018 12:45:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523232246.20445-1-qing.huang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::26) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3257;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;3:94LIf3pu3o/lguDcnArQGFW7r9Vfw1Hes4vXzYTEYOEHR/MyWZH85HkrVIL4NqWf+7wWTFtyjaQO2jz1WnkewyZJSll70g8ifCjXJK+dtRba7I7M85fQQvLEGsXasvnB2ahZwyMEKZ8cqk65h7hVvm/qgzfHN3dHbZQ1xfGeDwyCqTmW2dsd4QXyZ71sQfNTT2Fwft0S9wK3O8aNTdM4oadJJ3H0p4SQnh0XiZMToeyS8gqPBHUZv4I44GMr0Edk;25:tsPqOOYcChtDVEvTEp+xCFYgDsd89O1p8rSAAwWdFXHwSV2XskA+X0cULSn9ZXvfLhz5tzRFWobcWRV+1jphJxmIaSPlqJ238H8PqQQPlRAT91GUaNI/1baJRDayc+EJKq8f8ofP/k34E0ZXB0pbH24NVsNribvdpLPtW5JcbHgboerJxkXLtm96JZdPDn+43jd9StuZCVAEql28z2txWPPmxwI469sxYK8cbyBo8sCaAMqXB4M+Jvlm5tEdB3j9gW+ZG1EcTDCEHHGUT4bTOv2XnrTk1Nyyc3EmiIaHusw0OFJ8oYdRFiBYy/OkjDpbqWx+NhTNeQDa1Ln1ZG+fmw==;31:6h0jiG0cUKSXcitgTO0hGX0DJdaKg0T1A0a4Ux3WT0L0rprLW9fvHfWekhI2EDBW5Xwqua1IHvxuMYlha9h9exP2K7lemTGmuzAPSm8cfGiTxkkD7nWwqfsRX5xWLzt4kiF5TkRSSY81VBbXuoaEAS/ZRHMAlnm7xBxq/rC6PU1Ti12sN2hvbG+N+rnUmbKI5eWm1p73JVtF9+N8u9mBIM1tYn5mo9KnOPUecwalBGk=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3257:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;20:CXprjrJTna8AKpcO+aV1yN3hEaU3W6cMQ12xqRjJi6ds7Azdvin9hN2w60JYsC1bf4Ap+5s3QSWsksQQ/JQW+F5oSBWwdR5u733X4oTmV1iZjG5IKDxNNlJS0Wx296jfIj7yoU98PShcfopKhi6c9+d22Nn5fOIMTyoepE9mp8ttzKAOuqZspcgZId+0SaEZo4O/63kVRrqrBtGYaUYPJCXsQusMrNEyGAy2u+/DXtvTwoRlcHP05USxsfJTyEuI3vygwm4/bfjGmjLHyCHEvZSjSE6PvG04aomEHakGth5GnI+QAp5MCe9jIDMbucXH1/U/EBC0JT43HQfTM6lmWVl0AEl/Xc457uKnG/CCUs5NTjN9BM/T8zo/SjOoTMbPdVXvZbOylFG2Vn2UbbHmh/foirPjdvb6TCPgc53bLF1MKoq5eb0Q50QVvRdfMPLGHd/IjiMi1l0MqxfmWHeV0LnS9OczgC5aOaT7nbWJbZtaYZ9IX555c8F6g7ms3b9s;4:wfoJ2H6YPknD8jOt6jZTCz8QsIqhAArD1D5Ja14B+4WfuVK5h5qs76lHrZH3g+HgWfpU7Jv0lf2buts35nOhw9+7/Pqca0Pj7kXTs5sOv6EfZXvMB6x6RQ0FJ62qCtd+zEGNs2wrEBYX0UAeAoiW5TEvTcOX93ft3+C1bccvU9Y5Hff9K0hnt+rd9wGgB3/sDvkuOTGFlhkJuB1qAmxDWFQp63WWwGNJNMbYwzUO+WFxFLYHFFbsM4+J7Qt/OEM/hS7UFBpdsC86POxZn4/nb4HBnY66OPyK/NOBlKfkTSK64nh3mdw+9+XM2qNS9RhXr1v6gcNxdh+aZK2LnIgNPQ==
X-Microsoft-Antispam-PRVS: <HE1PR05MB3257E79700E4D351B74837AFAE6A0@HE1PR05MB3257.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3257;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3257;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(106356001)(229853002)(476003)(64126003)(486006)(4326008)(8676002)(956004)(11346002)(6486002)(305945005)(25786009)(7736002)(36756003)(6666003)(2616005)(6116002)(58126008)(97736004)(53936002)(6246003)(446003)(47776003)(81166006)(81156014)(316002)(16576012)(8936002)(230700001)(77096007)(50466002)(65956001)(65806001)(66066001)(5660300001)(23676004)(2906002)(68736007)(52146003)(386003)(26005)(478600001)(53546011)(67846002)(186003)(16526019)(31686004)(76176011)(3846002)(86362001)(65826007)(31696002)(59450400001)(105586002)(52116002)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3257;H:[10.8.18.17];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU3OzIzOjJ4dnlBRUJocFNrTGtEck43TTFJTzhpcW9q?=
 =?utf-8?B?ZENnakZCWFl4T1VVRXRCVmd4My9DdHA2a3Qzc1pOa2xPY2lvRXk1V2JEcTk5?=
 =?utf-8?B?K0VaWFVacTJTR0JIY1o1VDlLcUVuNUVuY3ozdTM4VFlWeXJKUG5aMkVSaFdH?=
 =?utf-8?B?WC9vbExTMStGWGUybXJRSG1YbUt1YjdkQzVpa0gzZTkrK2o3U1hWaUtxZC95?=
 =?utf-8?B?TkhqVm9DRjZnMXpiN0dXZERlYUtWZzNjS3ZTUkNra0MzVkVlQytISG96endE?=
 =?utf-8?B?ZXlKVVpvY2VwZUwxTnhKcWo1OWpYSjg5dUEySU4vdk9ZWXk3NGJKMVpGZDBM?=
 =?utf-8?B?RWdhM0NzVHJrNExDd3p6UnNKYzdKQTRkZU5mVW5tWGdiUy9ENkd1aVlEOW00?=
 =?utf-8?B?eU90STJpdFZEWGp0ejRDM0cvTkpjSm9ZNUNkUXo3YzJ2eHZ1S1VOYUY5LzFM?=
 =?utf-8?B?NUYzRkdlYk5uSXlaMi9BYVB0OStjdjgwcDZnMEpTclBBbFgvNE1LVU44dzg1?=
 =?utf-8?B?QlA5T1JLWmRhR3BzcGc4Vk5LZ2dQanRHSHEwL0o1RUVleXRvK3VwTU0vVkFh?=
 =?utf-8?B?M0pFcDNJZ2hqbnE0bTVVaVdud3IxUThRTzhyTnVUY0s1STM1U2ZiS2ZXNW1C?=
 =?utf-8?B?ZzJxTDFYUXVFSWNCZlhucng3anRiSTErMVV0YXo3SnE3SFhqbkIxYXc1RlJ2?=
 =?utf-8?B?bnBYSXc0NXZRR240Zmc2UjFOb2JqOVB1SjBMbWR2VzB0M0tmd1FUbGhGRE1l?=
 =?utf-8?B?czFXa1lqcVNnMWV6MEJBbzY1UC9kMld2SU1qUldUZDR2aVRVT1RBTVZjaHFh?=
 =?utf-8?B?R2pUMVgxUDVrdWx6UzFxMFZpQi93ejBkYm9iMVBBQ0tiaU5HbHJDWVF6NHhO?=
 =?utf-8?B?bVduTlpCTWtpZU5nTi9BZWdpOXJSY0xqK00rMUp6dm8yb21PUWRhTVZ5VnhY?=
 =?utf-8?B?SEMzUHRUbGpJK0x6T2FoWUpMWUpNZER1c1Y1M3Jsa3BGS1lCZERWM1pNZzds?=
 =?utf-8?B?aDdBZFZQYkNuMzQ2R0srZHhOTVVCUkhCRlRzdnVhMEp0ZzYzQ1dOaGFBMmI5?=
 =?utf-8?B?cG1PQnRodFFzMnBFbVBqaUYxaWV6cmNxTWxxOEtlMzhrcHlrc2NhbUJqV0lT?=
 =?utf-8?B?MFVuWUx2OStsUFpRNHN6cDZlUys0TzdUWnhGcFcxL3VNUk9EdmxEdE1uMHBO?=
 =?utf-8?B?NHRkMGFaK3R5Qk1oQzJmWkN1Q0h3bFAxcVNPWEYxcWMvUytZcCttTFFWMnp2?=
 =?utf-8?B?YzFac293Z2g2T1QzKzM4Z3REOFVHRDR4ZklHakJLRmR0U2hwS2JJall4djdN?=
 =?utf-8?B?U3QrUGJGRmN2N1RPdy9tWWkzc1BnSFVwcWpQWEV6RG91R0hxY3REbG8yVFli?=
 =?utf-8?B?amRwZzlzdXkzRXpvOHMyUGRiZ3V2cHNuQzI0ZzhSdXFUVnhiZkJjMnlPa0Fi?=
 =?utf-8?B?RWZaaGxONHZuL3F4ZGx2LzNFNDFJYU9MbW5DZk8zSjVMdjVic043bUxBclY0?=
 =?utf-8?B?ZVRJeXpmTmxQa1pEWE1HNjI0MlRlTmsxQ3JBWWEyZ2J2UW5ST2pSeWxJWFdt?=
 =?utf-8?B?V09JVHhIclBGdTlBZGdLd1pUTy8xRkdkczgybGh6cEJlSHJmb1NpT0pJNHl5?=
 =?utf-8?B?Wmw3TTJZQ0ZXU2t5N0sza3N3RzdSZktva0kwdlE5emxtWThRSCtlRXhwR1JS?=
 =?utf-8?B?ekQ0YldtU25ZMUh1UUF0ZDFJa1dlaVFxWCtNSHlGRE1DeWtZOEc4dTYraFJX?=
 =?utf-8?B?Y1dHWU5qUTNGbk9zYUVzTFlUanR6dnRqdXJnWVFhYzVTdEdCc1o3Y2RkQW1q?=
 =?utf-8?B?VXVCcXcxVUN1OVliNkZ2UHY1ZndvK0dKTTlhR0JITEpWRVhkNWI4TmNGQmt4?=
 =?utf-8?B?dUFwQzhlMFZ3azhzUU5ZYWxTMXVndndlaGJKZXNTbUtxQUo0dG55cEZWVU14?=
 =?utf-8?Q?rm0kpXGc1ORYE673Qb5hYj1S5M6A34=3D?=
X-Microsoft-Antispam-Message-Info: BIPoSX8AFdaSx7AHT5cN8ZLOkUACi8V47fuSGzXCEqg5czl5uhJO5LFM9VWLp5kWmGYD/Tkxdnz8OnlxtQX2Rt+O6/bl1TUZXbLbWwEWB/jq8gPfojocx91RssnHiO6MOqGEFrEIVSVUNUIOKJG5I2IyT1UoKw0plbi3owkpOJIDrTfcK9uOkMZT/q+oa6or
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;6:IeKa/N8PrqqAHhnTFdqUYxMazu+V6QEetBkY+lKcf95gOMfvFcD/IX64epUW8YmGG8k9ECS8B245WP8upZ4vsXTjn1pgv7WvIFRTVd/G9CaR75Lz63amYWiSLs8Vqq03TgSzd9zHcbvArDtjPVs1Cx9O99RWDnvezbXyszemWyrL7iN37JPC88YjQpzr1evzCvHbvo8J7jetqTFFvBlHp3ee+TIgVyAJdtUUudy1SlfiUs/fqSdgOWezny8WMc6rCDHErGtM8aWSGa7rjJe82mqhW552rl+15WNBsTUrsSnbejqd+wZECdTPdd3dDl/8sfMJK19BQnVNshz1gHMop9mWBipZaUR+wrjEQRb22ogSy7+mXNtfGXNxXmX2CaJ1226BjWUSvhL5A39dn2lacKCJJwlEuMCd7LU7SyVR/xHMQQit4Gm3J9Dsv9Q9cQ2u0ZhOe3fgBd2dReD//IEAOg==;5:/KxW8jACWLNLOKkBz4xV7FlbROYhAmJYptgxMKYX+UE2tkmR/e0/tE+Qzc0FkTlNez9JMgz87Vc1w8/XuKjt6K97pMUrNMWWqZWBH8XKrgpAtEGwXmxutoId8S6lSfKZH138ly36dQ0C89BeFUOqttLAgot/Imq5HgafWPugzhk=;24:KVkqxz+FuP7J3k2WCgLL9F+4qxT3Wav4ZOaGUErQKFPu4fAHVOpL9NNeq3T9CSql3vv/hM37x2ydjp9UxBT5ajmlbIyl/xiGawueoTZ6sKQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;7:02VEbSHIiPJR2h0pYT+LJzuSz5pGSpPETHNGxaTxFFujCaYwTnq2OjXT3xz5XGLPIBXA+uCH9AwIkWdIPuLWjR5PVqkfaTnh+/TEqNmPG+2Kox2svNxDflH1ti7JiVN1QytccF6ZFir3pYoUDYQ8mWwUZiuS4y09t0YZf6VTCaKMtfhi9LVCdJ0hA2ckzmzdVyWJCIT1lVtYMziip3PT7/3hsq2R92chwvXdq8ewbbN2NNlakyJAuzn5WT4NkJjO
X-MS-Office365-Filtering-Correlation-Id: b05c8e42-e619-44f8-ecd7-08d5c15b0a06
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 09:45:08.4703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05c8e42-e619-44f8-ecd7-08d5c15b0a06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/05/2018 2:22 AM, Qing Huang wrote:
> When a system is under memory presure (high usage with fragments),
> the original 256KB ICM chunk allocations will likely trigger kernel
> memory management to enter slow path doing memory compact/migration
> ops in order to complete high order memory allocations.
> 
> When that happens, user processes calling uverb APIs may get stuck
> for more than 120s easily even though there are a lot of free pages
> in smaller chunks available in the system.
> 
> Syslog:
> ...
> Dec 10 09:04:51 slcc03db02 kernel: [397078.572732] INFO: task
> oracle_205573_e:205573 blocked for more than 120 seconds.
> ...
> 
> With 4KB ICM chunk size on x86_64 arch, the above issue is fixed.
> 
> However in order to support smaller ICM chunk size, we need to fix
> another issue in large size kcalloc allocations.
> 
> E.g.
> Setting log_num_mtt=30 requires 1G mtt entries. With the 4KB ICM chunk
> size, each ICM chunk can only hold 512 mtt entries (8 bytes for each mtt
> entry). So we need a 16MB allocation for a table->icm pointer array to
> hold 2M pointers which can easily cause kcalloc to fail.
> 
> The solution is to use kvzalloc to replace kcalloc which will fall back
> to vmalloc automatically if kmalloc fails.
> 
> Signed-off-by: Qing Huang <qing.huang@oracle.com>
> Acked-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> ---
> v4: use kvzalloc instead of vzalloc
>      add one err condition check
>      don't include vmalloc.h any more
> 
> v3: use PAGE_SIZE instead of PAGE_SHIFT
>      add comma to the end of enum variables
>      include vmalloc.h header file to avoid build issues on Sparc
> 
> v2: adjusted chunk size to reflect different architectures
> 
>   drivers/net/ethernet/mellanox/mlx4/icm.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c b/drivers/net/ethernet/mellanox/mlx4/icm.c
> index a822f7a..685337d 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/icm.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
> @@ -43,12 +43,12 @@
>   #include "fw.h"
>   
>   /*
> - * We allocate in as big chunks as we can, up to a maximum of 256 KB
> - * per chunk.
> + * We allocate in page size (default 4KB on many archs) chunks to avoid high
> + * order memory allocations in fragmented/high usage memory situation.
>    */
>   enum {
> -	MLX4_ICM_ALLOC_SIZE	= 1 << 18,
> -	MLX4_TABLE_CHUNK_SIZE	= 1 << 18
> +	MLX4_ICM_ALLOC_SIZE	= PAGE_SIZE,
> +	MLX4_TABLE_CHUNK_SIZE	= PAGE_SIZE,
>   };
>   
>   static void mlx4_free_icm_pages(struct mlx4_dev *dev, struct mlx4_icm_chunk *chunk)
> @@ -398,9 +398,11 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, struct mlx4_icm_table *table,
>   	u64 size;
>   
>   	obj_per_chunk = MLX4_TABLE_CHUNK_SIZE / obj_size;
> +	if (WARN_ON(!obj_per_chunk))
> +		return -EINVAL;
>   	num_icm = (nobj + obj_per_chunk - 1) / obj_per_chunk;
>   
> -	table->icm      = kcalloc(num_icm, sizeof(*table->icm), GFP_KERNEL);
> +	table->icm      = kvzalloc(num_icm * sizeof(*table->icm), GFP_KERNEL);
>   	if (!table->icm)
>   		return -ENOMEM;
>   	table->virt     = virt;
> @@ -446,7 +448,7 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, struct mlx4_icm_table *table,
>   			mlx4_free_icm(dev, table->icm[i], use_coherent);
>   		}
>   
> -	kfree(table->icm);
> +	kvfree(table->icm);
>   
>   	return -ENOMEM;
>   }
> @@ -462,5 +464,5 @@ void mlx4_cleanup_icm_table(struct mlx4_dev *dev, struct mlx4_icm_table *table)
>   			mlx4_free_icm(dev, table->icm[i], table->coherent);
>   		}
>   
> -	kfree(table->icm);
> +	kvfree(table->icm);
>   }
> 

Thanks Qing.

Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
