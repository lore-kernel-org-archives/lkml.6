Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58320C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DD8217BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KieDgGp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DD8217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHUUT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:19:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45052 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHUUT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:19:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so14858913ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=33XT1vOT+xL0KZXjZwDh75H19NRLx7t6dSxJFDAN4fM=;
        b=KieDgGp/Q4ibfLa/FSot6CqT33iQHLa+1BU8RjHeZ0cAaN699Fa2YbGYgF6L2qBzDy
         OoncU4D/BDXPxWv8kY/xggSutnK1W0i0XB2XYvgWfyzDzxUYkmQsN6TlUDQEbaAsOG76
         CtAiBHCJBs7eJ1p7Iwt1Pp8ixHfsRwwuHD38c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=33XT1vOT+xL0KZXjZwDh75H19NRLx7t6dSxJFDAN4fM=;
        b=JW/1+9tfMzj9H3cCtjpIpsG/rU1vdOdz9xq9tpmOkULo46fZcbMQpmqK0Mwf0L3kqg
         TgirOpH2IzZRwIEHG8YCddiWoPx+8/0eBk/6zBmxUK2cA70FsY6qQDUffpMY/NKEGBhZ
         zfx460jrOOWI0Kwtz46RXRf6xP+ge17y0DTfwIVR5QpBcEeozcctQBrc9cnE1W6pwr7+
         WuXvoKTKcsWdeBPrcvS1PqJQs9OUKSHfhy1Qkq+BZ/J1M+lhmVX4R0hxy1FB+NT16sEM
         wbYDJtqWv/uhqIt12/vlnrcS6Pf+1/yNgxgBtKa8lpzFKKaWWAa1EPwFsxfAOUcZAfS8
         LgaA==
X-Gm-Message-State: AOUpUlEum6Y8QtP4s+tMereLSLmTYZxQrnqIHJrP/UUBneO80S8TWLoc
        ypohCYdGhhg6k8zdHiEwHANg9b+d/1LiWtstlmh3mw==
X-Google-Smtp-Source: AA+uWPwqcWnTU45C0Pg2S8D2A52ISdi1VY5Vy4sWabkNKGcORxh98kVLqRWcfMNfN4nLtHARrLZS/YOQDDvGY6yzbaM=
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr33473998ljj.153.1534870710494;
 Tue, 21 Aug 2018 09:58:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 09:58:29
 -0700 (PDT)
In-Reply-To: <20180821055139.462620042@linuxfoundation.org>
References: <20180821055139.462620042@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Aug 2018 22:28:29 +0530
Message-ID: <CA+G9fYuJJ3_w9NJaJ3PAmKBHg6pm1Xn+zv2vW4u1Q4A20m3AFg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/22] 4.4.151-stable review
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

On 21 August 2018 at 11:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.151 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug 23 05:51:31 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.151-rc1.gz
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

kernel: 4.4.151-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 2ca50ab62158be66a8db47d14fd2ed1a2c04b486
git describe: v4.4.150-23-g2ca50ab62158
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.150-23-g2ca50ab62158


No regressions (compared to build v4.4.150)


Ran 9181 total tests in the following environments and test suites.

Environments
--------------
- qemu_arm
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
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
* libhugetlbfs
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.151-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.151-rc1-hikey-20180821-263
git commit: fb3fa897aab281b05f9b6f0505ff3d69c5543e3b
git describe: 4.4.151-rc1-hikey-20180821-263
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.151-rc1-hikey-20180821-263


No regressions (compared to build 4.4.150-rc1-hikey-20180817-261)


Ran 2723 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
