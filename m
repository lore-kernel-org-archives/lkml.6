Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134BE20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134BE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeKSWF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:05:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38184 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeKSWF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:05:27 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gOhw7-0005ZO-S1; Mon, 19 Nov 2018 12:41:51 +0100
Date:   Mon, 19 Nov 2018 12:41:51 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/fpu: Disable BH while while loading FPU registers in
 __fpu__restore_sig()
Message-ID: <20181119114151.e4mbs7ktfjojl3uf@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-3-bigeasy@linutronix.de>
 <20181108145721.GC7543@zn.tnic>
 <20181109173521.2m6iijp5wkncgi77@linutronix.de>
 <20181109185202.GF21243@zn.tnic>
 <20181109232521.l2ll2n3coxygkxv4@linutronix.de>
 <20181112155643.vclej44qzg3pmbow@linutronix.de>
 <433cec57-57a9-afff-22f3-68308eda682b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <433cec57-57a9-afff-22f3-68308eda682b@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-12 09:48:08 [-0800], Dave Hansen wrote:
> On 11/12/18 7:56 AM, Sebastian Andrzej Siewior wrote:
> > Use local_bh_disable() around the restore sequence to avoid the race. BH
> > needs to be disabled because BH is allowed to run (even with preemption
> > disabled) and might invoke kernel_fpu_begin().
> 
> FWIW, that would make nice comment fodder for the local_bh_disable().
> I'd much rather run into it there than in a changelog.

Hmm. Should I really resent a v2 of this with the additional comment?
This patch should go stable to the fix the bug and at the end of this
series I remove/replace this hunk anyway.
I can do either way, just wanted to check first.

Sebastian
