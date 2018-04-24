Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2543453-1524555664-2-18057384381627231095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524555663; b=c7dLg1+ghNVvE15FFOMzTMIRUMhq3kDnv+ucN1POMXkDw3DaZO
    /x4Ma3Kpbd+K4oFHkEUJa1WiaeDwLQIrtyKrLyJZTabeZ1cJntaHsJ7lHQQwcYBf
    9ZqCUvb8xhniomRaszyKg6OeqfS7PHB3RjO5qPsjwSCEr3F/5xw+dbSdJ5tbG8gL
    RQhWskY0QexPV6G+K+aDSi70TIWOfsTY33F+z2bUOoWrh88j0ngo8/8IvGozLRzp
    KXMEw18AevjSjzjCDMM/9XG7qI8dtLIskUjgDb/0pcDT2bRJRjvsL0f2XlWclj4D
    1nVyyyhkiuJKVc8S72sTTLxJJmGUU2Pbl7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524555663;
    bh=2qbiigEfX8SoIGowCWptoAGF8UX8WNWHknqCLF8Ap7k=; b=Zv2EndRcJelI
    dEyR2rTZJTWIPuVj37xx/QULs+LyTnaktxtoiiLq1btXkVXWT49sd8zClx/2/wIj
    pX+Tvo2o24czFzeJQ9RASnmQ699vGlX526FqAmymULYAmk2f0vmOTCeGXItym38D
    jcUrEC5YZ9HWvi8LTU/PkSpzMGR9o0Ze4L6lgtsJGxd8+A3L4PVoh1+ESW6xB6pY
    47EOAR8QSnu+DYBin+zTxoP4e2f9UT7Tl8LHfl8H+kvqZhrQXHm7scwwLvB3ihkO
    r2Tg7wOkTAErrjXSNK7uThj4ZJjpcVfWCawPwtL1ZiorYEzh9O/Y0b0RkUFn0TBx
    PIZlja/L/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=F5e41Wdd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ixBoaP/b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=F5e41Wdd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ixBoaP/b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBaCSxLnLSnKqoEReldbGxHdFWnycMYl9K0nYLH+7gxivyKCSEMU7BouecGD35U7DKS57iKgFHt3o82xIL3LeVypNqefGzzKoxy2oV3tADHONE64iHFs
    ANM12fCL2HD3iC4f1tMf4d7KsPv4WLeIZeesutLY3rKzGdFX1kJYHEd4xoEIu/Q4TT7v8YbwM/C5qp1WWPz+MJLSJnOKNem6tBUX4W4/V3/2rTsTtKNr5HkG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=gWx1A5luGpKtexyLMGYA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756288AbeDXHk6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 03:40:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44718 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756112AbeDXHk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 03:40:57 -0400
X-Google-Smtp-Source: AIpwx4+pUNiCFh5YSuXxZH14XbkCdgf2MZct9PLnJQtdZqpRI00O4QqSoLpUm8kjP0V+vxd54eb/wYNA6AsfWwkHscI=
MIME-Version: 1.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Apr 2018 13:10:54 +0530
Message-ID: <CA+G9fYtqza4mRzO-LohE3s_UkzxAbC1nnRNwMJtWXdEY4M_CAA@mail.gmail.com>
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
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
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 April 2018 at 19:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.16.4 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.16.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
Few comments inline regarding the reported failures.
You ignore these infrastructure failures.

LKFT: kselftest: qemu arm32: zram test causes NULL pointer deference
https://bugs.linaro.org/show_bug.cgi?id=3D3765
This is currently happening every time on mainline and 4.16


Summary
------------------------------------------------------------------------

kernel: 4.16.4-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.16.y
git commit: bc36a03baa9f6a85680606030ddaf5c6495c030f
git describe: v4.16.3-196-gbc36a03baa9f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/bu=
ild/v4.16.3-196-gbc36a03baa9f

No regressions (compared to build v4.16.3-197-g405d1f8b04d1)
------------------------------------------------------------------------

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 20, fail: 2,
  ^ infrastructure issues
* kselftest - pass: 41, fail: 6, skip: 20
  ^ kselftest failures caused by kselftest upgrade to 4.16 (in all cases
  in this report)
* libhugetlbfs - pass: 89, fail: 1, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1017, skip: 133
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 46, fail: 5, skip: 17
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
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
* ltp-syscalls-tests - pass: 1016, skip: 134
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 45, fail: 5, skip: 18
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
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1017, skip: 133
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 21, fail: 4,
   ^ infrastructure issues
* kselftest - pass: 75, fail: 9, skip: 52
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 62, fail: 2, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 22, fail: 4,
   ^ infrastructure issues
* kselftest - pass: 84, fail: 6, skip: 50
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
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - pass: 51, fail: 3, skip: 26
* kselftest-vsyscall-mode-native - pass: 51, fail: 3, skip: 26
* kselftest-vsyscall-mode-none - pass: 51, fail: 3, skip: 26
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
* ltp-syscalls-tests - pass: 1003, skip: 147
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 38, fail: 6, skip: 21
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1075, skip: 75
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - pass: 55, fail: 5, skip: 19
* kselftest-vsyscall-mode-native - pass: 55, fail: 5, skip: 19
* kselftest-vsyscall-mode-none - pass: 56, fail: 5, skip: 19
* libhugetlbfs - pass: 89, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
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
* ltp-syscalls-tests - pass: 1034, skip: 116
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
