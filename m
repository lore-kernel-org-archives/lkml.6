Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2195869-1520014740-2-1252022008700737229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520014739; b=IlAZt1+30odY/7aAbBLdLHXiw2yve1H+LRT78Vxek9L+/M/
    BJDzGuncrZa8Ly/c5qHVYAmuqTRhoVRzTYrLYHDvBFeDlTOy/+gmqNk31M8/fWUQ
    vYXYKcydIpug0yEy1JU7OQzFqEbY72TAUaIrRC9jUgs+axEdVjA7mI/KCOXGfZoy
    hXDBS4TcsonUOPRiYCPki6gwKiJsOAOQAWqeRKm4bcz1/AHUzpaugY6TAANOiaJg
    /MjNs1t4g7lypPvv+BKvnTz8y/8DPASPYH3cWx9qPkJ6ILJDIqBXUG82p8sGTu/L
    GZ8rMXmYxbcXR1w4PKYJCmata+CGgO6PkryxxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520014739; bh=ToL4uU7pFIOHjGWfMSBJx7G6dY5/jK8Vf0P6OuUKUOM=; b=P
    Y0s6fDUfqm7o/N3J/uJI+3U/U0FaFF+fvtSs3o/lklN1KaHZdSoDjypaO45VRDft
    nsObMM3QjFzvPDE46/0MD+q5BibAwyyjEmURJZ3OFoPYvUcxe504nXfysScdB0gY
    I1rOIdfcODELtmRDJiSN0dgItBsyVQTqEar3Ik0MbUE8DHTbalU/PzgwtId6XM2f
    b8c3h9xnlUuRvFtlE8Ewfgig5NbEOYZkUjRlLvaEWG8z8BsvkJmKvDBte4LOW4LL
    zspXNUhg7Gg9S743V5w0eiaMT38u9GizH0e4USGctNWaySSNWxQtAe8lHmShmQbO
    Tqaeyu5e4KEnXRW/wCjAw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bex5Wj46 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qZq3+1z5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bex5Wj46 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qZq3+1z5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428575AbeCBSSy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:18:54 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36181 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426672AbeCBSSw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:18:52 -0500
X-Google-Smtp-Source: AG47ELtw+Gz7b6SswOaduK6tJ9d61/R/lUVb3L77J4r+A+OT3ZW0tjOevG1faPrKbSz6ZPVdExziq/c2Zi222RsCHBg=
MIME-Version: 1.0
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 2 Mar 2018 23:48:49 +0530
Message-ID: <CA+G9fYsbD5bU8-8X8g8x-cPc95PZbA+-_TQ7xzEwxQ1A3PPMtA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2 March 2018 at 14:20, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.24 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar  4 08:44:32 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.24-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
dragonboard-410c and qemu-system-x86_64 are added to testing device pool.
ignore boot failures 3 on dragonboard-410c are due to local LAVA setup.

Summary
------------------------------------------------------------------------

kernel: 4.14.24-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 0ae11358b0bdffc782ee655fd103b95cbcafb899
git describe: v4.14.23-116-g0ae11358b0bd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.23-116-g0ae11358b0bd


No regressions (compared to build v4.14.23)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 24, fail: 3,
* kselftest - pass: 52, skip: 37
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 4,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 18,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1012, fail: 2, skip: 136
* ltp-timers-tests - pass: 12, skip: 1

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 48, skip: 17
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 999, skip: 151
* ltp-timers-tests - pass: 12, skip: 1

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 48, skip: 17
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1001, skip: 149
* ltp-timers-tests - pass: 12, skip: 1

qemu_x86_64
* boot - pass: 20,
* kselftest - pass: 68, skip: 14
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1004, skip: 146
* ltp-timers-tests - pass: 12, skip: 1

x15 - arm
* boot - pass: 20,
* kselftest - pass: 43, fail: 2, skip: 19
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 62, fail: 2, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1053, skip: 97
* ltp-timers-tests - pass: 12, skip: 1

x86_64
* boot - pass: 20,
* kselftest - pass: 61, skip: 19
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 62, skip: 1
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 119
* ltp-timers-tests - pass: 12, skip: 1

--
Linaro QA (beta)
https://qa-reports.linaro.org
