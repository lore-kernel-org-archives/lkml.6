Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8CE20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwagInTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8CE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408081AbeKWPEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:04:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46623 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbeKWPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:04:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so7773581lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 20:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CrZnFeoBEwp52tnjlxku5qNjmQVf7rgzNBvbs9IB01k=;
        b=PwagInTYFuYkwBRi//FMeeWPrN7NXdurkhwTn4knsO79yBFqwhh6mLNxW9fHDNlqR+
         zrR/sLjvDoAe0W5TUeXEiWCT+EozLhSCae9CGVyOJ4W5jHDa6xrxtXX2/uCD358LaKlN
         CRNpUoFaxbiD22Pndqok407etnfbSF042T+XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CrZnFeoBEwp52tnjlxku5qNjmQVf7rgzNBvbs9IB01k=;
        b=VYV67Kcq7gTl0IJEZo8+KXr5EIPZgnHgxYFtarS/dB5t+tNbb4kV7yQMluoF/XkKs8
         nHCQsRBDsjiq4SblVmCP72cDccYjuUbDIytkjWE1Rgo4B+nOg8j0M69jnqY0XOQ+hVqu
         r2OGT7PYO1a/qXxczLtv8IDCSrVOHEEsGpQoE/UYSFJxqTqdzLsJ/B0cvmOLBqSiAJ5b
         KH3P0Rcvn0b8g7tLsU0ryCMWAyWSpkWO7K1JbYb+C5CfiGZO5QPYF3c8XCkeT6EzJjBE
         FUQnf+seilLwO4hH5fNbHW6QsIzhLkiJmgA/4UMcL8aIrcij8JRjwFTvszVYUSKSZchT
         FzmQ==
X-Gm-Message-State: AA+aEWZrx0+u8O+Hio+D7PkRRQ3bPdeRM+tBle6T/Bv02RoqVmhmiclV
        MzSbSrF7TBaULauD8LiKJanUVt/iGojpck4qaqDMmw==
X-Google-Smtp-Source: AJdET5dUCk/0hQYKEZG+6eOilx9K/WHdLZqSmjdmKjB9IGpOsMSnPbCFuLowcGeeLIDxUu1m2ZiXN38Wm51JS9er9nE=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr7330154lfj.126.1542946938758;
 Thu, 22 Nov 2018 20:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20181121183422.103826775@linuxfoundation.org>
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Nov 2018 09:52:07 +0530
Message-ID: <CA+G9fYsftAwyA9dsTJWDXtLJd9Zd4OkXYHw6MiJcPwUpXBYNPg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/21] 4.14.83-stable review
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

On Thu, 22 Nov 2018 at 00:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.83 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Nov 23 18:34:13 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.83-rc1.gz
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

kernel: 4.14.83-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: aa2838d50dfbecf82e5ba9e1013d3057c54590b2
git describe: v4.14.82-22-gaa2838d50dfb
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.82-22-gaa2838d50dfb


No regressions (compared to build v4.14.82)

No fixes (compared to build v4.14.82)

Ran 21240 total tests in the following environments and test suites.

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
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
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
* ltp-cve-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
