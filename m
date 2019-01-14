Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31164C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05952086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGJNe2lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfANQHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:07:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45613 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfANQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:07:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so10322950plm.12;
        Mon, 14 Jan 2019 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+h1lzJes7KKjLhWN6tcanBpRno5ZRwwBz4+zRwLkCtI=;
        b=ZGJNe2lOzOp0XeX2Ok91XXVo23A7y4AuzC79cWQ/9tHsh251wOI3yCm0oj2E6re8bd
         hN4MnJbqLCVZO+z3aUmigi15Txycdhxfd00VJbKMq8nbCeEP5dHLHJdMsOSDBvvhltge
         eJQeIba4OtXvjvirJXoA4bkJ5TS3734uLzgxyyON4n4wZ2tA7XXd56c9Y09W0Z5w88lJ
         WMl20il65exhzVkXLTvKLbri0AQydVyMpxXFIqwQkw3QdmkwMxWMMKVk6rbHeAGt5s3K
         eX8l/Mr7FfHNtG9bGuJH+Is82QD0hcWpb3p4kvrJZomiQb7oS4OWiufB8o3OvesADMzz
         Uuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+h1lzJes7KKjLhWN6tcanBpRno5ZRwwBz4+zRwLkCtI=;
        b=mhQfOlu0alPrd8gdqFysVHGSWgZ22dggRtVV9dmEwxyMithgKHmoYtarqLmc6I3+5N
         0ImcgZGX84tl/d8YrSWCGIjM6J5fb+CFH3LBc9oKUfvTjRLJTltJFRCFuCJRRhfz4Gsk
         rXBFkgR2xYnoCsrWsUHVncoKFnHX7/EF/Sl2UtzU+oUKXAgVq0in5i9ZXzCT7NjgBPGK
         73qkJEYQGimeA3BE9RhH+22wxZN+1GRrUOfa74h/kyj281/6ouwk+p5ZzRX8dJBSvKtR
         ug+G7w8GbtQ7RhyV6JvY2/KZ8Ytvw/Jxxh53sXnwe9vEJ1xdWeXLDuABWAHC9/+WuWNu
         BBtQ==
X-Gm-Message-State: AJcUukd6NqW5lYt8mKilIeyFcEWFEuuHSwk+1tvLmL9WROAUzxLKB4bb
        7TU+w00aG0BCcDY0Yz7UG1I=
X-Google-Smtp-Source: ALg8bN73VzysWfFlrT+VyleX8zsqr66a7CwqQhbHUuPdJAnij9bArE5+ILz8dyKI/Sj8cFrEc5+MIw==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr15304165pld.147.1547482038271;
        Mon, 14 Jan 2019 08:07:18 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id w88sm2636832pfk.11.2019.01.14.08.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:07:17 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:07:16 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Changbin Du <changbin.du@gmail.com>, rostedt@goodmis.org,
        linux@armlinux.org.uk, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190114160715.vfswtf6pzisbhxb4@mail.google.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
 <20190114121151.GC10258@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114121151.GC10258@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 12:11:56PM +0000, Mark Rutland wrote:
> On Sat, Jan 12, 2019 at 02:57:01PM +0800, Changbin Du wrote:
> > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > default. When this option is enabled, fgraph tracer will show the return
> > value of each function. This is useful to find/analyze a original error
> > source in a call graph.
> > 
> > One limitation is that kernel doesn't know the prototype of functions. So
> > fgraph assumes all functions have a retvalue of type int. You must ignore
> > the value of *void* function. And if the retvalue looks like an error code
> > then both hexadecimal and decimal number are displayed.
> 
> This sounds more confusing than helpful, and it sounds like this has
> overlap with FTRACE_WITH_REGS functionality.
> 
Acctually this is similar to Return Probes. The kprobe has same
situation and it uses regs_return_value() to get retvalue. On x86 it is:
static inline long regs_return_value(struct pt_regs *regs)
{
	return PT_REGS_AX(regs);
}

on arm it is:
static inline long regs_return_value(struct pt_regs *regs)
{
        return regs->ARM_r0;
}
Due to lack of prototype info we cannot handle complex types.

FTRACE_WITH_REGS saves all general registers but here only one.
> > diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> > index 81b8eb5c4633..223f4ad269d4 100644
> > --- a/arch/arm64/kernel/entry-ftrace.S
> > +++ b/arch/arm64/kernel/entry-ftrace.S
> > @@ -202,6 +202,7 @@ ENTRY(return_to_handler)
> >  	stp x4, x5, [sp, #32]
> >  	stp x6, x7, [sp, #48]
> >  
> > +	mov	x1, x0			// return value
> >  	mov	x0, x29			//     parent's fp
> >  	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
> >  	mov	x30, x0			// restore the original return address
> 
> What about indirect return values? Those go via x8.
> 
> Additionally, in some cases (e.g. static functions with cross-function
> optimization), the compiler might not follow the usual PCS, so the
> return value might not be in x0 regardless. Maybe such functions aren't
> hooked by ftrace today?
I think these functions have been optimized out so ftrace will not trace
them.

> 
> Generally, I don't think that this is going to be reliable.
> 
> > +config HAVE_FTRACE_RETVAL
> > +	bool
> > +
> >  config HAVE_DYNAMIC_FTRACE
> >  	bool
> >  	help
> > @@ -160,6 +163,7 @@ config FUNCTION_GRAPH_TRACER
> >  	depends on HAVE_FUNCTION_GRAPH_TRACER
> >  	depends on FUNCTION_TRACER
> >  	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
> > +	select HAVE_FTRACE_RETVAL if (X86 || ARM)
> 
> ... but not arm64?
> 
> Thanks,
> Mark.

-- 
Thanks,
Changbin Du
