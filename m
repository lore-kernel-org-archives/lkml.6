Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8420621476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAzeEQgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8420621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeJSBDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:03:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43199 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:03:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so15159866pff.10;
        Thu, 18 Oct 2018 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77GeRJFBJlE1tV/KEwIV6u9FdAYIwCOFSWKbfMNgFUY=;
        b=VAzeEQgW+tYp7oiG4XhQb7N/EWTi3WkD8AvLC00Tx+QdzDSNnVjdM2+nmEtn3IrA0W
         XZZzXAkZI1JJ8DAqJgxYxt7F6SHOCTAE6O2H4i61+6idEMU67Fx7NzQFZDOLYM22U3fq
         Z3uruTfDA92RKQZhECcFtsv2JLnUq1PZinDCQLcfC1u1OOOt8PXGEfR91Mu/sNr3MYLI
         IWw6YqaJjE3mOdUCZNmguYTf91WEG6Hh6d31J/N3clu2TZIZPjCFBDwQPLJFL7AAJtZb
         iVE4+7ICcL5LFJboo1vctGjQbWfUFWulR6Q+c3Ij2dZ4pYtfHqs1MB/lAPdN3oYF+5PW
         LSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77GeRJFBJlE1tV/KEwIV6u9FdAYIwCOFSWKbfMNgFUY=;
        b=J8UhIOJtMcS+rKMK/ws4ZzI4noF6cEmuEuc3OCty/at2Bd1F0y0kVZDmK1UrCVXr/x
         u+MpgDfxf0j06TkRt950FVok52aRKs00d4u+knqM4qMnzSB1imBMLsH/M3yN1DOpzUTT
         80t+MBmHxhKA0LvuWZaXitfmA0mAVCCeovKU94+gnqVtznE06yYKZQwFMqplMPNCRJz9
         gUzbt8nDYKEjlw/qUUq+QrzhUh0uYJNfbIePWFYnH3tQMGJG0Xsh24i5/x1fuAKjZOul
         ZH7VBDJQ76wZeX/2t6yf8/G4Ns19NVVIJJycKmrgbFdBtBO1jBrEgHxUocJX/bTTYewL
         J64g==
X-Gm-Message-State: ABuFfohWufOZCXucdrhGfDI1DbFprRdZJK2U42wFcu2V526sKJzDnDKy
        wYnTcGP87T9jwwtSGNhO52o=
X-Google-Smtp-Source: ACcGV61X7cGZ9xXKKG6bu7EIl8JXwi1RN54uXHx37+PqApQaCcO2HF4HwOFTyZBTD11hYgguiReWLg==
X-Received: by 2002:a65:6204:: with SMTP id d4-v6mr28986991pgv.121.1539882112127;
        Thu, 18 Oct 2018 10:01:52 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id v189-v6sm27307462pfb.54.2018.10.18.10.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 10:01:51 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:01:49 +0000
From:   Du Changbin <changbin.du@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Du Changbin <changbin.du@gmail.com>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com,
        linux@armlinux.org.uk, akpm@linux-foundation.org,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Changbin Du <changbin.du@intel.com>,
        linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] kernel hacking: new config NO_AUTO_INLINE to disable
 compiler auto-inline optimizations
Message-ID: <20181018170148.47zbtfno5cjh4wb6@mail.google.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
 <20181018162548.6399-3-changbin.du@gmail.com>
 <62bcdf3d-87be-407f-b971-5a53dbb1e4b8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bcdf3d-87be-407f-b971-5a53dbb1e4b8@arm.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:57:56PM +0100, Robin Murphy wrote:
> On 18/10/18 17:25, Du Changbin wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> > this option will prevent the compiler from optimizing the kernel by
> > auto-inlining functions not marked with the inline keyword.
> > 
> > With this option, only functions explicitly marked with "inline" will
> > be inlined. This will allow the function tracer to trace more functions
> > because it only traces functions that the compiler has not inlined.
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >   Makefile          |  6 ++++++
> >   lib/Kconfig.debug | 25 +++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+)
> > 
> > diff --git a/Makefile b/Makefile
> > index e8b599b4dcde..757d6507cb5c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -749,6 +749,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
> >   		   $(call cc-option,-fno-var-tracking)
> >   endif
> > +ifdef CONFIG_NO_AUTO_INLINE
> > +KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
> > +		   $(call cc-option, -fno-inline-small-functions) \
> > +		   $(call cc-option, -fno-inline-functions-called-once)
> > +endif
> > +
> >   ifdef CONFIG_FUNCTION_TRACER
> >   ifdef CONFIG_FTRACE_MCOUNT_RECORD
> >     # gcc 5 supports generating the mcount tables directly
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 4966c4fbe7f7..0f9b4fa78b1c 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -211,6 +211,31 @@ config GDB_SCRIPTS
> >   	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
> >   	  for further details.
> > +config NO_AUTO_INLINE
> > +	bool "Disable compiler auto-inline optimizations"
> > +	help
> > +	  This will prevent the compiler from optimizing the kernel by
> > +	  auto-inlining functions not marked with the inline keyword.
> > +	  With this option, only functions explicitly marked with
> > +	  "inline" will be inlined. This will allow the function tracer
> > +	  to trace more functions because it only traces functions that
> > +	  the compiler has not inlined.
> > +
> > +	  Enabling this function can help debugging a kernel if using
> > +	  the function tracer. But it can also change how the kernel
> > +	  works, because inlining functions may change the timing,
> > +	  which could make it difficult while debugging race conditions.
> > +
> > +	  If unsure, select N.
> > +
> > +config ENABLE_WARN_DEPRECATED
> 
> This part doesn't look like it belongs in this patch, and judging by the
> commit message in 771c035372a0 wouldn't be welcome back anyway.
> 
opps, this is a rebasing mistake. Let me update it. Thanks.

> Robin.
> 
> > +	bool "Enable __deprecated logic"
> > +	default y
> > +	help
> > +	  Enable the __deprecated logic in the kernel build.
> > +	  Disable this to suppress the "warning: 'foo' is deprecated
> > +	  (declared at kernel/power/somefile.c:1234)" messages.
> > +
> >   config ENABLE_MUST_CHECK
> >   	bool "Enable __must_check logic"
> >   	default y
> > 

-- 
Thanks,
Du Changbin
