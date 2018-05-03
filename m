Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039369-1525378423-2-13546135462891036573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525378423; b=ZX6Td1vVplcZOOgAh0KStCsdoQ2tFU129RRo8q3QFHIxc7YXGG
    1V8eEJkrxcIO1mdiN5IF6Xrx+UmAD8C1XXnnWZHl1o40d6xeyIvJ9gbLGeC4qP41
    3nJoks7OLjmYIA/Q0qQMnJyYOWnQaP4NhVpMH8LguykY/lIool+oefHJRIr/Xbqk
    BQ6t/nB8of9zsEyIpt0CXY7W1arYoqWnchiaVWQLiTZJSwmuyPCg05hl+PMBa5iu
    I4WWoIQ7KH/vuUECtBGSPendMwETMVdLFJg14mD4wOQgUvI/32fFDlrfm4eP+JhX
    LiNCbqE29MuDbwYu4FOAdjFoWn3YlwD8vIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525378423; bh=m3YduLnPCgn
    EAo4Fyg4xbfCCwU3WwjZlY8HGu1/fEAA=; b=AcRfXeVcWGd55Lr4XEWOOy7SjzO
    S/3XP0C4OgYnXLtUh4g7wGNQGpe8qSSWiRvOkiYr2LacTdaMTkzwClDYSqRWQ+PI
    5SxzCY/U8D3e1MlHXjngjCGviZrLu2vLw+PqQV9GiYxvBwRnSR5ymzsNSJVj3air
    7NpS9b/ir9TdQSKLZcXoiSqA1s4FBpf6zQTJryJgVVuFGzXJLca8c74OU5rMk7Fo
    M31Jzi1/d7zUYHLxQ977QEeR+ZXapY5qfTYppkE/guKdF/r+nLp+MZdYOh+bkX9b
    ZunLzmtJ6BR8Kbf3CUOQREhwz4ZLhkepx4WXQ4Yc/vMRfQNBB/Yct7IPrWA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=nW5elRQW x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=nW5elRQW x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK6DZ/j8UKoLK4ce8qn8WsM9YzjGtE5P1rneiml7j2stAsd7IozvXcaLmL4Xjp9MvIqVQVUzwORSsFoyv4t5brijVN7E+n8Z7VgtjAYxN53jf6spVwvF
    atqiDU6MOk5TcyoEx56BjaYqolE9od58DxXmsqFMWyzXmtG+7OXhikZpofD24BIfU1OgddJumvDQC9Dc0r74RZYcghhL2/k9h1qLiENso70v4b9GDgxCBO3j
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=O7zmUmNSAAAA:8 a=VwQbUJbxAAAA:8 a=hAeWe7OAgna5fDyplI8A:9 a=wPNLvfGTeEIA:10
    a=HUqATDVKn4QA:10 a=x8gzFH9gYPwA:10 a=IJxu9zi5bFdC9NS7oKyv:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeECUNa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 16:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbeECUN3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 16:13:29 -0400
Date: Thu, 3 May 2018 13:13:17 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Message-ID: <20180503201317.GA19401@kroah.com>
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
 <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:13:53PM +0800, Chris Ruehl wrote:
> Hi Greg,
> 
> On Friday, April 20, 2018 02:13 PM, Uwe Kleine-König wrote:
> > Hello Chris,
> > 
> > On Fri, Apr 20, 2018 at 09:07:59AM +0800, Chris Ruehl wrote:
> > > Fix a problem introduced with
> > > commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
> > > result in non dte-mode imx-uart fail receive data.
> > > By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.
> > > 
> > > Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > > ---
> > >   drivers/tty/serial/imx.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 91f3a1a..3d09933 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
> > >   		ucr3 = imx_uart_readl(sport, UCR3);
> > > -		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
> > > +		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
> > >   		if (sport->dte_mode)
> > >   			/* disable broken interrupts */
> > 
> > Doesn't 6df765dca378bddf994cfd2044acafa501bd800f fix this for you?
> > 
> > Best regards
> > Uwe
> > 
> 
> The IMX serial driver is broken in the 4.9.x tree since 4.9.89.
> Uwe's patch
> 
> 6df765dca378bddf994cfd2044acafa501bd800f
> 
> please apply to clear the situation.
> 
> I know you very busy! -

It's best to email stable@vger.kernel.org for stuff like this, as I
almost missed it...

Now queued up.

greg k-h
