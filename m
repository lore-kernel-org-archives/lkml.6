Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E76C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205420870
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZTru+Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E205420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeIIJKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 05:10:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37369 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeIIJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 05:10:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so14910967lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 21:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MAAlgGOFmZq3vGm/4H9/9Sczul3XqD7LP4Otdna85h4=;
        b=iZTru+LsvQLrSmCtazn7HwvAe8bzQfqm3Rrnn05YBwq7LVAi+mEHXAc6ski7QfDzVR
         Nh45R3iUdKSMkyXLr/QYjBng013R+ERK4C/Y33n+LMuEAljRg4pJcaH6b1jvpYBowPgk
         ZGchxx9J6ax6K0QDlDy7P7pfJ4TDQkIRMlHXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MAAlgGOFmZq3vGm/4H9/9Sczul3XqD7LP4Otdna85h4=;
        b=B3rI64Ql4fr7IuZpbeWZsHmzqR8SVbJpl+weM0NOSLFE9y6d6AQUMJNlPb0gYeQr2V
         KtNq8YipVesuO4vuTfpJnw3fK8O5Otn3qqRR8J38gXLKZG93J9tnwdzn9kfQLRKTAchW
         rrCydNRqFIkZEnlX4Yj6O9DKGn/0Tae2Oc/e2k3V0WwjqmWvVgyWvOQT8UZlQ9fWiXss
         /VS42lQFIFf5e07AiHp5loTPo9uLB5SnsBCSZiY0M/RYtw7IxqNdiI3W/YNjUUeogfrs
         dWD6NYyFKKCDIvVYPpko0vPU/bY/suZ7NBvP316xijetq2zmz8WzfKMsAUP1g7pg2Mi4
         kWxQ==
X-Gm-Message-State: APzg51BkXZy1CpXzXc7/f+OZTj9qyNVJKuSR1hKE3Z5jqBEjyBDh0cxb
        p9hX/4BrbXGRjfw3YRrrQumeBHk5+ewEGDJ42FtdZw==
X-Google-Smtp-Source: ANB0VdYT3J60tFzl/js4BQd1rCljlX0EKfsay/ko5tRNz9XLMbCLFzeEotZZ6Tncf3Hm0D/onTfVzMqZqajhXtPhrdA=
X-Received: by 2002:a19:988a:: with SMTP id a132-v6mr8669105lfe.76.1536466956878;
 Sat, 08 Sep 2018 21:22:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 21:22:36 -0700 (PDT)
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 9 Sep 2018 09:52:36 +0530
Message-ID: <CA+G9fYuNuf7+57bMbB3FVJ1f6tH64aBGO0XRySgJKnPjHXZM1w@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/145] 4.18.7-stable review
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

On 8 September 2018 at 02:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.18.7 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Sep  9 21:08:26 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: 778167eee1b92f5bc2405840b2110af2f6bb9723
git describe: v4.18.5-270-g778167eee1b9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.5-270-g778167eee1b9

No regressions (compared to build v4.18.5-124-ga6a229cf7e7f)


Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 20, fail: 1
* kselftest - pass: 59, skip: 45, fail: 8
* libhugetlbfs - pass: 88, skip: 1, fail: 2
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 26, skip: 9,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1016, skip: 133,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 21,
* kselftest - pass: 63, skip: 39, fail: 7
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 27, skip: 8,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1015, skip: 134,
* ltp-timers-tests - pass: 13,

i386
* boot - pass: 22,
* kselftest - pass: 82, skip: 40, fail: 5
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 27, skip: 4, fail: 4
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 18,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 8,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1688, skip: 40, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1087, skip: 59, fail: 2
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 22,
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 26, skip: 9,
* ltp-filecaps-tests - pass: 2,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-math-tests - pass: 11,
* ltp-open-posix-tests - pass: 1689, skip: 41, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 21,
* kselftest - pass: 50, skip: 53, fail: 5
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 79, skip: 2,
* ltp-cve-tests - pass: 23, skip: 12,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 8, skip: 6,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1050, skip: 99,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 21,
* kselftest - pass: 57, skip: 47, fail: 8
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 25, skip: 10,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 8, skip: 6,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 992, skip: 157,
* ltp-timers-tests - pass: 13,

qemu_i386
* boot - pass: 21,
* kselftest - pass: 82, skip: 45, fail: 4
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 28, skip: 5, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1058, skip: 91,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 21,
* kselftest - pass: 77, skip: 48,
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 30, skip: 5,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 993, skip: 156,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-cve-tests - pass: 25, skip: 10,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1690, skip: 40, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1071, skip: 78,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 24,
* kselftest - pass: 83, skip: 41,
* kselftest-vsyscall-mode-native - pass: 83, skip: 43,
* kselftest-vsyscall-mode-none - pass: 82, skip: 43,
* libhugetlbfs - pass: 88, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 30, skip: 5,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1688, skip: 42, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 118,
* ltp-timers-tests - pass: 13,


--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
