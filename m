Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-272202-1525672455-3-3348455086032545973
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
    1525672455; b=AXmQTmFqsFo5II5n/IJ96PNMug/D1s03IQnOILEKT7XJP4F1H4
    nK6QkL095WSAD6KlR7Q1rRMFV5hGTNU+fRmdeFZV4bBrA0gg3USAI6LHPheARZhG
    4V6K/PrxNrSfu0f4kUBoNlA6KYZE+3P1BSIyK5DcGFREaC0JNaOhQEi5t8lW/FZx
    usNjPRwqB/ThRNm/maiL5hPQSzUq3m6kDQMddQzR8EdKO07OH0vNpleDeOybyKpa
    K/I6xtnuMKQJTMt5sBlUahWWpS2DQGJSsHsCO/6DTdtUsDGQBGE8D5ABLlq+rMVm
    dB8a+d1O+dGRpATrtrtYEvFVLkCIGdG4hzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525672455; bh=PTJGG
    x+vKsXtusKI1VggCnSuUOIVsMIeww2GVcm1YRc=; b=WpWDWZGPvr68L253qcx4t
    2TxE1gDXAEH+VEXV9ChWKhFCy/iubqgwkyN1Rh2kyW3z3GOUvlJIzffogigwyLwq
    mdi/Pdr/lj1EQpa2tSMpf+zd0JTMzIcfj1hXF4oc8jq/CtZev300l881Z8mO1XQZ
    huDbYnXqh+LC8c03UvmBj/dDEEccDYfJ2gotOvYNXI3vKPMSn4f185kBb0oKN1dD
    72aimBeOJcNbFLkllZynsx4u/m7cZD4Nxsx9N6EXgVDPwPrb/n+ti9EJENeWo3JQ
    K2+vxzwoej701dTafRYUU8+g8lsFaJZvsFr79Q/1UW26g6tgfWt2K1SwBXJglMmL
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfIxu0au6kng25PgR3VFfGeW/9VeFxK9Kms6jAwTU49RqI20H+qDVcCcNqYKbZZ2XY7lHME1I9iUIt1YJVd3x/HInGCkMgqiYdqeVsR08gZ4nYwP1l2AV
    smZKopAChunjwCcbh7niSg9eaPdJllqjs2za4UfKSGa64m/VzJ4uYBXgL5U06MwoNCCreDcaY0PRZ+TDAIDzDz9P1GkeSKK0G8FzdCUCWrb0pZNAIFaaOu0I
    1WB0v10PfnilK4aGjQE1nw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=XYAwZIGsAAAA:8
    a=DDOyTI_5AAAA:8 a=e9YNR8KRjv5tQyLvbvMA:9 a=CjuIK1q_8ugA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.49,372,1520924400"; d="scan'208";a="14570233"
Date: Mon, 7 May 2018 11:23:59 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 1/3] staging: wilc1000: Remove unused variables
Message-ID: <20180507112359.2107677c@ajaysk-VirtualBox>
In-Reply-To: <20180506073333.3770-1-natechancellor@gmail.com>
References: <20180506073333.3770-1-natechancellor@gmail.com>
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

Thank you for the patch series.

On Sun, 6 May 2018 00:33:31 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> GCC warns these variables are all set but never used so remove them.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>

> ---
>  drivers/staging/wilc1000/host_interface.c         | 12 ------------
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c |  6 ------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/host_interface.c
> b/drivers/staging/wilc1000/host_interface.c index
> 28edd904b33a..3fd4c8e62da6 100644 ---
> a/drivers/staging/wilc1000/host_interface.c +++
> b/drivers/staging/wilc1000/host_interface.c @@ -1432,13 +1432,7 @@
> static s32 handle_rcvd_gnrl_async_info(struct wilc_vif *vif, {
>  	s32 result = 0;
>  	u8 msg_type = 0;
> -	u8 msg_id = 0;
> -	u16 msg_len = 0;
> -	u16 wid_id = (u16)WID_NIL;
> -	u8 wid_len  = 0;
>  	u8 mac_status;
> -	u8 mac_status_reason_code;
> -	u8 mac_status_additional_info;
>  	struct host_if_drv *hif_drv = vif->hif_drv;
>  
>  	if (!rcvd_info->buffer) {
> @@ -1472,13 +1466,7 @@ static s32 handle_rcvd_gnrl_async_info(struct
> wilc_vif *vif, return -EFAULT;
>  		}
>  
> -		msg_id = rcvd_info->buffer[1];
> -		msg_len = MAKE_WORD16(rcvd_info->buffer[2],
> rcvd_info->buffer[3]);
> -		wid_id = MAKE_WORD16(rcvd_info->buffer[4],
> rcvd_info->buffer[5]);
> -		wid_len = rcvd_info->buffer[6];
>  		mac_status  = rcvd_info->buffer[7];
> -		mac_status_reason_code = rcvd_info->buffer[8];
> -		mac_status_additional_info = rcvd_info->buffer[9];
>  		if (hif_drv->hif_state == HOST_IF_WAITING_CONN_RESP)
> { host_int_parse_assoc_resp_info(vif, mac_status);
>  		} else if ((mac_status == MAC_STATUS_DISCONNECTED) &&
> diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c index
> 8be3c4c57579..76b4afaef423 100644 ---
> a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c +++
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c @@ -917,12
> +917,10 @@ static int add_key(struct wiphy *wiphy, struct net_device
> *netdev, u8 key_index, const u8 *tx_mic = NULL; u8 mode = NO_ENCRYPT;
>  	u8 op_mode;
> -	struct wilc *wl;
>  	struct wilc_vif *vif;
>  
>  	priv = wiphy_priv(wiphy);
>  	vif = netdev_priv(netdev);
> -	wl = vif->wilc;
>  
>  	switch (params->cipher) {
>  	case WLAN_CIPHER_SUITE_WEP40:
> @@ -1885,12 +1883,10 @@ static int start_ap(struct wiphy *wiphy,
> struct net_device *dev, struct cfg80211_ap_settings *settings)
>  {
>  	struct cfg80211_beacon_data *beacon = &settings->beacon;
> -	struct wilc_priv *priv;
>  	s32 ret = 0;
>  	struct wilc *wl;
>  	struct wilc_vif *vif;
>  
> -	priv = wiphy_priv(wiphy);
>  	vif = netdev_priv(dev);
>  	wl = vif->wilc;
>  
> @@ -2016,14 +2012,12 @@ static int change_station(struct wiphy
> *wiphy, struct net_device *dev, const u8 *mac, struct
> station_parameters *params) {
>  	s32 ret = 0;
> -	struct wilc_priv *priv;
>  	struct add_sta_param sta_params = { {0} };
>  	struct wilc_vif *vif;
>  
>  	if (!wiphy)
>  		return -EFAULT;
>  
> -	priv = wiphy_priv(wiphy);
>  	vif = netdev_priv(dev);
>  
>  	if (vif->iftype == AP_MODE || vif->iftype == GO_MODE) {

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
