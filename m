Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1563444-1524506538-2-6805071740751742391
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524506538; b=RHTP1yisSzo96Y98wGQXZ0Z6vMF76LU/jOQQ+kob4ks+FbBNCz
    Wm9SWFJIzB+K8mzN6OMy1XENDn/jKVXia8DUWJ+WMXAzrC0nhZ/6nRssq2knHxfu
    rlGSL5qWtFGn9yBljvnqUaXLzxzhMBeInpzgVC5uxLffyVpKbfsE9eGq4iekU8bZ
    7XEhzLKiTi0dfQFVlYzMxQFg0SMzUMUe43lyzWfN+z67OsNT98XLDYD3HAGJTlU4
    hhuc7TZHZWgWUFivXYg2TYqlfEiZdLznF38Wl9FqDUS7vpekrccOaR9TONnWpXJj
    a6Vp9eSR8b9vbUDo2noHrGKlqb0oeIzypReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524506538; bh=5yGOP4Hc+kPmjlq4ubRtL3EHcgd6NZ
    oRMyqGgVO6itI=; b=lwOc1h558FPfxcRFJqlwZLiIi8lhicADQmh8ltBwrExskw
    A4SF4gtFiTwNs5J+UdK9FN3A5kbL8EUMKlHsq5sAGiB11LO0ClETVt0QHI/xVZEA
    HcYA/kJ+PBYX6AGiBk6QE/aN/Zz2QQCr6U7jJTRXtIJF/D5vRiqsxryomvgTtUbw
    dIRu6xWTc1wPchwZZWdyAGsGUEpGaX/rHdFI0bzpe9aP1ogt+0Y56KpVTCsK1NGE
    hFJfMDJLjGg2ui5pWIhKuOZMUt7ixHc8sKsKibyOZm1yDgNYScIcu5n6qUUNt3uy
    dS4sCblXc2TSMYO3aLJ7Ol5HN0Qa4gYHZs2sYcXA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPDWiqctWs2U2kX30i/XP9v41k13SJOE+ES0EAfAc2d8Lvq+bu/IySA/pfBwadq4tklI1CcIAD+HQFd+z/PxorRkrOuayoAiu0G22+FH/qkXRgZA2hkJ
    KChEBetlpCRDceyOwNvVtZXCt+Tt7vwGtiFWCzI6aIqo/F+0f4rUqs1NIwMleLXynd2WpFXyEt35u9QZ9tsbPA1PVbDcIVCSJE46uu/ZfKtOsKDVAMDHndub
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=PAdLV6QQiTuTgSo_Ue4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeDWSCE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 14:02:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbeDWSCC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 14:02:02 -0400
Date: Mon, 23 Apr 2018 20:01:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        ben@decadent.org.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jannh@google.com, stable@kernel.org,
        carnil@debian.org
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
Message-ID: <20180423180156.GB26974@kroah.com>
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135213.491879480@linuxfoundation.org>
 <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
 <20180423071520.GC28186@kroah.com>
 <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp>
 <20180423155637.GB8194@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423155637.GB8194@thunk.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:56:37AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Apr 23, 2018 at 07:21:10PM +0900, Tetsuo Handa wrote:
> > Greg Kroah-Hartman wrote:
> > > > I think this can be fixed by backporting commit 4a072c71f49b
> > > > "random: silence compiler warnings and fix race" but I'm not sure
> > > > whether that depends on other changes.
> > > 
> > > According to Tetsuo Handa, it's also causing problems in mainline :(
> > > 
> > > Ted, any thoughts as to what to do here?
> > 
> > (Resending because Webmail post was rejected by both stable ML and linux-kernel ML.)
> > 
> > Subject: random: GFP_KERNEL|__GFP_NOFAIL allocation from IRQ context
> > 
> > Hello.
> > 
> > Commit 8ef35c866f8862df ("random: set up the NUMA crng instances after
> > the CRNG is fully initialized") is causing sleep inside atomic warning
> > due to GFP_KERNEL|__GFP_NOFAIL allocation from IRQ context. Though it
> > unlikely sleeps because there will be enough free memory at boot up...
> > 
> > Please don't backport that patch now.
> 
> Yes, please hold off on this in the stable queues as well.  What we'll
> probably need to do is call defer the processing to a workqueue in the
> CONFIG_NUMA case.

I've dropped this patch from 4.16.y, 4.14.y, and 4.9.y for now.

thanks,

greg k-h
