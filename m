Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3270031-1525805204-3-3442890698369704659
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
    1525805204; b=h2OCchsu0h8deVC1GxI4UsYwgRL6fAVLH0OTLwC1RvgRqdJTXY
    W3q8uiSFi5f4Na2Ppe4gC/CYeHlgSR2+z2PcOWJ0UzG7eT/MrjLC76IQj/Gv9mBA
    IOM167lJFCjx6wEmk0sh4L9CRiyRo72/hhhK/cXXVrqTeAeuKKCqgycysZcd9lt1
    G4gyMcILwbAoj8e2+AzoSDgxTU5QfCgBv7Cv9WBfIeulDsFlnQQiYqobWGjoESZs
    FML6nV5EaMp/PEoiUGwBAambOWVQ7SiQvvZ8LNWb227DRWuO5ezEc3c8aSjAiTqY
    K0CfcwaZX08+y/U9XOV2EM98noAI/gWX773A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525805204; bh=wzQabb1mDc5
    V/tJlieatFn+GV/uxO1bjwbZYVek1ShA=; b=IlP0HbLP3e7Mz0iaMwyb/p05K51
    i61GEJ10X6D73zfqZXPZ9eF1IDubTBT2rGw3RMUFu0zlvCFi8wMinP8lv8OXQ9o6
    eDvQnZw4TjfPtL44nJAkLbsVqCoM72pjmrfji+bqUoJPoPQ+Fr0w5mGi4VAHgV9G
    jerN8fVHaRuU3kWkw9AiTml5U00P15wqjuPe1OPLB0vIH31MT1zxUAT6FlDaJjou
    ce9tSngevZdt1fBPlpHsa4WDp8iigvJSeVV+hFb+9kO4ioaBfE0KsGIcz1K2U2Wr
    2LvrQE+WvceUwo2eeLUZxKhAbDH72+gM6QNn3BuCgtzwth/nEIAWCT0GN5Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfC8IhnDq0wf4XXZYzzje2up/EZGNBWNRM+NlOUET9+mWQS7StBoXKhOHSc+uLOnUUQrLH8WqvLLS9o2Es54DRa3jzUDM3eD31UIWklYssk2V5Qjp8Mgq
    UXPXJxo7egA3NFvHR+o23U1/qh9bzjZ93IqI0ivHwpDwghKVulpMGNTnitrriMUo9pdAAdmRpxR4rwEpIG6Nzlmk+y/O7zDL5HCX4v3yohaeryz+v/ewzLtG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8 a=gvl4HP8tAAAA:8 a=bGNZPXyTAAAA:8
    a=VwQbUJbxAAAA:8 a=i9A59sLhxdq5BJXLAmsA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=X7_D5SgixhGjaE2bLVSS:22 a=tRkgsvjveJ3YVe9fnr1q:22 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755048AbeEHSql (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 14:46:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48991 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeEHSql (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 14:46:41 -0400
Date: Tue, 8 May 2018 20:46:12 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Message-ID: <20180508184612.iixr3psap4ik5fdr@pengutronix.de>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
 <20180508134047.zocurxwelw3a24ti@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508134047.zocurxwelw3a24ti@earth.universe>
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

Hello Sebastian,

On Tue, May 08, 2018 at 03:40:47PM +0200, Sebastian Reichel wrote:
> On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-König wrote:
> > On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > > This properly unmaps DMA SG on device shutdown.
> > > 
> > > Reported-by: Nandor Han <nandor.han@ge.com>
> > > Suggested-by: Nandor Han <nandor.han@ge.com>
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > ---
> > >  drivers/tty/serial/imx.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 3ca767b1162a..6c53e74244ec 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
> > >  	u32 ucr1, ucr2;
> > >  
> > >  	if (sport->dma_is_enabled) {
> > > -		sport->dma_is_rxing = 0;
> > > -		sport->dma_is_txing = 0;
> > >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > > +		if (sport->dma_is_txing) {
> > > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > > +			sport->dma_is_txing = 0;
> > > +		}
> > 
> > did you find this because the kernel crashed or consumed more and more
> > memory, or is this "only" a finding of reading the source code? If the
> > former it would be great to point out in the commit log, if the latter,
> > I wonder if this is a real problem that warrants a stable backport.
> 
> A bit of both. One of Collabora's customers had a (scarce) kernel crash
> in imx-serial and modified multiple things in the driver. The crash is
> gone, but it's not clear which change fixed it. I could not
> reproduce the crash so far and I'm currently rebasing and splitting
> their changes into upstreamable portions with proper patch
> descriptions. From reading the source this looked like a real issue.

In which context (kernel version, operating mode (e.g. rs485)) did these
happen? What does "crash" mean? The kernel did just hang or produced an
oops? If the latter, can you show it/them?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
