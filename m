Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E07CC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC621927
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMTaq1ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404343AbfBNOKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:10:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39965 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388106AbfBNOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:10:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so3126235pgp.7;
        Thu, 14 Feb 2019 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mY+z/AeiiAmWbPq5MVqs39K4/GRfaZOUFKBM2IDJJg=;
        b=TMTaq1ed+CKAyuFiIH9Lwluwx9WvGZuApMPwVUxAwE6VdW+0QigCsYv8lnKRUMAIpN
         QQHEYZfOZY9D4rU8fcsSozxR6aG4KpYJkTC5I27K7dFhWm8WTSJ7OVJMZjgaCx3bJzqD
         nAFQUPm5kgsE69b7xOqPYDWAL9qxf89j8Xf1SthYQmBtWGVfksSCLbAI9ONjRHkKmZmx
         0JoMeYUOAqZEq1wNMmvEGIMlgubIiHvL5ssvl0QIc0TbCr1k+XioZZ/hHbSb4vSGbn0H
         lufCh3LrR13qIrM9joBYplK3XTH4gkToyHhAhwPtGXvEUTWGsKwiwed069boutaLEnUg
         hTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mY+z/AeiiAmWbPq5MVqs39K4/GRfaZOUFKBM2IDJJg=;
        b=iPTj3WWE1SFgvQDEwLYQ7/EsACc42F+DeRX4xEf50Q1DF9jNkkAahpRdS7++BjBK3T
         6KgdaBG/jE+NWYBEZFJre8iEfKg4BjYpkHQjeUPzQLpdinTyxqqZrPVTY7tIdf2+YSYl
         G+ywA8j5iAJ8+nuZKt4b0aCgMreIuBwdIKNV/wwq6Yz9/TjkeeUPBWhq3IlOGdi/fc3U
         TLvDGEaduh0RKd+EV+v4uWoFCS8a6xffgHkQ9XXHjTvGfLxkXurri/u4rV6qKVXKeHBl
         YOyuSJ2P0ACx0xWGsF+nSZb64Uwa12+ygDlE+OFdry77V5t81HHOjnzTKa+nR1KWmbRn
         sc4Q==
X-Gm-Message-State: AHQUAubCFoG0zGke1rZvBgYUN3XCrxWHDXem+6a4MF2fnu1rxZsnzeI6
        OdupCcSIUAxXSNWemrhBIXA=
X-Google-Smtp-Source: AHgI3IbOpgHdSepgSprh2urcyeVh/sst7DbV0akui10Lx6y2BT5RVyNbtzLsIlUcOpEhQzOU8etxXA==
X-Received: by 2002:a63:80c7:: with SMTP id j190mr81865pgd.357.1550153447112;
        Thu, 14 Feb 2019 06:10:47 -0800 (PST)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id e21sm10584608pfh.45.2019.02.14.06.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 06:10:46 -0800 (PST)
Date:   Thu, 14 Feb 2019 14:10:44 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kprobe: safely access memory specified by userspace
Message-ID: <20190214141043.3j6upjrfmse75sma@mail.google.com>
References: <20190125151051.7381-1-changbin.du@gmail.com>
 <20190213143638.y54hghilbyastlpo@mail.google.com>
 <20190213104143.5c390b28@gandalf.local.home>
 <20190214000522.n7ltwbnjl3kufdsn@mail.google.com>
 <20190214080418.0f12923f@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214080418.0f12923f@vmware.local.home>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:04:18AM -0500, Steven Rostedt wrote:
> On Thu, 14 Feb 2019 08:05:24 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > On Wed, Feb 13, 2019 at 10:41:43AM -0500, Steven Rostedt wrote:
> > > On Wed, 13 Feb 2019 22:36:40 +0800
> > > Changbin Du <changbin.du@gmail.com> wrote:
> > >   
> > > > Hi Steven,
> > > > I think this is a critical issue. Could you give priority to this fix?
> > > > 
> > > > On Fri, Jan 25, 2019 at 11:10:50PM +0800, Changbin Du wrote:  
> > > > > The userspace can ask kprobe to intercept strings at any memory address,
> > > > > including invalid kernel address. In this case, fetch_store_strlen()
> > > > > would crash since it uses general usercopy function.
> > > > > 
> > > > > For example, we can crash the kernel by doing something as below:
> > > > > 
> > > > > $ sudo kprobe 'p:do_sys_open +0(+0(%si)):string'  
> > > 
> > > Note, I'm not able to reproduce this.
> > > 
> > > I just get:
> > > 
> > >         sendmail-1085  [001] ....   277.344573: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1550  [003] ....   279.879011: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1550  [003] ....   279.879056: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1550  [003] ....   279.879079: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1550  [003] ....   279.879132: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1550  [003] ....   279.879683: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1550  [003] ....   279.881521: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1550  [003] ....   279.881541: open: (do_sys_open+0x0/0x210) arg1=""
> > >            <...>-1597  [005] ....   280.907662: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1597  [005] ....   280.907694: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1597  [005] ....   280.907772: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1597  [005] ....   280.907825: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1597  [005] ....   280.907891: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > >            <...>-1597  [005] ....   280.907947: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > > 
> > >   
> > > > > 
> > > > > [  103.620391] BUG: GPF in non-whitelisted uaccess (non-canonical address?)
> > > > > [  103.622104] general protection fault: 0000 [#1] SMP PTI
> > > > > [  103.623424] CPU: 10 PID: 1046 Comm: cat Not tainted 5.0.0-rc3-00130-gd73aba1-dirty #96
> > > > > [  103.625321] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-2-g628b2e6-dirty-20190104_103505-linux 04/01/2014
> > > > > [  103.628284] RIP: 0010:process_fetch_insn+0x1ab/0x4b0  
> > > 
> > > What line number is the RIP on?
> > >  
> > I still can reproduce this bug on mainline (1f947a7a011fcceb14cb912f5481a53b18f1879a).
> > But it seems your linux has already fix this issue.
> 
> 
> No I didn't have the fix. I was running an older kernel actually. One
> before commit 9da3f2b74054406f87dff7101a569217ffceb29b was added.
> There's nothing actually wrong with that code, since kprobes is allowed
> to poke at anything. But that commit considers the kernel using copy
> from user to poke kernel address space is a security bug.
> 
Glade to know that. And I wonder wether all such cases have been
disclosed. I noticed the uprobe code also uses some usercopy functions.

> So yeah, I agree your patch should be added with a stable tag, with a
> Fixes: with that commit, since that commit is what causes it to bug.
> 
> I'll apply it and start testing it.
> 
> -- Steve

-- 
Cheers,
Changbin Du
