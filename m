Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C62BC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F290D20666
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8GRaYJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F290D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeI3RqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:46:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38493 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeI3RqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:46:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so663748qtf.5;
        Sun, 30 Sep 2018 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZc4TX06dDpgdIGafOY81Qt0PHB7lsXPf/GX6Jhu2zY=;
        b=c8GRaYJdQFuMRErsPrmrZlLaGJV03+QmqR21s+Jgw34s73qjupJ5zmo7Qhw2FcqbA+
         O4J29cASVGg2ubkLBl0uZmhv195ZGWg6jbe1sk5GlKVwo5hcLrbNPxSBX7ESiJSOEYAm
         3dXIbt1IaHD6Sc18K91VynXZ4vNRZvhjl0/DmXpX49HQoH2Vh80/Gim2q5q+4qsehFfD
         V9LtyPxPlNG2trxxn+9NK1AytY5V7IvF0cbddOV1HMc8bOsrhKZPgSV5fa/5ANxT/LRq
         Zp1hsd2Jfdj2BQot6safwuRHefoseEID/mLKsB6BOSHsk9ujpwPWSOAD0pBESv+pqz+s
         343A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZc4TX06dDpgdIGafOY81Qt0PHB7lsXPf/GX6Jhu2zY=;
        b=idNs8ix4taZob2MMkIitAG8zjKXFwTlTIIvRjugTgKvxB30UiUz9/YUPhYTu17hT3+
         vxidhU9bI2/oIXFYt/PwWlrS/0l45jPCrm5NVB4+1JmXyrXTiSClbP80qkJL+CTHsc/l
         IJOHNozEgcZYb9eo3TPYATwKvkqbt81yjkP+tDUZJcQwcX4V0DYlTQazcAvJw4YOzqFo
         U6kHlNRmWGCWFT8BFXr4QyrqJFAONMD8EKkTw5jBZAqvVefmE16DQNLcpOF5NEkZtyMc
         19l5C9BloG41FxsmMXZK7bexvWrn/MfROa0QiJ9TIwPatuTqyP6SYhjCJ2yF/QhxVxP0
         p4jg==
X-Gm-Message-State: ABuFfogB3OwFdv0zxuOPTzHRhSfS4/W8VBZuzPrgBBNKlhqwsD9xPNU7
        9a6IK67yXa3Kx3h6eHoL2gkwTMDv36zn+pA140c=
X-Google-Smtp-Source: ACcGV60n8I/ed+nUdMh3xOjlW1TUMi1xSMVnersLGbvq9RagpzFdkdcwz8Ec/t6mXgWxp0BkEc368yU0Gt+ftNFIHnA=
X-Received: by 2002:ac8:435b:: with SMTP id a27-v6mr4719883qtn.295.1538306027553;
 Sun, 30 Sep 2018 04:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com> <20180924143608.aiyehiibgc7isk7k@ltop.local>
In-Reply-To: <20180924143608.aiyehiibgc7isk7k@ltop.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 30 Sep 2018 13:13:36 +0200
Message-ID: <CANiq72=Aom+D8LsvMDgD3Am9n3DH13CzZKuL3dfanyqFEGyNbA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] Compiler Attributes
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Mon, Sep 24, 2018 at 4:36 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, Sep 20, 2018 at 07:22:46PM +0200, Miguel Ojeda wrote:
> > The Compiler Attributes series is an effort to disentangle
> > the include/linux/compiler*.h headers and bring them up to date.
> >
> > The main idea behind the series is to use feature checking macros
> > (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
> > which are compiler-agnostic (so they can be shared, reducing the size
> > of compiler-specific headers) and version-agnostic.
> >
> > Other related improvements have been performed in the headers as well,
> > which on top of the use of __has_attribute it has amounted to a significant
> > simplification of these headers (e.g. GCC_VERSION is now only guarding 4
> > non-attribute macros).
> >
> > This series should also help the efforts to support compiling the kernel
> > with clang and icc. A fair amount of documentation and comments have also
> > been added, clarified or removed; and the headers are now more readable,
> > which should help kernel developers in general.
> >
> > The series was triggered due to the move to gcc >= 4.6. In turn, this series
> > has also triggered Sparse to gain the ability to recognize __has_attribute
> > on its own.
> >
> > Finally, the nonstring variable attribute series has been applied on top
> > of this one.
>
> Hi Miguel,
> Feel free to add my
>   Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> on patches 11-15 (I think the others ones already have it).
>

Done for both Nick and you!

Cheers,
Miguel
