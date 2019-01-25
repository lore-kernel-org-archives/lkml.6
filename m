Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123BBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65AB218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZR5syNt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbfAYQZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:25:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43711 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:25:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so7332673lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tnrFUasdXsWl3ybQIDNn8xxv6CYCv5yDivAfuJ/m4AA=;
        b=ZR5syNt7FoteXh4RVzwJMqJYwO+PjBw1xUVoRkVp60fY+6gmVnRjDvZqw8FvsZijQY
         Typueir3IUuf4Hy9ObYOd06dM0bUuITAk+ZcPLaf6dKhOJbPp5iFhiLQbTMMsQZEv+1M
         c3TsDuxcZA6kA7t3p2THlK8sKTX9uFRcbMpIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tnrFUasdXsWl3ybQIDNn8xxv6CYCv5yDivAfuJ/m4AA=;
        b=BSTDs+wXoj0WE4MGD4yk6Ifz/sOlrhBjoIfYvXJ9MIrV6LRwh6TG+Ej5twrgSTsHQU
         6OD3VcCEEIlGHTo/Q/RiBqz9G9hpiKedFpDGn+XJeZxQWgG9wHJlgBBuXXaQ0D7/6mAU
         yy/TBUbUgC+MtEWkx1bEnLsJxm/9vgwBneSznXl1aWT+PkUkO0MQZxDNGg2Rla561VmH
         wo0BEWKhQa0Txim0J1lKjx8O89afvYYswNGQDcyAw6Zef6ZChcR6JIc+bbyGtZhWBpfP
         D+FCOAVVUjksUX4GLjBNnyG7CLMbKgtgdJSOpenFnP250FwCJpwFw/kVjzGPRJCbpJGX
         xbnQ==
X-Gm-Message-State: AJcUukfLJ6biq4A27C0vqd5IuQcZVlzoWLQPB7QLbKfTFfDVc1pUArgF
        wxF9W5wGaic3IgZELIWraa5hvSPNhBpx1VMnfsOJIQ==
X-Google-Smtp-Source: ALg8bN4dNqRKkDdvDPAgqeUN5ewKN5F3Jhu/pDPf96zO2qHctoUUaNAx8O36OxjdGcTmwYI4o4WOrdSyzwNLBXwmcaA=
X-Received: by 2002:a19:2755:: with SMTP id n82mr9090137lfn.94.1548433519536;
 Fri, 25 Jan 2019 08:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20190124190155.176570028@linuxfoundation.org>
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Jan 2019 21:55:08 +0530
Message-ID: <CA+G9fYsmP+D1w0hjQ-H+v+J6JbVjRuM6Ma2m3HVb6_F+WRTm9A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/63] 4.14.96-stable review
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

On Fri, 25 Jan 2019 at 01:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.96 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jan 26 19:01:15 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.96-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE: Kselftest source have been updated to version 4.20

Summary
------------------------------------------------------------------------

kernel: 4.14.96-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 32c758df374e897c0fe4dad050993758edadf997
git describe: v4.14.95-64-g32c758df374e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.95-64-g32c758df374e

No regressions (compared to build v4.14.95)
------------------------------------------------------------------------

Fixes (compared to build v4.14.95)
------------------------------------------------------------------------
The test case fixes coming from kselftest version 4.20
  kselftest:
    * net_tls


Ran 22202 total tests in the following environments and test suites.

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
* ltp-fs-tests
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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
