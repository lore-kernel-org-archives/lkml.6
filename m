Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC1DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400CC2089B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dm4W1gUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400CC2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeG1IVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:21:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45593 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeG1IVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:21:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id w16-v6so2640249ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOiS0epeIqe0tF/P/vnMJK2eGtTcvndBhuYOzfKlMb0=;
        b=dm4W1gUNL8AyiaGWRp51bNXIJprqRHylvucIchF4A2tBvhcC+TYG0SujWZvPPY629X
         c3Jn/5XTukY5ZiQWSHB37d3azmNHktfYLUdhSYp30CTAfUisDsaQHosYhMtN+4XU+TCO
         /ZJS4SRkB8oi3ndR8CIMkixiHHqwFXlrCviiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOiS0epeIqe0tF/P/vnMJK2eGtTcvndBhuYOzfKlMb0=;
        b=ZghB+b/QehT4nYHbuoCUqQzniQwTi5dJCjhl+74FqE4mHOqnmJJruHLxlbmeRizPia
         77djpPhV6QzXml7N+ud72ITtDD2XFsRrKGEOj2SltitoBTD2RlLFaaatHpgXrNKqaqwd
         cCSIeC5x+SdQrpQZRImF1UV++b14+I5x2v+F5nASlM0bDFYnUosXrttHr5g+GXllYUDm
         CjwHr4bk4bTQfd0ReJEb0YYCvhKQSMDFwBhnOHPm8GdPNqPAldyg1C7xA2SkAVBH3wLt
         zDBf8mIWBsy+v/CZT3Qdiw5/+2JgtvSTz6eJWt9U+idpZDJpqHFTAjRFxH3ETNqasGvl
         BqfA==
X-Gm-Message-State: AOUpUlEjxYgiz16Y53BPL4M7LBM4kfqbxPL1lhNOs9Guw5Ff99nSDgK2
        dsT8s0LeSXqB8Q21UFAUIWSPJ6aTvRDDoCgTLUb4Ew==
X-Google-Smtp-Source: AAOMgpeYGh1H0iLCcf+QIvNItZkrr67QJAaKn3ybe7QC6n3DJwu+OQ5kuYi4K1MgXQ+zXgIOYU3VjgyDXPgCN3ak1Kw=
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr7481966ljh.18.1532760944273;
 Fri, 27 Jul 2018 23:55:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 23:55:43
 -0700 (PDT)
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
References: <20180727100845.054377089@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 28 Jul 2018 12:25:43 +0530
Message-ID: <CA+G9fYttehR+2CpDkd311o=R1MV4nL+1XQwYew9WeA9GBrtLHg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/23] 4.4.145-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2018 at 15:39, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.4.145 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 29 10:08:37 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.145-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.145-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 7022b47a6ec790378a63d49f7338587b3276a636
git describe: v4.4.144-24-g7022b47a6ec7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.144-24-g7022b47a6ec7

No regressions (compared to build v4.4.144-24-ga03c11d24aac)

Ran 11995 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.145-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.145-rc1-hikey-20180727-245
git commit: 1712dec90e9e99c2d1f1e30f1071bbe656ecf600
git describe: 4.4.145-rc1-hikey-20180727-245
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.145-rc1-hikey-20180727-245


No regressions (compared to build 4.4.145-rc1-hikey-20180727-243)


Ran 2673 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
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

--=20
Linaro LKFT
https://lkft.linaro.org
