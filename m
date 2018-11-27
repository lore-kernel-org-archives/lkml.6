Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47AEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4902086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9oYPk7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4902086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbeK0XyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:54:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38493 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeK0XyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:54:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so19957566lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 04:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sj+YEBKh6IZbtCxd96CVlqPL6OI7LxngIO3QPMVCQyw=;
        b=V9oYPk7clwm5wC+CW5uq9duRicLNYzTmzPnVruFUje8MXqVUO0Rh0uH/GhgiDgTh/t
         3apFtaOKCvzmsWOo9EUsronu9RZqGXVIKy5xPvjsyct/JVRp4zz9LgoVcmpTTtbfehQD
         VGFrjBeIQgQxcLvXP8+MJ0aOxDJGOl6fEXGHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sj+YEBKh6IZbtCxd96CVlqPL6OI7LxngIO3QPMVCQyw=;
        b=aS9SQCfnqTHdv944yfJOfTd2oQCmfYormJAhuznLt6mzdOz9Fq1MEi1NmUbU0mcwql
         A/KZMowuZJuaO+zqqjEDhx9OnX+gk5oyrL6km7/hofBWvUp1qKh7+NPiAsmSUjVm8jJl
         E+C4t6jJ0pzNc/CO5s81pma5Ava3+GMm5wLGzQ9jXka5bq/0WfjHmgiyMhca1GtZc6Gt
         Uka1i+dUd1n2ldWo22OPqxF7P5UOd74PUQFSeMvzbgQQktXVntf6vRbywnKLS385I6RC
         A9GXOPWkmk5gKqtkXSQoYPfpt/ZHNgrOhF6BnhXw8S9kEMe/LaNY4VhlXeqCYkadGc1l
         H9yg==
X-Gm-Message-State: AA+aEWYhJNA64i88wt+IZbrudWgxDgF0u0M3YH0M24leOkstHwIKQIJS
        OHA43L0sO3xtPb7zw8TbbQFyBPjUez9ePZ5JzojX6Q==
X-Google-Smtp-Source: AJdET5eR3Bb2qIsCeiaxAQ9ZPYUb24IzVW3kvXNee4vaNyyINBssIyMHbhEheJSZLFoeelM9vDukaV4sa/KkXP3WOkU=
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr17313264lje.88.1543323378378;
 Tue, 27 Nov 2018 04:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20181126105059.832485122@linuxfoundation.org>
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Nov 2018 18:26:07 +0530
Message-ID: <CA+G9fYvoVbubi7tY-8QaEPJDKb6khCKgZFvs0HfUq1bWmxyYhQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/118] 4.19.5-stable review
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

On Mon, 26 Nov 2018 at 16:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.5 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 28 10:50:22 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: be4bbf9fbca5867a720f1f53c7de48e5d493f847
git describe: v4.19.4-119-gbe4bbf9fbca5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.4-119-gbe4bbf9fbca5

No regressions (compared to build v4.19.4)

No fixes (compared to build v4.19.4)

Ran 20282 total tests in the following environments and test suites.

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
