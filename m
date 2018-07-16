Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692C208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C692C208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbeGPJIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:08:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeGPJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:08:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8AA91D5E;
        Mon, 16 Jul 2018 08:41:40 +0000 (UTC)
Date:   Mon, 16 Jul 2018 10:41:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 01/10] staging:rtl8192u: remove typedef of enumeration
 TR_SELECT - Style
Message-ID: <20180716084138.GB8260@kroah.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
 <20180713201247.21428-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713201247.21428-2-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:12:38PM +0100, John Whitmore wrote:
> To clear a checkpatch issue removed the typedef of the enumeration TR_SELECT
> this should not impact runtime code as it's only a coding style change.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211.h      |  4 ++--
>  drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 10 +++++-----
>  drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  4 ++--
>  drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |  6 +++---
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> index 3b7968681f77..0fa55af7060a 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> @@ -2391,7 +2391,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb);
>  void TsInitAddBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTS,
>  		 u8 Policy, u8 bOverwritePending);
>  void TsInitDelBA(struct ieee80211_device *ieee,
> -		 PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect);
> +		 PTS_COMMON_INFO pTsCommonInfo, enum TR_SELECT TxRxSelect);
>  void BaSetupTimeOut(struct timer_list *t);
>  void TxBaInactTimeout(struct timer_list *t);
>  void RxBaInactTimeout(struct timer_list *t);
> @@ -2402,7 +2402,7 @@ bool GetTs(
>  	PTS_COMMON_INFO                 *ppTS,
>  	u8                              *Addr,
>  	u8                              TID,
> -	TR_SELECT                       TxRxSelect,  //Rx:1, Tx:0
> +	enum TR_SELECT                  TxRxSelect,  //Rx:1, Tx:0

This really should be "enum tr_select", right?  No ALL CAPS variable
types please.

thanks,

greg k-h
