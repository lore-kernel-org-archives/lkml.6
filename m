Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1950236-1524722683-2-537182153359282576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524722682; b=ZEPvXLmfEYvLSjirdaSQAVwAf54Snx9Zk9kWwKqNbZXEdR+OUw
    abmIlLMoqr1+p3/NtZktREINwTygxJbT5Y8nQxDXVZtkeiw207jPpAb32cF4vqO9
    pfCsDpR9qJx6nZ+FXJpC3o4DPM6uBNgLr+NETEy4MAl0Xb7hdrBwB1k1gTeQZG9Y
    xaq/oEmRsojyyzex+ezeb8k9+f99OLSsKb+/jI9xWX7eTWKexnAWi/1R9rQ80gyX
    cLAo3Vqwx7YT10rNkEci5XnoaUs5Rfj0q+pG+6Xwmk5Mf4ebkG2VcoT5LcuA6CcR
    gU36juosLYbRl3To3zIpjfHgkPnYH3lZ8OTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524722682; bh=sbxo5w3QA6rIxfvZK5Wyyf0B7KXHfG
    6E/9+3tcxEF8A=; b=giULO6HYq03N/YTs48SADC4rxt46V1pjB8nbXKGQ4/9yMF
    slcrxThM9vhGwAFn1Pimm41qvJ0sBfrzvPWfjzEmxOam0lS6IUcINbbAepqPi6HI
    cpyfboSfOhHZjDAqp2r286XCTxzcEaKmiSGLCTCeSSkYD6/hTVisIbnSF2tmIU02
    4EgiYeZ1S11qgh4jj9h1fLivRrXJ8n2L6dng7P5ibIAaQnuTwrzE8qEY9mTjqtge
    CdrO+jSBK+TazPLxHyUtBMTxyDM4dLvslerGRHGtc2Vllfhn7d0V4CqX3qSEcQ7f
    gRsIHEHMM/W6zLUkAXuacEvF1cB7K/sbM5laftbg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cv9OO/+H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fcqs//Gh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cv9OO/+H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fcqs//Gh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFmBy6NNmmTykFBSmNq5PARC2HLu36fJQEw3cv+C2cMRiDKC78Ofwk6iC4Y7ykdnJJacWNPjkSCqJgjKC1q43TFxu/IoVE+an6PcNR3R6H2bbi0dht7Y
    qVW3r3zgU/u+On9bsqY6ODbSjpBF+fY7VQgysl/frswcttWHfcG3vvVL7aYtxd+PkM1XPy52lNZ7at+7LVnPwptjCQGZx623kYTcxSuBcCC5tIzqZ9JB2+0P
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=6bzQQBi08rTdQbPllZYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeDZGEk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:04:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34686 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeDZGEj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:04:39 -0400
X-Google-Smtp-Source: AB8JxZrfiujCC3QobKopV8cIEayEIStqNZPzM3bQqwRVseiwrmOb8fAiAxuXYdy8F9HmU1piAWQ0IA==
Date: Thu, 26 Apr 2018 08:04:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        gregkh@linuxfoundation.org, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, stable@kernel.org, carnil@debian.org
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
Message-ID: <20180426060434.b7fwrem77ht7n5qa@gmail.com>
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
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Theodore Y. Ts'o <tytso@mit.edu> wrote:

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

What's the resolution here? It's still triggering upstream as well, as of 
69bfd470f462:

[    8.881634] dracut: Switching root

[    8.994899] ================================
[    8.999338] WARNING: inconsistent lock state
[    9.003760] 4.17.0-rc2-00151-g43ae031-dirty #1 Not tainted
[    9.009389] --------------------------------
[    9.013803] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[    9.019956] swapper/2/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[    9.025244]         (ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire.part.87+0x5/0x30
[    9.033598] {HARDIRQ-ON-W} state was registered at:
[    9.038628]   fs_reclaim_acquire.part.87+0x29/0x30
[    9.043568]   kmem_cache_alloc_trace+0x2c/0x240
[    9.048248]   alloc_workqueue_attrs+0x29/0x60
[    9.052755]   workqueue_init+0x4a/0x2e4
[    9.056741]   kernel_init_freeable+0x108/0x286
[    9.061335]   kernel_init+0xa/0x110
[    9.064974]   ret_from_fork+0x27/0x50

....

Is there a fix or a revert that can be tested?

Thanks,

	Ingo
