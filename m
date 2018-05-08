Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2323227-1525761841-2-350038930176574745
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
    1525761840; b=gXRkwcaYltcsXyEHq5MBCOUsdOiZMvd6Trx7Ti+Et501LFFCNf
    P8KvtEwmLE2tzCzgau+kgAOUG31u9DmVs8FMDvdaImtwKyG8TLhV4t5vemP1BSv2
    t0YoC9Xsx4T+nJralBuNR4AWESlZ0UUkrt6t37ohAwCr+OQyRKLPais4HiJj/MCU
    NS+1NTNk8sOlMKeHstcv2CgU80apKVQvlpPyvPKVqGAcZt0G+e8MqsfpOyqkw2uV
    EwHPZzDt6SeYKSbgJMAj7JdBtYtiIrB9z7ZFrRVQ7OjGfCmRccgtndfcGV/pUkiu
    EhxXa8q8/8F86hZZ0uSmU70K+ejEKcAwRFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525761840; bh=8FOkIJg8c32
    katb2ViHqCBqkvp2GSGIftpLX5uW5vMM=; b=XF9c+2KpKYaSMLd+5ElmLRI2OTg
    i3pYxDmSXFU58SKKieMuxSfKLij4/g/dwRiQFGBB2UbBYPANz/hdkPgOrpm9M/Jd
    ZcGqtJG6sD4KdHkH7lUJ+BIirmxU/i+M5BcPbIVNr+HmCfxEBhotlb0sd0CGhbdw
    xeBFJPrnxBB8MzZjv/7BaswQcPYPQs0ta+YwlNh0+iTAIoHDl1W1fmtwG4fDTQ37
    76wNGI2hwALicHH51J6V2tHPyIA4arPThCUUdaPScGxfvWep67vuPsjAaVtSFydF
    uE2ibegoPaaQ8sCZ77aJT1EeUIbzRkOsAk6bjui6uUdV17WkgaAfdvpHOVw==
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
X-CM-Envelope: MS4wfBrsisrCF5mGl2KmdXoGv866+1UIsDgYIdei5GnS3R+vccUlnZZLxZFyGrJye9/XVpBZVT+hmvsEQ+cZQUNx05tferjitZPSU8ty7UQVw4CKJxhBSRxw
    2178MT5yUfGHlCpcieco3Jqre2XrCDNjmCwq1gYLCeE5/0h5uET61iGTS8NE7m7lpUQFxr7JH4Oo6ZBofmG1Hib8oO8er6R1Zof26Du5d5dGXG+jUlm+uXNe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8 a=gvl4HP8tAAAA:8 a=bGNZPXyTAAAA:8
    a=VwQbUJbxAAAA:8 a=aDAxIjL0SOsn_Po97NYA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=X7_D5SgixhGjaE2bLVSS:22 a=tRkgsvjveJ3YVe9fnr1q:22 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbeEHGn6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 02:43:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbeEHGn5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 02:43:57 -0400
Date: Tue, 8 May 2018 08:43:51 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Message-ID: <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
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

On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> This properly unmaps DMA SG on device shutdown.
> 
> Reported-by: Nandor Han <nandor.han@ge.com>
> Suggested-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/tty/serial/imx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 3ca767b1162a..6c53e74244ec 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
>  	u32 ucr1, ucr2;
>  
>  	if (sport->dma_is_enabled) {
> -		sport->dma_is_rxing = 0;
> -		sport->dma_is_txing = 0;
>  		dmaengine_terminate_sync(sport->dma_chan_tx);
> +		if (sport->dma_is_txing) {
> +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> +			sport->dma_is_txing = 0;
> +		}

did you find this because the kernel crashed or consumed more and more
memory, or is this "only" a finding of reading the source code? If the
former it would be great to point out in the commit log, if the latter,
I wonder if this is a real problem that warrants a stable backport.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
