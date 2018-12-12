Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ED120879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HoM5Jjwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10ED120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeLLGhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:37:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40290 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLGhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:37:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so15254363lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 22:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2SPFkp0QNuGRM3Fao8SG+KL3VYsqaLAAhKynPkl/E4o=;
        b=HoM5JjwkisAK2GNMUUOBKV3nX8cfKPXu0HUoL3FTEtn4SIA1ZjlQ5DQp7980AudWe4
         7vmzoQnIVRJd+b3umY6xkI4qd+S6BB19gRA6aKQmoapm0OS/lIV+mQPZlZrTXcxNy8vl
         CUtPrEByGnrvGftmNRa6kAFcmYUO0Y9LqCAJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2SPFkp0QNuGRM3Fao8SG+KL3VYsqaLAAhKynPkl/E4o=;
        b=FywGwuoI4XZLiROZ0IoYR8cDTcectJYBgIhrDxtOWrmygmmjYhO/X7IBmbveyV/Bld
         RifRD5NZD5g9Idabwajomo4GzKitHGykIWeTLV9xKe9JyFq3BTcqZydg7ARKVGFYgRNY
         viZCDHYdBQ/Gj3LtJ+u3mrQyrx2trqsuSWU7lWA+v/4LGtaeHFC5DlcaLvVdyngvQNx/
         1E+PREkCoeDebTL31v0UlcAvqbzUHMXbPKVWSt9StUsm1l9Y1x6455J9qsFfpfNsFJNt
         BcO02XR9EvkzrbReqFiECesC1WLbc4ktrMQSPx9ugMdllBoFUWxGhquKKnFdRY1a3v9A
         AOgg==
X-Gm-Message-State: AA+aEWYwh3z0QlSWwpf53gdg2Sz9VAaW+6CJ3rWk/+bWIbEfdhKY9stD
        3nCwhVYtqW3YFPyp1qRjvcdAq9FeFLX+SUsBWdyc6g==
X-Google-Smtp-Source: AFSGD/UDwjdq871uRcirznk+TCB8WHeJFY+iYgBvTe/WP4cztpvjnbKV4assFjpUb1O0kNZLQQ/grxibt/VJNo/0v4Q=
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr12650862lji.130.1544596633479;
 Tue, 11 Dec 2018 22:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20181211151630.378216233@linuxfoundation.org>
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Dec 2018 12:07:02 +0530
Message-ID: <CA+G9fYt9T_FTcA=Xe3Qm_nMyfyXvU4155x_+teB-ixoMvLe3uQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/67] 4.14.88-stable review
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

On Tue, 11 Dec 2018 at 21:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.88 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Dec 13 15:16:01 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.88-rc1.gz
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

kernel: 4.14.88-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 9557e80a8f28e6bae4083dcc7dc6c2d1cb38d758
git describe: v4.14.87-68-g9557e80a8f28
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.87-68-g9557e80a8f28


No regressions (compared to build v4.14.87)

No fixes (compared to build v4.14.87)

Ran 21572 total tests in the following environments and test suites.

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
