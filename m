Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7DAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF72820811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sugds/DP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBHFlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:41:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46877 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBHFlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:41:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so1750244edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 21:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=56vBsUj6S8VeV1+1haZ1yV+gC1eDecm4i5Yq/vJ7M3U=;
        b=Sugds/DPenjs7p+LNtJf+TDTCzXjF3/kDvbP64ht1hxPyugNKgj8JtW4B98tKESQNh
         LQnwheIMVQEKZ+1oxdiaH2v97eK+xEehNUAR6b1mgY+lXt7Yz1uNJo6IRvmFn3GyEYC6
         /qcpLdDvdyUAmhWTGby2yfyjbj50GkYWJqw2o+kwp7Cbn5uwVwQCmrivGg8uW5zEBQWK
         rVCT/XZusjsr3+sGoTfRF/1nn9l5uwFdrck4RVbQkEjXB3tZgvkzx+zgxDwIZsKWSd14
         Gkk9F12puvXkwNuYN33/y9Rh7oTSMTCtHPSihLbvtElvh1p6iUVBxEzGWVaZbtNjFhn+
         j7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=56vBsUj6S8VeV1+1haZ1yV+gC1eDecm4i5Yq/vJ7M3U=;
        b=ZDIWuHPe0mJhw9acbXiqjH+hyo4OtMjuvuW7fjhLqtDmlxmPvBYtkBFn4IxGndpYqI
         9ITrRqu6RiQ9kqgodmNH5arSZr/4lOaxzcOHUmhG/FMhS+UFm6cML496DFwdg21US/g0
         yL7RvAr+iP4BSykH7dbJ3MVROkhumGxdaGVQ+wC1z0uLsSiqt5YdHn+FyX04M+9AT+1j
         0sEZLaXkT2BqdapymxWMKB04sMKXk3BlqpNiHf+u0HeuEK8VQAyZWQl3/WfvwqvDkfd8
         qPZjzTt7uwG5gzRw88U/Fp/WlYoimmbHdxCxy8plwvr7p3WZUIPOdl5deZCOHvhPUtrI
         L5yg==
X-Gm-Message-State: AHQUAualmYbO+IGQi4yNg6Z1RY+vXGwaVILPJOo8h92qOTMTqmgaDL95
        BmwdmANH70q/cJCNOwd8+hY=
X-Google-Smtp-Source: AHgI3IaFINuHC5Lt+pA4CiAva67HE0mKJo3MxWhhfu4Bpg7xQ47anodq0EV8oB4nqJ2qD4q2JSJ7qw==
X-Received: by 2002:a05:6402:1646:: with SMTP id s6mr5738593edx.156.1549604510558;
        Thu, 07 Feb 2019 21:41:50 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l41sm344954eda.83.2019.02.07.21.41.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 21:41:49 -0800 (PST)
Date:   Thu, 7 Feb 2019 22:41:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     ndesaulniers@google.com,
        yamada masahiro <yamada.masahiro@socionext.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] init/Kconfig: add config support for detecting linker
Message-ID: <20190208054147.GB9647@archlinux-ryzen>
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <563751355.221.1549587440037.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563751355.221.1549587440037.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 07:57:20PM -0500, Mathieu Desnoyers wrote:
> 
> ----- ndesaulniers@google.com wrote:
> > Similar to how we differentiate between CONFIG_CC_IS_GCC and
> > CONFIG_CC_IS_CLANG, add CONFIG_LD_IS_BFD, CONFIG_LD_IS_GOLD, and
> > CONFIG_LD_IS_LLD.
> > 
> > This simiplifies patches to Makefiles that need to do different things
> > for different linkers.
> 

Hi Mathieu,

> What guarantees that the linker used for e.g. make defconfig is the same linker used for make ?
> 
> Is it required with this patch ?
> 

The build system ensures that the compiler (and after this patch, the
linker) config values are correct before compiling (and prompting the
user for the new choices that are available to them in that case).

For example:

$ make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- defconfig
...

$ rg "CONFIG_CC_IS|CONFIG_LD_IS" .config
10:CONFIG_CC_IS_CLANG=y
12:CONFIG_LD_IS_BFD=y

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LD=ld.lld
scripts/kconfig/conf  --syncconfig Kconfig
*
* Restart config...
*
*
* General architecture-dependent options
*
Kprobes (KPROBES) [N/y/?] n
Optimize very unlikely/likely branches (JUMP_LABEL) [N/y/?] (NEW)
Stack Protector buffer overflow detection (STACKPROTECTOR) [Y/n/?] y
  Strong Stack Protector (STACKPROTECTOR_STRONG) [Y/n/?] y
Use a virtually-mapped stack (VMAP_STACK) [Y/n/?] y
Perform full reference count validation at the expense of speed (REFCOUNT_FULL) [Y/?] y
*
* GCC plugins
*
GCC plugins (GCC_PLUGINS) [N/y/?] (NEW)
...

$ rg "CONFIG_CC_IS|CONFIG_LD_IS" .config
9:CONFIG_CC_IS_GCC=y
13:CONFIG_LD_IS_LLD=y

> How does it work in a cross compile environment ?
> 

Since $(LD) is defined based on $(CROSS_COMPILE), it should work fine.
I tested it with both arm64 and x86_64 and CONFIG_LD_IS_BFD gets
set by default and I can see CONFIG_LD_IS_GOLD get set with both
LD=aarch64-linux-gnu-ld.gold and LD=ld.gold.

If I misunderstood the questions or my explanation wasn't correct,
please let me know!

Cheers,
Nathan

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > Cc: Nathan Chancellor <natechancellor@gmail.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  init/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/init/Kconfig b/init/Kconfig
> > index c9386a365eea..b6046dcf7794 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -26,6 +26,15 @@ config CLANG_VERSION
> >  config CC_HAS_ASM_GOTO
> >  	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> >  
> > +config LD_IS_BFD
> > +	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU ld')
> > +
> > +config LD_IS_GOLD
> > +	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU gold')
> > +
> > +config LD_IS_LLD
> > +	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'LLD')
> > +
> >  config CONSTRUCTORS
> >  	bool
> >  	depends on !UML
> > -- 
> > 2.20.1.791.gb4d0f1c61a-goog
> > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
