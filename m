Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1A0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0770F254CD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zhe2xqye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0770F254CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeFYGk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:40:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39182 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeFYGkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:40:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so13502575lfd.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D5dLiLRMl5arfjDf0ZdE2FjaY6DcwT6n/cn4j31TvJ0=;
        b=Zhe2xqye6goZuIyJA8qbC2J/z+35r7eJTqP+FiWffNBzoHRsMMfo348GpWJ5buiaWT
         9SpIXa2WjivBn0C+NoWx7KXc2V+RM9nPJBVoZHlfewfsw2c+XZ9Tq7pnhf1FFpvHQ+rl
         CaxDdz8L15Mdm2ScQRqX1zncWUm5S1dRuVbSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D5dLiLRMl5arfjDf0ZdE2FjaY6DcwT6n/cn4j31TvJ0=;
        b=eWhjO+38keHd+qJmC7ha5/yh+dGXcTyxRWO4MH7Uz/AQ4nG24YHVlQCj+uAocx/tF8
         oXgNTnOtyDlc1/XkbMOptEdy+BUwD8yMyZ53Y9fa9165vaXzzJlT6H/pEhfi5OtlIMVy
         DQzEwoHJRXB7oxMqzT3SZXZgxKdn5Qx2C5ZCq5z5uBZTag6FFmoZTwGGEH8zEpSTkL9O
         C7aJUKILZT/J26Tn0+qvTqxAh4aHRJx5bS78CmzE7Ta+lDLtWrK/8rIBJOuLPj4QENyi
         3ZbdUri0Gz8jBozIL49cYzai4dRO4Hrm3UwuR1YWUP/MfYFDUZ6Y4ecO9Is34f5hF1ew
         bBFg==
X-Gm-Message-State: APt69E3PFcmFkjOmhYq1CTb2A7jlygSbywsZ/0T70cLJLqWTXAwOCDYi
        r2jF2qOK44Q7BGodFY2I3lJs4I5zdgPa+MtaQ0aWhQ==
X-Google-Smtp-Source: ADUXVKJBm/mfFpmdCeOaboNI6/rqURRkhS5J7ioaGw0FXvuKWVqaj1nTIJClK0DdH5XFbdTZBKpsgcUF2O9jxpwBQjY=
X-Received: by 2002:a19:51db:: with SMTP id g88-v6mr5300500lfl.78.1529908854184;
 Sun, 24 Jun 2018 23:40:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 23:40:53
 -0700 (PDT)
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Jun 2018 12:10:53 +0530
Message-ID: <CA+G9fYt46ZPvsXE7k=X3CtAb_T-3XqNQgepTt4TVzD1aVeZ+wQ@mail.gmail.com>
Subject: Re: [PATCH 4.16 00/64] 4.16.18-stable review
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

On 24 June 2018 at 20:51, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> ----------------
> NOTE: This will be the last 4.16.y release.  After this release, this
> tree will be end-of-life.  You should have moved to the 4.17.y tree by
> now.
> ----------------
>
> This is the start of the stable review cycle for the 4.16.18 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jun 26 14:27:22 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.16.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64 and arm.

Kselftest test case mov_ss_trap_64 is causing kernel panic on
qemu-system-x86_64 and PASS on real x86_64 hardware.

Reported upstream,
https://lkml.org/lkml/2018/6/25/19

Summary
------------------------------------------------------------------------

kernel: 4.16.18-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.16.y
git commit: cb293ac209694e14e6348302f0c0b213eccaed3a
git describe: v4.16.17-65-gcb293ac20969
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/bu=
ild/v4.16.17-65-gcb293ac20969


No regressions (compared to build v4.16.17-13-ge3e37a950711)


Ran 11391 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
