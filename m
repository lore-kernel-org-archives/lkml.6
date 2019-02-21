Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E48C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA77B214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIGkya/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfBUJMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:12:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38919 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfBUJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:12:50 -0500
Received: by mail-it1-f195.google.com with SMTP id l15so21741323iti.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W+44EIBhBXbsefbi7VawPB4oVnnUrElgg4bWRK7GROs=;
        b=gIGkya/M7uiDBGl/4k5GTJZmSuediKC4hXOKVBq/zrquo+o8N+bdaLjKrRAeySMAxz
         fYVNOjj/Jp6pxJdIMgii8liCKJER5abXJboUqxhX3lxWzbw6LhPz3F4ov2sme0qgAlzk
         ZaKsRrmfBqUhnKDMFqU94agJjV+704mzIOqnyqB6SH9phpLcAXrQC1fVOU7AQnhhCQX0
         4McyQvUaf4GxYgtIEsU1qlHVxG4DyplIeTg9Tbp4S+1k5LRLHJHeHO90dfUq4j4xtg/3
         B0WgENdtqUfMQGm1/jKJVjwpWTCEfFMQMsyLoe3tT80GfA0qQJ/8d79jvP+G8PIJcsQx
         //sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+44EIBhBXbsefbi7VawPB4oVnnUrElgg4bWRK7GROs=;
        b=saUHVj8HE5ZHeJcavlX7c00zO0PFZfxnpevz7PPxPX3oavSRzyRzCo06RPZS4ihT/B
         NVmttCTQRZeuEGiDr0KDMl6iEEvF+vUFjUClnyxE1b+St8sRjb2u/Rm5fx6uWpzj8tuS
         vuSmM69hKyd0DsiEuMpGFiCCTF1B0Mc26ugaXYXN6eC2iLZL+J2y9YGcV5YMLvO7mJ1j
         mv5ok3IGNmWsAAndhCZpPy5rIacjUf7eVp9zIQ4diMmBckFFP2ZhXcoI3L/W3UsTETl8
         a3QpnG8AaTv3ohYRG9jem37luG63N8idJBGDAnZJGDzkfv/vRrxAxhu991ub7YLueBu6
         5qPg==
X-Gm-Message-State: AHQUAuapMlghUI9rorIjqBSU0vtn4xzZ2xGyXb/e6LzHUhVhUSy3lbiT
        vAdn+p0rNT0kM3Yt5SmW9JJgD44csFmvunBtk0zPkg==
X-Google-Smtp-Source: AHgI3IZgPyWYMpkh37W7JYFqIy8jB/tj47S/ldEdm4CmiHLdsApZ8diIU6VetwBx2GBoaE5DtW9nO5psVXdPVkexJD0=
X-Received: by 2002:a24:1947:: with SMTP id b68mr7172578itb.121.1550740368851;
 Thu, 21 Feb 2019 01:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20190220184341.73bd2084@canb.auug.org.au> <1114b964-8ff8-5632-64d4-e94a9160b998@hisilicon.com>
 <20190220095252.GA9089@linux.intel.com> <20190220095806.GB9089@linux.intel.com>
 <CAKv+Gu8G5eWeAdCB28xa=16ANFd2he9WPSztgXYwYRkhPfpEyA@mail.gmail.com>
 <aaac08b0-6366-7b63-d6a7-eea6630ce169@hisilicon.com> <CAMuHMdWfbPHv6WBMm7uDdPhbEB-m+bOcYzzYpRe4BfcSNR2pcQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWfbPHv6WBMm7uDdPhbEB-m+bOcYzzYpRe4BfcSNR2pcQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 21 Feb 2019 10:12:37 +0100
Message-ID: <CAKv+Gu8MWECBMgvQhLXpYkn6GQBXpGEo93EdjXcTxMsjCicaDQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Feb 20
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Zhangshaokun <zhangshaokun@hisilicon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 09:04, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Shaokun,
>
> On Thu, Feb 21, 2019 at 1:45 AM Zhangshaokun <zhangshaokun@hisilicon.com>=
 wrote:
> > On 2019/2/20 18:05, Ard Biesheuvel wrote:
> > > On Wed, 20 Feb 2019 at 10:58, Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > >>
> > >> On Wed, Feb 20, 2019 at 11:52:52AM +0200, Jarkko Sakkinen wrote:
> > >>> On Wed, Feb 20, 2019 at 05:11:15PM +0800, Zhangshaokun wrote:
> > >>>> There is a compiler failure on arm64 platform, as follow:
> > >>>>
> > >>>>   AS      arch/arm64/kvm/hyp.o
> > >>>>   CC      kernel/trace/ring_buffer.o
> > >>>> In file included from security/integrity/ima/ima_fs.c:30:0:
> > >>>> security/integrity/ima/ima.h:176:7: error: redeclaration of enumer=
ator =E2=80=98NONE=E2=80=99
> > >>>>   hook(NONE)   \
> > >>>>        ^
> > >>>> security/integrity/ima/ima.h:188:34: note: in definition of macro =
=E2=80=98__ima_hook_enumify=E2=80=99
> > >>>>  #define __ima_hook_enumify(ENUM) ENUM,
> > >>>>                                   ^
> > >>>> security/integrity/ima/ima.h:191:2: note: in expansion of macro =
=E2=80=98__ima_hooks=E2=80=99
> > >>>>   __ima_hooks(__ima_hook_enumify)
> > >>>>   ^
> > >>>> In file included from ./arch/arm64/include/asm/acpi.h:15:0,
> > >>>>                  from ./include/acpi/acpi_io.h:7,
> > >>>>                  from ./include/linux/acpi.h:47,
> > >>>>                  from ./include/linux/tpm.h:26,
> > >>>>                  from security/integrity/ima/ima.h:25,
> > >>>>                  from security/integrity/ima/ima_fs.c:30:
> > >>>> ./include/linux/efi.h:1716:2: note: previous definition of =E2=80=
=98NONE=E2=80=99 was here
> > >>>>   NONE,
> > >>>>   ^
> > >>>> scripts/Makefile.build:276: recipe for target 'security/integrity/=
ima/ima_fs.o' failed
> > >>>> make[3]: *** [security/integrity/ima/ima_fs.o] Error 1
> > >>>>
> > >>>> I dug it and it is the commit 901615cb916d ("tpm: move tpm_chip de=
finition to include/linux/tpm.h")
> > >>>
> > >>> This results from a new include in tpm.h:
> > >>>
> > >>>   #include <linux/acpi.h>
> > >>>
> > >>> Must be fixed either in include/linux/efi.h or security/integrity/i=
ma.h as
> > >>> those files have a name collision. Makes me wonder why neither has =
taken
> > >>> care of prefixing the constants properly.
> > >>
> > >> Preferably both subsystems should be fixed with proper 'EFI_' and 'I=
MA_'
> > >> prefixes. Defining a constant named as NONE in a non-generic subsyst=
em
> > >> (e.g. not part of the core data structures of Linux) and especially
> > >> exporting it to include/linux is not too well considered act.
> > >>
> > >
> > > Fixes for this have already been proposed, and should appear in -next=
 shortly
> > >
> > > The EFI one is here
> > > https://mail.google.com/mail/u/0/#label/linux-efi/FMfcgxwBVgrQRjglPkW=
RqRqVclGgVDnB
> > >
> >
> > Because of no privilege, the website is denied for me. Anyway, it's nic=
e to have been fixed.
>
> Looks like Ard posted a link to a label in his personal gmail mailbox?
>

Silly me.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Defi=
/core&id=3D5c418dc789a3898717ebf2caa5716ba91a7150b2
