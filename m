Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-288737-1525672506-2-1935966502093378084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525672505; b=kMqgjvcRYVbBkIg/aO9DZ5HjtCre44HgUAN8Qnv2wQEKzz6q+k
    ECRjJnvY9adVA1tdhWn3nBHGxqzt7MZZJBp0n0cpQ3BPSWBaUiuKpPniXIrVuF+v
    KtJsJkHCuGJAg2quM81PnsJJ2SV6X27fQpQFFYnEbtrTv6F3h8teW/er/NegJpKY
    NDvUJaJ1TGBN2pIxZemSB5tlcPqcqKd7i55dXuANKD78rpznECvSaUEJ6T1qSkn7
    H1b5bdaowdXgO83LsOE6Gm9qRvvw3SnWqgPysf1839duflJHNlWEnLfXE9I2P65Y
    ZFYMReFUnVe7qaEiOi9bQQ/RS4VbaKLPvGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525672505; bh=neDj0
    RfjDGq+B3MeQvFsK8Tiy4dzJ2AaB/qB/NVT/j4=; b=BNyoZ8oGOqnnaoUMcoObH
    O4QYRtyYycKzB7tRkNwFqADNz9c9D3cQFBm1SKUIjvsBwltckHfUZorTvChZ5Xwi
    F3YMqiBoz6jAbsfpVQ+ir9hh11milVc5HTBko87q3XnmP9tg5x8/9h2+Mxx5xjDY
    lEH11Lxctw3xh1Yq52bDGV4DmLUE5nytvuL5uPNuT12UbmLp+US8XvZr/I+eLNCu
    lwqVvttlYAS9LivJK6barfNOY2fp3Z/H+A0sVL+aVQ9h0HZiQZ9Y2olWJYChzkYA
    9sPqOR8UVrFAjYmL1FoCU3yT3OtT2GXBbn13rLqLpGlzlWrA8pXFZ4ILgrze6og4
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEKFkGu3TDdCKUeEgQYNiLX6tnYa83L48KIOvZsirY3FLp8ryQMynViPN4ZD6JjemS9ofuA67QlOuDRC3ngzeYXMjaJyrk5esBHPOwoznyetH8R7bmQq
    Cj2F+eChqAA9kUrHCDP+9LLF9/BVI8/mHkDvef0oaJxC3x/tA2+Ue0eTnyGc/AyodbiErgWPuQuqwFC2vN+kbeEyEUrsMP8E8XgadpQM1I26rmGs6/hqC1HF
    Erh8em34Fczt97by5px6sQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=XYAwZIGsAAAA:8
    a=DDOyTI_5AAAA:8 a=iaTgIlkPVuHxRqOLApgA:9 a=CjuIK1q_8ugA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.49,372,1520924400"; d="scan'208";a="13878727"
Date: Mon, 7 May 2018 11:24:51 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 2/3] staging: wilc1000: Remove useless function
Message-ID: <20180507112451.574f72ac@ajaysk-VirtualBox>
In-Reply-To: <20180506073333.3770-2-natechancellor@gmail.com>
References: <20180506073333.3770-1-natechancellor@gmail.com>
 <20180506073333.3770-2-natechancellor@gmail.com>
Organization: Microchip Technology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Aditya Shankar <aditya.shankar@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 6 May 2018 00:33:32 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> GCC warns that 'wid' is unused in wilc_remove_key and it's correct;
> the variable is only local. Get rid of the function (since it just
> returns zero) and shuffle the remaining code into one if statement.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>

> ---
>  drivers/staging/wilc1000/host_interface.c         | 12 ------------
>  drivers/staging/wilc1000/host_interface.h         |  1 -
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 14 +++++---------
>  3 files changed, 5 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/host_interface.c
> b/drivers/staging/wilc1000/host_interface.c index
> 3fd4c8e62da6..b5f3829e9903 100644 ---
> a/drivers/staging/wilc1000/host_interface.c +++
> b/drivers/staging/wilc1000/host_interface.c @@ -2606,18 +2606,6 @@
> static void timer_connect_cb(struct timer_list *t)
> wilc_enqueue_cmd(&msg); }
>  
> -s32 wilc_remove_key(struct host_if_drv *hif_drv, const u8 *sta_addr)
> -{
> -	struct wid wid;
> -
> -	wid.id = (u16)WID_REMOVE_KEY;
> -	wid.type = WID_STR;
> -	wid.val = (s8 *)sta_addr;
> -	wid.size = 6;
> -
> -	return 0;
> -}
> -
>  int wilc_remove_wep_key(struct wilc_vif *vif, u8 index)
>  {
>  	int result = 0;
> diff --git a/drivers/staging/wilc1000/host_interface.h
> b/drivers/staging/wilc1000/host_interface.h index
> 7a26f341e0ba..08b3ba7df8b4 100644 ---
> a/drivers/staging/wilc1000/host_interface.h +++
> b/drivers/staging/wilc1000/host_interface.h @@ -303,7 +303,6 @@
> struct add_sta_param { };
>  
>  struct wilc_vif;
> -s32 wilc_remove_key(struct host_if_drv *hif_drv, const u8 *sta_addr);
>  int wilc_remove_wep_key(struct wilc_vif *vif, u8 index);
>  int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index);
>  int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8
> len, diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c index
> 76b4afaef423..b499fb987395 100644 ---
> a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c +++
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c @@ -1054,15
> +1054,11 @@ static int del_key(struct wiphy *wiphy, struct net_device
> *netdev, } }
>  
> -	if (key_index >= 0 && key_index <= 3) {
> -		if (priv->wep_key_len[key_index]) {
> -			memset(priv->wep_key[key_index], 0,
> -			       priv->wep_key_len[key_index]);
> -			priv->wep_key_len[key_index] = 0;
> -			wilc_remove_wep_key(vif, key_index);
> -		}
> -	} else {
> -		wilc_remove_key(priv->hif_drv, mac_addr);
> +	if (key_index >= 0 && key_index <= 3 &&
> priv->wep_key_len[key_index]) {
> +		memset(priv->wep_key[key_index], 0,
> +		       priv->wep_key_len[key_index]);
> +		priv->wep_key_len[key_index] = 0;
> +		wilc_remove_wep_key(vif, key_index);
>  	}
>  
>  	return 0;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
