Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1402810-1524499074-2-1042683932784385735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524499073; b=pqE3zYz0P3DY8IMeyFKYlSzAs/jLNof7WEfvndeld14SgLeyWZ
    efyJRN9BAqaVkWTleVFF3NhAPnc6nM/YZTeZO6/UzoiEDwJt5Aa+KN+ju+vXS3Jo
    EYCx4n7XY0LYaEFDra+WpCuOCW5xBUNsAoscDTWYuuygNJFy90PejjIZnSaq06M5
    tPDsYYygidXywABwXFNXch7cJpumLc2dJ/lcO+hF/3V/ocYh5NaAk6Nimaj6DI6m
    S2Pi1RrzSmLbWqt0bT06GZbuqdAHXQPHxYhC1GgmVmTu4sgqG/6NIOaL0ALKxoeZ
    lAPRMxuddxAyiEuTnxmNhJtqgT2ZNK/Zld8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524499073; bh=L6xvQNJAHFFMq+1/LDmx1viWkFlFPO
    zJtlbqjBMCzUA=; b=l54kHSENhDsZU1fWc2tmr9E3aCHV4o8fdvS+1ha/0SLq4K
    p5z6rPzoiwvecDR5x9OErxMWlcBKEUsG/Fyz/mHoh8tg2GOmMvYoyYAlyGiIjiv9
    kJz1JFnbMzbJedzVgMqoIBLD1D4L/oc6ybW1SVSdppbveRM2nrzQ/qH0HToHMBFd
    mCteQcn45s/Wb7+lW9QBj/kX6YqKuHj+TbvtOrmhylMogNJsT9446Hom3R72nNpG
    2PtMLKZuWYd3v4CWK/HnOzlK19Qi+qwCy5A5n7aLOOCrcmIw3dHkaaPeJGofrzL2
    RjIqNQg5A8jZvuUrqjwEYbhRIRHLcJq7aQAlGbcA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=eYypdAUE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=eYypdAUE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHq+Xe033BGrcwKFipBlHc+2wYHAuDplWGqk3eNV0D9UYrLcgBRSWP2uNL25/AoW0mfhd5Lwuc5e7z8UIGqkZJzx9gjjcLz+h0P8l+x3LN0oYgWLJ61/
    AmGmslf6yiWcLBU4DdKFnoSFzsDPqZ/Dxlq7wuuy/Q5FV0EZ9ZVgXRvERvqy9PL3AwMTkJzYuZfV7IAwa9LElkED1eu+1Y4uEkMe7NYK1qmPoCFnJhoESli5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=i3ZxcjKFc1baQ7oW2SUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeDWP5p (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 11:57:45 -0400
Received: from imap.thunk.org ([74.207.234.97]:46622 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755858AbeDWP4v (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 23 Apr 2018 11:56:51 -0400
Date: Mon, 23 Apr 2018 11:56:37 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: gregkh@linuxfoundation.org, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, stable@kernel.org, carnil@debian.org
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
Message-ID: <20180423155637.GB8194@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        gregkh@linuxfoundation.org, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, stable@kernel.org, carnil@debian.org
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135213.491879480@linuxfoundation.org>
 <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
 <20180423071520.GC28186@kroah.com>
 <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 07:21:10PM +0900, Tetsuo Handa wrote:
> Greg Kroah-Hartman wrote:
> > > I think this can be fixed by backporting commit 4a072c71f49b
> > > "random: silence compiler warnings and fix race" but I'm not sure
> > > whether that depends on other changes.
> > 
> > According to Tetsuo Handa, it's also causing problems in mainline :(
> > 
> > Ted, any thoughts as to what to do here?
> 
> (Resending because Webmail post was rejected by both stable ML and linux-kernel ML.)
> 
> Subject: random: GFP_KERNEL|__GFP_NOFAIL allocation from IRQ context
> 
> Hello.
> 
> Commit 8ef35c866f8862df ("random: set up the NUMA crng instances after
> the CRNG is fully initialized") is causing sleep inside atomic warning
> due to GFP_KERNEL|__GFP_NOFAIL allocation from IRQ context. Though it
> unlikely sleeps because there will be enough free memory at boot up...
> 
> Please don't backport that patch now.

Yes, please hold off on this in the stable queues as well.  What we'll
probably need to do is call defer the processing to a workqueue in the
CONFIG_NUMA case.

						- Ted
