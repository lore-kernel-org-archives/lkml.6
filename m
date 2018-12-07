Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB4C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFD020882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFD020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbeLGIRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:17:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGIRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:17:20 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gVBJx-00025W-F9; Fri, 07 Dec 2018 09:17:13 +0100
Date:   Fri, 7 Dec 2018 09:17:13 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 08/29] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20181207081712.dys7zeh546e2r3wn@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-9-bigeasy@linutronix.de>
 <20181206200722.GF3986@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206200722.GF3986@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 21:07:22 [+0100], Borislav Petkov wrote:
> > @@ -314,41 +312,34 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
> >  		 * thread's fpu state, reconstruct fxstate from the fsave
> >  		 * header. Validate and sanitize the copied state.
> >  		 */
> > +		union fpregs_state *state;
> > +		void *tmp;
> >  		struct user_i387_ia32_struct env;
> >  		int err = 0;
> 
> Sort those in reverse xmas order pls.
> 
> Otherwise looks ok.

You mean:
  		struct user_i387_ia32_struct env;
 +		union fpregs_state *state;
 +		void *tmp;
  		int err = 0;
?

Sebastian
