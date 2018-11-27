Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7216D2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFkXZEP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7216D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeK0X76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:59:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33341 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbeK0X76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:59:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so20006751ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IM0bl37Kz3WRBAmTXbqSVXJf04kRGph//jVJyBBS4ug=;
        b=HFkXZEP/rH7DW0SzCkjib9PIy6UxZOvkcAFLtAHaSpVAW25ipRCYp8dOpKVuE1gNlq
         3kV22ep7kSnWflLWyb900SCqzyqPLaDqCGuKRlf0RiMUagGhdKzzH1CRnNTR6WMH56ji
         5HtkAhJwJ1ExcjZheDJhcKmbGVueqi2Vh25qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IM0bl37Kz3WRBAmTXbqSVXJf04kRGph//jVJyBBS4ug=;
        b=R3sFjuZGvstQaqphzGLa3RGB6e6SIPKQ8G/MgmZwit/18+B4KYcGwIe9ArZ02281AT
         ICIXeBes4JcrfClN9FpxCvaGtJzRVVTCFZoNZXtIuCikzXZ1brloVcIxerMrh9AczRpr
         k1vF2TBBN98LbZLGE5oGDs3MSo8K2VMqZYbC+KHpKvJFDldC2vQ9SbVCekX2BIIvfTFy
         qlL0FiZj6iRtrh/2yIImLt8NDoG8s6XGxVWIHM+QwuyZ7V3SKHFg/FA7CfQN7gEneRiS
         kYghbso+jtd/0lxp0M/WhwGskIBhAq6G8av/OEMyY7E/2B8D17ZvuPuHhxjTKmykPJkD
         PTBA==
X-Gm-Message-State: AA+aEWbX8jpaV9CUySglWjqcqYjzOw3gZwp/S8MxWz5rYdZe0RRSu+hP
        GP0MFw/5C9huBu8LVRmb8l5RhSNWouaohuSMNETwzQ==
X-Google-Smtp-Source: AFSGD/X/NMb3tg3ijY2PjrL1Ug1W4AeuqXSrHOo3Ohz0ylxXmQ6ik9WKEzkjVnksJ2cVfvERScT2gtQEDOIJ1dAebbM=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr10351750lji.30.1543323725484;
 Tue, 27 Nov 2018 05:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20181126105050.592727680@linuxfoundation.org>
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Nov 2018 18:31:54 +0530
Message-ID: <CA+G9fYtP0C4aX+870th9Sdo1c6TMXe_rmVHS-T49B1zssPYqfg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/62] 4.14.84-stable review
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

On Mon, 26 Nov 2018 at 16:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.84 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 28 10:50:20 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.84-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.84-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c203efd3a8fd7ddeec1ea4bb6f7c6e36c95dfd40
git describe: v4.14.83-61-gc203efd3a8fd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.83-61-gc203efd3a8fd

No regressions (compared to build v4.14.83)

No fixes (compared to build v4.14.83)

Ran 21442 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* install-android-platform-tools-r2600
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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
