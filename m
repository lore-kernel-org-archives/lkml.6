Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9VpOIwlmGVuNDAAAmS7hNA
	; Thu, 07 Jun 2018 17:06:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 34170606DD; Thu,  7 Jun 2018 17:06:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a+luCEay"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A5B2260290;
	Thu,  7 Jun 2018 17:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5B2260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934985AbeFGRGp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:06:45 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46057 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934919AbeFGRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:06:43 -0400
Received: by mail-io0-f196.google.com with SMTP id l25-v6so12627091ioh.12;
        Thu, 07 Jun 2018 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twx02lUPIhvylaveOv8VYkaG1r2AoNAxI+osMUTMksc=;
        b=a+luCEayH0Wlcm8rEv7HTEoUxZ847J0ndGJbbbQd/R4avLctFdoBjv0LRhyeAVN74m
         vaql0dbd9lO8bDH3z+obp3YhHYHnzBCVagONfojuegRP0w0ub9aAgv0XOX0zFSnYEd4Q
         PuTEzouKzL+qKKx46+UmLzjeXRD7yGVrtuAvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twx02lUPIhvylaveOv8VYkaG1r2AoNAxI+osMUTMksc=;
        b=OP0XtoK7E86gIOtzNid75fwYwxYw2YPON6D17kh7zaFc353FlqzLbSq0RS80A6l1cK
         /bYc8zRPIpVzOCeCxKYp91z4PaObFg4bhspu+RUCV93EFTeVYNh6ihHb6zVSNJUM0Mbi
         6G4XbXb9ZcEzxsICBmLYuT+O1CxoBMLnRHdxQB9zEOGOJH38NqK7mxGmQ6naggH92PMl
         Im2XrdA/3V5Qeit9U5nNP+rHg1ilEQhbUWqdGG9nzFoDxy9KE7bR0NpguWNndiEBlavc
         QybbN7C6o3gbUDYbnMBn4td+8rik2MtVjmzRERBT1eBtHNPq91fnr/x/FSc5FtQL761R
         1znA==
X-Gm-Message-State: APt69E21pzgDbP1eHUm6aFQZs55gAyjh//pMR803P3YId9a+SZFWV1Ax
        +btDEXFPku3RV6WN2XFt/CUZlbGACgKfQIkYHTQ=
X-Google-Smtp-Source: ADUXVKKVfRGThhRHAZgEgNuo1+CVGhDtlChv1X4pyXMa2MrPXPUZJQDMCe7bTssTN2dMkciwPRGDXH9GnR8TEKVfspo=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr2471596ion.259.1528391202381;
 Thu, 07 Jun 2018 10:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1806061223560.1579@nanos.tec.linutronix.de> <152838798950.14521.4893346294059739135.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152838798950.14521.4893346294059739135.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Jun 2018 10:06:31 -0700
Message-ID: <CA+55aFyp1xYWomHUHhSv0habEVDXLMOKB_uJnRUSmoVt6SitRQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/spectre_v1: Disable compiler optimizations over array_index_mask_nospec()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 9:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Mark notes that gcc optimization passes have the potential to elide
> necessary invocations of this instruction sequence, so mark the asm
> volatile.

Ack. I'm not entirely sure this matters much, but it certainly isn't
wrong either.

The reason I'm not 100% convinced this matters is that gcc can *still*
mess things up for us by simply adding conditionals elsewhere.

For example, let's say we write this:

    if (idx < foo) {
        idx = array_idx_nospec(idx, foo);
        do_something(idx);
    } else {
        do_something_else();
    }

then everything is obviously fine, right? With the volatile on the
array_idx_nospec(), we're guaranteed to use the right reduced idx, and
there's only one user, so we're all good.

Except maybe do_something(idx) looks something like this:

    do_something(int idx)
    {
        do_something_else()
        access(idx);
    }

and gcc decides that "hey, I can combine the two do_something_else()
cases", and then generates code that is basically

    if (idx < foo)
        idx = array_idx_nospec(idx, foo);
    do_something_else();
    if (idx < foo)
        access(idx);

instead. And now we're back to the "first branch can be predicted
correctly, second branch can be mis-predicted".

Honestly, I don't really care, and I don't think the kernel _should_
care. I don't think this is a problem in practice. I'm just saying
that adding a "volatile" on array_idx_nospec() doesn't really
guarantee anything, since it's not a volatile over the whole relevant
sequence, only over that small part.

So I think the volatile is fine, but I really think it doesn't matter
either. We're not going to plug every theoretical hole, and I think
the hole that the volatile plugs is theoretical, not practical.

                      Linus
