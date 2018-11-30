Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA65A2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cG4lADs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA65A2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeK3UJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:09:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36791 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeK3UJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:09:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so4309226ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4J6gGfcn8UNSN5oNZAl1llsk0nSlFsynTpilftIBN5o=;
        b=cG4lADs7OfeQc74YvILHpJYCIVgnKn2HwdshmeZqyJCv1mBW3Nw5vKb53mZvpo0oT6
         XHzyGyiq1xkSjXv0G3/ohUO508njb1TGYi1twPOBhy7xwyoIlQF6zk4Tip5eV5NSlH58
         QD6oVMgvOPOflEx8dFrDWXPxVQeOUc1UZtiT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4J6gGfcn8UNSN5oNZAl1llsk0nSlFsynTpilftIBN5o=;
        b=Ta/a/J1yN+TYYNKCrmWbskJP73M2NtlY1pUhtRcS4aoXWlls607eAmnEjFR9Xwf0lW
         j6hB0OqtRdvc0O9wgbP211W3VtM9EWi1ix3I3H+ScmAv7wb1aZpbpY2lE/ZN1svZcOcb
         P6kvCSID7iwolbSBGJiOr2JnuWp4xOeShBcqP+dnSPUnA+G3eY/ki0lVhHbvZwXApCxq
         zH7OEh7j8LJ2xjlILJq8AfnInuccJ4f+mzmsQ93EaNpRhEgwMChZufbnMJ3OyqNcNzZt
         toFcYxp+fhe1uZz+Nx4i8J/Z85bp6WPcUVcmS/a2fzjK7LuiJKUsyMcWgEeQ2Dp2iWRt
         RXaQ==
X-Gm-Message-State: AA+aEWbwUNINr9oIoN49KG0ip1TiHuFUfaLu/7AQDXBs3p5n21OQgF3x
        dC4wPauhsDcVGuCwlCR4fel821kWpdGHVBbSytpn5Q==
X-Google-Smtp-Source: AFSGD/Vv8do7E8W2fmf6IQKM/vxNHbKcjUXgDlw2wCfpHFGTAp+Z8i4ORFcxJxNWvXCDS1Vvz0zv1W2MmwOB6WJeVM0=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr3292743lji.30.1543568452450;
 Fri, 30 Nov 2018 01:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20181129140109.832117862@linuxfoundation.org>
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 30 Nov 2018 14:30:04 +0530
Message-ID: <CA+G9fYvDeooVM2EdG0wPAZxQ1-B5grvWce=4-t+LUx11fbYL4g@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/86] 4.4.166-stable review
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

On Thu, 29 Nov 2018 at 19:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.166 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec  1 14:00:43 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.166-rc1.gz
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

kernel: 4.4.166-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 0741f52e1a53c50944292102dfa048c5de080f14
git describe: v4.4.165-87-g0741f52e1a53
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.165-87-g0741f52e1a53

No regressions (compared to build v4.4.165)

No fixes (compared to build v4.4.165)


Ran 16844 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.166-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.166-rc1-hikey-20181129-326
git commit: 77aa70b86f54961372a7d28f2f54ed4461125b05
git describe: 4.4.166-rc1-hikey-20181129-326
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.166-rc1-hikey-20181129-326

No regressions (compared to build 4.4.165-rc2-hikey-20181126-324)

No fixes (compared to build 4.4.165-rc2-hikey-20181126-324)

Ran 2729 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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
