Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69BC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B952175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmWrfjOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfA3NBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:01:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39298 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbfA3NBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:01:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so17310592lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W55QqZ1L8cYyDXUOS3U+g4t8/wXWlkx4+Zx8yd+BeJw=;
        b=VmWrfjOQWkluMlRz9IkmnOuH4OkAuRVB0pZREoA2dkEfGSn8G3xP8oys0wDAMIs5Ni
         hK/gr/yzLmD+zeUXz7EA4Kg6FAnH1BjAXFxjkPq2dNP5gfpO/uIyi6ve3oRU+VRiKRtp
         3JsUidgz1xBlmIfUUCi1armFJBbnhaIl6wPN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W55QqZ1L8cYyDXUOS3U+g4t8/wXWlkx4+Zx8yd+BeJw=;
        b=bdhB4Z14OSufCZGnNWUgrPkiweO3LkHhGZhnXNcNZAKr/jDgSDo1Wrqm3pzlXzXmGj
         5pUMLxA0sWGwOre4B0wkMe0lEFrk4F1IsoZV7XvXKMejuiHvOrRwEigJuMwSTDJBqCXA
         t8sAFbeOcQo4l4+45sojNrkDDDzS3Dpl2eZJIXnZYPGSHTKCKwX1J1mvDDV5GcSOjcbJ
         eHntbtTr3/PgF2O5WT/7qkO7Av/JO3QChOYvyeD8PWRmx8szSxQtwjAjNsZDymWw5lvC
         0QTB3La6hgYdZwTHQ+rSpct+YAJ+nIR9ukhYrZe/HIflo0g2m2iE0bVmUtq0hN8NWyI0
         OqGA==
X-Gm-Message-State: AJcUukcegipmzKB0DG3zPFXAGwDD/HmjCthen5Ba2JJHcqv7muiHePkO
        wCx+W2t1D7HLSqP9eRYduWNhPQ7rf3734vs0UAuO9w==
X-Google-Smtp-Source: ALg8bN5sKRfpEPvcdd2JvJYOQ6W58dG/7BYWoIKpNB9Z+YqIHDmB4S1ZUe09cxsSUnwWAkaTBUeWzzv0vWIGJXOyOyI=
X-Received: by 2002:a19:4345:: with SMTP id m5mr23360597lfj.142.1548853298413;
 Wed, 30 Jan 2019 05:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20190129113139.826927690@linuxfoundation.org>
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Jan 2019 18:31:26 +0530
Message-ID: <CA+G9fYt3ULoisteyhtZw=C8w_1kFquU0ucEzt-YzT2fGYACVYw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/44] 4.9.154-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ltp@lists.linux.it
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        chrubis <chrubis@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 at 17:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.154 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.154-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

RC2 report.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
-----
LTP upgrade to 20190115 and found fanotify01 test failed
and LTP syscall test case  bind03 getting pass now on 4.9 and 4.4
version kernel.

fanotify01 failed on hikey and dragonboard410c arm64 boards all kernel vers=
ions
fanotify01.c:256: FAIL: got event: mask=3D2 (expected 20) pid=3D2756 fd=3D9
https://bugs.linaro.org/show_bug.cgi?id=3D4261

Summary
------------------------------------------------------------------------

kernel: 4.9.154-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 6674590d15d227f4096f193f8e6fb737ef41e89f
git describe: v4.9.153-43-g6674590d15d2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.153-43-g6674590d15d2

No regressions (compared to build v4.9.153)


Fixes (compared to build v4.9.153)
------------------------------------------------------------------------
LTP syscalls test case "bind03" fixed and getting pass on all devices.


Ran 21980 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-cve-tests
* ltp-open-posix-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
