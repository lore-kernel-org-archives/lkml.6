Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA930C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D942084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D942084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeLJLdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:33:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40531 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:33:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so9157058edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TIGAD1tThUKUSQdZkSPsPQOtYZEw68agfFfNzelGTi8=;
        b=eBv4L0NhfQaajnt52RU68xvW6Yr8DowvF+xz88+z8454Yx5ccwuJ/X789g4ajpupjg
         +M1PbRadj0OztmgIvmwWbf9JVtx9G3byhuCw/x1nXT4kaxwmMRijJOSKDAC1PQivvJYJ
         duX506APhM31j77TK51mZeSFMCxjwunfUwbxc50osIRpt8ncJHqg9mK2Einwlw/NFLcB
         letlfA7lYYA3dVr63Xt1t1S+qZd7GAuWZIe838FQAvEW1qffx3V4dj5q4yxya3fqfrL/
         6NjO8SJTtag8lZ4buv4s5d1QAbJrY/V8gZtP7Yx3IaplhVf7JoJqnSFrgVIf1fz5ztDQ
         QgfQ==
X-Gm-Message-State: AA+aEWbehYxowvYjPBWe4uU1JtmvipFvGltxkIJB5C+nu8WubN4zEstU
        Q2qGgyVr6xCcz/SlkXRR6hn+pgS8XtU=
X-Google-Smtp-Source: AFSGD/WrZElQ8J64J6GCOakqGxNnlqnT+K7kUJ6qbStoPSKoftyl7/fKwFsodYt3k2pooIoSk8kXpg==
X-Received: by 2002:a05:6402:694:: with SMTP id f20mr10641956edy.99.1544441601922;
        Mon, 10 Dec 2018 03:33:21 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c11-v6sm1753226ejz.70.2018.12.10.03.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:33:20 -0800 (PST)
Subject: Re: [PATCH 1/2] staging: rtl8723bs: remove dead code,
 rtw_port_switch_chk()
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181210095202.17599-1-straube.linux@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b735dd0b-b4a0-8730-f1ca-16e33e9dd1f3@redhat.com>
Date:   Mon, 10 Dec 2018 12:33:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210095202.17599-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patches.

On 10-12-18 10:52, Michael Straube wrote:
> The function rtw_port_switch_chk() returns always false.
> Remove the function and related dead code.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

Both patches look good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 34 -------------------
>   .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
>   2 files changed, 35 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 8445d516c93d..35003d8d9ba4 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -5334,13 +5334,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
>   	return;
>   }
>   
> -
> -bool rtw_port_switch_chk(struct adapter *adapter)
> -{
> -	bool switch_needed = false;
> -	return switch_needed;
> -}
> -
>   /****************************************************************************
>   
>   Following are the event callback functions
> @@ -5414,7 +5407,6 @@ static void rtw_mlmeext_disconnect(struct adapter *padapter)
>   	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>   	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
>   	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
> -	u8 state_backup = (pmlmeinfo->state&0x03);
>   
>   	/* set_opmode_cmd(padapter, infra_client_with_mlme); */
>   
> @@ -5440,17 +5432,6 @@ static void rtw_mlmeext_disconnect(struct adapter *padapter)
>   
>   	pmlmeinfo->state = WIFI_FW_NULL_STATE;
>   
> -	if (state_backup == WIFI_FW_STATION_STATE) {
> -		if (rtw_port_switch_chk(padapter)) {
> -			rtw_hal_set_hwreg(padapter, HW_VAR_PORT_SWITCH, NULL);
> -			{
> -				struct adapter *port0_iface = dvobj_get_port0_adapter(adapter_to_dvobj(padapter));
> -				if (port0_iface)
> -					rtw_lps_ctrl_wk_cmd(port0_iface, LPS_CTRL_CONNECT, 0);
> -			}
> -		}
> -	}
> -
>   	/* switch to the 20M Hz mode after disconnect */
>   	pmlmeext->cur_bwmode = CHANNEL_WIDTH_20;
>   	pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
> @@ -5530,9 +5511,6 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
>   		rtw_hal_macid_wakeup(padapter, psta->mac_id);
>   	}
>   
> -	if (rtw_port_switch_chk(padapter))
> -		rtw_hal_set_hwreg(padapter, HW_VAR_PORT_SWITCH, NULL);
> -
>   	join_type = 2;
>   	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
>   
> @@ -6087,18 +6065,6 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
>   		rtw_auto_ap_start_beacon(padapter);
>   #endif
>   
> -	if (rtw_port_switch_chk(padapter)) {
> -		rtw_hal_set_hwreg(padapter, HW_VAR_PORT_SWITCH, NULL);
> -
> -		if (psetop->mode == Ndis802_11APMode)
> -			adapter_to_pwrctl(padapter)->fw_psmode_iface_id = 0xff; /* ap mode won't dowload rsvd pages */
> -		else if (psetop->mode == Ndis802_11Infrastructure) {
> -			struct adapter *port0_iface = dvobj_get_port0_adapter(adapter_to_dvobj(padapter));
> -			if (port0_iface)
> -				rtw_lps_ctrl_wk_cmd(port0_iface, LPS_CTRL_CONNECT, 0);
> -		}
> -	}
> -
>   	if (psetop->mode == Ndis802_11APMode) {
>   		/*  Do this after port switch to */
>   		/*  prevent from downloading rsvd page to wrong port */
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> index 4c3141882143..f6eabad4bbe0 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> @@ -648,7 +648,6 @@ void report_survey_event(struct adapter *padapter, union recv_frame *precv_frame
>   void report_surveydone_event(struct adapter *padapter);
>   void report_del_sta_event(struct adapter *padapter, unsigned char* MacAddr, unsigned short reason);
>   void report_add_sta_event(struct adapter *padapter, unsigned char* MacAddr, int cam_idx);
> -bool rtw_port_switch_chk(struct adapter *adapter);
>   void report_wmm_edca_update(struct adapter *padapter);
>   
>   void beacon_timing_control(struct adapter *padapter);
> 
