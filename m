Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2071779-1519235907-2-5468108055906213042
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519235906; b=RHH0qUcT3btTccJJpV0onf4FAJIvqylWsn9dYEvpFLzVo6Y
    P0hJ1wHrnNcGA+FCU30N2P0VjOa7rQ5T2u6R537Ao99MymkYfZtIqlcoN8lyYTiW
    BNdnf88RgDddOVLPo006jT2Vejao5r7aZ6j/lQz0Sp87UmHFfqAQt41f6b2s3YrC
    3traItdg2A3a+6g+NPGkk6Mii0C5Qc2/4CavWYz42e8TlpoGOG279UYucyvfbPvR
    7NrODHLUFwiJHQ9iPVkmAPslYU5RceDwQqkxJ5FNWcOI3XBlUzTEF23ERP/GHF9F
    jsCCo8sE8DjNy0Fn7yWSHUTz1zw2OWHHs/w7IqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519235906; bh=ucLDbgwL9BJbYP9+TakGcToU1n2OQU+/qLeoI3FX3YQ=; b=T
    XKSaQGw/yh772hO7yj49GIRMzHVgIliJIcPiHXjbkjjFgnCM4TbOowyNbRUvwxia
    43AYOzXTqkkcUvZZSplSrfJJ9IXs3PeWUc6on33cUGxh4r4f+2o2Hv7w3hUDMf9C
    6ZPsU2c9/6Uu3CNOSOkBzmfezuSQRv95JUW4HOdco2HbxMsDA/OqTa6upL+lNluI
    yL/08NkqVsfW3wMrOC6V8OuhQMZYCG8vgL0fPSHXIJQk0BzUSFhqFCjas2AUJKv3
    k5MbjE0MnT+xHofPxKnYQbdd2CZgkR7RWrcUTFoJ2n9ZZ69sUEInUVk1OfjQBOlR
    IoFxtKu8ROlJiTfoBeioQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=G0QtV4wF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QCSlh5AU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=G0QtV4wF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QCSlh5AU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938865AbeBUR6K (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 12:58:10 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43530 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938843AbeBUR6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 12:58:08 -0500
X-Google-Smtp-Source: AH8x224iZ7uzOfFdZusIZXdlie00rbiKw/ja7m14PL8jUrSoLXnUoTfXz6d/BSwcU5MjhPhHXPqoZeOxN9DX1tqnEMM=
MIME-Version: 1.0
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Feb 2018 23:28:06 +0530
Message-ID: <CA+G9fYswizFez81cePm0jDumFnDb-Lis8aVM5ZESpOvNHTOtiw@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/33] 4.4.117-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
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

On 21 February 2018 at 18:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.117 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Feb 23 12:43:54 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.117-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.117-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 4335fbc640f95fcd163c5883d21db1ea69ac89d3
git describe: v4.4.116-34-g4335fbc640f9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.116-34-g4335fbc640f9


No regressions (compared to build v4.4.116-31-ga9bb1b3548e5)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 29, pass: 34,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 53, pass: 28,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 2, pass: 61,
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
* ltp-syscalls-tests - skip: 152, pass: 998,
* ltp-timers-tests - skip: 1, pass: 12,

x15 - arm
* boot - pass: 20,
* kselftest - skip: 29, pass: 33,
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 2, pass: 61,
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
* ltp-syscalls-tests - skip: 98, pass: 1052,
* ltp-timers-tests - skip: 1, pass: 12,

x86_64
* boot - pass: 20,
* kselftest - skip: 32, pass: 48,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 1, pass: 62,
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
* ltp-syscalls-tests - skip: 120, pass: 1030,
* ltp-timers-tests - skip: 1, pass: 12,

Hikey test results summary,

Summary
------------------------------------------------------------------------

kernel: 4.4.117-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.117-rc1-hikey-20180221-136
git commit: 72c8203f873c91e20d9b75b7198937d340eceb84
git describe: 4.4.117-rc1-hikey-20180221-136
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.117-rc1-hikey-20180221-136


No regressions (compared to build 4.4.117-rc1-hikey-20180221-135)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 32, pass: 31,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 53, pass: 28,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 2, pass: 61,
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
* ltp-syscalls-tests - skip: 154, pass: 996,
* ltp-timers-tests - skip: 1, pass: 12,
