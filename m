Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-791438-1524204807-2-7353496739128022076
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
    1524204807; b=JudJvyOLHnpTEMIepO7XeYim5mEJC2xt0y/vwV3CyMHuTm5bGv
    1kx6S+r04Em9P/r27QhEUpzMMgGD6OGebBSXzvKEDB5nQlVwtqhxf7hiNmV/MRlV
    P/RDf0q/M4CR7yosjv7o5+AAlenjpMtZPD/Bb5T/wXbukVhsDtgkcF1ToW38T4ry
    IMqe7dH1ipdJiqSfics0v/FbODcWKgsM5YuARCTczARPIsACp0FfQMVuaW3y13zM
    3lVGnPuUl0aTNrj5ucVB/9b5djrbqWBS+8bG5qzSrRdGS9dTy0HIsHitNqLCHoIj
    B7K1VBCuNUtVvwFnUh93PGaP5XwMhlIhbV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524204807; bh=3XHBb4j+Bru
    aMPACyuTOM3lal9hV1SjbmaLlavXMSbY=; b=IiI9tn89E6djnW19gcKccbPbtdm
    KuCClgpW8lhAsQFfGNo/3M/sa93UdIM+fryAaa+W4bbaPJHgE9ZlmszZNvOlmtFF
    FOsr9IOkhEB5my2fR2sA6Z2Lo4ShWqD/rEGNd481mxu69m6Q50Vb0U8m94+bE9Fd
    my2b6fvgV9aik9Tn72g/C8ujel32i5B1qUIl86NPkoXMxmNklVt3HScvoGDGioxH
    FV4gE2zoWloDxbTo8yLKT3vS9EwumEFY0WuZ9WsLsFlDi5hzBuYwJAVb2nGNKR44
    ylTvgA7uVQbs52dibEtTh6oldZYBXOBia3tCAj1g+dBSTtMJj1U6/B1RCEw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOgEEh0GdwryQ/M4L6xaWFsXotgaf8S1EM/MEEeMjNFcpYrDDuL8IaOSN5fk2RPkQ6Nz4p4GZEDzbOVY21xQjFdJksYJnKgBr0j1sZlBdCXODg/HHw2A
    ZhjCALVcjz/5k9dfaQi9svqOehgekGajGQG/Ic3XMkrjI+RoYLfjEqiqMXvKEYAmsE18oC0xWVds/eA2MMHp0q+ZuCybvSg0rYlrI+OMKSJvbs5OWOz+GsOy
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=O7zmUmNSAAAA:8 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8
    a=afs0Po9CjthsB_dnCTkA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=IJxu9zi5bFdC9NS7oKyv:22 a=yL4RfsBhuEsimFDS2qtJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDTGN0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 02:13:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34885 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeDTGNZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Apr 2018 02:13:25 -0400
Date: Fri, 20 Apr 2018 08:13:16 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Message-ID: <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
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

Hello Chris,

On Fri, Apr 20, 2018 at 09:07:59AM +0800, Chris Ruehl wrote:
> Fix a problem introduced with
> commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
> result in non dte-mode imx-uart fail receive data.
> By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 91f3a1a..3d09933 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
>  
>  		ucr3 = imx_uart_readl(sport, UCR3);
>  
> -		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
> +		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
>  
>  		if (sport->dte_mode)
>  			/* disable broken interrupts */

Doesn't 6df765dca378bddf994cfd2044acafa501bd800f fix this for you?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
