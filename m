Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF62C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E80320844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfBEKIY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:08:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58659 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfBEKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:08:24 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gqxeK-0001zn-84; Tue, 05 Feb 2019 11:08:16 +0100
Date:   Tue, 5 Feb 2019 11:08:16 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 01/22] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20190205100653.2t6junknrf3g4qq7@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-2-bigeasy@linutronix.de>
 <20190114162400.GN2773@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190114162400.GN2773@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-14 17:24:00 [+0100], Borislav Petkov wrote:
> > @@ -315,40 +313,33 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
…
> > -			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
> > +			sanitize_restored_xstate(state, &env,
> > +						 xfeatures, fx_only);
> 
> Just let that one stick out - there are other lines in this file already
> longer than 80.
Didn't want to add more of these but okay.

> Notwithstanding, I don't see anything wrong with this patch.
> 
> Acked-by: Borislav Petkov <bp@suse.de>
Thanks.

Sebastian
