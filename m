Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F579C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A8821104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6jndGlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A8821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeKTSf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:35:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44835 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeKTSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:35:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so804094lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JePoxniUlu/6at0ayVrPITysIZkM2sk00Ur8/E0NBQw=;
        b=b6jndGlKXyAcbF7hwv8Ze62Y7POGmB8OPjjoghxiQ3XJq5L3rsRgIHztwLkx24KbpJ
         mWKK0vNxvx+8aOohiOqKAla3nMSV6chCb688j2EkirFD/RIg4uZlKd+zrMYeo4Pue4lX
         C8GJAiaGhNJii911XBX1tIybdq1ZwNFOeZnrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JePoxniUlu/6at0ayVrPITysIZkM2sk00Ur8/E0NBQw=;
        b=j+QdmJZubVHgKMBI2Mok8MHevDmqiWZ5uLLcJtVun5MAlkmrHr1s0Na0vIGmu8bgLR
         b0AMel3cQw00Ju1aB5lUPsY+1PmR6Yhr0b1YcacdeeKmO8LFJgq1OCmR2bKynTyYq/1q
         WE2MuIGLg+maf/NsLpO232bkLHCzHv22maburWKJjjbVdy4Ho2epmMgu9abiQC+GlGaQ
         bTZ3QBhibgeyVBPqrquhl5ok5HwIq5xryFaxErko5HhyKZ++9w+Lrw7CUw7wv7t9YqCF
         MUj99Dmc6CGgrdpbyVefEmwIU8t8NrA7L33gIgad6alf0hq+O0G/CBGSNNR9/yoYqUge
         LP1w==
X-Gm-Message-State: AA+aEWZ7gxXfk9uZl2hFsrY0hhBxE+WI3DoifFWuvHE6mpF0Zu0lqaqT
        WBo9SpeQBTzues4F+FAdYG9He8hLFqnJiZbeDEmCCfx6AsU=
X-Google-Smtp-Source: AFSGD/XF9rUP17C/rmI8Bk1YB02V2h614G6Yw5Y3Q4upyJ/SSIRU3wq8fVrShmq1u2mxhJ5sgXjfUJZieuuP6miGQmM=
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr509376ljc.77.1542701256273;
 Tue, 20 Nov 2018 00:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20181119162618.909354448@linuxfoundation.org>
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Nov 2018 13:37:24 +0530
Message-ID: <CA+G9fYvHoy_z9pm2-5HOJ3CrwgwxZuJJeX-Wn3MTbHW9e8jxug@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/171] 4.18.20-stable review
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

On Mon, 19 Nov 2018 at 22:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> ------------------
> NOTE, this is going to be the last 4.18.y release.  After this one it is
> end-of-life, please move to 4.19.y at this point in time.
> ------------------
>
> This is the start of the stable review cycle for the 4.18.20 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 21 16:25:02 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.20-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.20-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: c15e70be568b978f9a73051089910dd60a81f2a3
git describe: v4.18.19-172-gc15e70be568b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.19-172-gc15e70be568b


No regressions (compared to build v4.18.19)


No fixes (compared to build v4.18.19)

Ran 21390 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
