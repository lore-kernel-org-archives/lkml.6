Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6208C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842FE21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="dv0sNj9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLRNVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:21:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37384 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeLRNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:21:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so13862881edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=835B9a2Vrobw8Jh8WycCsmQ+PVowpzDBSA7NR7cwFtw=;
        b=dv0sNj9khPmPJBhuU/WNB+LCUNOs1XytZPxWEhwJWq2BPy6ukhGXxv2ZDj+3NhztkA
         fIMNyZGRVrtSD/JV+7bjKyIgTQBFDks+rCVgniR5k9UBQGbGUmGr+XkDdqTxY4G5Fiqi
         BVopNe01SMs20eM581iO6275JPtxqzcerM0StK8RR7Dt9WhlrOxRvZynC0yPGB1bqZBP
         hLm7sjVjmz/ZMXHK/YSJKeD2M8Dc/NTW/tcL+CkrnhjZ9r17yF3co8erFNVguCuuVISW
         AkSQiZf5Sk4g9C5dKHOYxK+ZXciVelTXbD8iIB8Uvrkkc6b5VgCAZ0lBwP8XcdjcgUyZ
         +Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=835B9a2Vrobw8Jh8WycCsmQ+PVowpzDBSA7NR7cwFtw=;
        b=K5T5XGARQB9OKvxaEsKh90f/pofuqo7sal75S39RrXf84zwX+4XfLZ5cLdIC+/JKzT
         5yoJbazHI4ZdOMYFZwIkwWc1uGqKqfyhA2t/Ax6SHQi4xp4sxNv+f1SIYbQAwul/jf8v
         2SNTiOYR1dR43TGCm5Uz77ZCMINSRkZBBf8MpVHe8Sn6h5ChlhnUaGZg/uPkB4tVgLE7
         M4JwWLlgzLsXRfL6QIwccD/vpDwO350IuIMyrYaUpTsiV7uHcmQDiIK4JGRZaGllg6o5
         xzmpCcrsb4fG3sBhVUQB6nAq+qBcS1IIUdhEG/vXnjTQYnpvBaoKNxOxewDMiBbdE8yU
         TATg==
X-Gm-Message-State: AA+aEWY3Ln/JyMgqybT5H9e6bvQJuYfrrzfYneMe4BIqjzTSvHNk5z3F
        d780P/fp74HCCORmWz7NeLVueES85vC8YDWMZCNERw==
X-Google-Smtp-Source: AFSGD/UFgNirV053dva6+bJ8sy1WKYIZ4OXCCNbTrjG/RfLoJHwkd98RxP4JmNBi9WhKKilThxNKZ8EtaZX6xtc+akQ=
X-Received: by 2002:a50:9770:: with SMTP id d45mr15483391edb.49.1545139280043;
 Tue, 18 Dec 2018 05:21:20 -0800 (PST)
MIME-Version: 1.0
References: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com> <34aa8fad-ee7f-6833-41a2-00a92b4ad369@oracle.com>
In-Reply-To: <34aa8fad-ee7f-6833-41a2-00a92b4ad369@oracle.com>
From:   Gi-Oh Kim <gi-oh.kim@cloud.ionos.com>
Date:   Tue, 18 Dec 2018 14:20:44 +0100
Message-ID: <CAJX1YtYUtzqOipVSzW1jJ3LAnveZbaJmJEQg9sdT-0TqQ6wuUA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/build: fix compiler support check for CONFIG_RETPOLINE
To:     zhenzhong.duan@oracle.com
Cc:     yamada.masahiro@socionext.com, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mroos@linux.ee, hpa@zytor.com,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 8:11 AM Zhenzhong Duan <zhenzhong.duan@oracle.com> w=
rote:
>
>
> On 2018/12/5 14:27, Masahiro Yamada wrote:
> > It is troublesome to add a diagnostic like this to the Makefile
> > parse stage because the top-level Makefile could be parsed with
> > a stale include/config/auto.conf.
> >
> > Once you are hit by the error about non-retpoline compiler, the
> > compilation still breaks even after disabling CONFIG_RETPOLINE.
> >
> > The easiest fix is to move this check to the "archprepare" like commit
> > 829fe4aa9ac1 ("x86: Allow generating user-space headers without a
> > compiler") did.
> >
> > Link: https://lkml.org/lkml/2018/12/4/206
> > Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on co=
mpiler support")
> > Reported-by: Meelis Roos <mroos@linux.ee>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v2:
> >    - Revive ifdef CONFIG_RETPOLINE surrounding the KBUILD_CFLAGS additi=
on
> >    - Rephase the commit log a bit, hoping the cause of the issue will b=
e clearer
> >
> >   arch/x86/Makefile | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index f5d7f41..75ef499 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -220,9 +220,6 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables
> >
> >   # Avoid indirect branches in kernel to deal with Spectre
> >   ifdef CONFIG_RETPOLINE
> > -ifeq ($(RETPOLINE_CFLAGS),)
> > -  $(error You are building kernel with non-retpoline compiler, please =
update your compiler.)
> > -endif
> >     KBUILD_CFLAGS +=3D $(RETPOLINE_CFLAGS)
> >   endif
> >
> > @@ -307,6 +304,13 @@ ifndef CC_HAVE_ASM_GOTO
> >       @echo Compiler lacks asm-goto support.
> >       @exit 1
> >   endif
> > +ifdef CONFIG_RETPOLINE
> > +ifeq ($(RETPOLINE_CFLAGS),)
> > +     @echo "You are building kernel with non-retpoline compiler." >&2
> > +     @echo "Please update your compiler." >&2
> > +     @false
> > +endif
> > +endif
> >
> >   archclean:
> >       $(Q)rm -rf $(objtree)/arch/i386
> Acked-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>
> --
> Regards
> Zhenzhong
>

Hi,

I think this patch needs to be merged to linux-stable 4.14.y branch.
Following is what I did to reproduce the problem.
The problem is gone after applying the patch.

1. I created and installed a headers package as following.
make -j7 deb-pkg
cd ..
sudo dpkg -i linux-headers-4.14.89+_4.14.89+-18_amd64.deb

2. I managed to re-produce the same problem as following.
gohkim@ws00837:~/study/drv$ make -C /usr/src/linux-headers-4.14.89+/
kernelrelease
make: Entering directory '/usr/src/linux-headers-4.14.89+'
arch/x86/Makefile:245: *** You are building kernel with non-retpoline
compiler, please update your compiler.. Stop.
make: Leaving directory '/usr/src/linux-headers-4.14.89+'

3. Weird thing is that it works fine if I use sudo command.
gohkim@ws00837:~/study/drv$ sudo make -C
/usr/src/linux-headers-4.14.89+/ kernelrelease
make: Entering directory '/usr/src/linux-headers-4.14.89+'
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --silentoldconfig Kconfig
4.14.89
make: Leaving directory '/usr/src/linux-headers-4.14.89+'


--=20
GIOH KIM
Linux Kernel Entwickler

1&1 IONOS Cloud GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 176 2697 8962
Fax:      +49 30 577 008 299
Email:    gi-oh.kim@cloud.ionos.com
URL:      https://www.ionos.com

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
