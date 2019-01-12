Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD1C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D2B2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjcVgOkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfALIZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:25:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42428 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:25:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so14897306lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 00:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZIAjXHy9F0GSuVWWXloC/RKuwQ6uc5+T/zQdbZlUrV0=;
        b=SjcVgOkfkXyQKDzthJcVIi6UM0PHK3GXAc01o2BG2m+8A+XJyrswZc8mP16K93b/N4
         PAejXjpsyGmHWpgcKBR5jmtC9lFK1TLEcVm1yh3ma1BrjZ6DE7PQrSewd+3LrwrLyzAn
         mEjXcS05wKGGMF2Yocx96bXh3Ph70bBF9xTtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZIAjXHy9F0GSuVWWXloC/RKuwQ6uc5+T/zQdbZlUrV0=;
        b=n8NpWRsaVfAdGpDCKX4oL4HKW41VBXv5+EEiALsOUqbWhlLT6qorWyIxI81Hsi5YCz
         B4ziwthQVCg+6F9D/0TbMtYAM5OF2akzKMjWXlOS7ddNT+l/mNkWaQr7v8lf9vvUT14i
         yhAi932d/7GqOWzGrrjyCVXoVNhTs2usc4OKeJ1Fn3pjeUq6S7nDmxb20Mg4fghzjPwO
         GIHQhCCupI2rnwQwoFCLNSe7kq3Vkrm+wefNYQycKLbQ/yPW1UvrXd8gQEm28h/Iqu26
         OYAQNQW9jPmZyOjACjHAlWEz5AS0ATX2kBC8iny1ENPrI9/esz1gLv/3lEVVvCtw1zqS
         zZiQ==
X-Gm-Message-State: AJcUukctCTVFHatqzwcPbW2Tu1Zfx4gUVkacqWfuXp1yixemuTGgdrjJ
        X+N/OsLuoGGwQ+Vx6AwdA4Zb+0J3/sjJX9S+KCO8iA==
X-Google-Smtp-Source: ALg8bN56E0AT9Yb1Hg5tfZzkBxzl4zXaTfVDtzymCd2jB/+rg7vSWKyY/m4WEtj3xK2dig0WcYyw2DSBKGPH/JbWqw8=
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr8852732ljc.77.1547281541108;
 Sat, 12 Jan 2019 00:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20190111131114.337122649@linuxfoundation.org>
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 12 Jan 2019 13:55:30 +0530
Message-ID: <CA+G9fYtUkmbTn6xTm+giacb+h-JKXhTN0jW4PAP8fvt0eJ+Tag@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/148] 4.19.15-stable review
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

On Fri, 11 Jan 2019 at 20:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.15 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jan 13 13:10:11 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.15-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.19.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: c7f405f762f9b4baf690220a7bb650050eab4e49
git describe: v4.19.14-149-gc7f405f762f9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.14-149-gc7f405f762f9

No regressions (compared to build v4.19.14)

No fixes (compared to build v4.19.14)

Ran 20631 total tests in the following environments and test suites.

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
