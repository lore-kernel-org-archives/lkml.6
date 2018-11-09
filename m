Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371B920855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuC5cBDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371B920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeKIRHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:07:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37101 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbeKIRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:07:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so989791wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 23:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=he5OLrPM5p8Pz8INsiwNs98UiU/UWU4QFyj70J33W/0=;
        b=IuC5cBDVcH1m+OiyJljq2wwKAFI12JP/zzQz2BfhJ6iUrPBKKODKmq864lAh8IyqbZ
         sOCAQ0SGj8EV+tbIVdwwqipnKa8tlnQ87kG0uarydChpIHN8rkWqBq2RID2vDA41F3VV
         twhA8AEPaWs31nxbYvhTZf272TtxzU82zKPgef88q9S3ORAoqEp7irAXsZgQk1BGNfrZ
         93oWsu40umrmMn4aXzMxf4FK1rP2UWDA04jolMd8zoOjFGTnpoprPrmYxHJozF/iMyHK
         bpocv+hN6RvKVTGsXwftVRL7BINi7yGSAC0MAtCMYE4xMER/uia4mr8GUrKStqD8g9VI
         s/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=he5OLrPM5p8Pz8INsiwNs98UiU/UWU4QFyj70J33W/0=;
        b=tVr/SZmXXo7nZDr7TlOldmGili0DWMiuWaPAxzlDeGR7ezOiwd/m1R2nF2Sg3hJDlg
         QrdDv1Ftf40g0WVefIXj3kP8S3rpD1YLALBPlE+ekCDJG919y+S9rSYg2LNE9/W+wE7B
         dPS6erV1e7zmBh+kRAAveTFKgLX5u7FaCn44AbdpwdmNCP7+N35MtMtVT7NhgydsS4ga
         pkGza8jOIs8LMXLoj13qcgLeJqECr31O4c8LNyX/7TQoSyLgGHSCKnrZtWNs17ffkZ+t
         3jumTdleVvDrYP2+02JvF/urNaAHP3g+he+8C1WNEsn9BVPfgVHftnXYMUVbukkpDBDE
         L3rA==
X-Gm-Message-State: AGRZ1gIdPhrUDSL01pMVt+/w2xp6PZKpeSjwJoopE/i9FB4GaImcdfES
        xnAXOKQNupMxxdPRyv0RG40=
X-Google-Smtp-Source: AJdET5djeJfiOPW2BgKhaGFETPkEmPoj5pKm7LSHS0HqN2vk3zedTSj44HouwpfDauE7+Qin74aK9w==
X-Received: by 2002:a1c:c142:: with SMTP id r63-v6mr3766025wmf.95.1541748494338;
        Thu, 08 Nov 2018 23:28:14 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g8-v6sm7023749wri.58.2018.11.08.23.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:28:13 -0800 (PST)
Date:   Fri, 9 Nov 2018 08:28:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181109072811.GB86700@gmail.com>
References: <cover.1541711457.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541711457.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> These patches are related to two similar patch sets from Ard and Steve:
> 
> - https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
> - https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org
> 
> The code is also heavily inspired by the jump label code, as some of the
> concepts are very similar.
> 
> There are three separate implementations, depending on what the arch
> supports:
> 
>   1) CONFIG_HAVE_STATIC_CALL_OPTIMIZED: patched call sites - requires
>      objtool and a small amount of arch code
>   
>   2) CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED: patched trampolines - requires
>      a small amount of arch code
>   
>   3) If no arch support, fall back to regular function pointers
> 
> 
> TODO:
> 
> - I'm not sure about the objtool approach.  Objtool is (currently)
>   x86-64 only, which means we have to use the "unoptimized" version
>   everywhere else.  I may experiment with a GCC plugin instead.

I'd prefer the objtool approach. It's a pretty reliable first-principles 
approach while GCC plugin would have to be replicated for Clang and any 
other compilers, etc.

> - Does this feature have much value without retpolines?  If not, should
>   we make it depend on retpolines somehow?

Paravirt patching, as you mention in your later reply?

> - Find some actual users of the interfaces (tracepoints? crypto?)

I'd be very happy with a demonstrated paravirt optimization already - 
i.e. seeing the before/after effect on the vmlinux with an x86 distro 
config.

All major Linux distributions enable CONFIG_PARAVIRT=y and 
CONFIG_PARAVIRT_XXL=y on x86 at the moment, so optimizing it away as much 
as possible in the 99.999% cases where it's not used is a primary 
concern.

All other usecases are bonus, but it would certainly be interesting to 
investigate the impact of using these APIs for tracing: that too is a 
feature enabled everywhere but utilized only by a small fraction of Linux 
users - so literally every single cycle or instruction saved or hot-path 
shortened is a major win.

Thanks,

	Ingo
