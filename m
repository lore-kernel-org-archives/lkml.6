Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE53EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5C621873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JkJ4OqhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeLSDUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:20:06 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37561 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSDUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:20:05 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wBJ3Jn7I000981;
        Wed, 19 Dec 2018 12:19:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wBJ3Jn7I000981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545189590;
        bh=jbzD7gXSWc0jcrnZlHzfxSB1UoeRXShjreO3QuG9/xM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JkJ4OqhBwDHQBNHIwpvGlrrblfEBqCt7Tx3QAnRFo6Jl2/6ZOFZruHgmtPBxIDHmL
         24ZdqtoZ6ia1GEv6n5fV6meaV9ZUKxePPsE+UM/h6mzPT2m0Ip7gq5uVcsIdQHdfvh
         TELgmEtRWTLKcIblW8Rz50d6Fe9ZZ1BvlVSBPe2jyETUMC0oaJ1D5t7zAFvHwoWmoo
         OtKV0IRR6EVMUeu2XKLy1H6iKPsBEpreRJTNL0fgOnPUcgVhmaAALnPzPzPVRswGnQ
         rilNJG0IYgeupLTzqAt4DkEAXAUb2sQcEN5K3QZ8k8iuCU6Bm01wl+n24OqP+1eXvc
         BgC96UEYeGxBw==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id v205so11393146vsc.3;
        Tue, 18 Dec 2018 19:19:50 -0800 (PST)
X-Gm-Message-State: AA+aEWYDO9HyrIFkRaWVmMCRmUiaG/wUBut+XvXrbXYvXQYIO6ZI2y2a
        W4WeOaUmdY9CYlub2Luu/klDw92BwG40S88KegI=
X-Google-Smtp-Source: AFSGD/XMEFbjbYdc+MPXZSDoPC5QiFqagzFPVKq2RxcNjRR4Io+SXhKN/TYl9iX0Rg+y6C4PhFOh3T6DccKsgGSDIOk=
X-Received: by 2002:a67:485:: with SMTP id 127mr9707272vse.54.1545189589084;
 Tue, 18 Dec 2018 19:19:49 -0800 (PST)
MIME-Version: 1.0
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com> <C6D4A9B6-EED6-4DF7-8085-B1D3D221D25A@vmware.com>
In-Reply-To: <C6D4A9B6-EED6-4DF7-8085-B1D3D221D25A@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Dec 2018 12:19:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-uayGwbzmvezVO1w6N4AJaLe07ctYt-P6VHQv3PczZw@mail.gmail.com>
Message-ID: <CAK7LNAR-uayGwbzmvezVO1w6N4AJaLe07ctYt-P6VHQv3PczZw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly code
To:     Nadav Amit <namit@vmware.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Alok Kataria <akataria@vmware.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 5:26 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Dec 17, 2018, at 8:03 AM, Masahiro Yamada <yamada.masahiro@socionext=
.com> wrote:
> >
> > This series reverts the in-kernel workarounds for inlining issues.
> >
> > The commit description of 77b0bf55bc67 mentioned
> > "We also hope that GCC will eventually get fixed,..."
> >
> > Now, GCC provides a solution.
> >
> > https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgcc.=
gnu.org%2Fonlinedocs%2Fgcc%2FExtended-Asm.html&amp;data=3D02%7C01%7Cnamit%4=
0vmware.com%7Cc43f433d8c6244de15f108d6643a49e4%7Cb39138ca3cee4b4aa4d6cd83d9=
dd62f0%7C0%7C0%7C636806598899962669&amp;sdata=3D88UJ25RoiHik9vTCJKZV6%2F7xp=
zCGsvKb9LFg1kfEYL0%3D&amp;reserved=3D0
> > explains the new "asm inline" syntax.
> >
> > The performance issue will be eventually solved.
> >
> > [About Code cleanups]
> >
> > I know Nadam Amit is opposed to the full revert.
>
> My name is Nadav.


Sorry about that.

(I relied on a spell checker. I should be careful about typos in people's n=
ame.)



> > He also claims his motivation for macrofying was not only
> > performance, but also cleanups.
>
> Masahiro, I understand your concerns and criticism, and indeed various
> alternative solutions exist. I do have my reservations about the one you
> propose, since it makes coding more complicated to simplify the Make syst=
em.
> Yet, more important, starting this discussion suddenly now after RC7 is
> strange.



I did not think this was so sudden.

When I suggested the revert a few weeks ago,
Borislav was for it.
I did not hear from the other x86 maintainers.

Anyway, it is true we are running out of time for the release.


> Anyhow, since it=E2=80=99s obviously not my call, please don=E2=80=99t ma=
ke it
> sound as if I am a side in the decision.
>

Not my call, either.

That's why I put the x86 maintainers in the TO list,
and other people in CC.

The original patch set went in via x86 tree.
So, its revert set, if we want,
should go in the same path.



Anyway, we have to do something for v4.20.
Maybe, discussing short-term / long-term solutions
separately could move things forward.


[1] Solution for v4.20

[2] Solution for future kernel



If we do not want to see the revert for [1],
the best I can suggest is to copy arch/x86/kernel/macros.s
to include/generated/macros.h
so that it is kept for the external module build.
(It is not literally included by anyone, but should work at least.)



For [2], what do we want to see?




--=20
Best Regards
Masahiro Yamada
