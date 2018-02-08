Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3184158-1518110827-2-11896411579051884416
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
    t=1518110825; b=Jg7R9x4yb1657YeGTL5etoPeJA7s6O68/2fiAFq9wHRLkjg
    ggZD4SnRpLJnpVAzkLG8T4dfM7SlvPpceXdZXL4L3e4r/cqmZOhsJye+omAWaQA3
    tP4BA1/zVHJH5nH+656XZkkb4NdHVlHqFPMyoXTPsY/KLE+44tWD+zCqZXnRUe1L
    NosMLDuQ/z7Fwl0aHVlpUuw244wArUVLUOHS9QRfpFLZO+k+NJLW9v/Mz/wILQTZ
    Z7c8vwp/AdC8VeM2w4DUvXK9eAjzzS2LmuvbWt4ojOLvRvMJNrSTn3DmC235L6VX
    3hFZrzBUu7XVr2Cw600gJNogRxjBKfCF6aUlPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518110825; bh=+yAEjSJwX6eaBhhCVpWfl9jtbO
    PLvBlu/YabNSb1+xs=; b=wAyP0Zg5Aw2CpUz8PH4ywj70BhhLL5kp2eDyudJQ42
    lvzim9SDE0pYv6pYkV9VaINow68Nbjkh3noIvI61P0Ey5IjKqAdj14GhBH41OvVc
    b6RUjQemE+zZrncURyE4WMKnr8rGcr5oGMvT9P+QltDbwdVfB9FzqKga6DX8n+ps
    hL6QWo932DaY8QTBATfGAM0Wt1WNv88XuUwBKe3mEyyonIRaY16nAKjWSpFNjmCX
    LRe5gAB0w+8aJryHSpNKNvlyUteFpOnNRSIlk30M3Fz745T4ZxjZ+CXazlRGfrsI
    WsvVZTCswPKsDFY7kmdYeUdV2g52v+UkMu+RWNM0dEdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeBHR1E (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 12:27:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBHR1E (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 12:27:04 -0500
Date: Thu, 8 Feb 2018 18:25:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rolf Neugebauer <rolf.neugebauer@docker.com>
Cc: bp@alien8.de, zhang.jia@linux.alibaba.com, tglx@linutronix.de,
        tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Do the family check first
Message-ID: <20180208172522.GA12812@kroah.com>
References: <20180208163940.GD9421@kroah.com>
 <20180208171204.62005-1-rolf.neugebauer@docker.com>
 <20180208171204.62005-2-rolf.neugebauer@docker.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208171204.62005-2-rolf.neugebauer@docker.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 05:12:04PM +0000, Rolf Neugebauer wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> commit 1f161f67a272cc4f29f27934dd3f74cb657eb5c4 upstream with adjustments.

This also seems to work for 4.9, thanks!  Both now queued up.

greg k-h
