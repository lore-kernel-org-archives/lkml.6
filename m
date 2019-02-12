Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F40C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A30217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKEHjrQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBLGag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:30:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38389 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBLGaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:30:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so1207197lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 22:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5KCNEUBoG1dBWr2kEowMCW8sdacWIvlG5vrtDlYfZco=;
        b=sKEHjrQkIuNYXNEeDG6rsH8LIcIDcddHAg2eD7/g0pYIUnJwRnIErfLCi7YBSrDUKX
         scMo3O+yR6X9u2ixO6Ucl5K20vl/MBaiXfv4gubV1Vsl/SWDcr/CCieEpr07+4XjspjS
         5D805IvhOIAyomTSs+iqoNu1oJp/U5nect9HRUCv8hrI4LPxYIFgdmiyWMSzMe7Unfgx
         YmF4dfTlrQI9ybUpcevYZ1NzXisqoDMVTxEHROQaPvBWZisB+SmMfize6C/sT5qFh8z6
         Z5jbEuTWKd33EltFuE2jvLUK65IHDyaj2/a3HG8XN72aUDwv08O2J249g3lQ1F/vduyV
         Bnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5KCNEUBoG1dBWr2kEowMCW8sdacWIvlG5vrtDlYfZco=;
        b=LuwC55Ctew5/l1vOs9vQmVRFxDzZb5A9QgF0mRnwTYPpHsFz40kCMLqctW1nlZ5aXT
         8BrFJGNF2T7jyR89SxQgdmQIvfOnW90WAN4tWR/JeV5osm9dbuvBx12WhzML9KmDKSOd
         yLZ0KA84rzw3DcI00l5PaXluAQEwAfpF1pQTFus43ZQrKBvG3lwIsUWgccYuLMjLQGiB
         1/uwQtewsLWBpFCuXTG+boIpksO7u4Y+pMJZDXerWvKq2+xQhWuxzJmrZ9gYrwpr65eV
         KG5CC8KO6RiEUzetyQepmUH7XIqj6etMay/0bzE1/GSmkU2LdABnTzpdKR1n8jlu3Ghf
         vBSA==
X-Gm-Message-State: AHQUAubDxU9A7+PsD4fFKREWdIMrFkQjwczZ9u52DNS5Eh4mXvvor6Id
        tamIgDE/mHBK1khJrVAdbgrPyPUY6txpJtE4JkHTFw==
X-Google-Smtp-Source: AHgI3IbCT+ZTF1ceG/EsCynXXUH5o3wQWXKdJQtiWoe84qx3a5dUjB5MCzXMdPrVmdNO2Yu/vbSW3KtxDcuAKCrpOAc=
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr1321525ljk.114.1549953033343;
 Mon, 11 Feb 2019 22:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20190211141827.214852402@linuxfoundation.org>
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Feb 2019 12:00:21 +0530
Message-ID: <CA+G9fYuKVxuXow0PTnGGEQ0FNMHdbZpRq-rSpcV8FdqjiCKYTA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/205] 4.14.99-stable review
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

On Mon, 11 Feb 2019 at 20:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.99 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 13 14:17:19 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.99-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.14.99-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 151d6387b56840f9daaf468ec2212d2ac9ccc047
git describe: v4.14.98-206-g151d6387b568
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.98-206-g151d6387b568

No regressions (compared to build v4.14.98)

No fixes (compared to build v4.14.98)


Ran 22227 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-timers-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
