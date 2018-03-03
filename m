Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727864-1520102212-2-7707967731345772494
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
    t=1520102212; b=Nn6KCo6kuyn7pY58Zkc1iRpaIQKT6qwm+FD/ShKo2ugmYVJ
    eWxY20aGRpUtJyriHY0CTazp0pzWSxv28Ge3RGPL+uxMtkxSrPR6tGG27l2JdyT/
    eMi1mgNpmNMqw+EZo3pLm1YzjDOuWVjfFAHxjFEdMEfuPgVYpCcTyK/xBXhLB1MI
    Bf7hBzgnQltt2C63Oagqas3PIaBKblaqk5j50h+aCYaII3ub1D2aFBuKZaJeQQx7
    nLmVoizrjLfU/W7ZxNz8mg1Zr148gYbCAuosWRq0Oc0kPscmrYJRngxCYIwn2VCl
    pJlbUaZgBtqEdJ7uii8VUuBpMgDmzcbFGlmPBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520102212; bh=sNJdEHktQbVq3QnRYXEsAKBE6c
    d6YqKJwwpEUBSmvyE=; b=T+hsI6T3C50/vwEZMEErjnV20JlRd9ANOTxCCXB9F5
    fhxpPzh0enAk8RnjIj8pZQOgdMNtYiO74oZHEZKl7241s/48aV3mJdBfjxs9vG28
    hMIgsW3SOfW8Nrot21lSfe1vgGx+srkQI6PiRS6VpFsKMUTX4xE58vYe5IE54eNk
    RkLtm4Ghgm0p1C1Ysk12SBpukfnSIs6NuO+2YzWREB7mdKaE2Y+4miToaB7Ov/GT
    gBSn6VR5uQVbacthrZyvCXH1daObLm2hrz/ZHuN8GAYrrNKNjYiH/tx+ESS16gwL
    HT1ynI8CpMbrNiEM6/vxAMHrsZcUkwai80XuPR+mi9QQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ojP7pAPk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ojP7pAPk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeCCSgg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 13:36:36 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40116 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeCCSgf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 13:36:35 -0500
Date: Sat, 3 Mar 2018 18:36:14 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-samsung-soc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Stable <stable@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180303183613.GE9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
 <20180302135854.76ue5jzsg7lvxjxw@katana>
 <20180302140901.lrjqiaa2k4nxkqco@mwanda>
 <20180302153221.GB9418@n2100.armlinux.org.uk>
 <20180302162821.bmsxgrqqaginjooo@lakrids.cambridge.arm.com>
 <CAHp75VcPMmATbCCczm3NqNDGCda6J5vga-FDW4SFABaqBKe4iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcPMmATbCCczm3NqNDGCda6J5vga-FDW4SFABaqBKe4iw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 03, 2018 at 06:25:17PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 2, 2018 at 6:28 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Mar 02, 2018 at 03:32:22PM +0000, Russell King - ARM Linux wrote:
> >> How do we break this status quo and finally solve the IRQ 0 and
> >> NO_IRQ issue?
> 
> Guys, the question: Wouldn't be request_irq() failed when it gets a
> wrong number on input?

Unfortunately not - IRQ 0 is kind of valid on x86 (it's the i8253 PIT)
and an exception is made for x86 arch code with regard to this.  It
gets setup using setup_irq() rather than request_irq() (see
arch/x86/kernel/time.c::setup_default_timer_irq()).

request_irq() doesn't deny IRQ 0 - it denies IRQ_NOTCONNECTED and
anything that irq_to_desc() returns NULL for, which can be a radix
tree lookup or simply any unsigned IRQ number less than NR_IRQS for
legacy platforms.

If you're on a DT platform, then the IRQ subsystem avoids allocating
IRQ0 for any DT IRQ controller, so DT platforms should be fine.  It's
just the legacy platforms that continue to be an ongoing issue wrt
the IRQ 0 / NO_IRQ business, and those will generally be using the
non-radix tree version of irq_to_desc().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
