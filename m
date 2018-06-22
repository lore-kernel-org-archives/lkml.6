Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F337AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6A024672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEpN1x3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6A024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933521AbeFVRKb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:10:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37066 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeFVRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:10:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id y5-v6so3510464pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GK2Q+NuRcx7PRRD98mb1AIfMlpMOvjlQ4yLszHacTaI=;
        b=GEpN1x3EuBtF9A/Lg0XzOGFKpfBdPGhB2fymXoRsp4eJici+hz9UMrnVbxy0Gt/UcL
         6CMOjjdgyekGSVJ2px1w69uf3mcyBnDZ/CkczWbYLtaGghJITj0NVa44r5vxvArCYzm3
         o2aGK02sYARqKZ/1I8R6e1z6TMZHZPsaZZ3N7MWHuctIn1hor05l0K7nC3D3+v1moqcJ
         XbFmR18zaDgsGOp2gwM9eKrm+kSwkmXJlDe168jeMI6majrFtd/3+m2QZ0PYDomuF5rm
         c3NqDWOd/PfF/q///mg0qbGS6V6M/4sIKM/6u1HlAG+VQXdoRyo3q/fVkN9MJL8is0RO
         xsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GK2Q+NuRcx7PRRD98mb1AIfMlpMOvjlQ4yLszHacTaI=;
        b=m/jTdzDdjGaJFkZqauQi5Ftm/SWo9wczNRS6QionS7GMM5YlQ9QVg3nUhZWif0JDOS
         rEZNKkPAImcCGPWk9IVuDowr2VN1GpWjxXhJcYXSP4Vj8vagFH4aC0ZUZoUztGGtaFrJ
         FleP/FegLZEAkN459LbzKwLBc6lNYqk76EMboVAXCRU11x+P1JXboC/KvksJLl5WHiGz
         bHY8cBR/2Tftm1WWzd43/xjQhiEH3uoHGUuhj4348IFr+TmbhBZpXm8sPKALr5ZULf1k
         jA1wYueDdcTMo8nD5LjJIfnr73cTxpn99ajIxZ0iPdkcvzh3QtH7GkSXPg5hzawZzf53
         bdKw==
X-Gm-Message-State: APt69E0PeM7zCG3sYMyAZkJqI1CUZ/iA46Afiql8O1qp8WzFrn8Wwnfm
        mJedzgGHhNRf+BdMDeQtzu7jUeanR9l9SzY2uMIeEA==
X-Google-Smtp-Source: ADUXVKLsOZ3AZ66f1plz0mt1P1n8EvZFVC/+OYAMGNhDnT0536ypI5k6PokverbdB/YXAUbOtf6/WTOlRE9HQjLu0Dc=
X-Received: by 2002:a62:9945:: with SMTP id d66-v6mr2652475pfe.192.1529687427689;
 Fri, 22 Jun 2018 10:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180621162324.36656-1-ndesaulniers@google.com>
 <20180621162324.36656-4-ndesaulniers@google.com> <20180622022402.GA24194@gmail.com>
In-Reply-To: <20180622022402.GA24194@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 22 Jun 2018 10:10:16 -0700
Message-ID: <CAKwvOdn5gnB5cK=cy6weKyxAn4SNEdZTT_MtT_D_nHRG5EDZ4g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] x86: paravirt: make native_save_fl extern inline
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hpa@zytor.com,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 7:24 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > native_save_fl() is marked static inline, but by using it as
> > a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.
>
> > --- a/arch/x86/include/asm/irqflags.h
> > +++ b/arch/x86/include/asm/irqflags.h
> > @@ -13,7 +13,7 @@
> >   * Interrupt control:
> >   */
> >
> > -static inline unsigned long native_save_fl(void)
> > +extern inline unsigned long native_save_fl(void)
> >  {
> >       unsigned long flags;
> >
>
> What's the code generation effect of this on say a defconfig kernel vmlinux with
> paravirt enabled?

Starting with this patch set applied:
$ make CC=gcc-8 -j46
$ objdump -d vmlinux | grep native_save_fl --context=3
ffffffff81059140 <native_save_fl>:
ffffffff81059140: 9c                    pushfq
ffffffff81059141: 58                    pop    %rax
ffffffff81059142: c3                    retq
$ git checkout HEAD~3
$ make CC=gcc-8 -j46
$ objdump -d vmlinux | grep native_save_fl --context=3
ffffffff81079410 <native_save_fl>:
ffffffff81079410: 9c                    pushfq
ffffffff81079411: 58                    pop    %rax
ffffffff81079412: c3                    retq

Mainly, this is to prevent the compiler from adding a stack protector
to the outlined version, as the stack protector clobbers %rcx, but
paravirt expects %rcx to be preserved. More info can be found:
https://lkml.org/lkml/2018/5/24/1242--
Thanks,
~Nick Desaulniers
