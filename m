Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELtD17arNawnHp4W7eSpzVLQZ5CYpybp/n2teM57NaSzOGNvWsNoRiy3E8K7H0xN1cbh0He/
ARC-Seal: i=1; a=rsa-sha256; t=1521662603; cv=none;
        d=google.com; s=arc-20160816;
        b=PaTP42YLT2nAIuN7rJWrDbI1b1O7QryAc31HZCv0zpuof2VyeEYN6o7njwCxZpMjVe
         3Jm7i4UONVZh4MCBgv9vzA03VBdv+AoFwDoY+wjB+CqaTOFujoGUt6o2J4VdrcGivxbx
         IxqfwWze8rs7/5Nmw/STemmvt/hnr2c8A+hGqxr/5A+gPFLFwJTXDUb6YPqaBJdWDmPA
         98pwRNq+xb3AiPLj25t+dm+co85DBEdDwsrm7J0zCem6dvAVTXP3zJbchCxYxrBWjHFW
         FXIaI307aVRwdwVNJHE00fpTN6U9KrG6NaFXLImz/7jcXnDr6TZskLt4qZWDSB0/+zdy
         rwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=pWGahTaLx5cu0ExHr95dBymtsEzuxgY6YsIA2BvPB+o=;
        b=AR8pinrKbjfAS3H4VPTi0ITxcTr200lBw7mpp/59gdVgC0i5J7rQ82UZTb27oJxFb8
         ZGB/ML+8W601wI6JCUQryrDGm/MLyQfDbVtIqCnU/2gJPUv+JC4D5jBowxK3/Ov3sTQQ
         7UZFn4WAReop415+7HxsDCZO7FGXnL7C9yhafCLwz1/1X5mnOqF9aiAB1cc2yZx8W9pn
         VuNUGpIIkOPM5SAxXbRqxRv4ieOd3+GHFeeihe/sXQJBWvaljFH8HoIaRbiKEBMVizy6
         u+9hslvHJnInwZGX5sSZgoPg7f2SFS9+b6PZBTboihFnNz0mYhi+dBG/qSnd3dXAiN8w
         lp/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.247 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.247 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3866:3867:3874:4321:4605:5007:6238:7208:7576:7903:8957:9113:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12555:12740:12760:12895:12986:13069:13311:13357:13439:14093:14096:14097:14181:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: mine16_5739574fbf835
X-Filterd-Recvd-Size: 2930
Message-ID: <1521662598.7999.33.camel@perches.com>
Subject: Re: [PATCH] staging: wilc1000: check for kmalloc allocation failures
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>, Aditya Shankar
 <aditya.shankar@microchip.com>, Ganesh Krishna
 <ganesh.krishna@microchip.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org,
 devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2018 13:03:18 -0700
In-Reply-To: <20180321191941.4126-1-colin.king@canonical.com>
References: <20180321191941.4126-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595576138463353935?=
X-GMAIL-MSGID: =?utf-8?q?1595578885427049450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-21 at 19:19 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are three kmalloc allocations that are not null checked which
> potentially could lead to null pointer dereference issues. Fix this
> by adding null pointer return checks.

looks like all of these should be kmemdup or kstrdup

> Detected by CoverityScan, CID#1466025-27 ("Dereference null return")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/wilc1000/host_interface.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
> index 5082ede720f0..9b9b86654958 100644
> --- a/drivers/staging/wilc1000/host_interface.c
> +++ b/drivers/staging/wilc1000/host_interface.c
> @@ -944,6 +944,10 @@ static s32 handle_connect(struct wilc_vif *vif,
>  
>  	if (conn_attr->bssid) {
>  		hif_drv->usr_conn_req.bssid = kmalloc(6, GFP_KERNEL);
> +		if (!hif_drv->usr_conn_req.bssid) {
> +			result = -ENOMEM;
> +			goto error;
> +		}
>  		memcpy(hif_drv->usr_conn_req.bssid, conn_attr->bssid, 6);
>  	}
>  
> @@ -951,6 +955,10 @@ static s32 handle_connect(struct wilc_vif *vif,
>  	if (conn_attr->ssid) {
>  		hif_drv->usr_conn_req.ssid = kmalloc(conn_attr->ssid_len + 1,
>  						     GFP_KERNEL);
> +		if (!hif_drv->usr_conn_req.ssid) {
> +			result = -ENOMEM;
> +			goto error;
> +		}
>  		memcpy(hif_drv->usr_conn_req.ssid,
>  		       conn_attr->ssid,
>  		       conn_attr->ssid_len);
> @@ -961,6 +969,10 @@ static s32 handle_connect(struct wilc_vif *vif,
>  	if (conn_attr->ies) {
>  		hif_drv->usr_conn_req.ies = kmalloc(conn_attr->ies_len,
>  						    GFP_KERNEL);
> +		if (!hif_drv->usr_conn_req.ies) {
> +			result = -ENOMEM;
> +			goto error;
> +		}
>  		memcpy(hif_drv->usr_conn_req.ies,
>  		       conn_attr->ies,
>  		       conn_attr->ies_len);
