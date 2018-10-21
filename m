Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E0ECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651C620843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651C620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJUUlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 16:41:04 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:40966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727379AbeJUUlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 16:41:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 75965180AA4EE;
        Sun, 21 Oct 2018 12:26:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hat63_76641599ed25d
X-Filterd-Recvd-Size: 1973
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Oct 2018 12:26:53 +0000 (UTC)
Message-ID: <5f8063e4163361d64069d0fbecc7f723b503a4b8.camel@perches.com>
Subject: Re: [PATCH 3/3] staging: rtl8188eu: rename variable isCCKrate -
 style
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 21 Oct 2018 05:26:52 -0700
In-Reply-To: <20181020110819.1576-3-straube.linux@gmail.com>
References: <20181020110819.1576-1-straube.linux@gmail.com>
         <20181020110819.1576-3-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-20 at 13:08 +0200, Michael Straube wrote:
> Rename the variable isCCKrate to avoid CamelCase.
> isCCKrate -> is_cck_rate
[]
> diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
[]
> @@ -71,19 +71,20 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
>  	s8 rx_pwr[4], rx_pwr_all = 0;
>  	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
>  	u8 RSSI, total_rssi = 0;
> -	u8 isCCKrate = 0;
> +	u8 is_cck_rate = 0;
>  	u8 rf_rx_num = 0;
>  	u8 cck_highpwr = 0;
>  	u8 LNA_idx, VGA_idx;
>  
>  	struct phy_status_rpt *pPhyStaRpt = (struct phy_status_rpt *)pPhyStatus;
>  
> -	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
> +	is_cck_rate = ((pPktinfo->Rate >= DESC92C_RATE1M) &&
> +		       (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;

It would be sensible to convert is_cck_rate from u8 to bool at the
same
time and remove the ternary ? true : false too.

As well, perhaps remove its apparently unnecessary initialization.


