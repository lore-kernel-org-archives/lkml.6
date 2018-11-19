Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9031213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9031213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404266AbeKTD4J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:56:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39247 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404122AbeKTD4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:56:08 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gOnOa-0008KF-5T; Mon, 19 Nov 2018 18:31:36 +0100
Date:   Mon, 19 Nov 2018 18:31:36 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/fpu: Disable BH while while loading FPU registers
 in __fpu__restore_sig()
Message-ID: <20181119173135.sqxemqwfpuzszyfb@linutronix.de>
References: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de>
 <b8684952-69ab-d79d-7fc0-89c0f4745049@intel.com>
 <20181119171128.2lxnhga3pym2zlok@linutronix.de>
 <20181119172743.GE14688@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181119172743.GE14688@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-19 18:27:43 [+0100], Borislav Petkov wrote:
> On Mon, Nov 19, 2018 at 06:11:29PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2018-11-19 09:02:45 [-0800], Dave Hansen wrote:
> > > On 11/19/18 8:04 AM, Sebastian Andrzej Siewior wrote:
> > > > v1…v2: A more verbose commit as message.
> > > 
> > > I was really hoping for code comments. :)
> > 
> > I though we agreed to make those in the larger series because those
> > comments in __fpu__restore_sig() would be removed anyway (as part of the
> > series).
> 
> Also, over local_bh_disable() does not really fit as this is generic
> code and Sebastian said ARM does the whole thing a bit differently, for
> one.
> 
> We probably should put that comment somewhere prominent in
> arch/x86/kernel/fpu/core.c or similar - somewhere people poking at FPU
> stuff will see it.

I though about __fpregs_changes_begin() in the last patch of the commit:
 https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/commit/?h=x86_fpu_rtu_v4

Sebastian
