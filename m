Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2323227-1525761661-2-13773032470394114472
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
    1525761660; b=PYzUyjjj56feDS4XN9LjHCXUNcPKwLloxagNm5Zm5qxlednbm8
    UcICP3rtbIYTTloZM9pgt3Xnde9y40AQZHe5A41juhiq4k0C/YbxS/UEPpi5F03a
    qBs/IAWjfTlbkjWSLtyYTi4VQRHyNQn7QjR3fq0CUl8E4TxS05Y/fFw27aHm0Jpv
    IDBD0i06hhSvXDpN7kfyAQMLRqzmRB0LlZSryxMhEoeaabFKnD5aF+sGDf4O3inN
    0uKbGhNq+sMCPEezhbaFVH2B26ZirqCrpiaZ6kMjyeVkJ/iNNC6aDDiBSlRo1tBo
    g/shEmjBgwEqIjQM3An0dxvqKMps7ONnL/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525761660; bh=2ccjgQa+jq8
    +wQY+ZuXT8rbPvwqzbGxN2zO+rPvks0M=; b=UjsCIYOTEBnALvh00yOcKnuFEak
    X39JK2vH5R82pzDKSxZh67USmOiY3GL2tbnaXm8sQumU03Bj3DbyctevQJJIY5CL
    oPt4+V40oaxucnNYgEQadn4bZO91pd02xpeH496Stgs7WQ7pwyPkfpC5O0LCkfpO
    7L3JpJI+phy+M3zMM26wagqckNjy7+brnKEUStHcxhmKScL7pNE11+shoXYVQpLb
    NbqDLFM/EX30x/A3S5ePRPTuVA5ASNC/zOR2KtJPXMJOxGVWYzX2d5X7Bgj8Wrgm
    1oZoYLLZ+G72bTsrO5bbSAK//vT6No4h8aEuCQOM05OZRoupc8n/w15NDeQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfAWKinxgqi19ArgQs/9rRfVaKC9AgeYKn0myEiEUh5BSM6IhETQZG1uM0vbft2NyM91c/AKuYhHlSa50ZChKcYUTwYJRn3CCJMH/E+/q72B8HPEHZROv
    W82ydcihkiaGqy9LUwcMzoGFuE04gWhVKpnX9m5E1V9uErRwgD8VwY7QX0kZ2ZRHAkuVkm4V2ieioFOt7GPPU8kWeUA/f7a7lCHE9q/wieTGp83IS8qJ89S+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8 a=gvl4HP8tAAAA:8 a=bGNZPXyTAAAA:8
    a=VwQbUJbxAAAA:8 a=Bi1aKEMEiLQKamHNrGgA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=X7_D5SgixhGjaE2bLVSS:22 a=tRkgsvjveJ3YVe9fnr1q:22 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeEHGk6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 02:40:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35915 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbeEHGk5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 02:40:57 -0400
Date: Tue, 8 May 2018 08:40:47 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: imx: cleanup imx_uart_disable_dma()
Message-ID: <20180508064047.v7wz7b4t5ta55hv7@pengutronix.de>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180507213610.17330-2-sebastian.reichel@collabora.co.uk>
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

Hello,

On Mon, May 07, 2018 at 11:36:09PM +0200, Sebastian Reichel wrote:
> Remove unrelated CTSC/CTS disabling from imx_uart_disable_dma() and
> move it to imx_uart_shutdown(), which is the only user of the DMA
> disabling function. This should not change the driver's behaviour,
> but improves readability. After this change imx_uart_disable_dma()
> does the reverse thing of imx_uart_enable_dma().
> 
> Suggested-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/tty/serial/imx.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index c2fc6bef7a6f..3ca767b1162a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1291,18 +1291,13 @@ static void imx_uart_enable_dma(struct imx_port *sport)
>  
>  static void imx_uart_disable_dma(struct imx_port *sport)
>  {
> -	u32 ucr1, ucr2;
> +	u32 ucr1;
>  
>  	/* clear UCR1 */
>  	ucr1 = imx_uart_readl(sport, UCR1);
>  	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
>  	imx_uart_writel(sport, ucr1, UCR1);
>  
> -	/* clear UCR2 */
> -	ucr2 = imx_uart_readl(sport, UCR2);
> -	ucr2 &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> -	imx_uart_writel(sport, ucr2, UCR2);
> -
>  	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
>  
>  	sport->dma_is_enabled = 0;
> @@ -1447,7 +1442,7 @@ static void imx_uart_shutdown(struct uart_port *port)
>  
>  	spin_lock_irqsave(&sport->port.lock, flags);
>  	ucr2 = imx_uart_readl(sport, UCR2);
> -	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
> +	ucr2 &= ~(UCR2_TXEN | UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
>  	imx_uart_writel(sport, ucr2, UCR2);
>  	spin_unlock_irqrestore(&sport->port.lock, flags);

While this doesn't change behaviour (which is of course good and
intended here) I wonder if changing RTS is right here.

According to Documentation/serial/driver it is not.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
