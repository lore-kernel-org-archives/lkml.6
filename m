Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB0CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E67E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E67E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeKTBa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:30:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbeKTBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:30:55 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gOl8a-0000iB-PO; Mon, 19 Nov 2018 16:06:57 +0100
Date:   Mon, 19 Nov 2018 16:06:56 +0100
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
Message-ID: <20181119150656.ylbrsvchdyavms4w@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-3-bigeasy@linutronix.de>
 <20181108145721.GC7543@zn.tnic>
 <20181109173521.2m6iijp5wkncgi77@linutronix.de>
 <20181109185202.GF21243@zn.tnic>
 <20181109232521.l2ll2n3coxygkxv4@linutronix.de>
 <20181112155643.vclej44qzg3pmbow@linutronix.de>
 <433cec57-57a9-afff-22f3-68308eda682b@intel.com>
 <20181119114151.e4mbs7ktfjojl3uf@linutronix.de>
 <982af52b-4e39-2b26-a184-2fe13f3d9f61@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <982af52b-4e39-2b26-a184-2fe13f3d9f61@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-19 07:04:35 [-0800], Dave Hansen wrote:
> 
> Does the local_bh_disable() itself survive?

Not in __fpu__restore_sig(). I do have:
| static inline void __fpregs_changes_begin(void)
| {
|        preempt_disable();
|        local_bh_disable();
| }

and __fpregs_changes_begin() is introduced as part of the series.

Sebastian
