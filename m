Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D3EC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4AA2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwyY5PKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfALI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:29:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43204 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfALI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:29:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so12415871lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 00:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jUSR3bl2UuC4hFNZY9ZLUIZcjFDKFwO5Mi3dm4NDOxk=;
        b=AwyY5PKx11ZOHZAh3+2lO9JoD5AUYONd1tKgMfMe5jqOtljufDMoWl70UEeD1/HK1j
         XLu9Ryq/28AcKDjmoi6Ez63D5TArMGgqu0AQqmH1BiMTIij73A5ctMYVKLRAwDWpvAcr
         N7fZhSQOAkjM1bbC7Lk/joteIaHIfVj1/uJ6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jUSR3bl2UuC4hFNZY9ZLUIZcjFDKFwO5Mi3dm4NDOxk=;
        b=opGM8IEdMq1G06it8sMwi1WDmnYOObznhDgneIMtiSidFiiya6C8m4Q38wOl2NqxnP
         yAZefsz/29o/zZ0a/MoinJweEwxsVzaUh8dz5rhfeJtUPv9VKcHOIYrmzJM1t/Sc+QjO
         wj8qUt7KB/ObPsVUu1ReprRPv/3guutZNAG71bT8H5k/72dGC5fg1tYePo8SKJfQlvc4
         yTcZuG1L7Enjoqc0e8u2fKB8dXT0+WmixhVe5eHqaARKj4UB23/MkVPiJWZiB4DzzBAE
         nt0AxUzyJEAc0qIX/FXd1FbL3VxCxZ8wm/pvTRfboqBZZesav2AXz5ytBizlC9Zakd+h
         etOQ==
X-Gm-Message-State: AJcUukfNbrkvKLbrXbmEkhyJdkCY3hyQ9z1VoO4LFPksMBrPyPUtLZHs
        ULy723nrFyldAn2lrhE1C0yVrPEdN1IeRYuk9rOx0P9rdDXifA==
X-Google-Smtp-Source: ALg8bN4gkEU3ZRjze91aUy/CyrK2wFypl3/8fymjhWWdy4HwVgsED1vgbxw7Yi6iBVJY9SSYOXCDhA6a5qnG3OPjs5I=
X-Received: by 2002:a19:1019:: with SMTP id f25mr9486947lfi.54.1547281751006;
 Sat, 12 Jan 2019 00:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20190111131055.331350141@linuxfoundation.org>
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 12 Jan 2019 13:58:59 +0530
Message-ID: <CA+G9fYtoFMzGQYxWKw3MHYnPeChqjAO2+TDBs3aO8qiX7pEH6w@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/65] 4.20.2-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 at 20:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.2 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jan 13 13:10:14 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.20.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: 61a581953554b7aae086213d64da1fd3a760e0bd
git describe: v4.20.1-66-g61a581953554
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.1-66-g61a581953554

No regressions (compared to build v4.20.1)

No fixes (compared to build v4.20.1)


Ran 20568 total tests in the following environments and test suites.

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
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
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
* spectre-meltdown-checker-test
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
