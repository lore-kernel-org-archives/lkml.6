Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeENJJk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:09:40 -0400
Received: from mail-ve1eur01on0068.outbound.protection.outlook.com ([104.47.1.68]:16992
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751998AbeENJJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:09:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH v2] net/mlx4_core: Fix error handling in
 mlx4_init_port_info.
To: Tarick Bedeir <tarick@google.com>, tariqt@mellanox.com,
        gthelen@google.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
References: <20180513233845.135290-1-tarick@google.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <02b1c1aa-9d40-78ac-8136-f2c46d0e2424@mellanox.com>
Date: Mon, 14 May 2018 12:08:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513233845.135290-1-tarick@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::26) To VI1PR05MB3262.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;3:AZUX/5joDi73RY3EgD0KeWbMulc0hznDOe+BuXWbSaR/iq6ClkqRFFyDAG5IGtU58Vouz+/8G+xv4X7pGtpfGcUdNiXR6MYuJXtE4WssuzMrv661420JYd9QSfbXVjhIG4KLDefu/2bbnMKVCrGyRnJUyPIwKhBLm3eZjageACw2rpDzPTtZVHBkv0mkubx6ydPXe2qiuEt+7SiYP0DvYgHGIho574Bw5spktgqIqLhlvK+DV6NMgxUG9Rg8r9G5;25:VI+u/n087kBlBbXyZPKrTPH41F03t6optr3rA1nTOe2/Xws6Qc2JeQuNhvzX1qyizzQWPMeFqdH+piD+nCu6bnegEgk5DjhTiZlVsDz/q1tgg6EJWzSUi/7awNDJ3tD3nSqmUHP3/0EWJ1xSYU/+8ap3qTRn1MSBvbhEvlZrlcHhE9w2VZNm1REbNOC//zmuGfxlXFxXArrOrvT8PexJoMpxbOF8QEHb0T0MpdoiAWZdv0BEQqksziUN3+wClyY7A1d90ZX5MuqgcSJncdpHRbmnpMtypdRogORizreDNCS4QxrbYuJK+1BKyQRbVhP3Mj1ColqJObhFmWegxMiqVQ==;31:+ww7vGrnmMk0d18O2KSmzxRYAu0sw3RD73lfkr4RGjbkTh9pTVqc+XR26wC8ttmLtXbL/ORb5SiVJpbu/thBQvF3knnvhxsq+/rgU0VieQk6i7c9+7U28FP3mtC9A6gxe8noMETxYR7ErFnVVC7Cm+vokpUlR/iQ7ZrBDZSnigdKjpne7BPUnKu7EJVSNsh4apBtAsb7Dk+8dQVHTKUlqsbVWHhRpzmTGnEkGivoHqw=
X-MS-TrafficTypeDiagnostic: VI1PR05MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;20:GxisORyROJ03ZjkhXGSEQe1VFkeH6a/k6jijNbVEqiPaxHdHNxZw7pwqVbsJdEtT1IflnyOqJJIedfzcWkEcBYQEBfioUL8llDRgnM22GWHdDA01HYX1GEyZ6CWJZXPtTnL9Zg6fLoHfo4mQ4uv8WyhBhv3UItGmEIviRRpLo30sDNQp1lY+MS/zqARO96aqRL4inUbfYlvgGMJ0G3kaRrPvhrEBmvuqifnFm2IzXOFjquy8gWqVm8ic69wQpvmnHIOkyBEiCjgjC+L76hL/GtUnb7x2MQsDcW/TjNksMLkRK6tA5NdU0EB6VAZ8I9SvItJF0SKGPzVnEzl4CyhhGMbPnBfeTvx8mG878VTCoV7jyUo1JGUGalZoz/DwqbOJcyCdZ7XIgS9LcL+6ssPgwEjwC+bFBJYsiwGAMHAfU3jtRhIVG5Fz5k9yL14G/79WdPwS4U71EwQFfGZCTwgP/6SG0pJA8Dqc9lURG+4RFyUUfGThcUTKtUW9VgIX83RP;4:u4qnHuDGxXintM44hxbVH5UlIlPQR/Ui/zbkVMobOyzCmgQeS8YSx1i0u5FpKcMFtq5gwyA+pF2CcCQCZd265Dc8G+g9+49uyXjr2u6O64Zgdx1F87df923ddXlkLpEMx91vjIC9Z8y4nSeVBrM8hs3fosY2pzgm7Xv+MuTrslUvUS/UyyAt3w+6a/EoLk6NHzFhLn/4Ix1a/9a1hCFWftcDigdmJgfm5e6xZgp4D3r3GkzvZTBEHIiTojqj0QYhDO12/hZM+yjYAYjvE1OhzblcGxaYXUEC38r3S1YNiUmlMGjIyZ26u1l5nVsBZUGoE3Xiz9Oni6lphsYZbq9jGgqsoglaRmQQ7AAXOG+2+P0=
X-Microsoft-Antispam-PRVS: <VI1PR05MB3262D91C8E7848BB3A3D0932AE9C0@VI1PR05MB3262.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR05MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3262;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(97736004)(6246003)(25786009)(81156014)(8676002)(53936002)(81166006)(305945005)(7736002)(8936002)(50466002)(2616005)(956004)(476003)(486006)(6116002)(64126003)(446003)(3846002)(230700001)(575784001)(86362001)(36756003)(31696002)(2906002)(11346002)(66066001)(65806001)(58126008)(110136005)(31686004)(316002)(16526019)(16576012)(77096007)(26005)(186003)(106356001)(47776003)(65956001)(52116002)(76176011)(105586002)(229853002)(6666003)(65826007)(5660300001)(478600001)(67846002)(15760500003)(23676004)(52146003)(2486003)(386003)(53546011)(59450400001)(6486002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3262;H:[10.8.18.76];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1TUIzMjYyOzIzOlBhbGpteUx4dndFTlVvbjVJSFBRYTJCYlox?=
 =?utf-8?B?WDljOVJLVDlzR0NkMEZDemxseDVhaUlBY1N2R3p4YzEyTFFyd3ZjTE1pMHRr?=
 =?utf-8?B?UlRjdUtrUkVwYWVEcjcwYVdybzVKbDNFZDlLVVQ5RUNrbUFKYThIRU9XanJv?=
 =?utf-8?B?bXYzajdaT0o5V0FuMXliekdtYlo1dnF1SHowZ1l4SUJ0NGRuUnM2czlLeEc0?=
 =?utf-8?B?SFU0TVNISE5pM1o4cVFVSlNoN1U1NTZBSEp2dTNOQ25uU3lhalN4NlJwY2Nv?=
 =?utf-8?B?MUdlOTNSSWdqS1E4cEk2bzRaVjhxQWo3ZzNJVGxtMkhCWlNzM2c5VktlNUho?=
 =?utf-8?B?VGZORm9mM0JuY3ZDd1ZtTjZUbUI4dkMxT3JrNXZGcmYyd2d4NW9LY3Rrb0hE?=
 =?utf-8?B?RE1rOW50TUJMdVQwYkJDTjQ3MENqSDZZbndadWdHTllKRWVtQTlYR2ZITEo4?=
 =?utf-8?B?ZjJhTGtsNkRTay9wbkhQTUJuWE5tbDhGUzZvQmZnWjdGYjFPRlZBN1dXdm5u?=
 =?utf-8?B?b3dzTGpOMDJzd1hnSEF2WjF2ZFlLWnBUaExiU1ZUWkRuWnNZZ0wwQmJTKzlx?=
 =?utf-8?B?L0R1bDNYRVlBazlveE8xTXNZNlk4SVQyMWN6NFByNjBuVkZzL052bFFkT2JT?=
 =?utf-8?B?YmVIV1V2U0NtRGd3Q2xzVUxhSzhzU1lVYVFEd09DeEJVQUlMaDhzN1dTU21K?=
 =?utf-8?B?UjRnS1hXRXYvcEVuNTRnWlFzazUvSXFLSlpkSXZpT0dNQ3JWUlR6bWJvVUFZ?=
 =?utf-8?B?T2VTMnhRWEJ0V1JjcVAvVTVadkk4TXU4aEdmL2dnRG5jQitJZGRkMCtXcE9C?=
 =?utf-8?B?M2srWFkreVJjdzdBZlRRTFJVRWZjbjBsYktDbWNkK3dUNnk3Y1Jlbks5eE1y?=
 =?utf-8?B?cnNSdkgybVQzaU4ybEIwV25JN0NTWURiOHY0SS82K3M1ajlQRHV1bmExeUlv?=
 =?utf-8?B?elJiYkNTRGU2amZIWFhSVmxjK2FWRFptWFVSMXdBaW0vRzlXVTA0VFB5c2pa?=
 =?utf-8?B?VE5vS1dyWGlEZmF2TzNtVzR6MUI5OEZ4UFpscUx1bldvYmhDQ1NiQ055c1Vr?=
 =?utf-8?B?NlpYY1RWUVdVUzBSSVNNYXpIeVBhQ1ZOeTVPaFJCWno0K0UvbUZRSTlHSTQy?=
 =?utf-8?B?VjBRUzdmNjZocm1KVElSM0VEVUlpODRPWGgraDN1SzZaSU94bkhza0JJeGx6?=
 =?utf-8?B?aHRWNlRaalRLeUgwY3ZXbGtMQjNqc1haU0JPRnpQbS9XbmxjOUZWS2EwRE52?=
 =?utf-8?B?ZFRoYnZZYzQ3YUt1d1NPemdtempOTXF0WE1VbTduWXlCeDFQRVhvK2FBUDNU?=
 =?utf-8?B?Zk1uL1ZJUHNPRTVGMklmRW5FLy9iUWhRSmJpZTM0YnhTN2plTkFpMDUzZXVu?=
 =?utf-8?B?a2xHMEx6dUVmT0JBMExyWjlrL3FXRnVnVHpqVUdURElMWUFObWh2Z290Vmth?=
 =?utf-8?B?Yzc3VHZpOG9PeThRaU9YaUZzRkdvOG5oRHpQdFJaRHVHZVB6ZUgweEF4dkNG?=
 =?utf-8?B?c3NlTWFKUzJLU05nMjVwTlJQS0dvSStWcGtmbjRGVk9TT3RiNXpTbTZPS3M2?=
 =?utf-8?B?RUl4bEJKVjZoZzROdHBscGFJTE5TOGpPaDVzODlXQlZnS3Y5dk4rMTlmdHE1?=
 =?utf-8?B?S3VZbkJRR2hvbG5UdzNGWVB0ZUV6R1BaNDcvMGlPSDdvRGZWSDRnbkIzTjlt?=
 =?utf-8?B?cFIvcE9xcVd0djB2NzlBY0FVYmhvYXZUTVFMdjNtYTI0ajcvZHNDME9jSW9H?=
 =?utf-8?B?UG1WQWlNakNUQTdIV3owTjRqSmoxUUp0ajFRdjZHdGRVK1I4WHZOMi9RaTkr?=
 =?utf-8?B?bzduL0ZVZHgyWkRvemlRQzVlRmlTQXYzaGhaYXV3RklBTFZMNUdBZjhzUVpU?=
 =?utf-8?B?QXNKSkpLRE4zbXkvSXdlbnF1blR5VkNkZFpDd3RoV2NFMzNNZzhlZTNCSWFZ?=
 =?utf-8?B?NjZGVTNGZlJzcDhZVDB0Rkovb0pVS0kzZGUvbnEyTUdWSFdQZzFRS05wSmVK?=
 =?utf-8?B?Qlkxc2dkTUkzeExGQWpYMzNoYzhhaStXTU84QT09?=
X-Microsoft-Antispam-Message-Info: Y4n1oUBDg/OMSbbS69694UxC41kNmcRWoRmCaZnCRk1GioEZFbEQh9sCEXNIFGvlPFQLnycKmMJ8msuyoS2S9BfchdqFuOCQ/l0j/tzzt+bzXf/HI+q0uoDloEUf6Vhk1nL4wGDfOPXPqvLrOCmfN6i33f+meqGX85gEHd7oOQY/jTDqAYDTQz9NBhWMf6oL
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;6:T+5deB/VsDySSZds5jMi7FY/6jAt7QL7RwR4FioyeM+1UiojsoZTA8iqFtdCzMsf1lYQGxy3ThZ50rsr4bt9a5ZJA3anCrrT/NwDJeRC3drA88F/NaFkL+iEnSiwrwUY8WfXnhQCzv0EZbefu0+d7FbQKwKqSOEP8/3NTn38XfVYkkSMLOostK/2q7GgFhupFSlEDwKulhLRr50owupgZgJNT7ArQruEHw6/nojAxznQue5TulMztiVEUv+INQxMui+PhKiTBB56D/QxyyX4KYpmY3oeVR4GGPVfoHOwl6j8SzCGsKGwcurL3qnKMQenn8Pt3RfTQcGII0DLYFJP+rlVEQLQpS609hR3qIq39C4Btpkj/yoJIlxBPSLQ9pfnvbxgPK/8zzt+fWDdYyqrSSUNDzppFWxTENwFsjIyhNH4c4jd7u+8J3++wBxPGUtRjRJHGVU7bsg57oqv3HnjlA==;5:iMthlNTJwENeJSJeGJFGUw3iDk+tXd0wRw+ZWiaOWFntvjJlaFaRYgo6neEjjkJKJYPnSVvrsPYgDpX5VtKZ8xJern06MFN3U9c8viSFCNujfeefhEruYtqm+bcUX0A+cXNLGsKIFiG/Qc1omEJ8ibLO/2+hMmrfpv5NMoP7sIk=;24:AGo/sUkK7Iup0Ebo2dRqbSgLGqbQM0xYSQK/y3PY1op8Cz1Q3azBYhfGL7UtTBKRC4F1x4IyUXFwTFnTOSm9GiXISp4GTTuxNJ7FEjMcEWY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;7:/Pad/ZyAxjXv9pENxkuQjYWbDuxcoKirToaDdpd275IWxci4M8JY4DvUu+fY2srTXR/7bIJb3ay2fVx/iBCC4HiCbX6ySWDKM9Q4xiIMjMdmPrS5eAk1FJ7HL6xPKLZDmS/CEwmPuuJyeGbu3U4HFilpVKg47YhNpRpl828GMBua5agkgEoWN4uWdDxApBG1psGz7OIlG/qQ4gqFEQeEO3Z+jb6dwgBuRP7+KNZXTJpVRtvOtrHliB5hoSd+jmWR
X-MS-Office365-Filtering-Correlation-Id: a19fe179-d3cd-4b47-5a68-08d5b97a676a
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 09:09:27.0744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19fe179-d3cd-4b47-5a68-08d5b97a676a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3262
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/2018 2:38 AM, Tarick Bedeir wrote:
> Avoid exiting the function with a lingering sysfs file (if the first
> call to device_create_file() fails while the second succeeds), and avoid
> calling devlink_port_unregister() twice.
> 
> In other words, either mlx4_init_port_info() succeeds and returns zero, or
> it fails, returns non-zero, and requires no cleanup.
> 
> Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB
> ports")
> Signed-off-by: Tarick Bedeir <tarick@google.com>
> ---
> v1 -> v2: Added "Fixes" tag.
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

Thanks for you patch.
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>

Dave, please queue for -stable.

Best,
Tariq
