Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757AAC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C51320652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRigdheq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C51320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeJVSGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:06:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43816 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbeJVSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:06:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id r8-v6so36337731ljc.10;
        Mon, 22 Oct 2018 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXPI9oSyvoETFCtLgak03DHCOXgXMDfGGptay8CR9fs=;
        b=uRigdheqnC1vWPG45Te3/dwRBSgJC3jdIqZVkFLsL1UoDVPS76ZVU+ZkIRkE1MQA6L
         EcjiHwJeyo+7QrGMzyNQ9F1nU6Xfb7F7Hlnq0UbWfAfZqPIm1dMDxhQKoP0LL9Ph5XQm
         xUU/lW9ivUwPl/8fjQqmR/Ey38I0EBhv/FTbyC4no0SiuqF5r8cTLJUZoFBmeFXomUPd
         O4jyjr/lHXfDI7/oqNPL6vkODxCCAdb85MTQPrvcpLpSYRrT0UBJcc/VbAeTB6ZQG11X
         0vxcgjyGmV6Y0a/NqIR15HtY36h044W2bFW6HKlpHVDiTJsrANxUfNMW79zQ07kqJ09P
         dwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXPI9oSyvoETFCtLgak03DHCOXgXMDfGGptay8CR9fs=;
        b=XWIXjmzsviMN28iBkqbzuunQQd6d3fO06rXptCWmBxsj2s4OB6y2KOcPLxon3bQSNO
         dyVr4gHTkE5+5bEk9Eq3VgIDkIrfvXkRZD5DN16fD3jB0yT4RVi0mcOxCN9mHaCxGXFb
         JhTdWQxfsjjuirzW0aKU4Al700r7XDrMrhhnMtlD7JOne8TMU7GadGITtoNC2MEf7RCU
         AogoVv6uUDqsd0CT2Y0xzCVU/H8iGVR3Vw2Yz49hkxNscoA2JGC/2B/PGOiIuJ99V2H7
         ptmXhySc+fGYJMCpRZFkWoTjnMPzftXIVEE9iqo1yXYdkUmuYZmWiu6GA++QKDNXu4rl
         9Hyg==
X-Gm-Message-State: AGRZ1gKRRjNthHZmKjQd9YDJo1Xlxbrz0TtUyUWR0JHfdntBoF3aAR77
        MjzQADQ4xiVKSPwXxDhUnF2EYiNsuOFf4jIBbmQ=
X-Google-Smtp-Source: AJdET5fUYIBdmuS1nVF6+Mn09qklTjyJYipFHnVrBvRDbTsF3+aBN15GBfEXRuWoaiQY3CgNXXu+rtHEHZ/NZ1jIMkI=
X-Received: by 2002:a2e:501c:: with SMTP id e28-v6mr10745717ljb.45.1540201736218;
 Mon, 22 Oct 2018 02:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com> <20181021182926.GB6683@kroah.com>
In-Reply-To: <20181021182926.GB6683@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 11:48:44 +0200
Message-ID: <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
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

On Sun, Oct 21, 2018 at 8:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 21, 2018 at 07:14:12PM +0200, Miguel Ojeda wrote:
> > These are two patches are meant to go on top of the rest of the compiler
> > attributes series on:
> >
> >   https://github.com/ojeda/linux/tree/compiler-attributes
> >
> > which will be sent to Greg for the next merge window.
> >
> > Please review them and let me know! (specially if someone is against
> > __fallthrough for some reason :-).
>
> Will this work with all of the static tools that are currently looking
> for the comment instead?  I know coverity handles that, what about
> others?

Thank you Greg, good question. I will try to keep all the information
we can get about the tools in the commit message.

I will also contact the different tools about this.

Cheers,
Miguel
