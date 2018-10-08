Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F57C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B612086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX3DhbXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B612086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeJHNXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:23:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44024 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:23:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so19353687wrt.10;
        Sun, 07 Oct 2018 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MNPVj+A/IaZ7n9FRa9xC3L12i3eMs0Se4OmDXxEJ8xA=;
        b=pX3DhbXzt/iP5uDIOGjZUe5fL/BkB2L79dmdhnJ9ZqgQYYbHvCmrFpD4Ob9srycAZ6
         925g6v0UDEGafmBHSgWI0M+cJepNBUe37HoBmq0W44CfVJJPIxHIrXk/fVGqIwfoUccO
         CJVNvkEowp+tqAoMA4YVj+EmE85f2cxf9Ii/13bSe8LwsMczHN9x0NoMAMurqx8+NjLC
         NJxsf85E1i9UkMHvQonTLnupKmRvkHxAmLQ7I7gl3mQtbNlkIJ9choDRZu/I+FTpoHZn
         XqIJBJbhws9vDpkwFmkNHG24dV040JGpnGrd2KU+PdlP/+KqBHJB6Q9mZlUwL+TGoZ3W
         hnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MNPVj+A/IaZ7n9FRa9xC3L12i3eMs0Se4OmDXxEJ8xA=;
        b=AkwjjzLw4z8RkjPJUASfvfLkJpG1pU4BclWFZ5tUwpna2zg5fzJiD3ROW1Z0NkydIh
         u/6t2P+iC+PRF3INkoeJsYRGliQmW6koVTmPmLQOibNbU7SW+VaCig3Vh92gllUMfnwG
         gPZLDfTCJJpvZLCSbQ8C+sQk/sdybZnyvP66+bBxdwVoVXjRs9npLWaLo46Ni7OBrYpt
         8Yx55mQC/+jvNBEcvjxEwe9i4SBFP+IBkjbp6mpXSkUHQAmoEK+4oi8kCiIlA7WcXbnb
         qJ9lSi3LGV0JHWmNbhGX9CJj1DZrTQR5793Wld/F26reUpuHn81/NhZ9aRjw7J4Ov2QG
         kroQ==
X-Gm-Message-State: ABuFfoh98bsZMRjm47pEsP1kDovSvyKrDBMsXZCBCm3DymgPVfCmCA3G
        8J5Tx6PHg9pAXcOSD3FQ9vY=
X-Google-Smtp-Source: ACcGV61UNTPt4eebMka9o1w3uVQZTo/EwYL5ARuz3rQIBr0t5oWy9Kz7Ri0WgyBe91EzQGU56Wn0xQ==
X-Received: by 2002:a5d:6b4f:: with SMTP id x15-v6mr12937047wrw.304.1538979207114;
        Sun, 07 Oct 2018 23:13:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v106-v6sm26954117wrc.85.2018.10.07.23.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 23:13:26 -0700 (PDT)
Date:   Mon, 8 Oct 2018 08:13:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Michael Matz <matz@suse.de>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org,
        Richard Biener <rguenther@suse.de>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181008061323.GB66819@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael Matz <matz@suse.de> wrote:

> (without an built-in assembler which hopefully noone proposes).

There are disadvantages (the main one is having to implement it), but a built-in assembler has 
numerous advantages as well:

 - Better optimizations: for example -Os could more accurately estimate true instruction size.

 - Better inlining: as the examples in this thread are showing.

 - Better padding/alignment: right now GCC has no notion about the precise cache layout of the 
   assembly code it generates and the code alignment options it has are crude. It got away with 
   this so far because the x86 rule of thumb is that dense code is usually the right choice.

 - Better compiler performance: it would be faster as well to immediately emit assembly
   instructions, just like GCC's preprocessor library use speeds up compilation *significantly*
   instead of creating a separate preprocessor task.

 - Better future integration of assembly blocks: GCC could begin to actually understand the 
   assembly statements in inline asm and allow more user-friendly extensions to its 
   historically complex and difficult to master inline asm syntax.

I mean, it's a fact that the GNU project has *already* defined their own assembly syntax which 
departs from decades old platform assembly syntax - and how the assembler is called by the 
compiler is basically an implementation detail, not a conceptual choice. The random 
multi-process unidirectional assembler choice of the past should not be treated as orthodoxy.

Thanks,

	Ingo
