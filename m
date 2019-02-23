Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F49C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3F720651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uK12fADw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfBWAEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:04:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36694 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfBWAEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:04:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so1821071pgr.3;
        Fri, 22 Feb 2019 16:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PPKvJeHul2CIVflz1zoXBKQwuaRmtZB1Hx+W/mF2zpQ=;
        b=uK12fADweZxkpB8M3noFAl6YpY+9+EsQTHnBpca7xSg48l+xvrzwZoJ1FgE3ytaWRF
         IGcTuON4FrPil6+x6z9/0Gt4IVvoO3RVu9fbRMC7AEadkVMbkQQJYFMXXdqD/I3SEQGX
         PmgdTLFq8vjlqpdKOpcCMjF7IxzsuI+A+coZ2KmV5MMJhp4OXd1yV32tGW8kCfMollL3
         wYnxwHVJylZQxiIj23u22L3c+wCv3f8M9aCdGo5PecI+WwIp4W5111j4Od9gUIg0DVt7
         /d2Kcw8C1GUNg+2tPvf83xkOhWSXSFimSLRutnfBVfJUb7fqXxeJFb7ltLKtGmGEC2jh
         uKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPKvJeHul2CIVflz1zoXBKQwuaRmtZB1Hx+W/mF2zpQ=;
        b=BZAsxLEueAAzF2VQvsSRzMJUYRLS0bhsWqPX9TH1tnfcvL5BvUgbuVjAUdcWaF97nI
         FqwUZvxFXX9N588i4PV37Xqaszsth8vURHFcqLgl642r1UftW2e9qv8wGJuhV5GDlkp7
         K0eXWDW742HLKBJFZ4Szj76WRW/ilIDAGAwTIK0rtxfhkihouNTIOi9FnqwI75M1x/sK
         A5Th8V9BrIMDCVoG549BbvIqjoI8CXJPDutg9wwa4QwSS831RvxSZK6VzZZSceh7o2se
         5+KLK8KZSTm9+cn0zaEDqdztLkLzzCU/BrjOq5N7orjzkKXbwxrs0wc7rEjTnq+L5tqr
         nWNA==
X-Gm-Message-State: AHQUAubZ7H+B6rksbNzs7BGtpn+Hl77/S6AkR/oE/TdGErP4zwaInLMS
        1bIjntfluY0cxJ+kErReHPM=
X-Google-Smtp-Source: AHgI3IZlKIB+g4uudKbYecqFs6ycQ3UKS2FRsWFkjMBF6LVOZrV8C9fuVcZ29JglIgjNDDOtWL27OQ==
X-Received: by 2002:a63:cf02:: with SMTP id j2mr6521495pgg.113.1550880238931;
        Fri, 22 Feb 2019 16:03:58 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id n6sm3056089pgv.86.2019.02.22.16.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:03:58 -0800 (PST)
Date:   Fri, 22 Feb 2019 16:03:56 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Nadav Amit <namit@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190223000355.wpmku2gu6cg3dklh@ast-mbp.dhcp.thefacebook.com>
References: <20190222143026.17d6f0f6@gandalf.local.home>
 <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
 <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net>
 <CAG48ez2tVwzhKPu1tvK+E52jUCq5vTwjssrtMaGuCO=kMpSXGw@mail.gmail.com>
 <0ED6836E-3432-4E1C-BABC-BEA6BDD36287@vmware.com>
 <CAG48ez10RH2YhQ0wnEDOpKoGjrociq+zK0En6Aq06Yg9W3o5aQ@mail.gmail.com>
 <7701651F-F10E-4212-925E-1CB77C5D3E69@vmware.com>
 <A7232EDD-C53C-4B7D-AD02-4A480F40538B@vmware.com>
 <CAG48ez1Dm04kg2x3O=OOmBFFBSDr+RmnhBYChcwYv5zLbPGudQ@mail.gmail.com>
 <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:59:30PM -0800, Andy Lutomirski wrote:
> >
> > A relatively simple approach might be to teach BPF not to run kprobe
> > programs and such in contexts where current->mm isn't the active mm?
> > Maybe using nmi_uaccess_okay(), or something like that? It looks like
> > perf_callchain_user() also already uses that. Except that a lot of
> > this code is x86-specific...
> 
> This sounds like exactly the right solution.  If you're running from
> some unknown context (like NMI or tracing), then you should check
> nmi_uaccess_okay().  I think we should just promote that to be a
> non-arch-specific function (that returns true by default) and check it
> the relevant bpf_probe_xyz() functions.
> 
> Alexei, does that seem reasonable?

yep. I think that should work.

