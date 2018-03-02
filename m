Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1525519-1519993191-2-17435174436298523471
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
    t=1519993190; b=JYb4q928bZI8ABG1QoN2dDmNVniyszNO3g8HfnldHmVCGWd
    sSolxsI7TABZ/Ryp1lZTGOW8eM7obGpF6GezboldJjPzrjsO2QQM9LGc0xk+zxAO
    2pA/BI7Fcu35htJxVYFXGcwpd8rEk+2+5GRYpqbpnisf0FPDvU/ce86Qu69XjepL
    oZDP78cJZjeiV8hBowR6xP2GQVeF+PzZHUV8AC724i01/bYljYWROc7qo2XM6gGx
    t6OGtHN2uqRkm3COmh+uZn5NzwAREnLWypBHVI8zc3mZAfWE2vwCqqtFMbXkaAB6
    8Igr9x9aiO23hhxXZ7+gaq/WlZrsuhhdpKqEm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519993190; bh=eYwL4Nm+BQCcKo05T40fa5FHTj
    J7/BBKoN+y99KFClE=; b=lWvN3y9x6sLnNj9JcMGBN90srQNdKnyY9sjmfDMmUe
    fzxImj/R8tVNs9YgYHfOTPEhNQcj9c2ZHvene+dHHT+V1nFpurZqfU6zua3kIg0Q
    RDlx7tZRfBJotratltYod8ZoTrPV9ePvXc77wkHg5133225vQUN08uUPa80D+Y6s
    B+HH2Jx1x3IzvQCgon5N8+ZPrb5BWnrvQt2R//zJB32Ym4sMdUMqCwfH3Ykqi60S
    A9NgfygfXTDpM9iNKawGS31Nx5QdgFO9JKAsYAk8zbtAybY0q9Xn/rPdO1G0XEY2
    vOI68GgVEXo3nTYHeIpULwNztXiqCZ2wD/1Vk1J6j+nQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qkDRQRkm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qkDRQRkm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423302AbeCBMTr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 07:19:47 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47966 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423042AbeCBMTn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 07:19:43 -0500
Date: Fri, 2 Mar 2018 12:19:29 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302121929.GY9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302114909.u6kqdszt3aew2io2@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302114909.u6kqdszt3aew2io2@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 02:49:09PM +0300, Dan Carpenter wrote:
> On Fri, Mar 02, 2018 at 11:19:31AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> > > Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> > > so do not treat it as an error.  If interrupt 0 was configured, the driver
> > > would exit the probe early, before finishing initialization, but with
> > > 0-exit status.
> > 
> > The official position (as stated by Linus) is that interrupt zero is
> > not a valid interrupt for peripheral drivers (it may be valid within
> > architecture code for things like the x86 PIT, but nothing else.)
> > 
> > You need to number your platform interrupts from one rather than zero.
> > 
> > Note that there have been patches proposed to make platform_get_irq()
> > return an error rather than returning a value of zero, so changing
> > the driver in this way is not a good idea.
> > 
> 
> Those patches to make platform_get_irq() return error codes were merged
> 12 years ago in commit 305b3228f9ff ("[PATCH] driver core:
> platform_get_irq*(): return -ENXIO on error").

Rubbish.  Please look at the commit you're quoting, it doesn't have
much to do with what I'm saying, and I think you're mis-remembering
on two counts.

The discussion came up recently (last November) about making
platform_get_irq() return an error rather than zero - in other words,
it will never return zero.  This is entirely different from making
platform_get_irq() return -ENXIO when an error occurs (not finding
the resource.)  This discussion was sparked by patch sets from
Arvind Yadav.

Further information can be found by looking up the discussions
around killing "NO_IRQ", particularly messages from Linus.

Secondly, the code today does:

int platform_get_irq(struct platform_device *dev, unsigned int num)
{
...
        return r ? r->start : -ENXIO;
}

So if the IRQ resource is not found, then yes, it will return -ENXIO.
If on the other hand the resource is found, then it will return
whatever is found in r->start, which can be zero.

As stated, IRQ 0 shall not be taken by drivers to be a valid
interrupt.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
