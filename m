Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3459232-1521745001-2-9773903920472791095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521745001; b=bEuZNRk4B7cL6Vqrpvb3Fk+EVvdNezudF0ZSeyz49PZvMzb
    mMI6ntDT17miDNu8RJ41s6dK6SZ9kpbjkvkWnqkkaSQve+Y+Qzg/TUJLBRRLrcyc
    mLrj5yFnET1TLNsW2iBGrdxw2yswAPbnvRBH4tc5jsoJlOJe09oBryq1+sf14Rwi
    cJhqohMhcQmM8hg29MACwUWfBidnWHrT0In3wdA724r27W8384fIliHmCDFhCW9H
    WiCYwTQ2igwWxnUTlNqtqVdGDpiVDscUPqxyHlMjLQJRr6lD+UdiQf/a9ufZYF1G
    dmLlOYlGoEJkhJj5IJ2Wipduycunj5Qiv/JEfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521745001; bh=dG4m6rb7UUDrpDm0AVvLiSJMWb
    l6BMhtqc8l46wkGQY=; b=BFDI7mYPSjDbtJinjoh/WUke4mzmCz4mKKVMjoemZp
    Sg52BgLvxh4pGBXALFUWrTgAgsqx14OF+vs8cEZzY8qtS1xuzr+pkiseqgdd5CQy
    IWCpgqXHJ/ZLG5kPLIvesp695bThiUAnjmYTNwzkQ0QAWIak7ya/ByfI/sKSxqnQ
    BE0JA0gVAHlA8xNmQ574Dg/McQvycATsp3GDam27uGybxVX+F9cQTvonxuLOmkzk
    dzfg2F/GKjDI04FI+9Hf5UzOyZ40Uu2g1JK87hroPAJZ5K0gW5i5D6mKzXrRLOOM
    9xJdiayvykM6TErRwzifhb7NjH5NOlksqNT3EaKXp2Ng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=j11Vvi/O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LtViO7jx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=j11Vvi/O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LtViO7jx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeCVS4j (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 14:56:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42248 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCVS4i (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 14:56:38 -0400
X-Google-Smtp-Source: AG47ELvWuwui7FLlUCmsvZaA45aQtu83fdo4C70LIvsidRuoNe2cLNuhCwz/wMJP512KKql7DZc8rA==
Date: Thu, 22 Mar 2018 11:56:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Norris <briannorris@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180322185635.GA4411@roeck-us.net>
References: <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
 <20180216185220.GA29352@roeck-us.net>
 <20180217134351.GB28145@kroah.com>
 <befd1dc3-32ee-bd00-876e-a59397cffd37@roeck-us.net>
 <20180217152459.GA22308@kroah.com>
 <CA+ASDXMvsgOUkxyYuMNqNduNJR5k-jWHynfXvpEdTLGPZyD=TA@mail.gmail.com>
 <20180322175251.GA24850@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322175251.GA24850@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 06:52:51PM +0100, Greg Kroah-Hartman wrote:

[ ... ]
> 
> And that't the point to drive home here.  If you stay away from updating
> to stable patches, you have a huge boatload of KNOWN SECURITY HOLES in
> your product.  If you take them, you have the _possiblity_ of some bugs
> added, but overall, the rate is _VERY_ small.  Guenter has numbers of
> 2-4 patches per year cause problems.  That's lower than ANY other
> development model I have ever seen anywhere.
> 
Unfortunately, people tend to be irrational. Yes, the regression rate I have
observed is in the 0.1..0.15% range for v4.4.y and v4.14.y. Yet, there are
still people who believe that we should not merge stable releases due to the
regressions it causes (though they are much less vocal nowadays).

> So, stick with known buggy/insecure devices?  Or take the updates and
> handle the 1-2 problems a year they provide you.  I think the
> cost-analysis is easy to make here :)
> 

Agreed, on an objective basis. Unfortunately, one does not get credit for
fixing bugs which have never been observed in the field because they have
been fixed before they showed up. But one _does_ get blame for regressions.

Even though there have been very few regressions in absolute numbers, the
default reaction to newly observed problems is "it must be due to a stable
release merge", even though it almost always turns out to be incorrect.

The only way to deal with that is to reduce regressions to 0, or as close
to 0 as possible. 0.1% is good, but not good enough.

Also, while I agree that we are much better off in respect to security,
the verdict is still out if stable release merges actually improve release
stability; I don't see a clear trend even with chromeos-4.4. Of course,
it is all but impossible to say if this is due to 4.4.y or due to the
13,000+ patches we have on top of v4.4.y in chromeos-4.4.

Guenter
