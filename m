Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F47C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F75F20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o95/UgPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F75F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeJVU20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:28:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36955 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:28:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so30156929lfa.4;
        Mon, 22 Oct 2018 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsC82Pn18BUvYoVQ5QXsun6v8FM5FlJT/C013tOgF/o=;
        b=o95/UgPCL/aOEAHxnH4pT3MX+nsaNMYrnY2r8RIiDUNzkw9up40ToPTBwiETpZ2ArN
         +Qr5wHwSyV2MRinPnD6LHJzfEyb1ZFA3lIc1AUR/RAENfj2yb/e4B24lsVe91Aalkix2
         CDRbb46yQrQ4a6Vz11WZOJDvDty7XPXUDuE+e0PeI639FpKmzUInOaMOQ8WMByTRic0d
         5W5Zf+DrYds2cFR/RYKgJEra1j7uR2bN5suqslt7NEKu/sgSVmO4Xqoop26XsyeEvDQ6
         Kkj6trFeg4P4iPQtJKY6QIwQOFvxShjD1Vl5uZhIjBC9bZQZk+XB2jtJCkyydlE5Hgu0
         d9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsC82Pn18BUvYoVQ5QXsun6v8FM5FlJT/C013tOgF/o=;
        b=nNt33b+NEsjcu13zrFCxRF3BNfscDjAO+V83JQpWG14XvmYml1rRCAFAETYEVFqWMt
         /RhRq6qtGF6sJRNzq8Q6Fca7IIRBc/RefbUjFGu/600X8fVtau6Tr7NJ/OK9SbxYwZqJ
         H8tPm+8B0yQhYkpf4KNY5tMqnNQbSIwFRt3ADyAvzvo0yPE0rLMqZzZ9OHeUtAHAfMBu
         IQaCgOD3CogMN2rYMFuBM4TxYfNYW1vb+sbrAv+8tV304kLFWjQPPJ1vYIE4bkM4sszt
         oliRWcFCVxdBXT3xlq2xv/BlU6+ZbqtGqB7Z1EF5BgxclgN3D99y0RS9KWni+rioXqzJ
         cYEQ==
X-Gm-Message-State: ABuFfoiQZxlVfs2/lY1UcTq9Gptfh6yqqFLupTB/9Ht4RZKpbsQTiQtg
        nP4+eEQxIl3VRCAZ1frje2WKgi6Ieg1YgRTpayE=
X-Google-Smtp-Source: ACcGV60+l+NGv/maCBg1VldmO5F8ahCEao/dzTaNxqIBtNpChkLeg11Fv8hCzFoey88KdSmWjDNCXBh62eKiQjGASEk=
X-Received: by 2002:a19:4e9a:: with SMTP id u26-v6mr8928414lfk.91.1540210205638;
 Mon, 22 Oct 2018 05:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181022120658.jm7dv7jiq7riuqci@ltop.local>
In-Reply-To: <20181022120658.jm7dv7jiq7riuqci@ltop.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 14:09:54 +0200
Message-ID: <CANiq72ncRcjZE-mgjXJwbggZ_Nr5dZuZc4AuayKEuh074CWjcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 2:07 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> >
> > While comment parsing is a good idea to deal with old codebases
> > that used such a comment as documentation for humans, the best
> > solution is to use the attribute:
> >
> >   * It is a "real" part of the AST (=> better for tooling).
>
> This will create a problem for the recent versions of sparse which
> support __has_attribute() because sparse falsely pretends to support
> this attribute while, to play nice with -Wdeclaration-after-statement,
> it needs some adaptation to the parsing (it's actually seen not as a
> statement but as a declaration).  I'll see to fix it this evening.

No rush Luc! (I have sent the PR to Linus without this two patches for
the moment).

And thanks a lot for having being so quick to improve sparse to
support all these series!

Cheers,
Miguel
