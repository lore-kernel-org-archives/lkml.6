Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeCLInJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:43:09 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:8925
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbeCLInG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:43:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net/mlx4_en: Fix a memory leak in case of error in
 'mlx4_en_init_netdev()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tariqt@mellanox.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180311224529.4427-1-christophe.jaillet@wanadoo.fr>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <a61ed690-7df1-7292-4074-3f7d66c0b490@mellanox.com>
Date: Mon, 12 Mar 2018 10:42:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180311224529.4427-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: AM4PR08CA0056.eurprd08.prod.outlook.com
 (2603:10a6:205:2::27) To DB6PR05MB3253.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96ef3b69-c961-416f-9a12-08d587f543ff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3253;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3253;3:xGUHfEOM4DAAl8/J9ENobuuZoFpzgMDDAHPHeylQzTx8zsEfWrKZc0J9H5KEddqa2EfFbEJkP5x3kxbWulSnomFOyR7Dld4SNIJb0EMXsCbEZ/DFhTAt5EyXmEgk1kuJ4fQspZqWhJeBQzoqCZXaj9cQCLr1SGww+wvLIHilhEw7tHXz9UD20PhYr0OkbLCQMK4z2xW8L7PaHChHTa1SB4GIK5hL8u3q2Qxz554EtdgthqlAt5+s8G0GxjDCzO14;25:oF31VsjIc7GhVjCL4gMhPGK9JqsitJbmA+arBbR626z7Gw0NQbsKP1818I1tiIPMAxIuM73wTq52HaNUtKMBXT3uMxg8Sp8fBGbK3KY6z9iqb0N3U4lYaIOmrpQrzDvSZPKn/xwMuiDeVDreGOhlsKpnc32BnbhxmFMxfGkXeI42J7G9Pe4JV3FqJIeylpLanNd1bowBdy+vOc/ZYTWZbOg1RR4ieyTQL6c/0CmUoa3JVbcHsE2ZGfxfNofzsoCZ7L2InR6rHvmOK/T5LjPWCvQU7U/HjSzWwvPzpyymGw/Bcev3hfW9sRNtZn1gRAet/izrEvGMM/cSgcXiJDtlLg==;31:sutdftmW2a4iUbLoE8F1QB2yjWhQ6rQhegGnXPjV72oXW5rNJS7Y2CJB/n9kM7jUhP+JGpZ57p6nM8+knq5fXhB/L9NwRx/NLkY1JCAbdroCvmqHvcAO6wdMtitHGTAyzjMZWhxiwidrzQi48Yr32zMIelT850qhg3EkMlRmeOOiafrOHgmRHXluxBcqi8N7iL26WUSuiEVa48a9ahlBTVhiEErYoJ2AeTsqos3OA0A=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3253:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3253;20:w6oz0+m1xjNBxDebhGbXEKnX/e2D5ILnvxXhJeStY5fO+Ax+Y2b1i9+uOTAGAWMVdVXnYJzWGP1+ehtDp1PsUIHSU4bZq7NIW+y2hg0pLjo4M2VtBEAtJDtRtH8DZ2vcxl01epXBYLZpjD77KX2Z5pjj6qpN4ORuUbpEDUHP+Zs50+El++MBd4he80TksPi32VcFLEeH+cz8KOixk784QEMDnk/hKrK/fN4acUZCiMNHvc8/+jh0Jbbc8XMaYKOzN84C7tDFr86vTW/mP8K3znLTltJwxHQ+T5S+Pfz5JFxLdfU4Ci+h++BsBAnwSRHoapc5iTQ7a4NKKmpXJYzb9Wo+bYmQoaZmYFxl9AnN1sexpbqxEqqT5atMxQgiYQRn9u5yYc96ViQfKm/1qzd+FgW7bzY14ql89B0taiH3BGkCCtAHuFwKhgeH+lLaBSh3ZcWDjhAMDsfSNRkYEADaV7sxJTy8bK5y3Jpmo5LMIz4UDDHlipfqyFJYUcoJEROc;4:Udg00Rh7zvBZPK7kmgJHHv3DzAUrpcKJEoSmurMDbqwscoh/FsEIcIX/L/4dNH8HTL5xccoGC/DB/OCxmRyJoyOrZ/xcW0BEoqPRUXqZ6LSBzbEYdc5ap9/bEO6pegQdhI+1c21X+Y/r6pUZu0DuNiAmMESoOa4oOtWmgvyiQs799dQwD6N9eD72ETOGkiVIk/zMbYYYnIF9UJPI6JDksKWEL29tHPdLZhzAvqu0KuQeiqZDUYjvdz9Y5JDauGJZqltLpRAl/EJ+sey/aYdYGoFPoqnAu30Zbo5sCOIoG02X3yjnGcltFRSPP4yd9FiS
X-Microsoft-Antispam-PRVS: <DB6PR05MB32539A8DAC69AC6FB1728BE3AED30@DB6PR05MB3253.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155761271638844);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR05MB3253;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3253;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(396003)(39860400002)(346002)(366004)(199004)(189003)(36756003)(386003)(25786009)(4326008)(16576012)(6666003)(2950100002)(86362001)(229853002)(478600001)(31696002)(230700001)(76176011)(59450400001)(67846002)(2486003)(23676004)(52146003)(52116002)(105586002)(58126008)(106356001)(6246003)(15760500003)(53546011)(81156014)(81166006)(8676002)(316002)(5660300001)(31686004)(8936002)(65826007)(26005)(50466002)(305945005)(64126003)(186003)(16526019)(65806001)(65956001)(2906002)(77096007)(66066001)(7736002)(97736004)(47776003)(6486002)(68736007)(53936002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3253;H:[10.8.0.245];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjUzOzIzOnViZzdmNitmTmQ1RFc4L0pCMVNOaGU3QkQ4?=
 =?utf-8?B?bXdaTzEwS09lME1OM1VzZXV4UjZtRzRIODBrY2NRMEYxaGxSSTduT3o3OHhK?=
 =?utf-8?B?eW5OUE5aT24waGRKSXhYOHpiNk9CUjVvSEZ5UFZ0UFAxZ04rVDFjVkxSRjJq?=
 =?utf-8?B?VkFnS29sMFA3UkJNekQxQnNDbmdWY05zYlcrZTU2b0JpN0J6c1Fpak0wNXhQ?=
 =?utf-8?B?Um03OGc1Ri9CZTVKWUk0UXpUWUE1c0lYT3pudzlOVTZrbzNGMkIvSjFkaVp6?=
 =?utf-8?B?WlRFVm1Lb3FRbHpNSHFldTJTckhKbWJoanRSdEZ6TlM2TUplVnAzSUN6SUtF?=
 =?utf-8?B?NUpxY3hHL2U0WkhvV1I5eFVqSzdmZk1lWmxWWXh3S0E0K0NxSXlycU1KTVI0?=
 =?utf-8?B?d2VhRlBZQ01KczJTWExqbnZhcndrL0xnTkdvUTdQc200eEZSU1E1dVlzQ2Qr?=
 =?utf-8?B?NEJuczBFWmxyczZxS0ZyTVJ1Q1ZmdjBhMW45US9ETXJTcnJ6VW9GM1FnRkVE?=
 =?utf-8?B?VEx5c200MmU4b2lKc3VhV214b0t3aWlXbnZHSWs1dVE2My9QMENNSTExQ3Z6?=
 =?utf-8?B?ek9RanZrd1I3TzE3WitScEdFWEozbUwyZnB2OU9yVUFXNEJQOTM2QmxaM1RS?=
 =?utf-8?B?ekJUeVNqL0lzQThwK0l3QWNNQ1hHc0M3RXVPaXpiNEduZnpQenp2UjFURm5F?=
 =?utf-8?B?S2tmN3lleTM3VW5Ua0Jaa1JYZktCMkFRWnVlZ1YxZlZrOTJGMmNyLzh2dE92?=
 =?utf-8?B?aGpZSStEZEN5NGo5ZnROamsvdU5VQk16SkFoZFZHdk1HZGZDUWhHTmQrbmUy?=
 =?utf-8?B?ZHZpSDlCYnh4OVlKSjdwTjN3QmJNYzk1K3dDbHRabHJxM1VsbGp6VEpobG9o?=
 =?utf-8?B?bWx0MEdDSFViS2tVT0hPTHRTeG8yVzU3UGxsb0tKNi94b1o2NWRlc3k4OXFF?=
 =?utf-8?B?LzZoTUlDMmNrSjJiVklQNmc4TytJMVBMWlR6MVFlTXQvektoVXhLeUlpUGpR?=
 =?utf-8?B?NjA2UmVtU1dITmpiN3pYWFo4VEVzRXJCNXl6d0dSOTVDQ0QrL0xFV0lOYWFZ?=
 =?utf-8?B?QTdIMVVEZkh5emFZOVJ2T3Joak9tY3MyNUdaeS91V21mTi81TGdldUtrMlI3?=
 =?utf-8?B?MGlTNjlOaW1DbGRLWEx5YlUrc3RMSVVGM1dJdnp2cTdNUkpvcksycGRleTlG?=
 =?utf-8?B?TENkZGw0Slp3VG1hQml5OXFLR3F3S3Rycld1aTNuUHRodmRRSEVjbUdSYlN6?=
 =?utf-8?B?SVBZTU5xRXJUN29ReGhNb0tBYy9rZS8wQms4U05hQUthdmtIUjZPSkNQU2k3?=
 =?utf-8?B?bWlqWWxkTnFkZG9aeVpFZ3I2QXZpMENoMEFJdHpUM1c2QVBubmJEbEhKM3B1?=
 =?utf-8?B?akVNZWpCR2htK0hEaU5hS2JqTHA0T0Y3cEtKYUxHMk1oblRqRmtrclBjMVdH?=
 =?utf-8?B?V0VISUU2UUFORm9GTUpQSEQzM3RKNm1UeTUrVHlFWG1UeldtY1FDMEJONlBG?=
 =?utf-8?B?bVUvNjhsR0VLNHpWMFZ2SEFnUk45S1E5Wi9RbHhCeHR4cEVyUGhSQThwN1VY?=
 =?utf-8?B?ZDBDVUJHTGpsYXZFbXRGTU8xVDFqRWJrZkJRRWdIbWJPZENVREZFTmdhN2Nw?=
 =?utf-8?B?TTZBemh6Z2MzT0NjYUdac1d3anpMQVhtVWNvdWNieGUrTjVWNGV6NHVqVkp0?=
 =?utf-8?B?eVhyeFZLcTlJalJzRXBwS0tLeFlOaTVmcDIyOVdoanE1THJKSHJ2RWpqS21H?=
 =?utf-8?B?L3E3MnJMb1FwQUU3Ym5zQWVqeWtLUk1TNXo5WjNZRzRtbzR6SW5XY1dVWHBD?=
 =?utf-8?B?SW9Pblp4bzFtTW90a0c2TWZMeUxlU0Vyb2R1YllFTjIyeUMvRWFudGthR0l4?=
 =?utf-8?Q?r49BBDp7E0rG39wsvz/zQmUXKXNA7m4/?=
X-Microsoft-Antispam-Message-Info: 0f66ECNY9nXjFLIdQfZUoLDi572PHD+4vMceuyTmLvZFbYVthgFMQ6B7NLWrIJ3YSShckyS4QKta183jSVvnIHKN56IVLa38iBrY2elmH+mOMVBdaQ2NOXppCimOvqTXio9LBG7mJdU5tM3sybKVvOHb7PFIUsPCFsbiT161xqqIm7XJQG3pDBci6zAtNSAO
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3253;6:/EQw6fzqLJRP3zsq/nCLLuk4grpdDIf48ET9oyThDcLo+j2QhaWpvmUragVwqg904qF3YDYAYUTk55CRV6BMZ7PML9ZzcE1BNp5KS4v74/UbsD3VEqrYD0AAiOzyDLE6a2JWbraaWC0L9FhFszJt2gvLL/nXLmH/pk2uWL4eQnJfgmPV6Ai01aLHZmZlKSF8Ev9+765vSOc9D81jv/dSwxyCIFOWicKiZHGChB4iVY0cE/jeqckqCanRRHIQyKYrnFpg4bbtfg2HD9j71FzsuhZwiVUxIviS4wMaSdCJx6Ynspzsx5253KqXyaXLq/nAQ78mo5hv2343AZaVOfob8/K6P4GgtIfxQHStFRxoobU=;5:UMHP1fxI4/0B8ZE0koUSJC+ou9fYjYzr16q6ATyhUnXP8YhAg31h/cJTpqtqnz33uLWUSVo//LNrCmKysyCz/7zOUEsXYv0+sWCmN/Wy7ZGy92lVttKOQCuMaKk9aJ+1dv3lj+QZxqbCkKlXBbzuuYVWTLnCCHLQchW51/wCFls=;24:QlBcw6DVjUrqYJXwwsPpoOlCto1lH9bYrTqmvjLFUIV677HGLkwZWJdbJNsh05XzUo+U/0EP6L3ZKYsjyZHF1EODBnD8v+oivbJ7St1h+Vo=;7:7FfGWUHbrgj8UEc8J46V5DvFq+yNlDYlXgirGdVch4+A/fmkgMXt+z2YYfCtLcTxxC76rjmzUCKgTEh1XzbMXRoXLuvCXlGIXHwZrRexEUl6Ke1tNo9JhS8GLFpUtYHhrS0KDq6JadkVpU/4UTdf8MBvTWeWNmvvKudn84+Jf85BhQAJqOw/V6aDNa3jBBFz46QmqofnvtyodISchQnuMbumgrHlEexHV+eScVpPhF5Ela9WLBKUPXppobvWapo5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 08:43:01.3011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ef3b69-c961-416f-9a12-08d587f543ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2018 12:45 AM, Christophe JAILLET wrote:
> If 'kzalloc' fails, we must free some memory before returning.
> 
> Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index 8fc51bc29003..f9db018e858f 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -3327,7 +3327,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>   		if (!priv->tx_cq[t]) {
>   			kfree(priv->tx_ring[t]);
>   			err = -ENOMEM;
> -			goto out;
> +			goto err_free_tx;
>   		}
>   	}
>   	priv->rx_ring_num = prof->rx_ring_num;
> 

Hi Christophe, thanks for spotting this.

However, I think these err_free_tx label and loop are redundant.
Both tx_ring/tx_cq flows should just goto out, as resources are freed 
later in mlx4_en_destroy_netdev() -> mlx4_en_free_resources().
