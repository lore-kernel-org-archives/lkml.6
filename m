Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2046117-1524725238-2-7502565817086168241
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='jp',
  MailFrom='org'
X-Spam-charsets: plain='ISO-2022-JP'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524725237; b=WPGI2xOs+CIb8Q0yx034qOyO6Klu7WjidOHkuQHHiWi/+8mVde
    thQ4Nyoy9y+6dlBeJDRjIvqbEIZgFRrtjXcvKzusdhR13SNIbpfvd9xvJ3FS3y91
    gd2LilLivltB19YLp4RfEymyTr4eFpyAQn9w7ZyIQIuIJqL5qQg/IYIKp/8KO189
    iENqFymmr3VX35ZCSpZl92mr7QsIePD6/olmLgDdjiQiRsHQWLUbwbcdPWn2R+kB
    HcfWATTyJY1o+s+2C9G4VE6ZAN5yUVpO5l2nFylsT/7QxUCAUMpuO8a+dTBV/xFF
    NhqRvflvu8+riiLciFoLsY6F0cZxNEJQEFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc
    :mime-version:content-transfer-encoding:date:references
    :in-reply-to:content-type:sender:list-id; s=fm2; t=1524725237;
    bh=q67RZm9OgGtEhSixlQL+WP//4X2MHTpkwuB0K7OtuCw=; b=E8PLZKJME+Az
    ICDiJCl1W1Yf9riJlcvO/Wcdx5By3QfE8C8ZNZ3aoxXO8QLI9PTQdcAYRxhg8UlA
    RjjrX8uwCNmf0e4xZjheEgS/k2GIsIpWlAIbaiJwbM6qjTdPnIFd+yXn8BfjKL1p
    qb6Ap2I46s9p/4cCdpdxCVcwnk89Zv195sedcyTXfh2zLJrVqpZua8ODkZMKU22j
    A4VoFfwXg96XRM64swuqTPoBpbywO47/eJYgh+BN5GdF74Kra/2bIQPgaY30HeLo
    32m/MtEMC1p6ss9qp8OzOWueUj+IQd69B04a5fYGbUF+OPQcXVG/USKlXX8yDk6e
    FFJEpVA7uA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJF1mWh3540z3LL+LoNZTMNmXL4cRVracdafv5hrEs15F1htYY/axVZdHl/bcTqpOzynfSw4MZu5vgYn/eu7NPDOzFKJPFdKIiV9192dk9lZxFoU7gTC
    WL8HktDwy/ccabhhgwHd3JT9L+jD5vuftdDtNAUbIS1MM/LSWm5hpqtM40/ShaQMTHmCdNcWmZkl90YompcjACxggJ+cqYS2bTSVdj+JCsFjIHQ0MlABILQk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=ZPSk82zQDygA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=yrL-zjFfvDntZxs4844A:9 a=UAVRJdkkkM0A:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDZGrQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:47:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60947 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeDZGrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:47:16 -0400
Message-Id: <201804260646.w3Q6kx7s025759@www262.sakura.ne.jp>
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after the CRNG is fully initialized
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Ingo Molnar <mingo@kernel.org>
Cc: "\"\\\"Theodore Y. Ts\'o\\\"\"" <tytso@mit.edu>,
        gregkh@linuxfoundation.org, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, carnil@debian.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Apr 2018 15:46:58 +0900
References: <20180422135210.432103639@linuxfoundation.org> <20180422135213.491879480@linuxfoundation.org> <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk> <20180423071520.GC28186@kroah.com> <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp> <20180423155637.GB8194@thunk.org> <20180426060434.b7fwrem77ht7n5qa@gmail.com>
In-Reply-To: <20180426060434.b7fwrem77ht7n5qa@gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ingo Molnar wrote:
> What\'s the resolution here? It\'s still triggering upstream as well, as of 
> 69bfd470f462:
> 
> [    8.881634] dracut: Switching root
> 
> [    8.994899] ================================
> [    8.999338] WARNING: inconsistent lock state
> [    9.003760] 4.17.0-rc2-00151-g43ae031-dirty #1 Not tainted
> [    9.009389] --------------------------------
> [    9.013803] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> [    9.019956] swapper/2/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> [    9.025244]         (ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire.part.87+0x5/0x30
> [    9.033598] {HARDIRQ-ON-W} state was registered at:
> [    9.038628]   fs_reclaim_acquire.part.87+0x29/0x30
> [    9.043568]   kmem_cache_alloc_trace+0x2c/0x240
> [    9.048248]   alloc_workqueue_attrs+0x29/0x60
> [    9.052755]   workqueue_init+0x4a/0x2e4
> [    9.056741]   kernel_init_freeable+0x108/0x286
> [    9.061335]   kernel_init+0xa/0x110
> [    9.064974]   ret_from_fork+0x27/0x50
> 
> ....
> 
> Is there a fix or a revert that can be tested?

Yes, you can test a fix at http://lkml.kernel.org/r/20180424034138.23994-1-tytso@mit.edu .

I thought that that fix still causes a problem. But it seems that I made a quick judgment.
I can no longer reproduce the problem with that fix.
