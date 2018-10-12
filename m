Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD7C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CE821477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CE821477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeJMEAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:00:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52117 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJMEAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:00:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gB414-0007lq-28; Fri, 12 Oct 2018 22:26:34 +0200
Date:   Fri, 12 Oct 2018 22:26:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 07/11] x86/pkeys: Drop the preempt-disable section
Message-ID: <20181012202633.xj5jkg753b6uf6s7@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-8-bigeasy@linutronix.de>
 <1351ba57-1e17-1d76-63c2-0eead2cc5f3b@linux.intel.com>
 <CALCETrVm1ZygpEz+912BcMgTAPznB24uYsB1yQ_V4YQa2N-DzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVm1ZygpEz+912BcMgTAPznB24uYsB1yQ_V4YQa2N-DzQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-12 11:07:28 [-0700], Andy Lutomirski wrote:
> All these "if" statements in the FPU code are messy and make
> understanding and reviewing this code hard.
> 
> Can you prepare a patch for the beginning of your series that removes
> fpu->initialized and just ensures that the fpu is always initialized?
> This will regress performance, but you should get all that performance
> back with TIF_LOAD_FPU.

okay, will do.

Sebastian
