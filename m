Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0225D2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrbGUZ+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0225D2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeKMPGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:06:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37964 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeKMPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:06:31 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so7861375lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 21:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djtBlZpEv80K7Q3nxgeVpgyO0erCkTIvIYYFw9KSLW4=;
        b=UrbGUZ+ARxA815KrqZB/2aic8fbcYXI/wqoY1MtXAkzYYQ4dEdvwvYVl6tYzOuItSU
         41ZedVu8gZOSef9UCmoga1g6FELBOm8azo+GQcwSvwxPvSsKyCEBbT+YD7cEWXfmrVbG
         3BXxK39VXavKE5YpQShUg1UywK/x8aPpkp2oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djtBlZpEv80K7Q3nxgeVpgyO0erCkTIvIYYFw9KSLW4=;
        b=MMbXLN89Dx7hEVkHhaf/KjquWJgnYkV3QgRFQF+upbkCqOQTp9meOTYoP32WjvDTMw
         RTWYYwlva08ny7zj1cONQTer7E5YksqwEhwdGN1Lt8Mc/C2Sm1f0ecoDz3xQkxMZxzUy
         0r0ZJsf/3ByOV8i4n3HueUIWRFtuVkVCJ3IjO+4jGFMfgM2i61/VLIeLtVceeidpTg8S
         xyqtrlzwtsTEi9lX9XQxyZaKw+aPpCeibTk9hmSMC2liwrc9mOmJiNWNr84BNf+w6mAb
         w15nujk923ZELOSn7MVYOaxBfUytUgpd2plZKYD0nG55sRhdUX2p/23cewr00fenE63M
         y9GQ==
X-Gm-Message-State: AGRZ1gKZjWdp286fU5s2LZesbTe06LGOR68kUIseUvb9k5xGr1+b0xVO
        Ti9YFVuAs7BznU2fsGtFCBLjJH+JmHtOjSwbiNFBGw==
X-Google-Smtp-Source: AJdET5dENUG4dZF3OIu//C1GOa8WyvvjBJIWeTgZw574xJjzYpbFeHZcIeMl26TvXqVoQaVHWdDUoKp+VBs0z+P6x20=
X-Received: by 2002:a19:750a:: with SMTP id y10mr2050370lfe.43.1542085807388;
 Mon, 12 Nov 2018 21:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20181111221627.853046496@linuxfoundation.org> <18c91c75-18c8-21a1-3051-65007bd2f30f@linaro.org>
 <20181112133301.GB22022@kroah.com>
In-Reply-To: <20181112133301.GB22022@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Nov 2018 10:39:56 +0530
Message-ID: <CA+G9fYuasGVXY__7xZ7NOwijMvvmapPBCbd8q2DjBgxR3UHV1g@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/141] 4.9.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Tinoco <rafael.tinoco@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 at 19:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 12, 2018 at 08:38:44AM -0200, Rafael David Tinoco wrote:
> > On 11/11/18 8:24 PM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.137 release.
> > > There are 141 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Tue Nov 13 22:15:38 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.137-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> > > -------------
> > > Pseudo-Shortlog of commits:
> > >
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >      Linux 4.9.137-rc1
> > >
> > ...
> > > Prarit Bhargava <prarit@redhat.com>
> > >      cpupower: Fix coredump on VMWare
> >
> > Greg, maybe...
> >
> > commit ef8d3a128c1f1de7ffdedb2f14e846e10fd3fec3
> > Author: Prarit Bhargava <prarit@redhat.com>
> > Date:   Mon Oct 8 12:06:19 2018
> >
> >     cpupower: Fix coredump on VMWare
> >
> >     [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]
> >
> > should be dropped from v4.9 (and v4.4) since it causes:
> >
> > $ make V=3D1 -C tools/power/cpupower all
> >
> > gcc -fPIC -DVERSION=3D\"4.9.136.142.g36c7703\" -DPACKAGE=3D\"cpupower\"
> > -DPACKAGE_BUGREPORT=3D\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe =
-DNLS
> > -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare -Wno-pointer-sig=
n
> > -Wdeclaration-after-statement -Wshadow -O1 -g -DDEBUG -I./lib -I ./util=
s -o
> > utils/helpers/amd.o -c utils/helpers/amd.c
> > utils/helpers/amd.c: In function =E2=80=98decode_pstates=E2=80=99:
> > utils/helpers/amd.c:106:39: error: =E2=80=98union msr_pstate=E2=80=99 h=
as no member named
> > =E2=80=98fam17h_bits=E2=80=99
> >    if ((cpu_family =3D=3D 0x17) && (!pstate.fam17h_bits.en))
> >
> > Due to nonexistent CPU (flag) support.
> >
> > Replied to Sasha on specific commits for both, v4.4 and v4.9.
>
> Now dropped from both queues.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.137-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: cee1cbef71e8a5ebf74ae0e7d3858739df82a4db
git describe: v4.9.136-142-gcee1cbef71e8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.136-142-gcee1cbef71e8

No regressions (compared to build v4.9.136)

No fixes (compared to build v4.9.136)

Ran 21202 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-cap_bounds-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org

>
> thanks,
>
> greg k-h
