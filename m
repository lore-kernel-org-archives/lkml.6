Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBAC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057D32070D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549961828;
	bh=KCVmAMozwQnM9ScCawLXvQO7W8hd17A+tbqyJagS8r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O0afEI1N0hkc/u+9AR5eMdnLsza6JtXVa8jYljaABb0O1uLvdVv0wVefpTQmkM8Rg
	 rhTbih/JtMor+2te7jKZ7S50dP2TnkfcXgbaLKAoa/WGEqjP0dpc0AryeDCRAtS6Dz
	 ubJg6aix3tQXAg7Fj2I76kd8K9gOAkYYD5eHudPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfBLI5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfBLI5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:57:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82AD2080A;
        Tue, 12 Feb 2019 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549961824;
        bh=KCVmAMozwQnM9ScCawLXvQO7W8hd17A+tbqyJagS8r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0mv0JSFZFIiSpOg6Ypi3L7I14flhqMZ/hi8OqzACnOHbrYiV994+XWKxfS5QIZmZ
         oIQ0iHya8Jzum6DCR96/V1lXUmiOjR4KNL+VNOb+yW4pTZSPfEORybJVpsRIb48GWl
         7JOdlEv8yflcvw0HtWrGVmwoCy2cnAuxuJGB2im8=
Date:   Tue, 12 Feb 2019 09:57:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 034/137] ARM: mmp/mmp2: dt: enable the clock
Message-ID: <20190212085701.GC31657@kroah.com>
References: <20190211141811.964925535@linuxfoundation.org>
 <20190211141815.120436242@linuxfoundation.org>
 <20190211205125.GB22473@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211205125.GB22473@amd>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:51:25PM +0100, Pavel Machek wrote:
> Hi!
> 
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit f36797ee43802b367e59f0f9a9805304a4ff0c98 ]
> > 
> > The device-tree booted MMP2 needs to enable the timer clock, otherwise
> > it would stop ticking when the boot finishes.
> > 
> > It can also use the clock rate from the clk, the non-DT boards need to
> > keep using the hardcoded rates.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> While I agree this is good idea for mainline (thus my ack), I don't
> think it is suitable for stable, as older kernels will not run on OLPC
> in useful way, anyway.
> 
> Not-acked-for-stable-by: Pavel Machek <pavel@ucw.cz>
> 
> So I don't think this and ARM: dts: mmp2: fix TWSI2 is good idea for
> stable kernels.

Ok, I'll drop this, and the follow-on patch that fixed this one up, from
all queues.

thanks,

greg k-h
