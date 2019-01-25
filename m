Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A74FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE4F218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGKC295X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfAYQpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:45:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41214 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfAYQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:45:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so8889781ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 08:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Symsbaz5OpiXUIS5FJtt3IVU7bbhIA79xBTFf5fn0zA=;
        b=LGKC295XTyGXYX3K37nEpGjonG/F5xDwd1qI2EzamBHfeoxzTzJp8X5oziY17q2BCn
         ILT74cirXWWF0+Ei75h42D7UwgMrFAX9bwRtDAL967RTERJag7a6gDCk+EOtWr+p59uD
         etOlaR/X7EVWU0fJlZ8+d6DpZFNdTuyiSJt0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Symsbaz5OpiXUIS5FJtt3IVU7bbhIA79xBTFf5fn0zA=;
        b=bvv3uhLwQWvdEaW22HSI6hVlxsi2XTJkgZkqLrnvmDYx/binILu8P5wUD7Q0ABkfvk
         jCpdJVmsyjaRchmg/DlfWCcMB+wpPpbPncV64K2Ck+QECJo/egL/PapERFVW522ZH9ce
         RVRALMuLBSmQ7FaCW2iKKriCoakU+MRRn4o0bSciREwvRKTb6xFp2wYeLluvnn7navKd
         OfAUDuU38cPD2mc729fIsME7h3ZG6I/YhOkTrZbz/jqBRoQbq2seDDc7g2ustUs3Uufp
         Xfm0nI7nvCE+UB+wSrljWZQckcq704FYeNqMR+aO1/cGY6NJR1AQ8t9YNtKCGKGBeiHQ
         b6zA==
X-Gm-Message-State: AJcUukfI68Dot/6ip9x2m9aqPANDPMyMYgrkOl4c3/1mh1Yf3j0eMaxU
        ZUaeed31EAvwkkdtUZr9Jj4IAqYIRvmNUThS65GKUw==
X-Google-Smtp-Source: ALg8bN649qw/8n5UGgGKLPdyCvj3Kc9h6oUV9vIyu3oWXjVwnXyUWCPy7Tj/w79qF7RlpBQ7ynGtd+i7baSB5Z+PzVw=
X-Received: by 2002:a2e:6595:: with SMTP id e21-v6mr9394294ljf.123.1548434711455;
 Fri, 25 Jan 2019 08:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20190124190211.984305387@linuxfoundation.org>
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Jan 2019 22:15:00 +0530
Message-ID: <CA+G9fYteq20MGKUx6sy9sxdbyGoarWA+4yGPnNKB-ZUEbt47Kw@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/127] 4.20.5-stable review
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

On Fri, 25 Jan 2019 at 01:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jan 26 19:01:19 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.5-rc1.gz
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

NOTE: Kselftest source have been updated to version 4.20

Summary
------------------------------------------------------------------------

kernel: 4.20.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: c3515872cb7fee25e684c686581b51b51c1530e9
git describe: v4.20.4-127-gc3515872cb7f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.4-127-gc3515872cb7f

No regressions (compared to build v4.20.4)
------------------------------------------------------------------------


Fixes (compared to build v4.20.4)
------------------------------------------------------------------------
Following are the test case fixes coming from kselftest version 4.20
  kselftest:
    * bpf_test_btf
    * bpf_test_sockmap
    * net_tls
    * proc_proc-self-map-files-002
    * seccomp_seccomp_bpf

Ran 18206 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
