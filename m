Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1500788-1519995570-2-15181867656838369362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519995569; b=Y2QzUhTi8ngz9t7Qwc+O1AQMoueAV8TT/yLZ1wwWvd/8zjd
    BKEK/p5RVSuNSD5RZMtaSsKOjaPs3ha6lZ1U8/aB3yQ6B8ypPrA9fSxcszWrZw4v
    kUEYYtvyMYWBMZZgWa48r6mIbMphDl6bXBrp8G0rxWXI8TxFaC6fqcLMnexf1rvI
    2YFSifaBUTJs3kVZ16EoxxdSclgha9v8gU1O8zAFDg89WGysV83O79bo61g3MISA
    wS4TiIRGDkQNrrZpsn5gjkP98msWgGp2ZX9fravDgBKaLfqe1lnrMht0qf0S1qtG
    /sIDPxHU+eB79TXGQMtNEXZm2jypeauYFEM3BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519995569; bh=aZGlWXFsTYEg86eDKrsNcUeQWJ
    dPydDKbsYrqYWc3XM=; b=Zg+3PxjWnG6x7zIegdHFulaWPGKIxDN0sFGZbSoWnf
    SdT9+j887RGZVz+JVtPAUuO4xzg4n+cww46uMkWzy6ZoZ1033CIvddmaB/8D2DiE
    CQIeSYYLUO9H27Uk900RJpI1iU9q5/gywDTZNUNcybALo9uEyPepiRmKLOcEtzRA
    zlBmq5+ty5EJYIyxhLXUhV8Q9gpw4GzQVuFf2RCiFnWvnlDzh2s8kV0gIi+Rv0ov
    yDakbzLGqaO0Hc1L0eevJFbSRrBMiWOBxL81ou3Aeu+TGLn9eRR5tS08c2Bl5pjK
    Dv0o1YdQGIYmetixmDa4hHLgVDcCSL88ltcO/F48gCww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bg2LJY0P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bg2LJY0P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946536AbeCBM71 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 07:59:27 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48500 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423350AbeCBM70 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 07:59:26 -0500
Date: Fri, 2 Mar 2018 12:59:07 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302125907.GA9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302124647.sfhnto77wgdh5sv6@katana>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 01:46:47PM +0100, Wolfram Sang wrote:
> 
> So, maybe some words why I accepted this patch.
> 
> On Fri, Mar 02, 2018 at 11:19:31AM +0000, Russell King - ARM Linux wrote:
> > Note that there have been patches proposed to make platform_get_irq()
> > return an error rather than returning a value of zero, so changing
> > the driver in this way is not a good idea.
> 
> I'd much agree to such an approach, yet I didn't see it coming along so
> far for years(?) now.

It needs platform maintainers to be motivated to fix it, and one way to
provide that motivation is for subsystem maintainers to say no to patches
like this.  If patches like this get accepted, then the "problem" gets
solved, and there is very little motivation to fix the platform itself.

If you look back at the history of this, the times when platforms have
been fixed is when they have a problem exactly like this, and they're
told to fix their platforms IRQ numbering instead of the patch to "fix"
the driver being accepted.

Why fix the interrupt numbering if patches to "fix" drivers get
accepted?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
