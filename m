Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607228-1519929776-2-1660357887473667309
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519929776; b=nTl0Qk/WY2BAgi8w2fLgQicGPSj07oCflVY8/tt1RUwEMZe
    ZpZxLehJa9zh0xlCa0SonCcka8ckhAmInPbfJfr3IVJ4cvEuwsIl8wsUL3HlR5so
    LNO1tM0wGI6y7EKH7m28JW7izDz4X6bSJyRd8aa9nhwW/08k6pdFwkfRxej8TMyq
    W8Lm0SENzxtiwcdYZgQ1pbIsQXbpZzKVgXUW9RVSXj/fg2QQHX0ti9QOyRS9p3yz
    EPQdvqsdQFhGySNtLVTxEXemd677TYBQmNh4oVgpcabzq4XkIZ11LfBavNq1Er6k
    jUIYZUcDRga+JwmZHSugzrflkDjOriDizJ8B+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519929776; bh=A7/iB/FiCZv1Gk6zS3OljudbPV
    IzRlkYcYwyjcH7VDM=; b=XuuUn1oBgxWizpnz5+a14CIh1IZyLks0zU1mwdl3Et
    oqO9Ay0HcUhI0fwr/frZcYvN/r1h1hL/g2GWifakIhCRh7r2jEamsv9RUKaMl2qJ
    ocSozWxRehHkQ2DY0SPpzCbNcJbwel8roQxoTS1aTLiLc+nNDykfXL06RM1+2Llk
    p06hLU+CynPFQ/1umoFC2GuPBIXavDcyHMKSs22wi77xirIgBRVum1Ss9J1Arxdb
    g6nRS1aUhuCnesYQfUC7Lz7H/cExrwbzSnbcnmh/vtYRRLg5Vx0R4SoAjsFxEF/A
    hEXUpNQD0MyiMkbkfhwrmO8lvoVsQEStGZqcattBAP+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034010AbeCASmy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 13:42:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033831AbeCASmy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Mar 2018 13:42:54 -0500
Date: Thu, 1 Mar 2018 19:42:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>, adurbin@chromium.org,
        briannorris@chromium.org, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] earlycon: Allow specifying a uartclk in options
Message-ID: <20180301184252.GA29304@kroah.com>
References: <20180301182028.237856-1-djkurtz@chromium.org>
 <57fb4f35-fd75-b2cc-75f7-8157ab1081d5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fb4f35-fd75-b2cc-75f7-8157ab1081d5@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 10:30:45AM -0800, Randy Dunlap wrote:
> On 03/01/2018 10:20 AM, Daniel Kurtz wrote:
> > Currently when an earlycon is registered, the uartclk is assumed to be
> > BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
> > options, then 8250_early's init_port will program the UART clock divider
> > registers based on this assumed uartclk.
> > 
> > However, not all uarts have a UART clock of 1843200.  For example, the
> > 8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
> > cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
> > on such a device will result in incorrect divider values and a wrong UART
> > clock.
> > 
> > Fix this by extending the earlycon options parameter to allow specification
> > of a uartclk, like so:
> > 
> >  earlycon=uart,mmio32,0xfedc6000,115200,48000000
> > 
> > If none is specified, fall-back to prior behavior - 1843200.
> > 
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> Hi,
> 
> Hopefully there will also be an update to one of
> Documentation/admin-guide/kernel-parameters.txt or
> Documentation/admin-guide/serial-console.rst.

Well, considering I'm not taking this patch unless it comes with such an
update, I'm hoping as well :)

greg k-h
