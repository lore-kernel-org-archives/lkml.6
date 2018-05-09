Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934453AbeEIKbV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:31:21 -0400
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:64956
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933715AbeEIKbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:31:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net/mlx4_en: Fix an error handling path in
 'mlx4_en_init_netdev()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, tariqt@mellanox.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180508093426.11550-1-christophe.jaillet@wanadoo.fr>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <b4f20eff-ccaf-9a0f-dd49-3522ba13a449@mellanox.com>
Date: Wed, 9 May 2018 13:31:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508093426.11550-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::36) To DB6PR05MB3254.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3254;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;3:il54CXV/pDAjl7P9igE+ChMol0BPkeJYCdBsb0o9ApCChIANwZ+ZaQgnlVO9q8JKVUafklQ+yPYmpzkdTT0OzQZb4Y8EAmeePDTLvaE7HoIgy20ZxLUH3lAvJtGXlnjMUAInBK82TphOhTcOm7o1KctAlJqIOKrfXXpZfCffe8eKtlz6MVbL2Tw+Sc6FxuIRrc1O5s0sIQd3FlgCOtHjdhGKRDDvDmVwxC3HbEsCQtkMVPtVd1aHqGln9Pb6Do/3;25:qvUow4gZC2UaSkK/PkHjOBEP+0v/Cnbw2zmeKnVoAWYdjkSrc7/P78RDiLjH4go6NE3ASsSsTYg+EVBBvI3F5fKFuilHAwAyk0Y2Xcmtr8v3UHqIQwflQQrywZ6/db/HWFVbcD8moyXtippdzlQRJ0iPuDv70SeKaYV4TRDcxomd7bT7Od6fRjb0F8DX+G6W1oAlfyR3wYRD9J5uZSxjOJzflR48EfXAoGK6lKbUnJEJUEZY3T0EJ/Yh8uJGYwV39hBFQfsd/VsbYD8pNn5lpl8mjFTXWrMnoA0N/FEYKHSsYBaY0pFcAKHDBcl+/dlQNI9MYlvGjnpaVJ0n6R19iA==;31:wNoyMr6uRrXXPY9tOO9vx0a03xjlRs35yJ8OQBaVLMSk8xKKndNWI8bHQl8jPiXqJnnJsYoCkdakJt63CnU4dHaRYan8lzI3b+dc4/TFrJ3/QxjMJtj/AbDtxPp0kUjIt4vGXXJeUDs5U508AppqwIuWmc6+ATujv8v1waBA2YdtQLZyvwO3odzItqM1Vs6jKruA/9ifm3dLGl2CfuA+FQis9NiQU0APw0H06Oyl+n8=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3254:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;20:5SiF1QSy+3gYqTIGIqdWWY2BeGVNiSqdlE0Hxt/7bx2NgCh6xVMZyNHXwkR8SBezq4oeUbnQqZtjSgZGUbd11HbeHSwDFMuO1kiVXqvVGVE7AxSiycpxW1yrTMX+xrx38o2GAgT8DNmlRhqZ5AsX9SxgcdvXoLRbATrFUxWn/zctMr4i0YAUR7ZGsh/laJYJC7TVxerwh7/Fy+vykgVAltRDAobb6P4OGe52m9tQIIvyqXGexL6hS09m67vDqMHfmFiuCwh3+yE5zMsPTZ3ruYnTY8hS0k222znBwVPT/4247aUiJrNgp1JuhjFAWEGTDjZq/UzEHBKu38bFISt7hOmxw8CLBSVkun+3dw05pPu61JvhuE5RTJeisPvVaJHh9i5JSKlPBQVMKtkTXTcFziwMARjQbJSGNPM8SomOqQEmjjT7lwtI6pr1SOWexfuig+4Pdnkd5Y+GsG2r7tH3CFt5d5xjdUH6mKzV+ju4Qw6ci27uohpMMHQfccp2xKHn;4:t8Xs8B4/YLF6NP6QF9/mx/zujhMiKH57a5zmvAhbufqD0+FtEqtttUDwyEo+ElStUPP0yhpTnTHAy35pqkknXQXTgrDfbkr3FOrmiCs4QvRSetumzmo5rv5PQjfsIgnvdMb+IA9/tdiqJeM93s3IOMa1ty/Bdc4MAwlK8qL4iI1YGJMW7f1rfjo7xM+4USGEUlVoV7MMPdYMDuKAtphdf9OmAT8UKXp9gCjTIS1IHvSeQI3uKxIpPX+2VGeMvA4IsqYMHxcql+t/xod7evgJ9eoAlurhB0lg08mBuIRSKHNx2ow9HzxBA048OYbSYMI+
X-Microsoft-Antispam-PRVS: <DB6PR05MB32541E75F46C86759F22C333AE990@DB6PR05MB3254.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155761271638844);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR05MB3254;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3254;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(11346002)(25786009)(65956001)(64126003)(66066001)(36756003)(476003)(966005)(53936002)(2906002)(58126008)(478600001)(2616005)(956004)(50466002)(446003)(6306002)(81166006)(65826007)(8676002)(8936002)(486006)(76176011)(386003)(65806001)(53546011)(81156014)(7736002)(59450400001)(23676004)(77096007)(15760500003)(229853002)(186003)(3846002)(6116002)(6246003)(26005)(16526019)(2486003)(6486002)(230700001)(52146003)(305945005)(52116002)(4326008)(67846002)(86362001)(575784001)(31696002)(6666003)(31686004)(47776003)(5660300001)(68736007)(316002)(97736004)(105586002)(106356001)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3254;H:[10.8.1.14];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjU0OzIzOnNVS09mYk01VGdaaTVrLzhxcVY1Wm15cHVP?=
 =?utf-8?B?U2xCYjhmamVRYzY0ZmpOT0FDQm1aSlV3Z1BkR2JOaFFrS2pYais5S2pqbGtz?=
 =?utf-8?B?VXpaT0RPRWJROGhvR2VWR2tPcmR5YjJrcjE2ejhEam4xS0g2UmQxYUdqdVYw?=
 =?utf-8?B?NlBDY2hpdFh1U2VjMGE5T3VBS2JxZU0rV3BPckhJdDhUSzhxUk9NUzlFMVdo?=
 =?utf-8?B?UDRKOUxUdlh1bEp0RCtCMVhzWXV6L3hoMzlSNk5vWlVSWldaMFJaZ3EwM3JW?=
 =?utf-8?B?aFFXUXNUeEM4VVJxYXZIL2owMHdrNXVPSkVlZkdDaXJLVHZBeGxkUlhIdmRr?=
 =?utf-8?B?Rk9RNzZJQk1PZUdVeThPelVhQVMvaU9yTEhQd2YzVGZEMFlmWUljTnhiMno4?=
 =?utf-8?B?L1h5ekwvTmh0ZmttMUdkS041R080K21TT2M3bVJGM1lEMHZaczA3NEQ1QndN?=
 =?utf-8?B?T0dDQVhiUm12T0FJd1pteFg2NGtTU3p5NkhNM0ZTTmVEZVFkdFg2VE9WZi9N?=
 =?utf-8?B?RGY5M05jUk1iU0dOWW5CWXRrZXpXNEI5NnBOREx1Z0c2UisyWFo0a3JXZ3Jh?=
 =?utf-8?B?SWUyd2VRK3JqbjFrNUJibWZlcmpTclJyZ0kzWlBpcVlWU1FQRnQ1UWxMZzJQ?=
 =?utf-8?B?T0NoeGFrSC9obU01cTlmdWxCZWdxRFIzWVR3OHR3ZExxVzVDK2FVK3R2b0Ry?=
 =?utf-8?B?a0sxdlR6MnUva2NINlFkOFNuZy9aMDNoU2ZkUkZSSk1vaS80alEyaEJaajJK?=
 =?utf-8?B?T0VLMVg2S21TbEp6SEJES1d6QVlaek1DK0V5NGhSaHY1WFlYd1ZJVnhrR2Zr?=
 =?utf-8?B?WUdwYzFlSTZpdTAxK0FyTW5iaTJwTkpkRUppYjBCdUs5TzZ5UmxoVzUxN0JV?=
 =?utf-8?B?RTVmaXA1WWJPbnJLZWpwOHEzdCtoVmJudFpGUEdMS1JUTDlWRFM5NnlVNk5J?=
 =?utf-8?B?MjFLNWova1cwSUxJbXBPbGlFY0VLVXJ3M0dsczBlU294ejRlQlJCQWxGL1dt?=
 =?utf-8?B?cjM5bUhJM0Z1dDZ2aVpPZlNNb21MQnF4NEJReHM0bk9rQkFhRURhYjVNeWQz?=
 =?utf-8?B?b3B0K1hlL0g5UzVFSkdTbUZDV0thQXY0MVl1Y3dySHpjdFhjYWFyMENxdWhy?=
 =?utf-8?B?OW5ORTFtcUo0ajlqNUs3YU1keFVqV05jMDh3ZWlJbnNyMG9IdVVBUDllbnVD?=
 =?utf-8?B?aGlZTlJ2K1Rad2lDN09yRFRBdG5BeGtxWHA5aGErbVdwUWxib2w0dXNKalJK?=
 =?utf-8?B?SVQ0SUhqV2lBNExrek1uMlFXek9OQnZscEJnMVowVkdYcjAxVVBVM2pFL0Nv?=
 =?utf-8?B?UC9TSWdPK2pZYmNDT1RjSHdnK0xwcFVLQlp6SlRVMFNaYW5yKzlaMkJiZ3B6?=
 =?utf-8?B?WFZ3M2ZZbktRS3BWVERqOHl1VG1DNHVqMjdkODdOc0pvMmJlUnFmLzRybkpQ?=
 =?utf-8?B?QURxV2E0QWs2ckJMa3NLeFFwYUd6bDBNZ0NFK0hVck5XQkpENXJLRUExK0h0?=
 =?utf-8?B?amU4bnpKZUVPS2h3UWFTQ2NQK2RrU25COWVYWXA4aG1yVUxRWE9RdFlpTjEr?=
 =?utf-8?B?MXFZMmtmMTR4MTBEV3hBeFZSVndtZGlyanRmVU9nTXNIQWJGdlA0K3VDMVI5?=
 =?utf-8?B?UzUvck1aM2IxbTNvYnNESE4vN0tNZzFpTGFwQjNYdnU2aU5ib2VsSkZWU3BS?=
 =?utf-8?B?bG9mcS80UStYbitOVS9GZHRDTk5SQmRzWHZ3WTQraVM0S0dlQ20rMnFCbndC?=
 =?utf-8?B?cVVMeVpTL1VwdFpFRE0yeEV3UU12ZWNUaEdCeGp1WS9RT1pPbmxzd3lNM3FD?=
 =?utf-8?B?SFBrandoQUF1ZXl5cjJuQllLMFF5RFFPcHU1cE92c0dUcW4zWWFPcUxoTnhw?=
 =?utf-8?B?VzdIWFNHNXFjNWN6enhVOGtQSmVXWDR1Q2NiRS9NakY4VUllUFBWRGEwczNx?=
 =?utf-8?B?ZUx4clV1SlIxaURWTGFWZExXQ0U2ZzNOK2RpM3pBTGFUNHFza2tjYUR5WW9k?=
 =?utf-8?B?NEQwdUJFN2tLcExOK091cTVUSmIvSElRcUs3d0JHdlpxVDJhaGUxNjI4b1ln?=
 =?utf-8?Q?CowHISqPy67y4oVF3v+1sILEd?=
X-Microsoft-Antispam-Message-Info: oxr5ec+rTG9qlpHyGyBd/mJlvoV1Iuh9bHUiPSQTgnBC9QTL6C+U75VXuw/Nx5YWzqdpY2tPpc0+i8IDw4IU0vkjTZuviJEhMmhk5NszuzaCKNgTl+QP0jpw0cFxHclNNi992k25VEof8e/xlmSDxIJw0J1np5D+LRQzuC8seTcMlTLjUCx1SYAYcXM5q+3j
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;6:8VLZMdPaDpkGhcVRnHwh2voSJoNyIL0ytw8tCS3+CIZQIO0z03lLOK60d8CjHIvj2XtKEVJg7zFlJKpytBoeHVTRDQw6wfEOs53H47O0Nt2Yf5wHJLbkhnaEZePEojQK1YKBDhHATVn/gABpkB/wbcglAGfDTraZSUAZcksc5sRq3KnUQ50dSpQWkdTvpyMWYaCXZW/IZsaNh9YmSrowCWvuPUhR3MivTVt5PVhvyQwXgTbjJi2dF0ftfCQQhTO5Yb1Gr1X/v6x4Cgl26ip8zw3mLJKdRdOSQsxRCDfMhCzaSc6mDgvZJFsSwfeB9/gypdxtA5sjUSSGVkfpdiIVjMq8FSq4FsopFsXl8wI3QK2G7sJSz2P2hxhs1DthSgLKwR/jvhSiG6JOvdAc4aXkZ0kbwwLuDtYHdUbWN0qz5bYUZveYVp5RD1XrJI/T6FWs/8QFXkszh/PTZrNIZUWNsw==;5:cQbar7jM5ro9el1XydnW/Axgk9QFKVjyJvBB/QUam15FFDwENYb/ZrmNX9mBXZzbtwQ0WwcPJGaIG7RkxFolukmJq+EE9Xonsufi1XwGvNWKuozyHfve+vyYFpOSYd57Vl6FXvXPkcLGX7Q47OOoE7wTbYbfPzTOy/o/E6IUnJU=;24:a0RBtp44rSig5n1EfLS0AbhoS2QiusK7MFHQ+rTs45oKbv0gk2IedJ7BEDbZmQCHCxwf1aPNeQjTjDXQ0OH88eogRNo5xzvrjQBxh7mo+dY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3254;7:YURWckKWwjwtX7rMhSCWV3pQ+cG8Tw92XTHgTklxJ5uFmqNJ34oTFhXPqa1FcJaU2xpfZHUU3KcmlDsvXyR3Vh3rXZ+SdMUPURdHtrFc+GlVmB42xwMPMCmxedxNVFzEhWQ69ey+FZVwyGmrsDe2fErpHnAYp51JQPA3q0aJkrwTlic0kR2TP9vznfEE/AO0bem6O6HWuAHmR95QwircGYC10ACO4HwHAbwcygdKJPtvh4Tq4/50P5Sqq3HxMYsx
X-MS-Office365-Filtering-Correlation-Id: a94a1a4c-96dc-42aa-bfba-08d5b597fd47
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 10:31:12.6507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a94a1a4c-96dc-42aa-bfba-08d5b597fd47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/2018 12:34 PM, Christophe JAILLET wrote:
> If the 2nd memory allocation of the loop fails, we must undo the
> memory allocation done so far.
> 
> Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index e0adac4a9a19..bf078244e467 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -3331,7 +3331,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>   		if (!priv->tx_cq[t]) {
>   			kfree(priv->tx_ring[t]);
>   			err = -ENOMEM;
> -			goto out;
> +			goto err_free_tx;
>   		}
>   	}
>   	priv->rx_ring_num = prof->rx_ring_num;
> 
Hi Christophe,

Thanks for re-sending this.

In your previous mail you referred to the call mlx4_en_destroy_netdev here:
https://elixir.bootlin.com/linux/v4.16-rc5/source/drivers/net/ethernet/mellanox/mlx4/en_main.c#L232

While I was referring to the one below, which is always called on failures:

https://elixir.bootlin.com/linux/v4.16-rc5/source/drivers/net/ethernet/mellanox/mlx4/en_netdev.c#L3587

I still believe that the err_free_tx label and its while loop is redundant.

Regards,
Tariq
