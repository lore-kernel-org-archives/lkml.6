Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4189023-1521909089-2-207415495459545017
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521909088; b=YcJmhF7PVBzipSaS7Z/ILrBUHFMOznyygKeqA5u/FDjGQUf
    255gQhLkoUKQmmRozXcnTljk7mSrkFkY15G/wtchWqqI3kuPfIscit4GiFvJ9n2J
    /odgLZTEpX/ZEeacpZNSWukKYJpR2WHk1QNaP5nyFLxxvytRyigsQJNxeEEEbdm7
    icwTHsTOEMOQSvWflw/KYaGdjPFm42L+Ym1Dr2jNCXWHtTnuFYJA2BkOjbbAJpNp
    6BWw7xuocmtzK5UcTTAWh+t3+u9hrsDKE9s+O6EtaNIBlzxe86w466TpFXi8Th/O
    cautyfSlVA2d0ETUbrKRFbRr7NiQ5ROtJNedJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521909088; bh=GgY/0UYQX/4r7tbYc4GrePElyAg/g6YTkDisX/3aALo=; b=s
    Gax9HtsUrSI8ddhugeEOdJ3/+xbuozeAAYsOVSLCa9nwj8hKERY+Z72bIB8GtI2n
    H6OErfU7vXiRHYepLUVmWHHc4+lgmTIumthIUK59A1460KPE/E78Y4rNhHWDsNnr
    6W1avPkpjo7YDyYcwPPey89KKoDDYmT3THvVks0se4Z3iWmZvhTKtBlx7OTIOW+B
    dvXi9XgThdDeIQSh3vt4rFg3wwQAqFVCXxB6okA9yuoKWpl5zWacpFzGVQx/0U80
    ifLfL8Osqv7WATztyVSkEpiVytMzsNwsjRvRjeYtB7275zJ2LtnUFeuZUUO0Jygv
    m5K5sSQLMkdLu1lEtYioA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=B4yYypPr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q/HhOCsU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=B4yYypPr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q/HhOCsU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeCXQbZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 12:31:25 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:41064 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeCXQbY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 12:31:24 -0400
X-Google-Smtp-Source: AG47ELtDnNTjDJAmCHaEoDqIQtzuV34Mo+Y8G0PT9idr7Wcgic2cRh54DOIM6uP+dM8Nm9gkMZL4XX/MKyNrPa+ycug=
MIME-Version: 1.0
In-Reply-To: <20180323173622.GA1213@kroah.com>
References: <20180323094205.090519271@linuxfoundation.org> <38f8329c-79fc-c217-69df-4bb5dba024d2@roeck-us.net>
 <20180323173622.GA1213@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 24 Mar 2018 22:01:21 +0530
Message-ID: <CA+G9fYvZSXn+6c624YPzb6ivueydNGhxWEZPT3U8Yo0GnynO7A@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/177] 4.9.90-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

>> Partial results, build only.
>>
>> Build results:
>>       total: 145 pass: 143 fail: 2
>> Failed builds:
>>       arm:allmodconfig
>>       arm64:allmodconfig
>>
>> drivers/rtc/rtc-ac100.c:570:14: error: implicit declaration of function =
=E2=80=98devm_rtc_allocate_device'
>> drivers/rtc/rtc-ac100.c:599:8: error: implicit declaration of function =
=E2=80=98rtc_register_device=E2=80=99
>
> Offending patch now dropped, thanks.
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.90-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 87485cf16bc78d10cc59990ecdf640d34d8846d5
git describe: v4.9.89-177-g87485cf16bc7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.89-177-g87485cf16bc7


No regressions (compared to build v4.9.89-178-g8d6f4aae473a)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 23, pass: 40
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
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
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 28, pass: 52
* kselftest-vsyscall-mode-native - skip: 28, pass: 52
* kselftest-vsyscall-mode-none - skip: 28, pass: 52
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
* boot - pass: 21
* kselftest - skip: 24, pass: 38
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
* ltp-syscalls-tests - skip: 97, pass: 1053
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 25, fail: 1, pass: 54
* kselftest-vsyscall-mode-native - skip: 25, fail: 1, pass: 54
* kselftest-vsyscall-mode-none - skip: 25, fail: 2, pass: 52
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
* ltp-syscalls-tests - skip: 119, pass: 1031
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org
