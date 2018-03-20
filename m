Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1923497-1521566588-2-7760928130845452001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521566587; b=qGjLZ4YI08wDMjO5LKWNVP9HReYPuWPHaauWgCdbYTLsaVT
    6SjWlYYp3QQdNib/O33J4lfG2YjueosDmbUs2DVZ/YrpX+j8az8sfggHskNg5/Jg
    YjYp9mxdL3Y3XDIA2g4tvVw1oaHZIVJwJFcogcMtKcJgHuT2odyLZ1f/js6CBzqp
    BZLF3XlMLg5nRgiKUNyEsfTqtXlhdRGuqNjurH9bKdU4+W8Ezem75zc2ViKxyg1Q
    yYX28Vc3czfhdBnhWIPtGDK8+CN19QthSoIBO0roJ8aqp3sblWw12X9Aqp0c8YM+
    edHDxXyHVM5aJOXRfSSSd6J3ZtaFL/ZNxcghgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521566587; bh=Ub3hp8vjlQef4beIHEpY0SNGIMn8gRTmzpUMeRlHmzQ=; b=j
    Td3KPSRfiEYmtKOxpF3508zUbUcV94P8BnQLQgrPXV8YjWEaGWmCKgyMjPo1G2G5
    BZKhvbxbaU/1B8iL/jYjM4PCPmVG8VH5cu2CRPuFX/36PLZ7NO/nx88Ho4wntbKw
    HgjBZ+hKBR4WQgNZiVQ+HHsqdA/5B5ap9/touPN/3/sv713nl6zWjozkOIzCIxLV
    l2dPQlB7ebUFWb7hFHgh4nAjpshwiRgE7CYH0QoghSUUJ+1erOobvYo8vBa24Nob
    jpYkcfR1VNWA6ILuu49g/gbOKxkrb0W1k+EmI8eT+BslUJkta+ODFH9nPVCsTwBf
    /xr/DL82CcqaYDardMmSg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=A96JgCiL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KJn/Px90;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=A96JgCiL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KJn/Px90;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCTRWx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 13:22:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37495 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeCTRWs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 13:22:48 -0400
X-Google-Smtp-Source: AG47ELuKSnvk0z6EC478FlS33uXvILCJIUD7ageg3aNzif3HyYtPX9r+Any62yO7kr19DPsXch2n6rr2lMWfqJYojqQ=
MIME-Version: 1.0
In-Reply-To: <20180320075012.GB10034@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org> <20180320075012.GB10034@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 20 Mar 2018 22:52:45 +0530
Message-ID: <CA+G9fYsGwYQ1pEdp3vec6823GNcMpRqQzv7Zdt+CbBJAYMNU+w@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
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

On 20 March 2018 at 13:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.4.123 release.
>> There are 134 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4=
.4.123-rc1.gz
>> or in the git tree and branch at:
>>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git linux-4.4.y
>> and the diffstat can be found below.
>
> -rc2 is out to fix a build error that was in -rc1:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.123-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.123-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: b4e03b46235c27f79031a504b8bf20d085338f18
git describe: v4.4.122-134-gb4e03b46235c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.122-134-gb4e03b46235c


No regressions (compared to build v4.4.122-135-gce9da67811cd)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 34
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 152, pass: 998
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 33, pass: 47
* kselftest-vsyscall-mode-native - skip: 33, pass: 47
* kselftest-vsyscall-mode-none - skip: 33, pass: 47
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 29, pass: 33
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 2, pass: 20
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 98, pass: 1052
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-native - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-none - skip: 31, fail: 2, pass: 47
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 1, pass: 62
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 5, pass: 9
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 120, pass: 1030
* ltp-timers-tests - skip: 1, pass: 12

Hikey test results,

Summary
------------------------------------------------------------------------

kernel: 4.4.123-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.123-rc2-hikey-20180320-153
git commit: 0ad868c09a57249a737a21599412c085870c72ce
git describe: 4.4.123-rc2-hikey-20180320-153
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.123-rc2-hikey-20180320-153


No regressions (compared to build 4.4.123-rc1-hikey-20180319-152)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 32, pass: 31
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 154, pass: 996
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org

>
> _______________________________________________
> Lkft-triage mailing list
> Lkft-triage@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/lkft-triage
