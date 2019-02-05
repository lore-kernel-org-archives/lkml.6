Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A20C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUg08AWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfBEGZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:25:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41112 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfBEGZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:25:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so1746296lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JGKmw+ivEwbtIMRAqMQBjlEJSrGDn7ywDHuPlpQWhA0=;
        b=eUg08AWzlAokNLfn9LxMDXA0qGi/141bMpIfGmWg+9X/8MKB77bmkwV6GTn/mJZgyf
         ryHuzUK5k3x9QMGJ1s9s8zRDTZIYiq06PapUt3kvboVDiY+okPraAlXATuCKSeIxCq/J
         27QAEE0Iy+HneLNA9VqRsVutK098uupiqYTEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JGKmw+ivEwbtIMRAqMQBjlEJSrGDn7ywDHuPlpQWhA0=;
        b=eJPRT2EovSu9ewYs60yAJm8x35D604XuPQ2c+cmVLiHhOC6PXdFhE39QnPkHLqW9th
         fXZbR/Qe6uy7yUdD3KBlLTiLkqxkj7eX4HAS3/M18N3seBhqsYaCck3H1xXnsnobQ0sn
         eOMiFlHPliyDaAVQb0bsUpr1OPIQJPBeSJ6mEc9VkUxM7TOGaDAvs345WFQXJchvdiZP
         fWS0a5Y+bqy9VBnWwiQtWlYcRRK4zaOOnb/tPtVhHz08mvpD0gFer5n8wlVVbvsUI1Ho
         6QbqiOzVdANQQK0OmR0oDGB8MpNq1fzNSuVFp/UXUNd3TopvoNaLfsOjiHf8hOuPx9+r
         sfng==
X-Gm-Message-State: AHQUAuaNNwoJGlLiNCuQop3zZYjMHVvkDUzV6QO/m2wbOQXR8nYLO1//
        MuZ/WHUSc9ljUA0Ag7XsypOxVYaRU1OZkqG7ZgS/UA==
X-Google-Smtp-Source: AHgI3Ibj9s/crFHvkpktM+6lP+l5tIpaJi1ym+QwX1VAf0M/Tb8tTXuQwA+viPO1JexC/hQwMyI0/bZUBXSrAHtcSrU=
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr1967767lfi.57.1549347911029;
 Mon, 04 Feb 2019 22:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20190204103610.583715954@linuxfoundation.org>
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Feb 2019 11:54:59 +0530
Message-ID: <CA+G9fYusQ+q2qssYurowuYw1tEkZ-ePR7YwksEWX7Fiep5NYSQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/65] 4.4.173-stable review
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

On Mon, 4 Feb 2019 at 16:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.173 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb  6 10:35:30 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.173-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.173-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 256c5e4d5358cf3c649b53a0c8bef02f499e357c
git describe: v4.4.172-66-g256c5e4d5358
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.172-66-g256c5e4d5358

No regressions (compared to build v4.4.172)

No fixes (compared to build v4.4.172)


Ran 17275 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.173-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.173-rc2-hikey-20190204-367
git commit: e7819526baa5163360b89a0c45d2e09992772ff6
git describe: 4.4.173-rc2-hikey-20190204-367
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.173-rc2-hikey-20190204-367


No regressions (compared to build 4.4.173-rc1-hikey-20190204-366)

No fixes (compared to build 4.4.173-rc1-hikey-20190204-366)

Ran 2826 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-fs-tests

--=20
Linaro LKFT
https://lkft.linaro.org
