Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA62C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDED20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDED20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeJABJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:09:12 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:45001 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728192AbeJABJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:09:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 502F5180A813E;
        Sun, 30 Sep 2018 18:35:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hall21_49367db75cc12
X-Filterd-Recvd-Size: 1736
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 18:35:02 +0000 (UTC)
Message-ID: <7c4f645219bb69f31777367d5edc0830c32467db.camel@perches.com>
Subject: Re: [PATCH] staging: rtlwifi: Removed unused define and code
 efuse_re_pg* from wifi.h
From:   Joe Perches <joe@perches.com>
To:     Rick Veens <rickveens92@gmail.com>, gregkh@linuxfoundation.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 30 Sep 2018 11:35:01 -0700
In-Reply-To: <20180930182919.GA19383@localhost.localdomain>
References: <20180930182919.GA19383@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-30 at 20:29 +0200, Rick Veens wrote:
> The following:
>  bool efuse_re_pg_sec1flag;
>  u8 efuse_re_pg_data[8];
> are not referenced anywhere in the rtlwifi code.
> 
> Signed-off-by: Rick Veens <rickveens92@gmail.com>
> ---
>  drivers/staging/rtlwifi/wifi.h | 4 ----

Presumably the equivalent uses in
	drivers/net/wireless/realtek/rtlwifi/wifi.h
should be removed as well.

> diff --git a/drivers/staging/rtlwifi/wifi.h b/drivers/staging/rtlwifi/wifi.h
[]
> @@ -1840,10 +1840,6 @@ struct rtl_efuse {
>  	u8 efuse_map[2][EFUSE_MAX_LOGICAL_SIZE];
>  	u16 efuse_usedbytes;
>  	u8 efuse_usedpercentage;
> -#ifdef EFUSE_REPG_WORKAROUND
> -	bool efuse_re_pg_sec1flag;
> -	u8 efuse_re_pg_data[8];
> -#endif
>  
>  	u8 autoload_failflag;
>  	u8 autoload_status;

