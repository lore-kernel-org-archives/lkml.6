Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971070AbeEXTYe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:24:34 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:49910 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967322AbeEXTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:24:30 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:69:355:379:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:2915:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3874:4321:5007:6238:7903:7996:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12438:12555:12698:12737:12740:12760:12895:13439:13870:14093:14096:14097:14181:14659:14721:21067:21080:21451:21627:30012:30054:30056:30069:30079:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: front67_7e497354c512f
X-Filterd-Recvd-Size: 3015
Message-ID: <57f2881d031de041a6ce95cf8adc5ce80551ce19.camel@perches.com>
Subject: Re: [PATCH] rtlwifi: remove duplicate code
From: Joe Perches <joe@perches.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 24 May 2018 12:24:26 -0700
In-Reply-To: <20180524185450.GA2875@embeddedor.com>
References: <20180524185450.GA2875@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-24 at 13:54 -0500, Gustavo A. R. Silva wrote:
> Remove and refactor some code in order to avoid having identical code
> for different branches.

True and nice tool and patch submittal thanks.

> Notice that the logic has been there since 2014.

But perhaps the original logic is a defective copy/paste
and it should be corrected instead.

Can anyone from realtek verify this?

> Addresses-Coverity-ID: 1426199 ("Identical code for different branches")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  .../realtek/rtlwifi/btcoexist/halbtc8723b2ant.c    | 23 ++++------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
> index 279fe01..df3facc 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
> @@ -2876,25 +2876,10 @@ static void btc8723b2ant_action_hid(struct btc_coexist *btcoexist)
>  		btc8723b2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 13);
>  
>  	/* sw mechanism */
> -	if (BTC_WIFI_BW_HT40 == wifi_bw) {
> -		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
> -		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
> -			btc8723b2ant_sw_mechanism(btcoexist, true, true,
> -						  false, false);
> -		} else {
> -			btc8723b2ant_sw_mechanism(btcoexist, true, true,
> -						  false, false);
> -		}
> -	} else {
> -		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
> -		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
> -			btc8723b2ant_sw_mechanism(btcoexist, false, true,
> -						  false, false);
> -		} else {
> -			btc8723b2ant_sw_mechanism(btcoexist, false, true,
> -						  false, false);
> -		}
> -	}
> +	if (wifi_bw == BTC_WIFI_BW_HT40)
> +		btc8723b2ant_sw_mechanism(btcoexist, true, true, false, false);
> +	else
> +		btc8723b2ant_sw_mechanism(btcoexist, false, true, false, false);
>  }
>  
>  /* A2DP only / PAN(EDR) only/ A2DP+PAN(HS) */
