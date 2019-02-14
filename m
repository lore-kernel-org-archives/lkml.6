Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7283BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4310E2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390741AbfBNOwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:52:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49998 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfBNOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:03 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1guIMj-00019c-Uy; Thu, 14 Feb 2019 15:51:54 +0100
Date:   Thu, 14 Feb 2019 15:51:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 09/22] x86/fpu: Add (__)make_fpregs_active helpers
Message-ID: <20190214145153.oeqlocjwqeaedlvq@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-10-bigeasy@linutronix.de>
 <20190128182349.GG20487@zn.tnic>
 <20190207104325.ai5fzaxa7xy7yydv@linutronix.de>
 <20190213093025.GA9683@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190213093025.GA9683@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13 10:30:25 [+0100], Borislav Petkov wrote:
> On Thu, Feb 07, 2019 at 11:43:25AM +0100, Sebastian Andrzej Siewior wrote:
> > They are accessible inside the region. But they should not be touched by
> > context switch code (and later BH).
> > Is that what you meant?
> 
> I just don't like that "changes" name. So when called, those functions
> practically lock the FPU regs from being accessed by others. So with
> 
> fpregs_lock
> fpregs_unlock
> 
> for example, is kinda clear what's going on and you don't have to wonder
> what it does.

renamed as suggested.

Sebastian
