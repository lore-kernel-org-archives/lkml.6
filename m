Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935478AbeEJMmi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:42:38 -0400
Received: from mail-db5eur01on0067.outbound.protection.outlook.com ([104.47.2.67]:32288
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935393AbeEJMmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:42:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH v2] net/mlx4_en: Fix an error handling path in
 'mlx4_en_init_netdev()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, tariqt@mellanox.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180510070604.19635-1-christophe.jaillet@wanadoo.fr>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <086ee1ec-3806-d1f4-78df-d3f4417e47f9@mellanox.com>
Date: Thu, 10 May 2018 15:42:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510070604.19635-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::20) To DB6PR05MB3256.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3256;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;3:HYQhTgO83etATFWDJwj0Uy8xEzt+r4Ye/kH3XAJE5YLWhqHFTsRo9dwP5YzY7e3TSEWQ/nUdHBURDfasJYTX5CSS9XHOx0jI3/6s5H+E+ZWoZFwn8f8BRUAHtHtASmC0jVdrvedaht94cyZpXz7IxkZql0QqtrI9ldiRcuES2A+E2RIbda2P8Cp5MOI11eUdHbczC//UgcvgLXTxSHirsO20RNaqb27NQDSB4K6jeAlrxgCEnbhNMYu7vVDQvCdW;25:dzumhvXvZssfhAkAThWbfc4mJEZrm8vsYjkW5bfT+cO+xgC4YyYRkEjFDtHYLDO/FLoGSkJSkg2JrguySQC8y6Xf9lC+8AoWv6jdsW7Xczg2srcvNCJzleI+0/gtfaq6dN5Sj91ootLHMM2kHpPxSEei4yrQHs70Sufzc5gIvt2UxY3rx80GoF2zXBVEWfV1i1/pSi3/icmVuvf1c9ZJ3+CFa7c7mDKqyPx5mONpIYU+yMQY9qnYZRhDWHcA0qgi1/0MqwG0Izdjan89O2anlZSDFXAZYAEJO0Jxkq0lq9fmWA/TBpkk31A6aNKjhWBvHrV9LJu99DZtXM6AGZPEGg==;31:cKkfqoB+fKcmTA2skNtwUo1hSlxSD8IjKvHGRGRjkep4a6Zplf6GEBUJ7IZl/nN8mPyW2RPLgv9z6kLqwXthjhwhseFPhkGkpbDDQYSksiNctYnc1+MnnwWJ5kjxz6cEuNuAGEqJZindgR8PR3zpwRVoYh0b5tRkxC2aecMwszk4i7DFA/FgBRsVt2JAJPtqXKmXjq5t/vX5E1jMHnJVapSoHPTwvUzI0sWpR0HY+hg=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3256:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;20:66mZ60XUdh2gC9A1R5rifgSnp924jE4uo82G5PMJknK8OpVNcxCaG6Zx+xmDj9mGEskVZF8y8+ucOTPPYvSx5g8ao6xMtM/Ain/MPzJOnYe9MBw9QEzNQvrQFjFI6BGy5KrS9nLsBSoBHJwVbP6uU+6dRIQhFWGWU5cu4ppSkT6bggr9tSK3YwPMpy2l49pRnFo9K5m1JImSQ7OLfa8snTA8ClNjxzkLKrbDs5riQJCKxIHYHJZyoj0CM4LhTnpIXerWXdXjivHhY3H55MSZhs5SgCtma94/egv8/mnLzQZP5OfAu77seiYChsFcK45u2+8B5811AXXG809V0MiHFRPmeVLBjV9FrTsO7EsMLUMsTiCHYoEacGCZWsqNVgUDcB2kM37N1LIXo2Zj4R1XWTRKsPYA2yrYuCUZSu1VdGnfBhtcN4giCfKpDwV9qxvdfInF8n3hzSUGaqpnKkHoBD5U/9RL/u8LLnHx3rBioQLtkIFJnmczhS3l/wD3YZEa;4:e8b4Q6fBDKKtBviEoqEsLjiJfph2UKcfZ/mYsLsxxcziPTtD7BHrMC79pARng82fZZWk5Bs46eqeNHZ1Hn7ZgEokJKMchpaDCiXBDWPYfi6i4kb4/KsfEZziTJ6TGYalSxMA0EZW/pAHe0qBfdDCk/ab1e4wi+mqy/o8ekVuySwzU215GrHNs8SGLWHC84HinqmvdxHaIG8IVSjwzVY0pWf5OSWlXIk3Z2a+3n4NudMg31nVVNLSxMB+iX6G6M4LmZZOMeZqzKO7RbAT1j1Iuu60R481GzKD99UG9vGH9tm/w8pbIquPn6IaMMX4rBdD
X-Microsoft-Antispam-PRVS: <DB6PR05MB3256321B417AFC180FDB169AAE980@DB6PR05MB3256.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155761271638844);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR05MB3256;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3256;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(376002)(396003)(39860400002)(346002)(189003)(199004)(67846002)(105586002)(2616005)(52116002)(186003)(446003)(6486002)(956004)(486006)(16526019)(97736004)(5660300001)(86362001)(31696002)(65826007)(11346002)(23676004)(575784001)(106356001)(76176011)(26005)(305945005)(476003)(15760500003)(52146003)(386003)(47776003)(7736002)(53546011)(65806001)(316002)(16576012)(77096007)(65956001)(31686004)(66066001)(58126008)(6116002)(81166006)(478600001)(8936002)(81156014)(36756003)(229853002)(230700001)(6666003)(64126003)(3846002)(4326008)(50466002)(53936002)(8676002)(68736007)(2906002)(25786009)(6246003)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3256;H:[10.8.1.14];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjU2OzIzOkNPM2Z3VmlVS0hoUnVZQ1ptclF4L0d3Z2pz?=
 =?utf-8?B?YkhnV0Z4eFl0WlVoVitJRVo4MSt6RXJwaWVvd2hhNWc0ZmVPZVZHcjNGcGNF?=
 =?utf-8?B?TCthVDUrQ2tScmxjM21KajMyWkc2b05mdmtVZlExY3pSSVNWcDVjVmNZaThT?=
 =?utf-8?B?UnM1K1dPTm45ZHRCZEpEdU83MnlsWFZkNWhTWm1jOVVpYlFHR0pNYjBjMEY0?=
 =?utf-8?B?SjBIVTRwZXgwb3Z2QXFOekdZZ1hjOUVyK1VZNDFNUXZGMlpwdUs4dkppelNv?=
 =?utf-8?B?MEk5TWlqcjBlZkZITXVUd0s5TEJ5WXgxbUl6aXVQUTNVVG12U043VThYUVg5?=
 =?utf-8?B?UzdkVHBLbnByTWZEejNZci9QV2twS29XK0w4MHQ3YXBMMHZlRkRJUnJydDJ6?=
 =?utf-8?B?bjhySkJOQlRYZm9KTmV3UHVaNGhCdm5EeGloL2ZuK3NnRXJvdVFQUmpheno1?=
 =?utf-8?B?WTV4TFlBQWtnRDNLK0RRY1dKUkkxM0RJcWdzZzJxNXlxckR5QzRpYUVPblpj?=
 =?utf-8?B?Z252RnltWjVDVER4YmxOK1Vic0pFVFZuWHFlNFVoUGtJUzF4aldVOUc2bVpy?=
 =?utf-8?B?N3ZialNQYUk5R3Ezem11Y25SYzBCMEwwRzhmZTN6T2Fwb2hrZ3FUMkRKdFlm?=
 =?utf-8?B?MlowbHNSQTJvdE91Si9zK2c3WWFkU1J0WURjQzBsSDBGV2FSMzRnOXJNMlFT?=
 =?utf-8?B?Tk1wUkdJSW1FMmc3aTBEUXhoZ096NzNJVTAzckd0LzdwN3pYb1RGcE9rQXZY?=
 =?utf-8?B?cmpRZmN6ZkZOYmZOUTFGcG5ubGxGa0ZSOUNGYVVMc3RTMGM3REdBZlF5dVpu?=
 =?utf-8?B?R201SWdyT1E3YkZ5bDNRSzJXeWxwVkhqYkJHb2xNWGJaMWtub1ZDNVVqbEUv?=
 =?utf-8?B?ak9hRHNSRFJZZWY1YWVoemk0eVV3RUIwc29LRWk2djFlOHR6VnVzOUFZNElZ?=
 =?utf-8?B?M2lzNjFiKzBad3p1RDJNT0RIS1NkS1NOb2puMmdOQnhIRU4xY1RyYTJhSlRT?=
 =?utf-8?B?T1dWNmpxT2Y1Z1JpdFQyVmRSeGRnb3hFaUIyQ295aWpuZUh1WW01QWptVjVx?=
 =?utf-8?B?TlViaVI4MVRkL3graWtrbjFBWkRrckFGM2tuWmlMTE9OUFRwcUJJaWplWkti?=
 =?utf-8?B?aHZLS0ZUWXQySFZnL0dCVUNHMURnS2VtUkN5WHRBbmxYc0dBOEhBZmYxUUFU?=
 =?utf-8?B?Zk1aY0p4clMwdFh5UDhHOWxZZWpBdVFtRnZUa0RrcWh1dWxKMlRyMVlCSnlO?=
 =?utf-8?B?VXg1Y0sxbUxEenBmdlJOL3pCSDNhR0phTlB1bnJZQ1RZY1dxYWJZVUZtNkxX?=
 =?utf-8?B?NVBVQmJEUzRKNEhGaFpJOElIQi80RDFUcmpzN0JtNlRpVXg4QU94ZURTUllL?=
 =?utf-8?B?R3NOeDdwTXhnMHBzcjBRc1N5bWgvQTkrZEhCN0k2QzMyMjRXZGh1QjhGUUZn?=
 =?utf-8?B?ejFwYTBuTzYrUHI4YTE5ZlMzbEdnaVBBa3RrUXYvQnFXTWxVYWlndWFTZCt4?=
 =?utf-8?B?bHZkRXQ1TklhU0VZZ21GVVhOd2RsV3NqSytQZ29hMnNqSWRGbytTeTlKUjVW?=
 =?utf-8?B?RlV6enViZC9sMXBqVXl3MElvK01uUjhxYnNJOTBRbEdqaGpVQTY3VEkrNHFt?=
 =?utf-8?B?TldPdmN1aDFLcnNNUnRUd0JKSzZkSVRjUktBeit4UlI3cExWM2YwUU5pUElw?=
 =?utf-8?B?Mm9YblhmSUJPdy9LRGp3SEdGVjdHZWk2MHdZa1BhQUdDRTdabmpIcmJRMm5l?=
 =?utf-8?B?WjkrN0lWMzdjRll4bWNRdW5tM3VPQ09Za2VKa2hZaU45SWxST3Q2OXBvdnFx?=
 =?utf-8?B?QnNQT3FpRlVFcU1FOFM4cmdXdndGUmZZcUdsS2xuZy9UQ0Y5cGFKa3duZFR1?=
 =?utf-8?B?UDdxRmdvcHBpY1VhVjE1K3RYOHU4MlhUc2YxYzRRVVU0NjdzZElCM1lMN0l3?=
 =?utf-8?B?a1hUSS84S3gzeFlvTUxBMCtLZHVjbGd6T0hpQUZLRmZhSkMxWU5rR29IV3gz?=
 =?utf-8?Q?4yMG5a?=
X-Microsoft-Antispam-Message-Info: KgjzDLtaR0m66ttNmwNtDcFSJCwwG7eKL9g40hb/16g8NI6yIOgi/OBXmmh3d05n3BPH/VKcTEdhr2UV0tntTTYmF4+vdATB0LAGOzVxHYk2H8FJQaH8WhP3kBkmcPxwGBN4Yi8zH6YajbFLPu3YGcArSULeTe1JVcOrFU/f67YHcpc01/5yXVgkCUyT3zDJ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;6:2GUf0dAiw3XZJ9S3GjY7llzb1RV99JQbom1yJ96Ww7XIlYagEjGEZFZFXhye0idq+sOhtEVjmVOfGJ2eYr04LKJr16L53uq6Nn8ps6P562Uv8ph/RK4p32vUR4JFUOsP0S4H4DaoJ1eF36FbC7Ae7N80N/dlE4xm1R4Yy3l2/bbP8DC5B0lKZOS1AELk1G7GcbolzuyO7de8yV8kjR5ahWE2UjYOJjPckmKzi47lL4Db584hFqUwuRRpAi15BlkYkAuAhNFUu3GFAPxNa53JdsrbPnr59HkRvDFh8vrrzIP3Y+CJuD5QCJlQr07z+hjnuRbkbe0I6ivbXmrtrCPzw0KSu5Ertq9AhJCKdknjhu2UIliWc1JenGEvOUnUkNflfNtUNO/MAdUItlXpKYJLAmjYH/HpxyduVYsasVisF0SojE46nd4ge0ToRNmhOqMX5HR56JRVULGnkgU3NvWJjQ==;5:0yYm9RLcBBOujstVrcLAvg76OK2BtHoEgrdSpKUgEBsTJTqrt54ND3qoykQPby2CM86nLW2dgQ2/GmdNU3wslKnh3sX4jyoMzUIiL/Mr1OkKgsItgncEaNVNMVeQxhuR7TSjz8EUUhfu+BucF5Lkfnz5ORoxxYvj23Jl9K7BfpI=;24:oFwUG15KjKE7swWaRn/uYIxuo5LtHlFfVaDWszsDkci8M6UimQuOUypKVqAqoDMcemSVFqAKAHoYL2JYOMuwJDZzjeryabSxvDYTO5PtCOM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;7:DBfwCCxAr8uYB4UgjmO4SMfnKcqppccqnsoNInuczs0PVrLoT4hkVW02HOnB2Tn1D0GUeaXZa6Y7LjnrKBXazsusPj0qopBzfMKvTrEeUfjQEyJ++xpT8frtkqEc0NVBr2vMO2MxT6qetnoxuMXzOfP0o4DzEiT6NtgcnbeiXjc1Z4PAHLcbtB6Fh58gG0DVn1FMPht1QY8dKWpghs5wTQQBPbDMm1OAlG9Syvw5F55DeVTFzx7MNl45MZAWieqG
X-MS-Office365-Filtering-Correlation-Id: 2fc72889-1c68-45a4-c01d-08d5b6737f2d
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 12:42:30.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc72889-1c68-45a4-c01d-08d5b6737f2d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 10:06 AM, Christophe JAILLET wrote:
> If an error occurs, 'mlx4_en_destroy_netdev()' is called.
> It then calls 'mlx4_en_free_resources()' which does the needed resources
> cleanup.
> 
> So, doing some explicit kfree in the error handling path would lead to
> some double kfree.
> 
> Simplify code to avoid such a case.
> 
> Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 -> v2 : rewrite the fix as explained by Tariq Toukan
>             (this 2nd version may have been posted twice, once without the
>             v2 tag. PLease ignore the first one)
> ---
> 
>   drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index e0adac4a9a19..9670b33fc9b1 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -3324,12 +3324,11 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>   					   MAX_TX_RINGS, GFP_KERNEL);
>   		if (!priv->tx_ring[t]) {
>   			err = -ENOMEM;
> -			goto err_free_tx;
> +			goto out;
>   		}
>   		priv->tx_cq[t] = kzalloc(sizeof(struct mlx4_en_cq *) *
>   					 MAX_TX_RINGS, GFP_KERNEL);
>   		if (!priv->tx_cq[t]) {
> -			kfree(priv->tx_ring[t]);
>   			err = -ENOMEM;
>   			goto out;
>   		}
> @@ -3582,11 +3581,6 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>   
>   	return 0;
>   
> -err_free_tx:
> -	while (t--) {
> -		kfree(priv->tx_ring[t]);
> -		kfree(priv->tx_cq[t]);
> -	}
>   out:
>   	mlx4_en_destroy_netdev(dev);
>   	return err;
> 

Reviewed-by: Tariq Toukan <tariqt@mellanox.com>

Thanks Christophe.
