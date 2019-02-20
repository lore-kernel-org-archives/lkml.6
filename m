Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9990CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698DC20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JB6odzgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBTKFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:05:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53871 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfBTKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:05:45 -0500
Received: by mail-it1-f193.google.com with SMTP id x131so13896981itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 02:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UxXpoqYZsr0myC52GC/581uh8VWI9MAJmfeUPOdUYzE=;
        b=JB6odzgSqp/bdn+I4ZLRPMDUJURq1EfqGY7gw+vzqRlhzMHW7W9wZTABh+ovCTilYQ
         ffHakS6IC/XGat/4LmoYU2FChH0vCQoazpPk5kkn0BoHSDMsf+1SVb269PWpYY4eegX5
         l8cPkK7Om2FeAG0wYATP/SIcCO/7SaNl6EkC/cJVsv7eOc1hCVp80kQRT1/XeX1oYhOa
         jFpwRTMuSMvUiTKuPfsusL39LNvXTga1NAAAdMRp9vs4Vb/NIA4+aw46QC164f2sdYQO
         XpGlu+3EfdtfxgeSZWvTz2sPvlTxcwZxCS1ax25i7e06NvA1GeXgpnhFjtL00P40Auji
         0/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UxXpoqYZsr0myC52GC/581uh8VWI9MAJmfeUPOdUYzE=;
        b=b0CdiZaD2CrE+V8U/6FW7TaSN0qkEA8Q3fjAFA1oo3KJM5E/L3VDWUKzp06v4RXaIS
         rRfVxOX6ddRh335qCsTOeUyY9DScgFHcfs4nS2Bjru4C6sswe7jGW+6FkHDZmXHim3gB
         1qIREOcJHi5C+9IHoBwNfgCflP0RS2INm8Hv6OO8JsN4o3zhSwYHMJXgoMLpO6A+Mq0Z
         4abKNBFY36sX8kr1TuP+LDaPD5zVtN5wxmJyNLTrap5sFa8tS+y6AI90EmVcUKFUhSgo
         W9hKI0SX2hCCuA+VaCQi+wOnkH0HDxtCLvu0WjO+lgMNAuFJ9N5h9g9Bawr2B6X6cnR9
         NPaA==
X-Gm-Message-State: AHQUAuZR/fYT39qVoga5YNd/rOgUHxmSEdGD7uypC4uBXgEoW987+2BP
        YhaMdxJEGAPWyeKzyqRrCS83EqL5ZnaeOEZtKXMfBA==
X-Google-Smtp-Source: AHgI3IaBmzuBelvzZljDo9bLWPL9x3kCu8fHROcygzsU27yJqCT9BfMehg621YzVjfjHHnERLuklCPvV/PLZIJWc8tY=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr18532724iom.170.1550657144079;
 Wed, 20 Feb 2019 02:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20190220184341.73bd2084@canb.auug.org.au> <1114b964-8ff8-5632-64d4-e94a9160b998@hisilicon.com>
 <20190220095252.GA9089@linux.intel.com> <20190220095806.GB9089@linux.intel.com>
In-Reply-To: <20190220095806.GB9089@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 20 Feb 2019 11:05:32 +0100
Message-ID: <CAKv+Gu8G5eWeAdCB28xa=16ANFd2he9WPSztgXYwYRkhPfpEyA@mail.gmail.com>
Subject: Re: linux-next: Tree for Feb 20
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Zhangshaokun <zhangshaokun@hisilicon.com>,
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

On Wed, 20 Feb 2019 at 10:58, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Feb 20, 2019 at 11:52:52AM +0200, Jarkko Sakkinen wrote:
> > On Wed, Feb 20, 2019 at 05:11:15PM +0800, Zhangshaokun wrote:
> > > There is a compiler failure on arm64 platform, as follow:
> > >
> > >   AS      arch/arm64/kvm/hyp.o
> > >   CC      kernel/trace/ring_buffer.o
> > > In file included from security/integrity/ima/ima_fs.c:30:0:
> > > security/integrity/ima/ima.h:176:7: error: redeclaration of enumerato=
r =E2=80=98NONE=E2=80=99
> > >   hook(NONE)   \
> > >        ^
> > > security/integrity/ima/ima.h:188:34: note: in definition of macro =E2=
=80=98__ima_hook_enumify=E2=80=99
> > >  #define __ima_hook_enumify(ENUM) ENUM,
> > >                                   ^
> > > security/integrity/ima/ima.h:191:2: note: in expansion of macro =E2=
=80=98__ima_hooks=E2=80=99
> > >   __ima_hooks(__ima_hook_enumify)
> > >   ^
> > > In file included from ./arch/arm64/include/asm/acpi.h:15:0,
> > >                  from ./include/acpi/acpi_io.h:7,
> > >                  from ./include/linux/acpi.h:47,
> > >                  from ./include/linux/tpm.h:26,
> > >                  from security/integrity/ima/ima.h:25,
> > >                  from security/integrity/ima/ima_fs.c:30:
> > > ./include/linux/efi.h:1716:2: note: previous definition of =E2=80=98N=
ONE=E2=80=99 was here
> > >   NONE,
> > >   ^
> > > scripts/Makefile.build:276: recipe for target 'security/integrity/ima=
/ima_fs.o' failed
> > > make[3]: *** [security/integrity/ima/ima_fs.o] Error 1
> > >
> > > I dug it and it is the commit 901615cb916d ("tpm: move tpm_chip defin=
ition to include/linux/tpm.h")
> >
> > This results from a new include in tpm.h:
> >
> >   #include <linux/acpi.h>
> >
> > Must be fixed either in include/linux/efi.h or security/integrity/ima.h=
 as
> > those files have a name collision. Makes me wonder why neither has take=
n
> > care of prefixing the constants properly.
>
> Preferably both subsystems should be fixed with proper 'EFI_' and 'IMA_'
> prefixes. Defining a constant named as NONE in a non-generic subsystem
> (e.g. not part of the core data structures of Linux) and especially
> exporting it to include/linux is not too well considered act.
>

Fixes for this have already been proposed, and should appear in -next short=
ly

The EFI one is here
https://mail.google.com/mail/u/0/#label/linux-efi/FMfcgxwBVgrQRjglPkWRqRqVc=
lGgVDnB

Not sure about the IMA one, Mimi should be able to comment ...
