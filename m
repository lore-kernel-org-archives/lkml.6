Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966122AbeEJOhJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:37:09 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:23666
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935438AbeEJOhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:37:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net/mlx4_en: Fix an error handling path in
 'mlx4_en_init_netdev()'
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180510070226.19575-1-christophe.jaillet@wanadoo.fr>
 <20180510133808.GA10943@lap1> <20180510141836.2qlm676j4675buti@mwanda>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <f29e851d-c4d7-cd04-dbb7-582adebc2854@mellanox.com>
Date: Thu, 10 May 2018 17:36:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510141836.2qlm676j4675buti@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::22) To AM4PR05MB3250.eurprd05.prod.outlook.com
 (2603:10a6:205:4::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR05MB3250;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3250;3:t6gQiMcJQKzCHsZxPqTcYrggYofcDdKX4xC87+FvRU0PCrBPGn441ITsVRou65nwUhpFQijPx2qcKHsKYvFAEjwRMJ744ucapWOcpVAfhtKx0apUo3pTrYLDHSG2vHIUmuDzz9W8xkyPwHmsu2CyVc4MWhaKWX3ENJXIX0c+dVrltWkhqjUHH/oAn67tMGXlo1Be9EqxDKfjx8LgY3glcKksyH49nKX8evKmZxZKb2sdPHg+mvVWit6uchEAxyiq;25:8w890yteIiiKZtXXt0KL1i2sMpQUCzxlaOzMVRSNEn3xoSK4KTBjLTJKLJ2mRus4/xhoxm2nLlWMSaCwJQSHgq8qSp+4TSaVh+AxYoC8IhNppaAQWfOhkaBLDID6nE+MtAhao47zuoqaeCyab5MyrB0EfwjkmmtXMnZm/SFnNIYZ5yBjN99M9B2KnNtiq3CR0eutq17S2Fe+8oSAlG5G0bp8Z7+e52PAlAKIfYVyszkH60MozeAXoOXWoQLOnm7dj6LAfG/0RX/3ouQb2Q0v1lEsFnjzZAR5b4JtP2gQ715aNPHVbuNMBMA8TqIs7hcxJO65f6UGSvGWZ5dcewgB6Q==;31:auf7rD6BvDw9NDAwEps7wYGXAuTMvVl7A7tu4Oey8HIgHvAwcb59XTRYV6B+41efsID2QQPQ1H1/4EzKUMTbEv4+yvYoxp/gvCEw0IM4DqW4jyFR5tCQ91WuzsFdYOtnTRvGp/AH0Gj00MV40pam3OLpWdt6F65McjnS8HNHJtWswVKOwFpEDggoh2/IZjrWEykttkBeVGhKJz9wLKBeSonYIkIMQEnvSSxz1fnyOak=
X-MS-TrafficTypeDiagnostic: AM4PR05MB3250:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3250;20:tgi5CBZb/5AAqM9W5PKH+ktDskx0sr7wjIbt7IEU60Un9Yg4F5jmbRe6DG114cvLR5X+eWYlNf7KKMsWsvUp3Tj3MW7WeJs8+SMCQe0lOUF7HVxEyI9HunNkKKfd0dB0shHruoBvDt0Ygv8z7GMmlaI/Fsry/bnKXpBb5DWImld+XdTKSnkvEPb+zsO15ikZfSIpR127NzothMKMc1kE7O7QhsD3mQ2rVB8jCJ3oMgc4CBW2aNBQJ97/yuNl6v7p5uyHdYA2POCUndliV6vFD6BARFnzsLNip3g2maASHzm+1eioK3r+xJk1TeUvKdvJbQ9+172YydTg2Z0euJc3PO7sl/y5IMUhCs8oxtrZBjloZHKxG96Bk662iBkA+Zy0Q7huQ7YtXdhvAyGn2DRWU+k5lUCoG9EPgmTlR74VnAy4yfdLhOkG7MI28NimMING2883L/I5ymFBWUEksWcCTPgHwEewJxjf0qsF2q6AiyAGPq5JZh5/KZJmUAQIXBdC;4:bi/A+AzghZRykAsyNkvLwDS/UYbwbcd8R9J+L4v2uZyUpYdYFJyX+SOWPYRQMq6oQ70fKgUkWmMJ/XIwGLkoN3KhYGCr+wewSJvYzA9rfL+AATHTiclR2a9LhgRTD75/bYo+ngZ4MT9MbbRjWZ0UN+Tt7R87d0ID5m9puQTkhXx2/FXqonaYEIE5xltlHZzOMc7IagG28GwwB4CfunHbT/6uLvYrMSr+eT1k42qvT9BS/kQJjuLWSwUit4nUVY6sN0asNhEBiBgcevXtO9W4QQ==
X-Microsoft-Antispam-PRVS: <AM4PR05MB3250939CB03F47BEF0481D2FAE980@AM4PR05MB3250.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR05MB3250;BCL:0;PCL:0;RULEID:;SRVR:AM4PR05MB3250;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(396003)(376002)(39860400002)(346002)(189003)(199004)(15760500003)(47776003)(478600001)(2906002)(52116002)(6116002)(386003)(81156014)(2486003)(52146003)(6666003)(230700001)(7736002)(66066001)(8676002)(3846002)(81166006)(8936002)(65956001)(65806001)(53936002)(106356001)(67846002)(105586002)(97736004)(76176011)(23676004)(5660300001)(53546011)(4326008)(58126008)(50466002)(26005)(25786009)(305945005)(77096007)(64126003)(86362001)(186003)(229853002)(16576012)(68736007)(6246003)(110136005)(956004)(11346002)(486006)(65826007)(6486002)(316002)(446003)(16526019)(2616005)(36756003)(31696002)(31686004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3250;H:[10.8.1.14];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA1TUIzMjUwOzIzOnFDdkcyUWtYWXRadHFZWjk1ZzkraDAwS3lq?=
 =?utf-8?B?cGNnWk5BUmM2SUhnTGFUbmRDWW51YTJnODczZ21Gc2Jtc25Cb21TTjJBQ1RX?=
 =?utf-8?B?TE5LR1RyQlYvQk41VVoxeDIxNTBaSnp1VDZiR0pyQVFkTkRNbFdyRlNXQktZ?=
 =?utf-8?B?aFJuTElqK2tkRW9WWHNtWmtXak44RTFUSGk5OXJGS3JGb2c4TlFsUWsydk5C?=
 =?utf-8?B?Z0dTajBrRFA4RnhZbmJyVEoxSmxISEkrOXZwOHhSWHV0YUJUaXJrOTFMRGtv?=
 =?utf-8?B?dDlpSyttUUUxaXZVc2VQRmxjUnAzZE1KRmhwejhzTmdzVUIzNXl3L2kwVjNv?=
 =?utf-8?B?ZHZqenZMTkZvMmk1c09nRmNjNDNvU2NKRkl2ektOcG1MRkN6ZmxXRFQ1Wmkx?=
 =?utf-8?B?TklrL2N0K05NRUo1UHc4a1h5REpiMEJZT0tGKzRZWGR6eFp2bU1WOEFIYzZY?=
 =?utf-8?B?NzkySDhhaXBSU2VIWE83V0pUQkhQZGhRNTFiWnZFanRhTHdrbWcxR1NFSHM0?=
 =?utf-8?B?OVNOQXJvN3JwNkQ5SllkWDVxTTNpakdNenJDWHJuaDhBRS93NU9OeDBDaUhP?=
 =?utf-8?B?RTdLS0tBaUZBQ3hza1BqcXc3UUdsakNwT2R0a1ZCNkQ5ckxDRFZlNno5c2U2?=
 =?utf-8?B?NmxVVk5ndU5iM1dhYkE3Y3B1Rm4vSDNmWEhUaWo0c2tLZXNRaTBOZlhZdHlT?=
 =?utf-8?B?OGEvZkF4d05DenUwRFdtSE5oaXlLbjdXUURYRFFDbjdYcFlvYVRETnk1bUV0?=
 =?utf-8?B?MUdyeHowYUdpNGpDTnhlR3U0RklOR3U3RS8rNWNTYmQwZWtXUWNJWEVtZS9h?=
 =?utf-8?B?Znh1MXdIaTkrbnlreVR5VmMxcjNQWTRCYUtvSlNzWmg3VnFMSWJERkMvK2R5?=
 =?utf-8?B?Wjg5YVJZd0hLNEJ4RFkyMjRjREdzSlpqVzlVdVkvUkNmbTkwMFp0QUhrbndH?=
 =?utf-8?B?cms5WVVSWEVzajkvdGZDZzRpdkx5OWE0OVBKMDUwRUM1K3hFZlJEWEp2bWJS?=
 =?utf-8?B?bzk4YkwzMjd2UFYrYUxacnVOZ01LMGpPSkVSSVc1T2pRdWZ2ZFMwdDV5NE5P?=
 =?utf-8?B?ZGpKZXVxRDFnL2FEL3JpejRQQUxkZmcwYTBnaXI4U0F2MXJoUzJ2MHFQcUx5?=
 =?utf-8?B?TlR1Z2NwU0NOSUk3RGM1aHVTQ2JxZnk0S1l1dU10T0dmWDVVemFXamliMlIz?=
 =?utf-8?B?NXFwaXpUMm9yRncycWltM1puVkZGYmJOMTIrR1ovVGJlS2wvOXBwQkRZc29Y?=
 =?utf-8?B?bmliSGZ0bFZFYjZXZVRsTjVHNDBobFljQ1loaXpzUlYxVW5ZWkJEamtZcFJS?=
 =?utf-8?B?dU5ZUk0zem8zNlU1Q0NjTjh2MVhXTzJWbk1qSWFYRDBVQVJwL3ZjM3FXWWc0?=
 =?utf-8?B?OGRTSG1oZDRoQU1GNlJmS2NDV2pSSlpKNFZxbEtnT2xnV2tpMXdSQlNmbGVt?=
 =?utf-8?B?SkZPL1lDSTl2NDd3a0lDb0c2TlZqcmF1bTdEejNCeGp2SXExWEdoaTFzek9y?=
 =?utf-8?B?dE8rTjJZb1phNCtKQlZqSnVwbHgzRGdvQW5sa1M2alNYZW5DR0FWYUtHclVm?=
 =?utf-8?B?SUJMbmRiUktPYlNsYjZ6VVFLejA1VTJkVitDSDBnZG0xSHdVYTRrbTd5b0sz?=
 =?utf-8?B?VzZ1WmJIS3FiV0ZobjM5dG4zUFlENHBsSDc0SzdudkhRK0diSllmWU1lM3NY?=
 =?utf-8?B?b0RmVzJkUkdXdDRoaW1rR2VlY2dTcjRjc0Yvd21PeHpyNmozQjMrbTRYVm1K?=
 =?utf-8?B?UUp6RGQvUGQ2cDlvT2ZNd25Hb2pPajlnS3ZNS2RQZXpzRnpLekcwVmFpNjEr?=
 =?utf-8?B?ZlJmSWZpei8zZEUvU2Q5L3RWR3pxQ3l2TFRKdEFFcU9oTGNjb3doc2dKMTBw?=
 =?utf-8?B?cVVLRTBTaHMvZkxCeWJnNGVHMkZCd3VhVHI0UU93UHZocEtHWUEyRHV5blZt?=
 =?utf-8?B?bUt3NHluT3RkTm94RGw1TmxBK1ZDOTRFUEdJU3I5YW5PMlZ1aUFPQ3lTL1FL?=
 =?utf-8?Q?Ftjut4?=
X-Microsoft-Antispam-Message-Info: bVY1gBjAApSTBA3EwRccPestYbw7WPVCbkUbGowxVFMYJggpY70Iz/360oKTJUDlASHWBTUpaho0GRJzQnl30FA5dSmLfICbou0Modwt+05SCn6euGfbwG+I+mYcubI0x/9iqPM3dYrCUXoOamDgEJ8KRMAurj5jvf+5EeOaFVAAJPrLRpSL893xYXXFF16g
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3250;6:t9OFjBGb4c8gmdjRd4AkLJ4N/A1aO9K+j1graMjuOK3wG9UpGSbbrgb37+3o14oYLzDZzHSG4NAwEFS8NaD0yAsy+FBlumlGv/5YSBbvlx9enzA5ps2XlQyzcJu5yxlNhpvtC7M0QTSI0nOyj80QZzi5H+diLONaq3IlUY2+G6VHhjYmGOT4efQuGt+CgnEYIEQ+z4mIuJc5w61fUV+PiB85Vli9N9SzkJTkzj1w06e4yIVt2SJftqwd+eyOW+WuhCJjqkC02r6NBKfs3fJZx8wVbYZHttkK2naN1082Zwd8gHpK4mHgdJRZpoVYjtqeTxyfVrw8ynZP9ZVj1Nq0WkbYFIbh5hPF6ADzXNKqLuVda04wzQH/QugUJRHk3qb44697xd7XA9+1SZt4bb1XOsH45FRZIl3unodfQtRDzgDrZu3ATBOWQavyyLSYtYfDz+LN5OX5fA6zamZUMYE1Yw==;5:XDnYDYi5qcR6rAqMtjZGPo9q4UIeupHbDs4ijeGlHt2hBE5wzR7AUmcscKM7nWjFBm0MaaPkqViyHocC3N2WN852yOBS9gsFM2dUcVwIp9uaDHXyeUFulza4u/kYTqOm9YRxcbdsK84A4yUXsKPbnf6bUzrZKT7bkc9+a+VFlNc=;24:797SGWQTTZRaSLCk1sWz4tdmolS9dPu0tMrZNZKdtiTed1CsYfviTsTHke3HGavpmTQCH2l59k0cVROKvEqT6Zp5bU0iF6NHjzed3LG0OxU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3250;7:7REd6pAJLnn3QD3JPuI6TTxWzlbnhVLWlDsHhLGxwUWlqVjuij9fIZfYJevuJBFp/WWLHogWp5m2DgngtvmRkCVaaLnl4uDgkRQB5z0oSLNqPyAc2JArBl8xWom8SYml7O/4+MtIoQF9pJSAzA7VGqL2xTBQrNxx/eEHPp8jzuzB/hhpyTlUJ5zr+R9LXhzsS/doG4m9mtobVFAJetdTTJJyl746/O2LLyHCl0KDCw5wJlCvOv+15JaYCtvvrg3O
X-MS-Office365-Filtering-Correlation-Id: 7a27e7a0-effc-4e68-9405-08d5b6837e5f
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 14:37:00.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a27e7a0-effc-4e68-9405-08d5b6837e5f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3250
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 5:18 PM, Dan Carpenter wrote:
> On Thu, May 10, 2018 at 04:38:08PM +0300, Yuval Shaia wrote:
>> On Thu, May 10, 2018 at 09:02:26AM +0200, Christophe JAILLET wrote:
>>> If an error occurs, 'mlx4_en_destroy_netdev()' is called.
>>> It then calls 'mlx4_en_free_resources()' which does the needed resources
>>> cleanup.
>>>
>>> So, doing some explicit kfree in the error handling path would lead to
>>> some double kfree.
>>
>> Patch make sense but what's bothering me is that mlx4_en_free_resources
>> loops on the entire array, assuming !priv->tx_ring[t] means entry is
>> allocated but the existing code does not assume that, see [1]. So i looked
>> to see where tx_ring array is zeroed and didn't find it.
>>
>> Am i missing something here.
>>
> 
> It's zeroed twice.  alloc_etherdev_mqs() allocates zeroed memory and
> then we do a memset(priv, 0, sizeof(struct mlx4_en_priv));
> 
> regards,
> dan carpenter
> 

We do zero (twice) on init, that's right. But I think Yuval's comment is 
valid in case of the driver went into configuration change, or down/up, 
that reallocates the rings. I'm double checking this.
