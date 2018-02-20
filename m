Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549902-1519122726-2-17570273505026640188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519122725; b=PjebdmlHg9gFgQgUmPK/9CCwXCW1QBtEKcLotgKjTMg0dgu
    6jjFIgmetNILJlP4ZsiOiZphpfbc3hG+uBSdt4WmKuApXwl7TM5yNGC41anw0V63
    QrR1iwPaNBEHM0N+4oAzRttHnKEhjklULwCoLnZQdDjjgqiuJO+bB8tOfKQIxfk3
    pm1tT2bIsELdy/YQURtRQ/e+JbTWAtMIoUkNXUi3vntg6k93do/2lSrmCJoBNeIm
    1su3XtRORX7uAAeFYNfWefpkSZ7qempe3GxkGJpFfH4umHdhDwBerOC9so3dbKKb
    WnNsBdKMcHNvClqT7B1taSKDqUG/AMH15loITjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519122725; bh=B25VQLa
    5lE99TZFxUgp9x1Ya52y3ChHKtl97wE8dzaI=; b=Zk8quUXE+Hb0nwXsR+PEerB
    46a1FTcsZghgpBd041LBCWhyb32mTl+OGWWFZnFrzT3CwDiAfIThTsKUv95pGahz
    YrXswCLStOY9U72Ely7wluVdjJkC83RsrPKBd/uKiBa2rqB9i2MZquIOglcyd74P
    Lp9PxnMb0VEwE+whAFQchSRh6xJGWw4SUzlKy9RgqvXhk3TrvojqP9qT6efGZ/zT
    Kg1rzRNKLuBJUAclbGNQKdJcJmSQ2GPmwaBli4osOmRiTEMxtkh4r6U3GFy4eEi2
    3JaCDBhry7/le4Dtlw6b4vBV8o/ESnPmhXjwYTuSBVmr/Ed6Wu9oesV+NPNCZKQ=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBTKcE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:32:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35531 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeBTKcD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:32:03 -0500
Date: Tue, 20 Feb 2018 11:31:34 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <baohua@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] serial: imx: Fix out-of-bounds access through DT
 alias
Message-ID: <20180220103134.xfh2zl2vgonb2ywb@pengutronix.de>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
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

Hello Geert,

On Tue, Feb 20, 2018 at 10:40:18AM +0100, Geert Uytterhoeven wrote:
> The imx_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
> 
> Fix this by adding a range check.
> 
> Fixes: 9206ab8a0350c3da ("serial: imx: Fix out-of-bounds access through DT alias")

huh, this patch fixes itself?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1d7ca382bc12b238..e89e90ad87d8245c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2041,6 +2041,11 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		serial_imx_probe_pdata(sport, pdev);
>  	else if (ret < 0)
>  		return ret;

I'd prefer an empty line here.

> +	if (sport->port.line >= UART_NR) {

I would have used:

	if (sport->port.line >= ARRAY_SIZE(imx_ports))

which IMHO is better understandable
> +		dev_err(&pdev->dev, "serial%d out of range\n",
> +			sport->port.line);

Note that the same overflow can happen when a device is probed using
platform data (and your commit fixes that, too). Maybe worth to point
out in the commit log?

Other than that: Good catch, thanks for your patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
