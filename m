Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428B1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EA12084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EA12084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeLERhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:37:15 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:39549 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727475AbeLERhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:37:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DB6F3181D3368;
        Wed,  5 Dec 2018 17:37:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fear10_3f03f044c6940
X-Filterd-Recvd-Size: 2789
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Dec 2018 17:37:12 +0000 (UTC)
Message-ID: <3799b30191f457cfec945ccc0b91bccf6dd7c63c.camel@perches.com>
Subject: Re: [PATCH 10/12] staging: rtl8188eu: correct indentation in
 update_wireless_mode()
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Dec 2018 09:37:11 -0800
In-Reply-To: <20181205170247.5401-10-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
         <20181205170247.5401-10-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 18:02 +0100, Michael Straube wrote:
> Correct indentation in update_wireless_mode() to clear a checkpatch
> warning. WARNING: Statements should start on a tabstop
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
[]
> @@ -1442,7 +1442,7 @@ void update_wireless_mode(struct adapter *padapter)
>  
>  	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
>  		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
> -	 else
> +	else
>  		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
>  }
.
gcc generally emits smaller code by using a single
call and a ternary.

$ size drivers/staging/rtl8188eu/core/rtw_wlan_util.o*
   text	   data	    bss	    dec	    hex	filename
  14974	     36	      0	  15010	   3aa2	drivers/staging/rtl8188eu/core/rtw_wlan_util.o.new
  14990	     36	      0	  15026	   3ab2	drivers/staging/rtl8188eu/core/rtw_wlan_util.o.old
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 24918223499b..acad30f53f5d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1440,10 +1440,9 @@ void update_wireless_mode(struct adapter *padapter)
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_RESP_SIFS,  (u8 *)&SIFS_Timer);
 
-	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
-		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
-	 else
-		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
+	update_mgnt_tx_rate(padapter,
+			    pmlmeext->cur_wireless_mode & WIRELESS_11B ?
+			    IEEE80211_CCK_RATE_1MB : IEEE80211_OFDM_RATE_6MB);
 }
 
 void update_bmc_sta_support_rate(struct adapter *padapter, u32 mac_id)


