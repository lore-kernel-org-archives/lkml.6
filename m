Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC302098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4hNyzem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC302098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJLMIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:08:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33606 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJLMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:08:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so10229092ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 21:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m6QX4vYwIDB9hlNCfos+sS6GH6wXzJxeVJ5Bo33B2U4=;
        b=g4hNyzemKTxCwYXAdwugPw9NEPqNjus3F2521bsg00gYITNzk12VRw1oHsvbjlrLRQ
         pkmHWfKhsATNahyjkg6+CAFheWXuLRD0c09Znx2Eg8yAm5MZXWxUmtj+Du1WwXQcmYQ3
         604aQ0R+BuTTPwm4xrc0wgN+WiycaeIX34h/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m6QX4vYwIDB9hlNCfos+sS6GH6wXzJxeVJ5Bo33B2U4=;
        b=B5H/MeK7OB4lAlfTqV3JaSTwmCFekMUllxwbj5lN135pit+yAH/rdHgUDs6FuTnBHl
         sQpANlcpp2xrjyMVadsDEyuFz9i5rC4kwJRBj9/71MkbaARHg6CmG+jbEo1SZegBIMPX
         fZ42IvW04GhEIpw9ovx5ix2qzpksqif3IWWJLLsSEpMqvJ3D1VOJNljKGPYam/UZJ0CQ
         3e1em5ZEHYkZJahBZUGwxgqVbr1XZ/22h1DiASJzDdaFQKROk+NyW2OFeGUwpp4H3I6O
         JS8BHJxwCVPoVPliPNRgvIYrP2GNl71jLFTZBq8WAQCPrA7J0zSHbmi6GnBXvVd0JFVu
         a8IQ==
X-Gm-Message-State: ABuFfoj/XM9Rr7oPo5tGH2gKZDTx8phT//UVlsIb7Co35ASK0VmN5gNI
        l8ATiqACEZasI7103sfIAu5uCwxlmQEjebMJ8JWMbQ==
X-Google-Smtp-Source: ACcGV607TNk5Y+Tqtdbae86cq/szWkL4DFOa5zktvg6hiwpdTZKry/8vUtUvGRJgp8Ie7fqxqHXA9NIjy/cnZ6/fJoU=
X-Received: by 2002:a2e:2bd5:: with SMTP id r82-v6mr2851994ljr.63.1539319098587;
 Thu, 11 Oct 2018 21:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181011152534.014964888@linuxfoundation.org>
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 12 Oct 2018 10:08:07 +0530
Message-ID: <CA+G9fYsPW60+xCYVoBqa1pN9OzqtKCqDhMNzv356o9hxXd=ZfA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/27] 4.4.161-stable review
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

On Thu, 11 Oct 2018 at 21:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.161 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Oct 13 15:25:23 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.161-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.161-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: b3522afcec59a6a8030ebf4397f5b285b3e804d2
git describe: v4.4.160-28-gb3522afcec59
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.160-28-gb3522afcec59


No regressions (compared to build v4.4.160)


No fixes (compared to build v4.4.160)


Ran 16805 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.161-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.161-rc1-hikey-20181011-301
git commit: d3ba9c3a1b2509d2b14941baee1cd504d5ab0a07
git describe: 4.4.161-rc1-hikey-20181011-301
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.161-rc1-hikey-20181011-301


No regressions (compared to build 4.4.160-rc1-hikey-20181009-299)


No fixes (compared to build 4.4.160-rc1-hikey-20181009-299)


Ran 2688 total tests in the following environments and test suites.

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
