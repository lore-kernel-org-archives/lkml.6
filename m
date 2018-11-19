Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1803120659
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1803120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbeKTEmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:42:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39406 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbeKTEmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:42:16 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gOo72-0000l6-F0; Mon, 19 Nov 2018 19:17:32 +0100
Date:   Mon, 19 Nov 2018 19:17:32 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 17/23] x86/fpu: Eager switch PKRU state
Message-ID: <20181119181731.bmzbkdwwwt4kbcso@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-18-bigeasy@linutronix.de>
 <1d4b7b5c-9c3d-1ef5-3336-b7945b7978d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d4b7b5c-9c3d-1ef5-3336-b7945b7978d4@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 12:12:52 [+0100], Paolo Bonzini wrote:
> On 07/11/2018 20:48, Sebastian Andrzej Siewior wrote:
> > index 375226055a413..5b33985d9f475 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -811,7 +811,7 @@ void fpu__resume_cpu(void)
> >   *
> >   * Note: does not work for compacted buffers.
> >   */
> 
> The comment is wrong, which was already the case before but it becomes a
> bit more important if the function is used outside its module.

let me fix it.

> However, why not use get_xsave_addr?  I don't see why it is important to
> skip the checks, and if it is it probably deserves a comment. "Raw" and
> double underscores in the function name is scary...

yeah, it is scary and only those that can face baba jaga may use it.
I though it is a fast path and it would be okay to skip those checks.
However. Let me fix the comment and use the normal function like
everyone else. If it is too slow then we can still short circuit it
later.

> Paolo

Sebastian
