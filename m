Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78A1C282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889A02085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dG4cjZcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfAVDHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:07:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37123 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfAVDHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:07:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so19271588ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 19:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J38yPfhV+6xOhx//AAQfAGRuK4on7n734s641bT8T8k=;
        b=dG4cjZcsK7duzza3YV8jx+Erc3uOv9XpYayZPR5X3ila9Z3iqvQ6255Xn1gtXqBzMg
         FS2+h8PpNHoAgD0CpOiL5JGIHkVolJRrvJ6wAR8oTnFMDX2mke+vux8leb2MCnxPbhMr
         yDwrTz/WsVjtR1oBIxVCq7h51xXL8sPkM9kQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J38yPfhV+6xOhx//AAQfAGRuK4on7n734s641bT8T8k=;
        b=G6oax3mmGB42GvYMfNyfu7B3yb+RHh5p3Mn5oUSpLXzfzjB0blugnteLcVJj2q4g6x
         Vcz0mogMAFZZoABJsLz9lZskw/e7XOKekpNUgAgWZT6VqBIcsW7/YqGTrolbbwoD/XlX
         ahx7dkrQZzKZ3EkkG4h/9VhMXwC6OAsT/OfyftGRhV0EC4zUKUBA0Rjfv06z7j4KpQU6
         JIL6GZ/63Nju8XZb8EFqJ4S25B5qjRclTsWo6CEtQ/y0ucXYDvocCraaPiHBQGjBZfDt
         HsaopKVFd20e1VhiXC3wqJ9zI6n/bW3jepvOCl/3jXiTkeRFkplJUcturQ8eOKOBC4wB
         TEow==
X-Gm-Message-State: AJcUukeNSQxrUoj9X20usG2zn0UW8QCpkUOB5BRtwDBcQtUEbMWJ6ohq
        vGwH/DlstKoawJfRXKZ5hcHaD0p+oX4Ar0ctK3VxXv8fnG3FxA==
X-Google-Smtp-Source: ALg8bN6l5jXtBU+Aoc7SoYYmNGLbtLSVDJgJkWKB/8jWApkbxnGjzrz4uQgNi7s68z+e2xtkUteLabmkTa/veF+lalg=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr18984099lji.30.1548126433055;
 Mon, 21 Jan 2019 19:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20190121122456.529172919@linuxfoundation.org>
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Jan 2019 08:37:01 +0530
Message-ID: <CA+G9fYtgGRXoNJcBGe7eSE4RGCmVBA1dSWnZKgvpbNL4c2_OiQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/59] 4.14.95-stable review
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

On Mon, 21 Jan 2019 at 19:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.95 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jan 23 12:23:55 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.95-rc1.gz
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

kernel: 4.14.95-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: b18179b91e8b8e3c00f111995c6e358709589d67
git describe: v4.14.94-62-gb18179b91e8b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.94-62-gb18179b91e8b


No regressions (compared to build v4.14.94)

No fixes (compared to build v4.14.94)

Ran 12210 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_i386
- qemu_x86_64
- x15 - arm

Test Suites
-----------
* boot
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* spectre-meltdown-checker-test
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
