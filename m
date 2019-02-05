Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1A3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3E620821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTEWkWFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfBEGVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:21:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36802 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfBEGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:21:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so1775275lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PL85EkMDMQaSjfeRtKJr2X/yfOTZ3cp0VDbabujT+xY=;
        b=WTEWkWFSexsRXY7nu91CaT0P8hoo3S4ygl7xhDpgIkIrkoVAL6MST4ifIqRDM36Reu
         /E7w5IjoJU2tf71QcUascB3eJpZrmcVbIYTRfCJCZ3l+WsU5UwEjhFCofeEe4H+nuaec
         iiJ96u9YyUXttJRbRB8J/rDK+Qw/nEKqQuAFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PL85EkMDMQaSjfeRtKJr2X/yfOTZ3cp0VDbabujT+xY=;
        b=ZHFx5Ig3iKl7xBXpNTsqdPW65KaECp135GULEtJTeJei3bUmBx66u65jftjElYd2PF
         5TzEzS0jkjsBu27vPXGeDv2Ix4e52ge7ZIQUrc+6nOFbZEdBDqVLZ+1ZBtY6TVm+aJgF
         3tQrWtN2FE3DdNdEGTzmY4dm6CDyBQuplrBIZn3bK6hXKEWDigLTQkZdh+bj09lMUSNh
         nfBklkorv2bHrfxqBm3iqwR18pPNooVk5CoYwntePtf5h/4NfUxi92dJZEJwRm6PJjZi
         6N3d9OaGnalOEFia37Wv5zoqXOczipl7o5kgW71qD9mhiaDz5PiRw2Ft65NwzXC2ZhTp
         LK1A==
X-Gm-Message-State: AHQUAuYMlzExyT3bUlvaCUxlkRk0UpzvIyGQB8aoKjKdeq+7ZXXGCJSB
        Epqp0Gw6pq0N9mwU7vtzy+yra/fhRNIg3FcXBtXGgw==
X-Google-Smtp-Source: AHgI3IbZ+fhC4AaBrG2paGBEyNC8vEZv05rM7DaXEOwfVmbBnGX5FyCv0YiU9Ly/BrpvhR7yalx04rmiETbI+dlb/A8=
X-Received: by 2002:a19:9b50:: with SMTP id d77mr1873755lfe.137.1549347668413;
 Mon, 04 Feb 2019 22:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20190204103620.287366543@linuxfoundation.org>
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Feb 2019 11:50:57 +0530
Message-ID: <CA+G9fYtiWY7c-fEn+ao4UFqWikuB56oyDawt1u+Kp-_d_HQrtw@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/80] 4.20.7-stable review
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

On Mon, 4 Feb 2019 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.7 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb  6 10:35:33 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.20.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: cc6e62e7b38a4a9309c07e6e5d45d8e619570823
git describe: v4.20.6-81-gcc6e62e7b38a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.6-81-gcc6e62e7b38a

No regressions (compared to build v4.20.5-121-gb3b8ce0697df)

No fixes (compared to build v4.20.5-121-gb3b8ce0697df)

Ran 21126 total tests in the following environments and test suites.

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
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
