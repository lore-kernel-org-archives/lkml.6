Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E80C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CE920868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547565202;
	bh=Kn8ZXTa5Nz7EX2NWpPLtlirqIVUmk5Nw2RgTFr9vVwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=if2UaY+xPg/9ZHAN6e7EVhep9UKkBZXVCAUi36/cXDlhA8vqilxUJ63pJhi6IIL8l
	 txAYhrCD4NYTKB2k4FBza9hYeO0rYppkmCzADrIjG9AyQbsihBh3TaN5oopwENTlP5
	 GGaR2sp2k/3X0x7Kad8dvgoIMmtUqhMG6pLcRCbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfAOPNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbfAOPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:13:20 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F058D204FD;
        Tue, 15 Jan 2019 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547565199;
        bh=Kn8ZXTa5Nz7EX2NWpPLtlirqIVUmk5Nw2RgTFr9vVwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jH1vqpnHRg+Cou1aDdC9bjQmWBVe5Hjtfd+7n1rwUQ3ATT6gw+TqONesIaqMomDMU
         7wEiqx+cFbaHYZC1JMMjUTQ4ObAi9fPeCqiwfxLDKsn89yVuFsjggEbyzdGg1K7sQN
         mHfl4K+rhi2g+r2B3nw7Lv32OOFrfA0Tq6ji15Cw=
Date:   Tue, 15 Jan 2019 23:12:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Message-ID: <20190115151250.GC13895@dragon>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
 <20190114005600.GN11426@dragon>
 <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
 <20190116001043.69529b90@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116001043.69529b90@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:10:43AM +1100, Stephen Rothwell wrote:
> Hi Leonard,
> 
> On Tue, 15 Jan 2019 12:30:23 +0000 Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >
> > On 1/14/19 2:56 AM, Shawn Guo wrote:
> > > On Fri, Jan 11, 2019 at 05:57:30AM +0000, Anson Huang wrote:  
> > > > This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> > > > states supported as below:
> > > > 
> > > > 1. WFI, just ARM wfi;
> > > > 2. WAIT mode, mapped to SoC's partial stop mode #3;
> > > > 3. STOP mode, mapped to SoC's partial stop mode #1.
> > > > 
> > > > In WAIT mode, system clock and bus clock will be enabled;
> > > > In STOP mode, system clock and bus clock will be disabled.
> > > > 
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>  
> > > 
> > > Applied, thanks.
> > >   
> > 
> > Hello,
> > 
> > I'm not sure if anyone else already noticed but it seems the
> > arch/arm/mach-imx/cpuidle-imx7ulp.c file was dropped?
> > 
> > It's not in your tree:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/soc&id=cf2d2d392906f5603cf0d0f3630f6386babf7e4b
> > 
> > This causes build failures in next-20190115 with imx_v6_v7_defconfig.
> 
> That file does not exist in Linus' tree either.  And there are no
> commits in linux-next that add it.

Sorry.  That's my fault.  The patch doesn't apply to my tree and I had
to use 'patch' command.  However, I forgot to add this new
cpuidle-imx7ulp.c file.

Just fixed it.

Shawn
