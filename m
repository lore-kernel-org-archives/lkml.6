Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3376651-1518247425-2-18220137852523197274
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518247424; b=d1nGDwpd01cIEQyDHHxXZb7TFvZDDmd+Rlq/wx+7sg2ZkAT
    da3xInpxXjPSSEm2P/oWOUbQsCl1OEha8erHIWo1+sw69jDxkVgd//LRcfqQTaJO
    4+r+ndKse+uYTvaPCuZl/QV9YVlKSLAyx5SdBHcd6kHJopmN1n9394/r9Ak0OgBZ
    5vgPmgyqOW3CVE7V4cbtTwiT6r301VO2wV6PCPirv9plbDHMtFp0UdCxt+PWQsek
    sS+9E3nVKdbNa/XHbULhn5ZtrgTzzONukUQLFxFzrIG3QSQIkM/j7izTD/P/YN+C
    vLiFsJDTcudYBUdSqXVzKSOI76ZFPBE1QTkhMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518247424; bh=xELPoGcGwgOcQAMVIgo8Xcd98O
    fC7f09Bihf5VGw2G8=; b=TXcb3MbqkIwcOIL9xxrwe2H195Or00rOYoKawmYvB5
    EeAm5W49dMso/llSnb7Q9ufC6hv/oRp682wXcww50vgc8BEnM951694JXARxhRa/
    wJM4W31CVibVKfVrooGugv8Xu/21EcXCOiYwlvekPRFYRlmUbEhYfSTDruVxW02t
    j1snbc0Q6LY8/S2nTEpWDPnQXKmSthfcQjQ3c1gFIPkV5td5z3FUyIWcy61aAElG
    M4cODppwmVhXFePqh3lEnIeX2wmgzh7JH4xi+jaXBew32m5451kJAAoag6bT38cP
    Wu2RuHeP5LL4IG36Rk1qoEm/dcpy9QspuBMaffSehfVQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbeBJHXm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 02:23:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeBJHXl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 02:23:41 -0500
Date: Sat, 10 Feb 2018 08:23:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Paul Turner <pjt@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 4.9 46/92] x86/alternative: Print unadorned pointers
Message-ID: <20180210072340.GC8814@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.472824776@linuxfoundation.org>
 <CAGXu5jJ2K3SziXQsy-w5VOu9-V3H79w0OFQQFFnZiezUyc53Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ2K3SziXQsy-w5VOu9-V3H79w0OFQQFFnZiezUyc53Vg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 02:01:32PM -0800, Kees Cook wrote:
> On Fri, Feb 9, 2018 at 5:39 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Borislav Petkov <bp@suse.de>
> >
> > (cherry picked from commit 0e6c16c652cadaffd25a6bb326ec10da5bcec6b4)
> >
> > After commit ad67b74d2469 ("printk: hash addresses printed with %p")
> > pointers are being hashed when printed. However, this makes the alternative
> > debug output completely useless. Switch to %px in order to see the
> > unadorned kernel pointers.
> 
> This missed a "Fixes:" tag so probably missed automated checking on
> how far back to port this. It shouldn't go back beyond 4.15 (where
> ad67b74d2469 first appeared).

Good point.  Should we instead be using %pK for this change instead?  Or
should we just backport commit ad67b74d2469 to 4.14?  :)

Thanks for letting me know this.

greg k-h
