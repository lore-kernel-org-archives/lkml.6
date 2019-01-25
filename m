Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B772C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B91720844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dzb2TRei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAYQSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:18:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44978 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfAYQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:18:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so8814371lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 08:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k3g8/Ypxr9JRncBS99iIzMWnoGOfGN4745khw+Hyezc=;
        b=Dzb2TReiYyrbfWy8bP+TerCUFKtK6GTzpypzEQAG1I8UOEcTb2ismpj+DhJtrewaQb
         koBwPmS4+di+SMmsisIi7Hx09tboAl8z/5SI/lcjcvBjuDifV0W3aMklLO1Mtv3GjXgl
         lrAutoVA9JkMPJDqZRg0OWDDDVGqBCxtvRPKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k3g8/Ypxr9JRncBS99iIzMWnoGOfGN4745khw+Hyezc=;
        b=ZC8oStUrtqNERgPzKAWDUyvwJm/l6dwM0IIJYJZ67l8uAXPeWhCXty5I5nhl0xVEUj
         /gGnd5z8h+FbOXl+xw+/3rJ1r1AN53p+EL2eFEd3KeQgdj3/Zib4/+k4CaeLHFDgM0kY
         VO57N4KQHoLazHTGeSe6ieDmUVSeHtZWQWC28DwnC4xGcfhCyc7xAN2xRHg6TW1sA/Kv
         MbFIaI5fahWuo6NsfDqjBbkIs4QHH7es+D/ZbD1svAprK97b089nYp1qSz3/WVdwuxqY
         CiLNLzbpZaSAKJu2BLDWhIwN0Fb0Nsjlt0zzKdp+M6owSWd0dYtP0cYcUqVo5FfJvdxj
         +VJg==
X-Gm-Message-State: AJcUukfrAbFwpVyxhk7vOje7DSSHVl9BzJ1bmt9c6hUBqy9G74xrpNVl
        HLHiEvxLHaHMYfKg1wuVmERqp52Phlr9aHZyC3hyAg==
X-Google-Smtp-Source: ALg8bN6Wll1tJqXFTQjZ7bl0lDrigHETEh08INmHz4WmyL3/5cA1164JNCGOnc9++HKoQx4f39ndl9E+Yn+rzj7IWo4=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr9462817ljj.9.1548433107447;
 Fri, 25 Jan 2019 08:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20190124190206.342411005@linuxfoundation.org>
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Jan 2019 21:48:16 +0530
Message-ID: <CA+G9fYtBRqLVnvg_4ixN1iChYKbQeMj5kP1OkEbA=PbutTRGow@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/106] 4.19.18-stable review
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

On Fri, 25 Jan 2019 at 01:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.18 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jan 26 19:01:18 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.18-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 3784655a0f02f5406c522f7acae06d41df59c5cf
git describe: v4.19.17-107-g3784655a0f02
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.17-107-g3784655a0f02

No regressions (compared to build v4.19.17)


Fixes (compared to build v4.19.17)
------------------------------------------------------------------------
Following are the test case fixes from kselftest version 4.20
  kselftest:
    * net_tls
    * proc_proc-self-map-files-002

Ran 20797 total tests in the following environments and test suites.

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
