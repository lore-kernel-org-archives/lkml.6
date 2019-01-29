Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E63CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF8A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548768692;
	bh=LLV5wYRcAUcDpnnD39+DhRqdG+csyN+W36Dga7ygcI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Klhq2kpnN1oZuTrnRJz+IZt50TbRBi+kxLXiqZ3KcvPLnHFxppK+V9xAalztrgSyx
	 XEvD64KNHnKVLJ5ancp4YKR7jnI+tHXZ5u4tPSaRQjgB58YjHm2YT+Ie+83aXr8zu3
	 zBlkACE5HJTjbuvoCkuy6+oH60lM0eyryXS9AxJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfA2Nba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbfA2Nba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:31:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B58221473;
        Tue, 29 Jan 2019 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548768689;
        bh=LLV5wYRcAUcDpnnD39+DhRqdG+csyN+W36Dga7ygcI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vTBdkLOZG3h6aMWbhkwxqb0O0NQgVfLjbVwpm6mK5LFOdfCcn2D4nLzMN1Nxzu4x7
         yG6KfEpp41qg6qgLf/+6j6BecelvLTfQwCoL+f1P5XFjHsYILQhtBFfvJ1kvzdDq73
         ss3nR3HOEPDQzDkFhY6wg1vWq87jtwrloR1dY1dw=
Date:   Tue, 29 Jan 2019 14:31:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 08/44] mmc: Kconfig: Enable
 CONFIG_MMC_SDHCI_IO_ACCESSORS
Message-ID: <20190129133127.GA26351@kroah.com>
References: <20190129113139.826927690@linuxfoundation.org>
 <20190129113140.773786691@linuxfoundation.org>
 <e8e8160a-0139-40c8-7283-81f1d274c8d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e8160a-0139-40c8-7283-81f1d274c8d2@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:54:24PM +0200, Georgi Djakov wrote:
> On 1/29/19 13:36, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
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
> > @@ -399,6 +399,7 @@ config MMC_SDHCI_MSM
> >  	tristate "Qualcomm SDHCI Controller Support"
> >  	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
> >  	depends on MMC_SDHCI_PLTFM
> > +	select MMC_SDHCI_IO_ACCESSORS
> >  	help
> >  	  This selects the Secure Digital Host Controller Interface (SDHCI)
> >  	  support present in Qualcomm SOCs. The controller supports
> 
> 
> This patch is not needed in 4.9-stable, but only in 4.14-stable (where
> it is queued already). Please drop it from 4.9.

Now dropped, thanks for letting me know.

greg k-h
