Return-Path: <stable-commits-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549902-1519123775-2-14311645202561353775
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
X-Mail-from: stable-commits-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519123774; b=NIYKIN87ysvLqHQYjW6MU9mDyGlSqtvNGeVt+8cjsTga2ao
    ThoEm8ln8x4071kct/aLISa8kA3aDeOu4Yel0O4dzO0JGEr+jGMbbrAcKEozeZMh
    Mxq7BYK5bz4rJ6hXTvvZfhA3Ek7xI0d9BFSs3iJMJzXVDy3jmWrSThujdD6LC2DC
    QzhNnVZWMiHOc7mmlM5KN6JWuKULcZCYkNLkC0qTBWP1JvgIgCJvrttZjh7yE6oP
    qIPoJPq506r3RaHvZSeiYwcPPBlaxB2pRHU/Bv9/SLLJiIUli5qy6WRLV7xA/2Te
    z7YppqV71GutufyarUBM2qXWBVhWGrg/toLqXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :reply-to:list-id; s=arctest; t=1519123774; bh=tiMymi+0vk+D3AKqP
    y5IJCIrQu2aIrFk98VtDeMRQD8=; b=hQZBzdH6+8KjS8qBEFdIIUzScpFZoRuux
    CdT614/KFagA7qE4MynZgkl/jzZkMiJcrQo69zp9yd7EitLR7fX1+vDdlxOjdge4
    lp3E8ys5b1EHRc1VFj+t4KoEeKzezoqrjQckUXGIz6k8Pqbdm5/H3qH6Y8dt4Nw9
    e5rKLqGln0AZ9+TN5JB9xqUXlE6jna+RR/1/EBKrI4ayE6EQlRUzK4VRgyJyC4NX
    vGWRA7PpIyG8/PBBpo61T76oxq+WosXdrWPu29YqFLP31Kbsst40+20Lsbl7nu/e
    gA5VK6kpS0B8dOFFsKadqnDVmNpE4dciD3CatOYRNZQ4BLWNy7yog==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-commits-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-commits-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeBTKtc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:49:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeBTKtc (ORCPT
        <rfc822;stable-commits@vger.kernel.org>);
        Tue, 20 Feb 2018 05:49:32 -0500
Date: Tue, 20 Feb 2018 11:49:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Masters <jcm@jonmasters.org>
Cc: Timur Tabi <timur@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "[Variant 2/Spectre-v2] arm64: Implement branch predictor
 hardening for Falkor" has been added to the 4.14-stable tree
Message-ID: <20180220104933.GB16450@kroah.com>
References: <1518616386206238@kroah.com>
 <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
 <5be20f44-b750-7250-76a8-03b6c39bb2fe@jonmasters.org>
 <20180220104738.GA16450@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220104738.GA16450@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-commits-owner@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org
X-Mailing-List: stable-commits@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 11:47:38AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 19, 2018 at 06:57:12PM -0500, Jon Masters wrote:
> > On 02/14/2018 11:16 AM, Timur Tabi wrote:
> > > On Wed, Feb 14, 2018 at 7:53 AM,  <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> This is a note to let you know that I've just added the patch titled
> > >>
> > >>     [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor
> > >>
> > >> to the 4.14-stable tree which can be found at:
> > >>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > >>
> > >> The filename of the patch is:
> > >>      arm64-implement-branch-predictor-hardening-for-falkor.patch
> > >> and it can be found in the queue-4.14 subdirectory.
> > >>
> > >> If you, or anyone else, feels it should not be added to the stable tree,
> > >> please let <stable@vger.kernel.org> know about it.
> > > 
> > > Please note that there is a follow-on patch, also from Shanker, that
> > > fixes this patch (it was slightly mangled when merged into 4.16-rc1):
> > > 
> > > https://www.spinics.net/lists/arm-kernel/msg633726.html
> > > 
> > > I would love for it to be included in 4.14.20, but it hasn't been
> > > merged into Linus' tree yet.  I will send a patch request when it does
> > > land in 4.16-rc2.
> > 
> > That has now landed in Linus's tree.
> 
> What is the git commit id for it?

Nevermind, I found it myself...
