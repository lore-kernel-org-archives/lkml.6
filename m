Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED32217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551178580;
	bh=7vOICuNCMFbg3xP6GkbjzvlMG/B3vzFGwNisgY5v4SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KTNYmZO6gKg8C+NCFIJeg3x/SwJb6vE0QqLn97PXDFNU+SHsavi7VR4FOvmQu58+a
	 /rrOEK7Ogtap3zAmNzw/kzuXrn1tCfm1M0VaWpSoi81k6ZWSDtd55UnWfw1m8VH9MB
	 6CQvRH95jQLl6fOKROQqlyWX5aFHyr+qYUKxOUQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfBZK4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfBZK4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:56:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CF22173C;
        Tue, 26 Feb 2019 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551178578;
        bh=7vOICuNCMFbg3xP6GkbjzvlMG/B3vzFGwNisgY5v4SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2YkPWfPgJ1RZEiSm75HoXO4MmC87RdQqXmcuTLNT4UPD9k614KkWmCRRCPzCn8Nz
         SGgvvHB3vondFbZ0VAZCsguyT0P/1WYfE1Eo65chNS9cW4h9FVyexawRRT1SrbXflK
         bMPJ5P3k6N+phFSfcG46HtKvHDo1PRu7PAkVd2cQ=
Date:   Tue, 26 Feb 2019 11:56:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
Message-ID: <20190226105615.GA12397@kroah.com>
References: <20190224153622.8877-1-digetx@gmail.com>
 <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <20190225080715.4965810a@dimatab>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225080715.4965810a@dimatab>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 08:07:15AM +0300, Dmitry Osipenko wrote:
> В Mon, 25 Feb 2019 02:27:19 +0000
> Peter Chen <peter.chen@nxp.com> пишет:
> 
> >  
> > > 
> > > Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for
> > > Tegra20/30/114/124")  
> > 
> > I suppose you need to apply at stable tree too, right?
> > 
> 
> It is enough to have the "Fixes" tag to get patch backported into all
> relevant kernel versions.

No it is not.  My scripts do NOT trigger off of the fixes: tag, please
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.


> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >  drivers/usb/chipidea/ci_hdrc_tegra.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > index 772851bee99b..12025358bb3c 100644
> > > --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > @@ -130,6 +130,7 @@ static int tegra_udc_remove(struct
> > > platform_device *pdev) {
> > >  	struct tegra_udc *udc = platform_get_drvdata(pdev);
> > > 
> > > +	ci_hdrc_remove_device(udc->dev);
> > >  	usb_phy_set_suspend(udc->phy, 1);
> > >  	clk_disable_unprepare(udc->clk);
> > >   
> >  
> > Acked-by: Peter Chen <peter.chen@nxp.com>
> > 
> > Hi Greg, would you still accept the bug-fix for this release (v5.0)?
> > Or I send you later?

I can pick it up now, thanks.

greg k-h
