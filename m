Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1873148-1520004769-2-15997806345554777954
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
    t=1520004768; b=jNzndXlydugWFWqvqUFd4cZwhy9cjN5M/sAjZi6MBI8tDlr
    rMn3ifKW/4DuKAdUsuDhh8z+fdbOtIHLv1TqzobF09vnjV2Qye/557kU4doA9F90
    oSXWkpwTKEIyprTdtRQ5nrbloKgzPf0Dusm+HSP4OP48rUxdJGBXshg+kfI5+PJA
    3/zkFcC5kISERysGrrtskGGbkEcBSSptAYdxm5drXLok2iyRLasNw/HESDSIrDu9
    51ndkjWcGx+22guI82pU/98ZOf1dlkZg3603N7T9YjypdXP9qw7tZtEcYz7gB/0p
    pIYgPEgTT+Mzon7sybDOWju0sa8Tw43rEPyrfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520004768; bh=8OnUjwZnktJbCxDBCj8oO01yHD
    w4A0dI7BTvCQcNSIw=; b=cU4zkxSx6YT7uYF9DTsj5Nk5A02+VxSB3VlbxPTXbe
    pHPepVUOjBwC3xkb0XQa2cvNHAmnWgBhszhJMt2euTpfhBbzosqWuDJr1hXWWuow
    XNhydD3ZiePtcf0TfjxRDiYJF7QuICm7swJoRs64/5OI8+xgtiEAEBpNavAI2VpS
    4J8K1vm3HbHvRYn5PCZ+GlYcfYeai0WNveRIHmE872AVhAlGUh2i1X1+iKKvwHgd
    HITCOWI8ILCJ9a7Dz//AYIBol/O0TlomWwr7WbQei1+bRzysyv7MXcLLSRM4mEbL
    k/QQDAxazSSDx58BbV6AcgDcVyNBun7lEtQc68wTEi1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EYP81CPa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EYP81CPa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423112AbeCBPcp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 10:32:45 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50350 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422707AbeCBPck (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 10:32:40 -0500
Date: Fri, 2 Mar 2018 15:32:22 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302153221.GB9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
 <20180302135854.76ue5jzsg7lvxjxw@katana>
 <20180302140901.lrjqiaa2k4nxkqco@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302140901.lrjqiaa2k4nxkqco@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 05:09:01PM +0300, Dan Carpenter wrote:
> On Fri, Mar 02, 2018 at 02:58:54PM +0100, Wolfram Sang wrote:
> > 
> > > It needs platform maintainers to be motivated to fix it, and one way to
> > > provide that motivation is for subsystem maintainers to say no to patches
> > > like this.  If patches like this get accepted, then the "problem" gets
> > > solved, and there is very little motivation to fix the platform itself.
> > 
> > Yes, I can see this. I will drop / revert the patch.
> > 
> 
> TBH, I can't find the threads from November so I feel a bit lost and
> there is no documentation for platform_get_irq().

Start from here:

http://archive.armlinux.org.uk/lurker/search/20380101.000000.00000000@ml:linux-arm-kernel,sb:platform%5Fget%5Firq.en.html

With the right list archiving software with a built-in search facility,
it becomes much easier to find stuff!  There's quite a number of messages
there though, as there were multiple patch series posted.

Some specific messages:

http://archive.armlinux.org.uk/lurker/message/20171204.182556.775e16ab.en.html
http://archive.armlinux.org.uk/lurker/message/20171120.164840.87002f9c.en.html
http://archive.armlinux.org.uk/lurker/message/20171118.182704.3e1a5553.en.html

The reason it hasn't be trivially done (just by changing
platform_get_irq() now) is that doing so will cause a bunch of
regressions, precisely because people _are_ using IRQ 0 with some
platform drivers.

The patch series above has died a death, so yet again the IRQ0/NO_IRQ
issue has disappeared off people's radars and there's no reason to
fix the situation.  So, we're yet again back to the status quo of
almost nothing happening.

How do we break this status quo and finally solve the IRQ 0 and
NO_IRQ issue?

I believe that we have to bite the bullet and start by saying no to
these trivial patches which try to preserve the current situation.
That at least provides some motivation for things to get fixed in
the right way.

Another possibility would be to change platform_get_irq() and
suffer the regressions that will cause, telling people that fixing
their platform IRQ numbering is the only solution (but this
requires breaking our ideals about regressions.)

The alternative is everyone (including Linus) stops whinging about
NO_IRQ and IRQ0 and put up with the fact that some platforms treat
IRQ0 as a valid interrupt - which, I think we can all agree, isn't
going to happen.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
