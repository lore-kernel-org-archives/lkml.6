Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeEBNbi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:31:38 -0400
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:48496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751121AbeEBNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:31:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net/mlx4_core: Fix error handling in mlx4_init_port_info.
To: Tarick Bedeir <tarick@google.com>, tariqt@mellanox.com,
        gthelen@google.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180427152015.185861-1-tarick@google.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <7e5d6d30-ed89-8a8e-55c1-a25897937727@mellanox.com>
Date: Wed, 2 May 2018 16:31:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427152015.185861-1-tarick@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0206.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4e::26) To DB6PR05MB3254.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3254;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;3:C/dBsYAUBaWpiD04KQHefKRFzDcYxq6vrEullwDluxyKQkld5Ny2aU1IN1JU9FdtgXHtqmpg2zi5Y4DtMGeUfsjPm1miATAoSrscLqLpLopYrWbthhzj0mAz/Fsbz9Yi/UgiD+3lRXHiY3aId+AZA+OabkFuyM9Oak2o8+ZL638KvuSz2vWQaq0BmU1Mazpzu75HI3awE8JGPHpPML8SbgCJ/l8I9hQaqgNKPkrfHYvXp0M321RosKoRc2pSbBWc;25:1qXP8UIivYb4TvormQH+2WzrFCAcB52zO77bMUjlkp2390o8wJ/odkquvsHQTBmuphv2y/9oz5D/GMHnZLy8TvEbP1Wa/L5WYYiQabkqPu1vLTaWk58RiEaI4MwXMRRh631UDGWZUYeVZ9PkLsb7irr3AkwMrxKYkVKUjoH0tUH/kyQzuKoLGn6qnrrbNAyGNv2S1H29A3In3owvISUxiCfr1qzC6yYP2zrJqPqveE+VYztCCu211i1o68pSkBxiyEoebsfakbv+BaK65tcXS/VwFLEM755J/nbPGKdZ7opgZ66e3RDBocQXS2b9yRpwUDUhq6uwO9/xPRJM1gvf7Q==;31:+Gw3l49pXXtDFVvrOar6yje1RPNs3BgBrrUqzNr2FVI0oh+pWgABYMgRaCFkwF9q9ZDWCFlOSQZKtQu/OcUFn3jvdYLNbrtlBgpGu46ZjeWf77qxQF1Osa8NlcwxrQTyVgq1spSM7EJSzKOye3DJ282ycOl5tUZHA4H6g70jG9FMWvkBTENIl382Q/jV0XfrZ7sXZ8cFyGY6K0B85Wly9jZkgxj42f5uwR7tvTsqA9s=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3254:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;20:tUny66PHtJNyZttyplte/pjmKq1tOCerV+XGUN5N2KkiZP4gEIHewAtGh9wIuzP7MO5DGC+qyJvyi5ECDyNSMBnAeSoViwsT40xycMXFyZQIvpbyK6+4KZHDaGGniU5jGdi9WzCe/JqpegCUMPXROjdMX1elu322uGRiV1lfzgn90lgAxaiLNHUSeSs+vIr0EaH4yCiEcP/U5Tv6KfUzfNtZizfRMhqmfPsj7uqti2ry6pZv1/Q7AhEsk3ICjeoAbOFT7GVMyLBWqPppDVwG7bjKJHzmIoR0Qq9qCvGlob/rRxfVSdC52VFXcc1PDhVhFvUp6IY+RmW32q1NKZ7+GjkFgjnIEZ4eqms5f5PtyToP5ZOcy/Mf9ZkVVDftjR/Um6KHbo6ECH1LlvaO3/kRH6IYWIDPAY5TL8WkN601pE91tjnv1onjdqQNJKagu/sJHcg0JzqZqUamAdg4hnmiUAvZdIc0bk9FaK0/EBn91gqogYj0MOXfw4jH+pmdhtg1;4:lsOuxjxfIQudPns5P5H7oXKUvJcTyPGb3Mz0/Tv5Y41Nrg96AHypXocj/xFylhi2HqLVxS66REFnmVAxWNcrwdUCDALu6CrEEKk1i7HaVJFednXOnYuLw8BlBiLmX2+mJKvFTF8JGvizgupXDmpFc1j/6NCC8CnCmYvbnDfoVy/8dyRi+eJ0dJKnJmkJBj83YXO8JmOmgDzFMgvwmatlZua1HGWKgsq6mW5Y/ZqjBykWbLV5AeXL6nMb5nfj404jqFhnRbM7tSKBiBDSwKlh5IK6myetMDK5+E8hhj3yWyI4GGiEgU8ef6olkw57p9Ju6UufUWC7BI/vCGDPUbQQkUcxsBAIppj2CuSD/sES8E4=
X-Microsoft-Antispam-PRVS: <DB6PR05MB3254C7024E2DA8A225F335ACAE800@DB6PR05MB3254.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR05MB3254;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3254;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39380400002)(366004)(376002)(39860400002)(199004)(189003)(6486002)(64126003)(31686004)(446003)(53546011)(6666003)(486006)(386003)(5660300001)(2616005)(11346002)(81156014)(476003)(6116002)(97736004)(65826007)(36756003)(81166006)(956004)(105586002)(68736007)(8676002)(3846002)(6246003)(229853002)(65806001)(66066001)(65956001)(8936002)(50466002)(47776003)(26005)(16526019)(2906002)(575784001)(305945005)(478600001)(86362001)(25786009)(2486003)(23676004)(52146003)(77096007)(53936002)(31696002)(230700001)(52116002)(76176011)(106356001)(59450400001)(67846002)(58126008)(316002)(15760500003)(16576012)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3254;H:[10.8.1.14];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjU0OzIzOmcySUJTMnQwUmNqUS9vQXVORkpwbCt2QlhW?=
 =?utf-8?B?ZnBXOHhSVWkyOFpNM3JEZVR0M05LTDBuYUs0MDRKcnRRRFdwaVA1Y0RJRGZo?=
 =?utf-8?B?cTgybEF4KzNNZS8ya0lUZUhRRlkwTjJKOERaWGpPZXFhS0tmL0p6MWhnbXIw?=
 =?utf-8?B?SHNkKzR4cjJrVzRwUXJMNnFlMGZYMmZBTmgvLzJvaWhITnQzMHVpanlIVm9E?=
 =?utf-8?B?VXpQbG4rOE1xRFFZdElOMzdjbWdia0ZZeGRrS05mYXl3cWZzbDJMa3lFOGxD?=
 =?utf-8?B?SEZVMnZrRTVjQXJPM2hhc3ZjaTVWWWdjbWdxR2NNcXZrT1dmWXllSVhCcE9V?=
 =?utf-8?B?dm14QzdTYk41OFd0TkJCRm5obGwrVW02TzVhc3dHMnFXR0V1TkMzQ3lIWW0z?=
 =?utf-8?B?VHZYK2tVa2JTWXdZTGxIb2d2ajZFVUxyOS9xc0ZUQ3ZGUnRzd0w1Vk1mRlFX?=
 =?utf-8?B?ZU96dGphRU5wanlxYUczR1VHQmJvMEo1NG9qQ2RiQnZjdWh4eGtMWDhCRDI1?=
 =?utf-8?B?MzBRK1FZWld4UWQ5WVltL3VHMWFtcEM5ckw5NXErWDN0amdUc2U0bDN4b1dH?=
 =?utf-8?B?QzA2NmpHaE1ld1UzUUNxamF6eE9icHRJdCs1UUo4blFiUVVJYzNWSW5nNERV?=
 =?utf-8?B?TUQ4TklUSDlaQW1HUWdEdG9CREVXTUpOeGlvWm1nZllYLzFCRFl2dFNUNEti?=
 =?utf-8?B?RE5FR1ZCNlducG1oeUtiaDFPZWltejJSei9uM0JOUUw4OTdBTDgvYVUyNzRn?=
 =?utf-8?B?RUNqRFNicEpqT0NsZVNHZkdNMHN0ZWM3eEp3TzlabTM4SWthWmxuS2M1Ni9n?=
 =?utf-8?B?eUNEc0RWUkpMbkJrbDFIdkNJa0cxR1FIQWM3dFpBci9Fb0VSY0lONFJmVTA5?=
 =?utf-8?B?TnQrK2pPOFRaRlAvZldkbzN6U3FRaEdleiszbFNnNDJUSmNJTlVZL2doSEF6?=
 =?utf-8?B?aEhRVGR2dXhBOUdsak12OEd3Slh6QXh2WVltRHhsdWRYc1ZtYTVza3ZoZjVO?=
 =?utf-8?B?MG1GZ0N4b29vUzhnWEg3anBYdFhWSThpa1BCTmQ4OTdseWc0U0J4SWJvRWtn?=
 =?utf-8?B?L2JhczlMeEdDVldtY09SWGRTblFRcHR2STdCQ2V3ZjI1T2dNUXR3R0NyK0t2?=
 =?utf-8?B?OWJFQmp2Z09manJ3N0w4d2Q5cEFoYWl6akI2bzUrNjJneXRQUytHZUZwdmtP?=
 =?utf-8?B?bzJyOVBBV1BzZXd2NnJPd1ZOb1JSclBRaHFQVWFWdVFLMFAxWkQxWC85aHJ1?=
 =?utf-8?B?N0JiRlZLaFdsbUJ4NTJYNEcwN3o5R2xXRWdVY0NDQU56UDVXSGVhRm1mZVJ1?=
 =?utf-8?B?UjZndUVsVlBxRUJpSkFZM1d5ZkNXbHBWNVZWeEhzVTN6a1JzUElTZURxQW1W?=
 =?utf-8?B?bExYUWEvR0d5eVZkTDlSUzI0VUlMaTh5aVgyOW52NTRGY2lrOGloRnhMMWxy?=
 =?utf-8?B?aVZwODRBUFNBRFFTNmpjdHR6Tzkzci9mMGFYcWRFZXZrdmhGbWRiZzRWQ0dC?=
 =?utf-8?B?S21DeDAyVTY3NXNuNnd2QVQ0TXhyZW9iSkRza0g4WVo5c0psdW5Ub3N6Q3Qx?=
 =?utf-8?B?VGhXeXZDWExoYmk3ZlpOdHFwMjlZVkhOekw4TGM5L1ZHTi9JN0h1QWlkeTJO?=
 =?utf-8?B?WHJXbnNJMEd3Ylc4ejlkaTEyVlc4a1QzbDRRQ1o5Vms3QWtpOTZXVXNjS2lM?=
 =?utf-8?B?ZGNucWNzLzdjYUs4WGZidDFWMVQ5M0ZvK1Z3d3EzK004RmlLMG40L0pvdmk2?=
 =?utf-8?B?ZWNjTlVleHNXSWh2NWswazhJYnIzUEwvcmhjVkVjOGI4UlNaVCt0UU5DSnRk?=
 =?utf-8?B?NVFOMGdzVVpualludHR5TXNlTFRjbEdEaEhXa3M0VWJPV0JWUDlnRExuaTUz?=
 =?utf-8?B?ejA3b0VzN3ZoZ3NPZGd5bVlpVFZpNFBEY0ZDelROdEZ0TDJjdDhNYThvMzhw?=
 =?utf-8?B?M1dJK2FHM0YzdHZjbE5rd2QvdVUveVBMS05hRGphSzNPcisyRVNUQ2RtYm5l?=
 =?utf-8?Q?EkqIzk?=
X-Microsoft-Antispam-Message-Info: yJb0fyDhrUEpK8XKpXl798oEAX08WrrMj4g+D43s+d/JGPJNMtRhdScj47kFKyYJglBBrnbiTM28ll54aoJ/eN3dTmTI2XZMcrilUgbqhRWQJ1LeB6HMC4DgK+iREjsOeuKHQAheQqVfgFKYxBZ5znsNet335psrlu9tcG7cY8W2qYWuR6Gh8GvZibShFQ5A
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;6:jn6c0qjV/mXG29eTVzask2ewOMJh/aKr3OFMbqKkB9lhH1rbsslzXowyK/r2+pDd9BB+Zd1Z/oC6gTDh9OpdQ3hAA+QmSNC997A4ZD1tW0MC+1r+T7Ip2YHMFrBawhwFlPJp+G708uE6RRGylleYA77m2CBR4shcdUcYuxedcQCPr1J9KI/Yq0w0xbzTyo2vu0/rdfiKs2JAH1zTkPk6VZlexaoALc/awNrVPfpp68jgRKx8UV3dlM9bsH9M6JnIfqFoxJ3+Ousi57fY0vMgLPRGKTbjOctN2waiyCsWBMsZabp1C+mGXQdsCNvmPq3QeCE80g6248aqQ+buD3iKvxIFyk0EJqZxeXq+V3eV8LA+4KwyGETkkm10XT/y4AZjOAdpXwxW56MzGwl6t46nIG+r4QpWaZmj4EgdYwyxSGRH1PWI5EU2ELQxxTxTS45HELVc4D3opTbVlz6Y0u1eAw==;5:7wGEoePK3EnjtxMkNhhpM8nMJaJaNl4PJPuYmVVU3FMtrPtpqKRAuD7szY9JBdlsHBBlsYUHx0uWF6Lz5FKScGS99P+iIBu1mTWuI6mRh2ET1JHs9NPvs9qMISy8/YDEMPHCRnw8hByE85B7xHCgFDGVOWqWS8w7W0HIho9E9Cs=;24:uLP7JASH02tfw4FUpl3dEFLzTh+EQ4RKkHcvzpZqkCVP1Xql5dddgEKe7aIMUF5+bh+uLw0nxmwGmYHa/ol7h+8cEn80+/7tFKDA7Cj6gjg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;7:NsfAum7no2eoN0Yy5pMIllQl4dYlXp7oCBu22NOzbfx8Zjq7EiBdTv+ERsoP/9sjbkow/I15T8BodoLjyhX2tKG5KRiGcTmIkDOdekFTSSUTtj9FQat8IqyEH1K5dR7SobnL4PrtFUnSaypsml2JH5O+RdxmbASmllxIN8cM/3BfZPfmoQCgWm/K2D62oSLWiCnzjevxffwEGEDR27QxmBVb07SIs+7ug4W31ClGJqISqnk6+4OcLY4vleIrPSgS
X-MS-Office365-Filtering-Correlation-Id: bb76200d-1deb-4750-b278-08d5b031041c
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 13:31:30.4950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb76200d-1deb-4750-b278-08d5b031041c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2018 6:20 PM, Tarick Bedeir wrote:
> Avoid exiting the function with a lingering sysfs file (if the first
> call to device_create_file() fails while the second succeeds), and avoid
> calling devlink_port_unregister() twice.
> 
> In other words, either mlx4_init_port_info() succeeds and returns zero, or
> it fails, returns non-zero, and requires no cleanup.
> 
> Signed-off-by: Tarick Bedeir <tarick@google.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
> index 4d84cab77105..e8a3a45d0b53 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> @@ -3007,6 +3007,7 @@ static int mlx4_init_port_info(struct mlx4_dev *dev, int port)
>   		mlx4_err(dev, "Failed to create file for port %d\n", port);
>   		devlink_port_unregister(&info->devlink_port);
>   		info->port = -1;
> +		return err;
>   	}
>   
>   	sprintf(info->dev_mtu_name, "mlx4_port%d_mtu", port);
> @@ -3028,9 +3029,10 @@ static int mlx4_init_port_info(struct mlx4_dev *dev, int port)
>   				   &info->port_attr);
>   		devlink_port_unregister(&info->devlink_port);
>   		info->port = -1;
> +		return err;
>   	}
>   
> -	return err;
> +	return 0;
>   }
>   
>   static void mlx4_cleanup_port_info(struct mlx4_port_info *info)
> 
Acked-by: Tariq Toukan <tariqt@mellanox.com>

Thanks Tarick.
