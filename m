Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915A7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444AA27E7E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="y/bcBWGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444AA27E7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937334AbeF2Ujp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:39:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55102 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936349AbeF2Ujm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:39:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so3372473wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0SuGM8blz8HcsIDoH86MI1r8RbSvlEjQap/IrEM9G40=;
        b=y/bcBWGHilUkhcag3XPrUpjIQ2FJXjMo/JXbmC/lwCvD9dCIy7Qk5BZMzRdCdFfZ8g
         wqEsv58SDeVPYwqNmHsLKxx10CfXI5dVOPEPimd04qv4A4yOSYj5jqJtDfcO8VaZQG99
         1GWp8bFZIhRMY0jDyoEMAspPIcJ5zTbhzcgtzoIBfsu0fvLbFwS1MRcF9F9attHs6G6b
         1F1zbkD1DDZq7CezaU0+HMtuxzZ/R+CuWTWdLguZZMsJYNLAGayRS79kUe428idbQAxp
         6F99IrVN+mxDHHkUo8rRp4EaDSyBrtwpblhnUfEzzaODguK1quTaL2zxVpk1welqXBXW
         pIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0SuGM8blz8HcsIDoH86MI1r8RbSvlEjQap/IrEM9G40=;
        b=ZyPrggfKPgZoZLtNUAGtd5TSdKdfKqsgGPanD3EemPDN6Zyx1vzWCzEjUW1vkmJqJm
         WDq+CFbE8qIL5T2K18Y3zMisJUAJsuRZ63FDX+R1QfKbi8VRJiTsSXt/jsDDST4EAzoq
         rWUfufMTz7AtRTVxdNP0uhuCMFDVGFLXDT+FVd5zUlxfEnVgEB/CPqqz2eZgSkE5CRSG
         eJVxYZV2bv302aqHCm5TnXin/nZNZc5mUefoLnmiQzN/iSo7xPPSLHVPeGXI2mdhFu/H
         SttdTMx2OEEKE7FxLRtGOPUa+90ui+6hc+j7GF4pKHbN5fvmfPruu6m/UZKNg4+31G19
         vawg==
X-Gm-Message-State: APt69E1F6uNVBCjzETod99f0pb2AHBe83qzf4lFCSdH3WDCMNiICDibf
        mEFpNxZrSTAAN0uRqYnl/acCPu1UJcSqPdOLdy1J+A==
X-Google-Smtp-Source: AAOMgpfaxkX2c46FLiUOIxulRO2jhNJXzYisvr8Mg0t2Co7dLI6c8YNHrbu2SsKxi6N8amQm1AWfmBmerbc8A+TygW8=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr2585851wmd.144.1530304780946;
 Fri, 29 Jun 2018 13:39:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:39:20
 -0700 (PDT)
In-Reply-To: <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com>
 <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com>
 <729451355.9702.1530284622326.JavaMail.zimbra@efficios.com>
 <CA+55aFw==YnFJn7iGnKMW=RbPT74YHNa0QDF96mEdMPA2oX9SA@mail.gmail.com>
 <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
 <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
 <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com> <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 29 Jun 2018 13:39:20 -0700
Message-ID: <CALCETrXqjrCoHX1KyL0iKGBaAZSGJb1cVdNN1gNigJ8DW9LF8w@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:48 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> There are two aspects I'm concerned about here:
>
> 1) security: we don't want 32-bit user-space to feed a 64-bit value over 4GB
>    as abort_ip that may end up causing OOPSes on architectures that would
>    lack proper validation of those values on return to userspace.

I'm not too worried about this.  As long as you're doing it from
signal-delivery context (which you are AFAICT) you're fine.

But I re-read the code and I think I have a really straightforward
solution.  Two choices:

(1) Change instruction_pointer_set() to return an error code if the
address passed in is garbage in a way that could cause unexpected
behavior (like >=2^32 on x86_64 if regs->cs is 32-bit).  It has very
very few callers.

(2) Add instruction_pointer_validate() to go along with
instruction_pointer_set().

That should be enough to solve the problem, right?
