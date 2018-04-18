Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-634944-1524063228-2-3159452280047864334
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
    1524063227; b=Lxw2ZntQkFe9g2pfKvTKG89fjJARoCyaSlfapBQ6jye9uO2to0
    r/N50DjGdmPl1t+oerOUBimYgvMuIGe2+rt364D06aAzEh3n6xgKVRzVkup6x1fl
    D8LOqVys0115SDlz0a0o9eFLjtzGzqIxvaSTn7ibdr/+sXM6NSTmFD/WmQdEAWv/
    hSNYrDPswBr1AjDQWDfI1eDDUq74/hcJSmmVTBRkbriMoBy6+aS2skqKwcyLzeLD
    jmMLdPWZK92vqqkQOFyiQ0GSBOxM4lgVMUaARaiHTm5Of0hb9wBjxjtx+5c2tlIk
    B23xN03l0V16dILKw1rX/01ZTuSknPtKFGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524063227; bh=Z7ACbN8r4eU
    e7tsHL1ZfQIO9LivDzIdWYy0Xzo2UjEs=; b=B0m5fzmXiFhp4IhRIF7ppaTcR8Q
    tDGY0385mkvgkXj0HBI8gXvhjvOS7fiOCqp+okTcLqp6cRMkx4cVK3YqbVabzDbY
    hdcxqUUqrM3H7RRJbjpuIQvL1LDx4B1VyUQ7ia1igpF/4QIBtTK5RbwH+aefUimV
    sToexNaghQrmIEVXWVJLZK/lbFtdS8lfkLC/I70+97ef5OOiXUf+aSBPwZv+DHq1
    NTJD73ZGIKAfeHEwbAIXuxtgrlZoB3ZoCVqFYyuvgTJgjiiCMWqtbHceFjkE774H
    ebii4RrHSWAslpvB74SXby5lvYYPEcWzxenXBA+OKc6jkARvH2uOT1Rse0Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfD8J7h4/BwQYSIe7TCrPoOJbxK2Nsrw/ej/Hxpw5Hiz2HFAjEOAcrQkJb5TMYpdPzTiHWYZFm8UQh5lNv1iRSQwNEWABCk4Nv09y4yjeWliJX6xAnXmk
    m5TGweCRWK41o2O1ZF1zG5X13LQfSurgRJvkFNVxhudo0ZOFXX21rUtM5bwLB0gNXqTa1ezzFecAc/Vno/ZAuDmfqZQao1csWwYDJqPhQLfaMzSU5Q0vQvp+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=a_IHXpSbrGB9PHkO7QYA:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDROxq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 10:53:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39231 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbeDROxp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Apr 2018 10:53:45 -0400
Date: Wed, 18 Apr 2018 16:53:41 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: imx: warn user when using unsupported
 configuration
Message-ID: <20180418145341.xwsah7spyfazcb63@pengutronix.de>
References: <20180418140638.19331-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418140638.19331-1-stefan@agner.ch>
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

On Wed, Apr 18, 2018 at 04:06:38PM +0200, Stefan Agner wrote:
> When using half-duplex mode (which disables receiver during txing)
> the RTS signal cannot be driven low during transmission. This seems
> to be a limitation of the i.MX UART IP: The RTS (CTS_B) signal is
> controlled by the receiver. When the receiver is disabled, the
> signal stays in UART logic idle state which is high...
> 
> If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
> transmission. Since this is the default state of the RTS (CTS_B)
> signal when the receiver is off, half-duplex mode in this
> configuration works fine.
> 
> However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
> cannot be generated when the receiver is turned off.
> 
> Print an error if the user selects this unsupported configuration
> (both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
> configure the closest working configuration (set the
> SER_RS485_RX_DURING_TX flag).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v1:
> - Consistently check for sport->have_rtscts && !(rs485conf->flags &
>   SER_RS485_RTS_ON_SEND)
> - Don't break printed message
> 
>  drivers/tty/serial/imx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 91f3a1a5cb7f..1c1080fc8084 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1833,6 +1833,11 @@ static int imx_uart_rs485_config(struct uart_port *port,
>  		rs485conf->flags &= ~SER_RS485_ENABLED;
>  
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
> +		/* Enable receiver if low-active RTS signal is requested */
> +		if (sport->have_rtscts &&
> +		    !(rs485conf->flags & SER_RS485_RTS_ON_SEND))
> +			rs485conf->flags |= SER_RS485_RX_DURING_TX;
> +

I wonder what should happen, if the device tree has both

	uart-has-rtscts;
	rts-gpios = <...>;

. I think the right thing would be to check for

	sport->have_rtscts && !sport->have_rtsgpio

.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
