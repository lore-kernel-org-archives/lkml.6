Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-206431-1525862590-2-15938616780822886568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525862589; b=i0Pvy/pcGJO09ZhkdB6B154LscUfgHp2JTBhJTuONP6v3UXzIt
    vnVFbgdgqG3dHHv4F6MO5jbw8LVNZ+AykZ5/AG+dQZoJXmIzmp7glDKIK+59X5FB
    VO6asGxv5faXnFaWpaj730vYMp4bym9RadGxlEJVnBY+ktSFrAay/iQmLG4oa4G+
    cipy8Fc7ixLr0rYQRkLp4Z6uu9LOxxNgFc8iXrWRqgxa/K5Kw+qR0YQu+nJ0+V0p
    36GiUnEMVKBzWuA73gslGD9o+0emSP9CpWHa9F2dH70rB9vPQ7vVbUuxQlUGsupY
    zRgAMcdviZXIJSRJ1k4UKodc60TbG8+3mk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525862589; bh=aSBo7SQYQTC
    RqGXbxg+0CLsZad+NrnP/TqxbXlkQONw=; b=gO1dusagavH1+GTdzMtKf0dAqsU
    BICVm0pXgQB48DIETn/7DFZWm0Ex0FEXmfJjASLhW2N+GM5iyv7su3FqdHYdycAx
    bk/g0C1TpV+iVaZF/YJWonXb1cynA96l6Rmq8bUSSAUmcuhyZ+gvPaArB9dy6jUs
    ZWiDWNtBH1557TChlyHl1QGy+SAHuVpC2Bl5OHrl5pNBcFnw+m0SaT14clifZGe2
    qyhimlw+FUShZh8gYBSDHtxJG1fE/+kga8bYjdKeQvtBqLJS+I++RiIlwENA0okw
    An/9LZ8r/9GU6uWoUCKa6jWYsd/waU3XpDcncGSMljwmQ5WYEwVBgw1UduA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNIn1CCzhmIGIJnj134oNvg0LSKiXxQw9ey9hyfb7gcRzgBKFfByCBReWsJpvumXEcKD/9uyJiiGkezRjDLqnnwseagMxpoSH7U5ba9Vq0BPgAsOC829
    nMUz9SJ6B7ZnLHUJKbWCRmsAzO8ckhI6c2uGPFpdr7DFfwXKIGMIyngbDAkXlXWGel3p4cylOtSZqmVcyiOLg/Jx0WjqOPR3nYam+SdBW+VsOxWh0t44muPK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8 a=gvl4HP8tAAAA:8 a=bGNZPXyTAAAA:8
    a=VwQbUJbxAAAA:8 a=d3kHLwdFJiuHtPLaSdUA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=X7_D5SgixhGjaE2bLVSS:22 a=tRkgsvjveJ3YVe9fnr1q:22 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934136AbeEIKnI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 06:43:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932570AbeEIKnI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 May 2018 06:43:08 -0400
Date: Wed, 9 May 2018 12:42:56 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Message-ID: <20180509104256.slkzauicnhsktqqf@pengutronix.de>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
 <20180508134047.zocurxwelw3a24ti@earth.universe>
 <20180508184612.iixr3psap4ik5fdr@pengutronix.de>
 <20180509102058.6mshag4y7aq4w2n2@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509102058.6mshag4y7aq4w2n2@earth.universe>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 12:20:58PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, May 08, 2018 at 08:46:12PM +0200, Uwe Kleine-König wrote:
> > On Tue, May 08, 2018 at 03:40:47PM +0200, Sebastian Reichel wrote:
> > > On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-König wrote:
> > > > On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > > > > This properly unmaps DMA SG on device shutdown.
> > > > > 
> > > > > Reported-by: Nandor Han <nandor.han@ge.com>
> > > > > Suggested-by: Nandor Han <nandor.han@ge.com>
> > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > > > ---
> > > > >  drivers/tty/serial/imx.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > > index 3ca767b1162a..6c53e74244ec 100644
> > > > > --- a/drivers/tty/serial/imx.c
> > > > > +++ b/drivers/tty/serial/imx.c
> > > > > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
> > > > >  	u32 ucr1, ucr2;
> > > > >  
> > > > >  	if (sport->dma_is_enabled) {
> > > > > -		sport->dma_is_rxing = 0;
> > > > > -		sport->dma_is_txing = 0;
> > > > >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > > > > +		if (sport->dma_is_txing) {
> > > > > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > > > > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > > > > +			sport->dma_is_txing = 0;
> > > > > +		}
> > > > 
> > > > did you find this because the kernel crashed or consumed more and more
> > > > memory, or is this "only" a finding of reading the source code? If the
> > > > former it would be great to point out in the commit log, if the latter,
> > > > I wonder if this is a real problem that warrants a stable backport.
> > > 
> > > A bit of both. One of Collabora's customers had a (scarce) kernel crash
> > > in imx-serial and modified multiple things in the driver. The crash is
> > > gone, but it's not clear which change fixed it. I could not
> > > reproduce the crash so far and I'm currently rebasing and splitting
> > > their changes into upstreamable portions with proper patch
> > > descriptions. From reading the source this looked like a real issue.
> > 
> > In which context (kernel version, operating mode (e.g. rs485)) did these
> > happen? What does "crash" mean? The kernel did just hang or produced an
> > oops? If the latter, can you show it/them?
> 
> I pasted the oops, that triggered writing the patches (Linux 4.8, no
> rs485, 4MHz baudrate). I think, that the actual issue has already been
> fixed upstream between 4.13 and current master.
> 
> -- Sebastian
> 
> ...
> [  302.516696] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0938000

This is usually a missing clk. Alternatively RX is disabled and the
RXDATA register is read. Scrolling through

	git log v4.13..linus/master -- drivers/tty/serial/imx.c

I didn't find a candidate for fixing that.

> [  302.524394] pgd = 80004000
> [  302.527111] [f0938000] *pgd=de81a811, *pte=53fc0653, *ppte=53fc0453
> [  302.533451] Internal error: : 1008 [#1] SMP ARM
> [  302.537994] Modules linked in: smsc95xx usbnet atmel_mxt_ts
> [  302.543651] CPU: 0 PID: 357 Comm: _ACFRead Not tainted 4.8.0 #1
> [  302.549578] Hardware name: Freescale i.MX53 (Device Tree Support)
> [  302.555679] task: edbf1f00 task.stack: ed5ce000
> [  302.560228] PC is at imx_rxint+0x5c/0x228
> [  302.564261] LR is at lock_acquired+0x494/0x57c

If you still have this kernel, disabling imx_rxint would be helpful.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
