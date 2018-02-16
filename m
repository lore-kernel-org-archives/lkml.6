Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3465934-1518760900-2-1225808281592438041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518760899; b=pq+sYxwiYvU1fPZVIZe7uPsOlqx4HVo0JQFJx+0knLwS9VD
    5NsQSuVILdiVrzvhsIQ8zbjnCF0ti0Gt8WRMTMceFrh67UfQRIzMVLEPjY6jO5/0
    G3Na7UXlZshP+DyKSJYRt/RU+Zv7hdQ3BGkedU1pRhOerKw8DV7ZljuEandw2bPm
    czc1A8FVpvhM5LiH396f0dkwUsq7tIzGJwhKa5qawr2TAaQAHmFv37zfyoWQSdh0
    9zX1Z2yTXG7gYY4cu3Q4Rk6v916AqMycZ/LuS5xRfeprYpZAurbSXcqt47cByC4K
    a2Ki8qXnm4eobtB8fWlyZbZrNxxbJINNtQ4V6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518760899; bh=qXjiSpVpm8EZ5blk8/F2BQsfT4kY0ph/Ncn3PXLjCgk=; b=S
    hd4N1w94BmPX+be0qea68CNweHKNEJm4fsfsXb3/o2X0JeMRCLIDdK2wm/2BkUrK
    qvH82l9j2ErDP6Px9nonodhG258spE3buQge2e1g2k72lkPqLyKi18eEEnzOMGgr
    AivMGP5ZlpammBp+ziKJ1nBYFrdAfH+VOWzpyQPyjv3k6Xn7SyBzCp6+tElWozZ9
    nucNkoV7OwU0PyPj9FbuNFz8klxLjs6ezSWTxU5u/s88D1OCUx8MwoRaB2H+ElWP
    wuTsIMNw7Y6GliS1bebRN8+Hr95LVmOJnIUZT7rsH6GfeiQgLvJf7Kg0hBLkJxI4
    W6IqJGPF36iJkjRQ30BjQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CYttkkn5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iPiALCC+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CYttkkn5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iPiALCC+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeBPGBi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 01:01:38 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33220 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752956AbeBPGBg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 01:01:36 -0500
X-Google-Smtp-Source: AH8x226eJIiwJvtZsfPjGUhz8EgEatfD75NBRrcqE9Baq8Cn4uTye1jLAFwsZ+VCAAF0KBHHvUkPsyKvGLyqT3cj564=
MIME-Version: 1.0
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 16 Feb 2018 11:31:34 +0530
Message-ID: <CA+G9fYtF3woXJ9jLLcyEESZT6VynLrtzcGq0SwCT4YWQZ45VEg@mail.gmail.com>
Subject: Re: [PATCH 4.15 000/202] 4.15.4-stable review
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

On 15 February 2018 at 20:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.15.4 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Feb 17 15:16:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.4-rc1.g=
z
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi=
t linux-4.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
LTP: netns_netlink test fail started from 4.15 on ( armv7 ) beagleboard-x15=
.
tun: section 3 reloc 18 sym '__memzero': relocation 28 out of range
(0xbf022224 -> 0xc10a3ac0)open: No such device
https://bugs.linaro.org/show_bug.cgi?id=3D3484

Patch is in discussion to fix this problem by,
[PATCHv2] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
https://lkml.org/lkml/2018/1/31/577

Summary
------------------------------------------------------------------------
kernel: 4.15.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.15.y
git commit: 01be67fd216daa47afa25bbfdd555eff8a66ce3e
git describe: v4.15.3-204-g01be67fd216d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/bu=
ild/v4.15.3-204-g01be67fd216d


No regressions (compared to build v4.15.3-88-gcc4b654d33e8)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 9, pass: 57,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
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
* ltp-syscalls-tests - skip: 151, pass: 999,
* ltp-timers-tests - skip: 1, pass: 12,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 10, pass: 56,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
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
* ltp-syscalls-tests - skip: 148, pass: 1002,
* ltp-timers-tests - skip: 1, pass: 12,

x15 - arm
* boot - pass: 20,
* kselftest - skip: 12, pass: 53,
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 62, fail: 2
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
* ltp-syscalls-tests - skip: 97, pass: 1053,
* ltp-timers-tests - skip: 1, pass: 12,

x86_64
* boot - pass: 20,
* kselftest - skip: 10, pass: 71,
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
* ltp-math-tests - pass: 10,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 118, pass: 1032,
* ltp-timers-tests - skip: 1, pass: 12,

Documentation - https://collaborate.linaro.org/display/LKFT/Email+Reports
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
