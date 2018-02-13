Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518513391-3-3627379118741181858
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
    t=1518513391; b=E3sKcfXsqt9rIw9nzXU6SMwP4Gad6DlERl8Xw96M6I9JTk4
    zIo4q7dVdPyN3KRzx+Pvv3vIVZBlMlEo3jS/gPrtXQq0I3wUNkFQo8+ZnjzoaY36
    nRe1puHe5ucofG7zu1Lm+XpVVK/IRhmS7b30JK4f4ciG7v0siaV9Fe147W/sEbwj
    1F58hmmTAc3SF6oR0KjmsgULQgzBiGPavICTMGEOOMcv0TMS1C/F9+SNXmm9yy8n
    C/vvrCXiG9uQNDhGiomlUF8/tG8wylBRj7pHxYxltc0VYN+bMlAUV1xrUG8SJRRt
    mb/JQlO/HSgq02WXuVP3d77v3tQm7QnB4bQKG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518513391; bh=uD03tGytxyRE7Cx3P3Ss269egf
    El05mbJpQDTRg6zvQ=; b=Z+piOd5zInJC+jJZJGKYir572UaY3N4IsQx1iJIpFj
    aDUaajvvIvT95J9PgnBUa12OZzsLzip3hnMkwOq9H+AJGiSN1lEjrccfRNIWj/yP
    wUpqMhIq9uhC0UP6tVrDrNXX3utodSklrN6ClfSfekKXRtI2WC/l5kqN4y521chP
    kKFRBV6t5BLAUKdo47nxNKbC/v18p3KgBguuMWay44HZfmTcievfOH0FbF82Z36i
    126PvAitbyeHClywscth8pMC7i9/LfiS3ij4xpWyjLcFgbRgWnP/E2w2f36sKiQC
    Ka9qXQ8kz+L64eLt79S/pM3pHO19huAmafynhepmAaKQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934443AbeBMJQK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:16:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934024AbeBMJQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 04:16:09 -0500
Date: Tue, 13 Feb 2018 10:16:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@suse.de>
Cc: Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
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
Message-ID: <20180213091607.GA13711@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.472824776@linuxfoundation.org>
 <CAGXu5jJ2K3SziXQsy-w5VOu9-V3H79w0OFQQFFnZiezUyc53Vg@mail.gmail.com>
 <20180210072340.GC8814@kroah.com>
 <CAGXu5jK=46Oz63Q5rPbDuGzGxDPFpx5asE3-RLunuvQkEsF4cA@mail.gmail.com>
 <20180210192136.GE4866@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180210192136.GE4866@pd.tnic>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 08:21:36PM +0100, Borislav Petkov wrote:
> On Sat, Feb 10, 2018 at 11:14:18AM -0800, Kees Cook wrote:
> > I would just revert this commit from kernels earlier than 4.15; this
> > %p usage is in debugging, so %pK doesn't make much sense here.
> 
> Yes, just drop it. That's only for debugging alternatives and not really
> needed in stable.

Now dropped from 4.9.y and 4.14.y, thanks!

greg k-h
