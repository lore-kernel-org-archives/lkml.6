Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CY3ZE9KAHlv1cQAAmS7hNA
	; Mon, 11 Jun 2018 14:02:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D187F607A4; Mon, 11 Jun 2018 14:02:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUZOj1Mw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 166B06074D;
	Mon, 11 Jun 2018 14:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 166B06074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbeFKOCq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:02:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43680 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933280AbeFKOCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:02:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so30708853lfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xiZMc73qQl4XtFL+dop09rdq+gdthaZsmZhQ/ZiY0cE=;
        b=dUZOj1Mw6raNPqIZF/grp2V6H/Ll1Ysm6VHsMoVrfMjbaOSNLDNWnwWzVRE/Y1Eczp
         QAkpmsdORINmCtik5pOjvbiJ8O5nh99TmPLgl6N16g/c52SfvviZyyrKDR44fN9/3Ywq
         7F5yTiDi139qvLme+OX4//aLMR2qYFL0BvhTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xiZMc73qQl4XtFL+dop09rdq+gdthaZsmZhQ/ZiY0cE=;
        b=G9EM0gbkLLwjVEXB6DQkNRCqd08LFhhn80OmxUdLJ5TKzQ+PgWEXnoMicZDT2OGHdN
         WdNrnEeDORLG44xjgwo1+tfxA1GKM6OMupD70lkoHWGCuSt+PCrWfIg9eFtw9Xz6Lt2q
         0uXy0xAKdEmbQw1aFAzTrU+4eXM7hUu9KnGI4OyGRyQHUDt60943tOUjTYO/jFHE/HSe
         DoE0WEYyZ1kUgSD56a1e5DV3avVK+kuAyfPG5tq1qvJBwGlZRvHYrK3dJD/YKRYnsuBY
         BEVr4gEZKoi+u+W5rcnuSSuXjUgOQ54QdNvXt/9qFzz3Ik/PIJyyX7tx5t+NLF4eNFG1
         eYog==
X-Gm-Message-State: APt69E3l2ITFEswQp3tto6SK808xIALCWPb/kb7dYn6+crmbTIu0GiiG
        d9PedRIQyoVKJYgltCDP1L62CACZy5J+w2d6/8YgOw==
X-Google-Smtp-Source: ADUXVKKwwyg0D6whQ0/fclR3b3lbr8MgH5ZMn6M+p3attnf9/wJIDWOkJRQdPycc1z65ovfaLro5VJzKpvCmcy4wxsI=
X-Received: by 2002:a2e:9dd0:: with SMTP id x16-v6mr11621022ljj.142.1528725762319;
 Mon, 11 Jun 2018 07:02:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 07:02:41
 -0700 (PDT)
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 11 Jun 2018 19:32:41 +0530
Message-ID: <CA+G9fYuF=oe-fw6qpwRg0qPgBtjH18JY2JGR7hDVb-eC20sW3w@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/15] 4.17.1-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
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

On 9 June 2018 at 20:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Jun 11 14:59:48 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
Kselftests and LTP syscalls test run with and without skip list, so we see
double results. The failures we have on stable-rc-4.17 are known failures a=
nd
respective bugs are already reported based earlier results from mainline ke=
rnel
and stable-rc-4.16 kernel builds.

Summary
------------------------------------------------------------------------

kernel: 4.17.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 9d1e6d8bc07197ac09395dc55e95030ff92e4dba
git describe: v4.17-16-g9d1e6d8bc071
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17-16-g9d1e6d8bc071


No regressions (compared to mainline build and stable-rc-4.16)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 22,
* kselftest - skip: 27, pass: 40, fail: 1
* libhugetlbfs - skip: 1, pass: 89, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 25, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 262, pass: 2032, fail: 4
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 23,
* kselftest - skip: 25, pass: 104, fail: 9
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 25, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 264, pass: 2030, fail: 4
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 24,
* kselftest - skip: 28, pass: 102, fail: 9
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 24, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 262, pass: 2032, fail: 4
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 24,
* kselftest - skip: 36, pass: 91, fail: 11
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-cve-tests - skip: 8, pass: 22, fail: 5
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 7, pass: 7,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 187, pass: 2106, fail: 5
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 23,
* kselftest - skip: 35, pass: 97, fail: 9
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 23, fail: 4
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 6, pass: 8,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 307, pass: 1986, fail: 5
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 23,
* kselftest - skip: 34, pass: 123, fail: 11
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 3, pass: 29, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 304, pass: 1990, fail: 4
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 23,
* kselftest - skip: 31, pass: 96, fail: 10
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-cve-tests - skip: 8, pass: 24, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 2, pass: 20,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 152, pass: 2146,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 27,
* kselftest - skip: 23, pass: 126, fail: 9
* kselftest-vsyscall-mode-native - skip: 25, pass: 125, fail: 9
* kselftest-vsyscall-mode-none - skip: 24, pass: 125, fail: 9
* libhugetlbfs - skip: 1, pass: 89,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 3, pass: 28, fail: 4
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 232, pass: 2061, fail: 5
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
