Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C17C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D21207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278862;
	bh=XK6N2uinDvV+6JPeXfwHwJnZR3lP8Ti8W5TFmVpwnec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GPCJrJZ2ybXPoMj34L5Z7cgV+ZkQ/AiHJhW0EGXhKd8V7r31RpqBApX9i3BRX9UX1
	 sJA7MDCSV+7O3K/dU033+MWxwtqjh9olEGr6yWilMQWlDi231E6g4Ac684xBSIxXJe
	 GVUnyTLKeblKAfQCdtG4ZrmEhUOQciKzKEgOpcl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfBDLOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:14:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfBDLOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:14:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 509D92082F;
        Mon,  4 Feb 2019 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549278849;
        bh=XK6N2uinDvV+6JPeXfwHwJnZR3lP8Ti8W5TFmVpwnec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQstwBIcoxiZPecPDL6qmGie3Yst9fn3Q5FVuNq+B+K4orDJEwmQEu3Zf4hNsa4GL
         SOIcVLDg3ncL1fjtB4kj9wW2yRmlwvYQH9QVCDA+zrh473Y0XMIlnncNPQ3BA3+pkR
         oUSW5Uv8C07YHj8fjDUjRnxuqqznVdQcZgqJcias=
Date:   Mon, 4 Feb 2019 12:13:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 06/65] mmc: Kconfig: Enable
 CONFIG_MMC_SDHCI_IO_ACCESSORS
Message-ID: <20190204111352.GA14550@kroah.com>
References: <20190204103610.583715954@linuxfoundation.org>
 <20190204103611.631926586@linuxfoundation.org>
 <ce449f05-ff58-3bef-5d8f-5499fefae9b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce449f05-ff58-3bef-5d8f-5499fefae9b5@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 01:05:32PM +0200, Georgi Djakov wrote:
> On 2/4/19 12:35, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > commit 99d570da309813f67e9c741edeff55bafc6c1d5e upstream.
> > 
> > Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
> > register read and write APIs, if registered, can be used.
> > 
> > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Koen Vandeputte <koen.vandeputte@ncentric.com>
> > Cc: Loic Poulain <loic.poulain@linaro.org>
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/mmc/host/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -409,6 +409,7 @@ config MMC_SDHCI_MSM
> >  	tristate "Qualcomm SDHCI Controller Support"
> >  	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
> >  	depends on MMC_SDHCI_PLTFM
> > +	select MMC_SDHCI_IO_ACCESSORS
> >  	help
> >  	  This selects the Secure Digital Host Controller Interface (SDHCI)
> >  	  support present in Qualcomm SOCs. The controller supports
> 
> 
> This patch is not needed in 4.4-stable. Please drop it.

Oops, sorry about that, now dropped, thanks.

greg k-h
