Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B32C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A827206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQ2Nd2uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A827206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408409AbeKWS5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:57:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37430 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387607AbeKWS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:57:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so9927976lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MYnCVfUtt2t4THMTs7eTqsRZVRhikhfOPIYbBHG+4Oc=;
        b=FQ2Nd2uXBqmPXIykqGG5LuPAw+HwtuwNHXe5zIMpN6qBBJyOBVfhIt3gHn+DrjbWHS
         CYuI7UQiG4La9rnDTGaEzEEdvhfYUH3FivNEmThLjCISB17z9PaS3wIkF93O+Qcz0Ngm
         O0QccrP1L7iO9jJUo9AqzhpZHVypl5cDLNDOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MYnCVfUtt2t4THMTs7eTqsRZVRhikhfOPIYbBHG+4Oc=;
        b=cYngu1yZKtiheRuADDNqYQ0OKvvA14uvSsCWV77XfXkWwVVv+0IrNk3uX8PDOJnOPS
         NxNyD/vYYz96Fx8ig4bo5maAUNU1t1yUjlwuaYLXJKCyrGS4D6yYZGMja7U7DeH+Qx5L
         lZMeJ5Ea9EIZfKtk9gxNcc8qfwTYhJlOi3SHspoG7C1N4gdZtVl+bs1pK6Rs1wLjSiiz
         KAUqJgrxWVq3WfR24vPNapsnDKL7m5HJkxhEcWdcXzB4eZbtqOkxLdHe9dlZ3oBQDacD
         N6sPUn1bwieKASFK0HXgqcVsQ5juescVXUAlIqkedNvSGIs+nJo5LrEdXQicEkjgKgC0
         4xQg==
X-Gm-Message-State: AA+aEWavLTM/TCMJi2yFCHUYuwVkzr1EkKzeqAu6QqUD9WRbvbiFucJh
        EhDgXXYZFtw+zoM2+fbWdnpRzaflSjQTuEuUvWAnmg==
X-Google-Smtp-Source: AFSGD/WcPOElGjkx2iPBdEG7ZOGb9O1VowVBsD9RcZyUqOs910JwET0ulGOIzC3BRITsuK01Jyg111KZtwWa9tS2D+o=
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr9054228ljh.63.1542960848536;
 Fri, 23 Nov 2018 00:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20181121183147.869199006@linuxfoundation.org>
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Nov 2018 13:43:56 +0530
Message-ID: <CA+G9fYu1EmZiXQ6U+L0s9AsBH1nOTFer1=ZFv6yBUPK1qDcqMg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
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

On Thu, 22 Nov 2018 at 00:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.4 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Nov 23 18:31:31 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.4-rc1.gz
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

kernel: 4.19.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 2b8db8734888b00156c6afb235eda91aa71da503
git describe: v4.19.3-43-g2b8db8734888
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.3-43-g2b8db8734888


No regressions (compared to build v4.19.2-206-g73aa1c86c6ec)

No fixes (compared to build v4.19.2-206-g73aa1c86c6ec)

Ran 18944 total tests in the following environments and test suites.

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
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-hugetlb-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
