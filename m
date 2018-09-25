Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5CFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D2820833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSI78JVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D2820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIZBYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:24:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55107 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeIZBYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:24:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id c14-v6so14596710wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VpJOLTJQlfQhlNPwjVTdlKFqBt2XRE5fnCgMp00p+GA=;
        b=sSI78JVTN0sCZHiu8AulpSmwT0RcYlpAF1g2jhC93YJhZCYdsyqiTV1nzLifxMDZtV
         YY6DACv+EmvGy99n/LB8oqDwLVpbyYnGitOV6f1kl4Y9kOCoxPPsGbx0EW2sY/5HkHqX
         uKlqXp//jOwbmqqJ0FWuPFvVtkqTXayW6np4gbHKYKz27MwP0+bQ0kUlMdA626Wc/BwQ
         2zAkCobJ9C17jqrGAOZraElCMwIid8UGZ6RoxEXc18hZeylQZewdWIE7tfr2ZBFQoNZJ
         iu5oGOurTX36TIsOxAL6GKgcMy0qQFnUkYST4t4Wd9a/xTSU6vcRHDvevcYBTGutXx+f
         oIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VpJOLTJQlfQhlNPwjVTdlKFqBt2XRE5fnCgMp00p+GA=;
        b=mpmASEosPzI8w1shgk0v8PX3lWtjxMRbwmkCZ74ysHRiV5AlC88H5ENvPMujNTKm9b
         GqUXMkfSb9xc/dinNRqX516pLYMoxPxPxV12mKOvR+o/D4mXg2bdTOE0JFkZxvpBq2X6
         AqSTdGyseddt2D96oe9XNIGozfH3F5jIUhEyZfRNxNKfh6mQJvnu5ba9x97BboqcK2oo
         yPA8KECjvKcTfF+W24nl8Ra+XBtsJAL1BL6FbGmXKy6VogFMkgzikulvve+YtrxWAzVG
         l3+byhI2HRLdLAdGBHct/mQ3prdy3OhwM3XZHi/yCgKDjjG/8bpyoltAzhV2SFi+Y5xL
         1bMA==
X-Gm-Message-State: ABuFfojvT0MsZWr02EjA98IFeDjzbZbbjsgX2ze3mLm42gMbRONeZUHa
        LESEhA/dwwacmKxyedCm8sw=
X-Google-Smtp-Source: ACcGV601XmTXWnfoi/ZBq3oipU/ScR8mQr3xh1xJXUAlJGQ1jFOiTJ8Dh8lpZ7tkAex+4NFnoZkutw==
X-Received: by 2002:a1c:889:: with SMTP id 131-v6mr1861198wmi.142.1537902906764;
        Tue, 25 Sep 2018 12:15:06 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o19-v6sm4574831wro.50.2018.09.25.12.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:15:06 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:15:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Simplify memcmp logical checks
Message-ID: <20180925191504.GA4454@flashbox>
References: <20180921002221.14424-1-natechancellor@gmail.com>
 <20180925190711.GA31631@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925190711.GA31631@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:07:11PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 20, 2018 at 05:22:21PM -0700, Nathan Chancellor wrote:
> > Clang generates a warning when it sees a logical not followed by a
> > conditional operator like ==, >, or < because it thinks that the logical
> > not should be applied to the whole statement:
> > 
> > drivers/staging/rtl8188eu/core/rtw_ieee80211.c:293:8: warning: logical
> > not is only applied to the left hand side of this comparison
> > [-Wlogical-not-parentheses]
> > 
> > It assumes the author might have made a mistake in their logic:
> > 
> > if (!a == b) -> if (!(a == b))
> > 
> > Sometimes that is the case; other times, it's just a super convoluted
> > way of saying 'if (a)' when b = 0:
> > 
> > if (!1 == 0) -> if (0 == 0) -> if (true)
> > 
> > Alternatively:
> > 
> > if (!1 == 0) -> if (!!1) -> if (1)
> > 
> > Simplify these comparisons so that Clang doesn't complain.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/161
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 2 +-
> >  drivers/staging/rtl8188eu/core/rtw_mlme.c      | 2 +-
> >  drivers/staging/rtl8188eu/core/rtw_recv.c      | 4 ++--
> >  drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> > index 9e5c7e62d26f..20f34d25c369 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> > @@ -284,7 +284,7 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
> >  
> >  		if (pbuf) {
> >  			/* check if oui matches... */
> > -			if (!memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)) == false)
> > +			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
> >  				goto check_next_ie;
> >  
> >  			/* check version... */
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > index ef8a7dc4bd34..43d6513484c5 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > @@ -1437,7 +1437,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
> >  	/* check ssid, if needed */
> >  	if (pmlmepriv->assoc_ssid.SsidLength) {
> >  		if (competitor->network.Ssid.SsidLength != pmlmepriv->assoc_ssid.SsidLength ||
> > -		    !memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength) == false)
> > +		    memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength))
> >  			goto exit;
> >  	}
> >  
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
> > index ab9638d618a9..f3eb63f8cf0b 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> > @@ -1283,8 +1283,8 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
> >  	psnap_type = ptr+pattrib->hdrlen + pattrib->iv_len+SNAP_SIZE;
> >  	/* convert hdr + possible LLC headers into Ethernet header */
> >  	if ((!memcmp(psnap, rtw_rfc1042_header, SNAP_SIZE) &&
> > -	     (!memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) == false) &&
> > -	     (!memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2) == false)) ||
> > +	     memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) &&
> > +	     memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2)) ||
> >  	     !memcmp(psnap, rtw_bridge_tunnel_header, SNAP_SIZE)) {
> >  		/* remove RFC1042 or Bridge-Tunnel encapsulation and replace EtherType */
> >  		bsnaphdr = true;
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> > index fb496ab5a862..51cf78150168 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> > @@ -856,7 +856,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
> >  		return _FAIL;
> >  	}
> >  
> > -	if (!memcmp(cur_network->network.MacAddress, pbssid, 6) == false) {
> > +	if (memcmp(cur_network->network.MacAddress, pbssid, 6) {
> >  		DBG_88E("Oops: rtw_check_network_encrypt linked but recv other bssid bcn\n%pM %pM\n",
> >  			(pbssid), (cur_network->network.MacAddress));
> >  		return true;
> 
> Always test-build your patches before sending them off so you do not get
> a grumpy maintainer upset at you for breaking their build system...
> 
> Hint, it's the last chunk here...
> 
> greg k-h

Gah sorry, it's always the times that I don't do that that something bad
happens :(

v2 sent.

Nathan
