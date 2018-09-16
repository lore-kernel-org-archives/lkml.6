Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADFECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7DB2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LCswDJAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7DB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeIQDwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 23:52:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeIQDwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 23:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GNyQtAu7+C7TiVV929gNHkiH4fOBwCXr5gkbCNKvC0c=; b=LCswDJADtt5Cvi43DijJAAqoR
        stwnLycdZriWaZVA2NXTrnQztd1bjwk9EyMinrG/i1nAa2tKy4wZ2FYOexUwwzibB6UmnFKh5egOZ
        coBiEjiLrGVWbZvOK2Rg1NrxJjy527pasLOY0NxqYSKnmO8o24tN1hWwogcmT30XRkMfgGM0Sjyo1
        cW9IkhSwmPKASYrxsQnQu8CGXKa7PP2+17dX4FyiLvc7rklYGZ2ohuyWsJ1pu2/8Lg9QMG4sTCLYl
        RZEr8/7o/HoEvuK/z+AFqYA+67fNorI8LK2EKaQ+MMUoP1oonzL0jaTxLs0RpAxadfezkciMmLbrN
        WdHZhM+LQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1fVs-0002AV-Ny; Sun, 16 Sep 2018 22:27:33 +0000
Subject: Re: [PATCH] fix iwlwifi on old cards in v4.19 was Re: 4.19-rc[23]
 iwlwifi: BUG in swiotlb
To:     Pavel Machek <pavel@ucw.cz>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi@intel.com
References: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org>
 <1536651177.3224.106.camel@sipsolutions.net> <20180916093414.GA4299@amd>
 <20180916094142.GB4299@amd> <20180916095535.GA4245@amd>
 <20180916095935.GA4388@amd>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <23940459-3a95-7ccb-6ad0-dfa0790910d1@infradead.org>
Date:   Sun, 16 Sep 2018 15:27:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180916095935.GA4388@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/18 2:59 AM, Pavel Machek wrote:
> 
> .max_tfd_queue_size was ommited for old cards, leading to oops in
> swiotlb.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 

Hi,
Thanks.  Works for me.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


PS:  I started the b-word yesterday but my old laptop is slow...


> --- linux/drivers/net/wireless/intel/iwlwifi/cfg/1000.c	2018-09-05 13:12:40.453164067 +0200
> +++ linux-64/drivers/net/wireless/intel/iwlwifi/cfg/1000.c	2018-09-16 11:54:04.010970756 +0200
> @@ -51,6 +51,7 @@
>  
>  static const struct iwl_base_params iwl1000_base_params = {
>  	.num_of_queues = IWLAGN_NUM_QUEUES,
> +	.max_tfd_queue_size = 256,
>  	.eeprom_size = OTP_LOW_IMAGE_SIZE,
>  	.pll_cfg = true,
>  	.max_ll_items = OTP_MAX_LL_ITEMS_1000,
> 
> 


-- 
~Randy
