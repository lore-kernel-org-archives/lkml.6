Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C45C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C6B214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548056814;
	bh=sDeqApZUS7ix8rBamhD5MyQkr6Lc5EPs5VGMwN0RYNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nA0X+NIEkiAihqC976AjPrOLITQdtJ+GoLH8diUS9Ug2tBqi50iFBjg4uM6k/es9M
	 xrCZgzIclRt1jB1BkH8nQqKsxA/LuTsKQgraIRa20jeHL1bmYoSxp2Jm4LZujBJSsU
	 ORCES96oddY1CFHQGP8SibFd7wIzyvSG3MI6Kxds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfAUHqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfAUHqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:46:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82F82084A;
        Mon, 21 Jan 2019 07:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548056811;
        bh=sDeqApZUS7ix8rBamhD5MyQkr6Lc5EPs5VGMwN0RYNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlRwevV/lAQEDiYENxwDNwb5kMTqGt+t+jMjtLKf9+AakR4rZmoF3ZNDYsvLqsG+V
         CvCAqlRXezUQG91QsAT+Kk9OWX1DiMt5MmxIV232pPkHEBURpj6XQUiMZ1jVTPg3SR
         JWCW9yvoEkPg95Ljp/6poMnVlheDwx3RRyat512E=
Date:   Mon, 21 Jan 2019 08:46:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, xiaobo.xie@nxp.com,
        jerry.huang@nxp.com, ran.wang_1@nxp.com,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suresh Gupta <B42813@freescale.com>
Subject: Re: [PATCH v1 2/6] usb: phy: Workaround for USB erratum-A005728
Message-ID: <20190121074648.GB4651@kroah.com>
References: <20190121031304.31161-1-yinbo.zhu@nxp.com>
 <20190121031304.31161-2-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121031304.31161-2-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:13:00AM +0800, Yinbo Zhu wrote:
> From: Suresh Gupta <B42813@freescale.com>
> 
> PHY_CLK_VALID bit for UTMI PHY in USBDR does not set even
> if PHY is providing valid clock. Workaround for this
> involves resetting of PHY and check PHY_CLK_VALID bit
> multiple times. If PHY_CLK_VALID bit is still not set even
> after 5 retries, it would be safe to deaclare that PHY
> clock is not available.
> This erratum is applicable for USBDR less then ver 2.4.
> 
> Signed-off-by: Suresh Gupta <B42813@freescale.com>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

Same issue here with the signed-off-by name.  For all of these patches.

Please fix up and resend the whole series.

thanks,

greg k-h
