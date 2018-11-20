Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C82C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA840208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdfB+J7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA840208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeKTSh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:37:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35698 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeKTSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:37:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so841301ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GR9A2paDjRsYqaqOr/oLBHI/V9qzVftFzkbS59yIrbY=;
        b=fdfB+J7Yh7IYjj9xiy/BAeE/94mRhj+luVe+crCsyK8OyoP+NhqT1dIUoCGa+a+j4r
         LADdI8lWlpNqSKqROAU+0QnLJ9GY6aOz+xmVVvW73LbEFC6KFfE9t0+9DIZf9o3O2epg
         jEqB+PRel1fKOcc1D6GEpeVdDNb5KgKNVN5yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GR9A2paDjRsYqaqOr/oLBHI/V9qzVftFzkbS59yIrbY=;
        b=Ai94+NShoeTQFJGxmC7HL5YCGtIOPhQMFyfphUt0CqSt2XoulvJnf4c9cvA66cmnNt
         nTOealgxNgQVRi862HWk1o/6rLDHj6X8dp7t1GJnpgWzMNk1/IACw/wg6YSiz/6YxxxL
         4Ir9FuXx2oNfcTzAgIeh6nShoPcSV5M/BY7Kt38AfvRrXbTR6nl0q/wq9OjTrllM1+pr
         XgG6JLfLjgJB4fjRaQrRXNw619w0rMzvN+cNqh8EGl8c7cq+f6rVGtdPr7MPjKghg8is
         Jp55lGVfkPZf6WRIgG9/SbmAVNVL5TWnz6fBQmaZPNrjkjZWFjerKG6xm+D4feTjRFl0
         rE/w==
X-Gm-Message-State: AA+aEWaeICcdawP1uCgtY9BF8ZcDq5L55U1I1Je/HDrrkUyojmJjqmRU
        h3eAnOTOowYHQ8HVzLqYjXY+loSn8u1zRzwyMAjPlg==
X-Google-Smtp-Source: AFSGD/Ue6cXuAoz2T4IYUIVR+ahxWjPhEvQuE7Zdufnaa0Gw63Ybtl5I4hzSpmGA2jPUpWSXy02jn23B0GNv+uYpw8c=
X-Received: by 2002:a2e:6594:: with SMTP id e20-v6mr642802ljf.123.1542701408205;
 Tue, 20 Nov 2018 00:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20181119162612.951907286@linuxfoundation.org>
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Nov 2018 13:39:56 +0530
Message-ID: <CA+G9fYvM5QqrGuEu4k2kaaXc1G_cZVPW=casoXNpEY=07a0M2Q@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/124] 4.14.82-stable review
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

On Mon, 19 Nov 2018 at 22:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.82 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 21 16:25:07 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.82-rc1.gz
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

kernel: 4.14.82-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 43bb46eb6e2eae660d29ec037de28fca0cd2e7e5
git describe: v4.14.81-125-g43bb46eb6e2e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.81-125-g43bb46eb6e2e


No regressions (compared to build v4.14.81)


No fixes (compared to build v4.14.81)

Ran 19592 total tests in the following environments and test suites.

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
