Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1D16C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9613820891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCm1uRHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934461AbeFLVge (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:36:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45148 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933696AbeFLVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:36:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so216345plz.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZeE5rcQ+KFwR0PMw1LbUIdqpuYh0fOsY0HLm1tPdRw=;
        b=eCm1uRHNdV9uyItVGDi0VNemBkAKtBsSXlvuHy9F6eEoIL3FT0Z3KcfR2BDM/B71o7
         gqxxGkUSuVFmB6eb6RF+GN/Xb+geEFMFXgzij+K3xFTcPmcZsBqGgg7e/aTDtpDRF4vd
         tvCnTrmrIv7+g309nm1z3Qh0q+pIr54Brl0vVk35KuV1yOiunMfzYYvHa8yITEahVXfe
         CoiGLBw7R4sdlhmlSo829fxHo8eJA8sr/QeHRT/5nvaM2eBp1JMyh29PkuWzRHRQe93N
         S74rFc+Yzn2jH1CbCTkCzEezZZXp/339Obk/vKIBcAFr60tDmgqNcR2fyZ6sE6OIiS1j
         1XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZeE5rcQ+KFwR0PMw1LbUIdqpuYh0fOsY0HLm1tPdRw=;
        b=kO9ZEPn3dDRkwCEEP661I385sOkJ5Yx540xf5pAuSSSCAOimKmFjtdHqcZqvm+oCBz
         I8xj26O6k6Rw4lF/bdJus/OsqtXlp0lBt8qNf6uwT0ggBfZxOndIXen10k08CEJ3kllo
         rPDHqNPTo/rYLpCyjHJwAQrve1L0iXyqgZBzpU6FbHhsx+x9zW3fcFPg+bQnpeeQEZeS
         yMtTbmgFGUEELkClw7L/ZhDLztf0alwJcB8qAo7Q3+ibYpOQmlmMh/hPK4buFNgYK01V
         Z5PsCtx2NqMu7F9s6LPHHXeuvRblxd0KMb1pv6MUCTIQ3UBMbfHGzBa2lrJDIp3WoeQR
         oKxQ==
X-Gm-Message-State: APt69E2QZEhDO4f127J1OgVZg/+wNMu42U7ZSb4n+ZjNqiVMka3aAlNr
        gMrkWwY/NX7ydasfWoCSzTruGu0LLdAgHq87huAbAA==
X-Google-Smtp-Source: ADUXVKJsR8lmwdgXpVw4Uu4oyM9ZCMImDkl0WoD5bT6r0OX/Qgx5M5AJORid7zHXSzshk0uNLX7GrJqc52B61Svf+aw=
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11-v6mr2262392plo.20.1528839391498;
 Tue, 12 Jun 2018 14:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180607204927.219329-1-ndesaulniers@google.com>
 <20180607204927.219329-2-ndesaulniers@google.com> <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
 <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com>
 <CAKwvOdmxFHfkj81YAXa8fE86fC+k+KvqMvgk4=e62pNCcXbKOg@mail.gmail.com>
 <201806121851.w5CIpTY7134381@mail.zytor.com> <CAKwvOdkeEqb0HnHoggpwmHiKtDo06VN0N_r9ffv0rzigNLvXUg@mail.gmail.com>
 <7e375fab-f8ad-705a-dd04-f7e18952bd0c@zytor.com>
In-Reply-To: <7e375fab-f8ad-705a-dd04-f7e18952bd0c@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Jun 2018 14:36:19 -0700
Message-ID: <CAKwvOdksGzdeFOAiYRNahFqxRoYoTMGkTeprfP4oZPzdF94WLA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
To:     hpa@zytor.com
Cc:     sedat.dilek@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, David Rientjes <rientjes@google.com>,
        acme@redhat.com, Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 06/12/18 13:19, Nick Desaulniers wrote:
> >
> > Oh, by [0] __GCC_STDC_INLINE__ is indeed actually the correct symbol
> > to check for.  Clang does support that, so nothing to fix there.
> >
> >> By the way, you should check clang against gcc's predefined macros by doing:
> >>
> >> gcc [options] -x c -Wp,-dM -E /dev/null | sort
> >>
> >> Options can change the predefined macros substantially, especially the, -std=, arch and -O options. -x c can be replaced with e.g. -x c++, objective-c, assembler-with-cpp etc.
> >
> > Neat, I'll have to bookmark that incantation.  I can s/gcc/clang/ to
> > get a similar list (which is how I know it supports
> > __GCC_STDC_INLINE__).>
>
> I bet that if you add -fgnu89-inlines then it *does* define
> __GNUC_GNU_INLINE__.

Indeed! I see what you mean about [options] changing the predefined symbol list.

> > Patch now becomes something like:
> >
> > #ifdef __GNUC_GNU_INLINE__
> > #define __gnu_inline __attribute__((gnu_inline))
> > #else
> > #define __gnu_inline
> > #endif
> >
> > #define inline inline __attribute__((always_inline, unused)) notrace
> > __gnu_inline
> > ...
> >
> > Issues with that approach?
> >
>
> s/__GNUC_GNU_INLINE__/__GNUC_STDC_INLINE__/

Oops, sorry, yes good catch.

-- 
Thanks,
~Nick Desaulniers
