Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA82C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DC32086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMxleEng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DC32086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeKJAVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:21:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43318 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeKJAVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:21:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so1482834lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SQcgIR1s9phtlv8DEcxb5T8LZvhEYdJxW+FiLMUwXCE=;
        b=UMxleEng2rCSIcf2JRiJRZD+cH+YsPQlnk791SWN5aPdZfJhdIQUX29VsM86ItFTAU
         6KILlRZxOWQrlLePHbtpE3bzpanaa59Qpg6Dr8Wf5VJ+3MmiPXlZvcWXJDqCcoZH3T6F
         BEOXacwTwXHOOcjlwmB7oWE9iuz8ulCtY4hbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SQcgIR1s9phtlv8DEcxb5T8LZvhEYdJxW+FiLMUwXCE=;
        b=ghGpI9bFwecI+pbbr2L/qldthRArC8u8iqYfWzs1AlTn5VhcE6BKGZEg7eYYmFpqW2
         yqdTCJoTF5yq652/tB7i/BqqfzVyqNsBdwYIoU54gxJjqKGd84PtK2rsCPs1qtXoijSj
         HW56+IdsuESiVUxWVqJpfZ8hyYmh6FiTAaLJkk2sLnvvJDau2BI4BdHG7HZmL+ceiysF
         fIXS3M8dlii9IehYJZ34XtTjpXMshEJ+MRpM2J+3JH7L+tD3H0AhUj94sFTa/14fhjBT
         0vXc3GZRXUv/P7pEo5Z0HKa0gvXrJHZkmrXNj2ph9q6qoQl2QjXn/zolxahKFzbstN2Z
         XAkA==
X-Gm-Message-State: AGRZ1gLph8J5iVu3RjSaTTw4WkdWu1C0/pApf3x+rsSCAbbcF+5t7mTd
        C7v2Dz9cPm5HzPRsb5rifiBTfeeIDMA0xOV0OqwyIApiO8c=
X-Google-Smtp-Source: AJdET5fgJxg48wmRlMYYNqQqGNUIdDXJM4i84lakblTisOJIazdVg9XZX7fIwHNfHcFepU5WidL+tzUsKzh1HpBoE8c=
X-Received: by 2002:a19:750a:: with SMTP id y10mr5528845lfe.43.1541774408054;
 Fri, 09 Nov 2018 06:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20181108215138.892971755@linuxfoundation.org>
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Nov 2018 20:09:55 +0530
Message-ID: <CA+G9fYuPgK3ni_CKW9xkpw8CPk5UduNunaz23Tcfci38=MNH6Q@mail.gmail.com>
Subject: Re: [PATCH 4.18 00/34] 4.18.18-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 at 03:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.18.18 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Nov 10 21:51:21 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.18-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: 46c86a0ac4a119d8aaa02055e233b2ee550a016e
git describe: v4.18.17-35-g46c86a0ac4a1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.17-35-g46c86a0ac4a1


No regressions (compared to build v4.18.17)


No fixes (compared to build v4.18.17)


Ran 21302 total tests in the following environments and test suites.

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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-pty-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
