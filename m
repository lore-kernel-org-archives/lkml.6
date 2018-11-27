Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CC7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B982133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4pi750X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B982133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeK1ADF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:03:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33618 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeK1ADE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:03:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so20016866ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7t1Bfl67fQNQkuhlFzBQYcdPf674F7omLFtYrEQqGp8=;
        b=Q4pi750XA1B54e1qgOJE4VlfLDPkaY1T8UJZttvVXkJDN05nyk9XFpyGF7yrzu9yki
         tdx9lDXOjjOuaLguxzPaM36zpySctLARrw2L0Rcl01CY/ifcCYm3m+i3+Ievtdonty8e
         GgwJgxMGefMSMFOJNU62r8Po7wGfcSMNEf19k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7t1Bfl67fQNQkuhlFzBQYcdPf674F7omLFtYrEQqGp8=;
        b=rjXG7238em2gJy3SVOjFOkGUDacN2VOlHyvW3U3WTlikxAq/iRBuanmTpmdiNwXhkB
         Pk8aHSvwTvKJlnL5c617CMkpZRAatV5H1DMjym2GEgjR4UWtf4DICZ9dQ/VwjpK9maTB
         nvXk+oRituzU4ys5PWVn+jIRS5j87DRy25D6CKGSty0w7qpmxmiafEfCYryklOPLAYfM
         ODQ25/N7c8UZ2vnwButdHFg+IDA/PTbokv/BfCOU7lWxkou1EOs0cMKfL+FwdojBAnJh
         O5dZWOMnKLxwlxZkwYXrmJwE/Ub4dROP4oo48ow6Ybsz1IqDP1e1c98LnRMndMRUX71F
         bciw==
X-Gm-Message-State: AA+aEWbfbLE8HQAz+IXoDoGPP5B6FB1bjQf1MOoPl+a7RknmgjFr+O4x
        rG5t4NLxA1kgaTYozXi+/eYGM7OA6+XktJTIu7YWJw==
X-Google-Smtp-Source: AFSGD/Wtxr9e1X/nAS8Xe1jA74VsxbCeHOtTfizHtoDkfIqXf2y4iSDnQ2awq4NvJVnd2oMJ7VvblaefUrQuZr9pGIM=
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr20058380lje.110.1543323911148;
 Tue, 27 Nov 2018 05:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20181126105045.447291262@linuxfoundation.org>
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Nov 2018 18:34:59 +0530
Message-ID: <CA+G9fYtb4hFnXb3ZWuLvfhE7X3i33EAxrTVY1RSrziEn0qSCMQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/46] 4.9.141-stable review
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

On Mon, 26 Nov 2018 at 16:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.141 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 28 10:50:18 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.141-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.141-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 77e519ecd736a4f379cdb6b25fdcf42b14aee341
git describe: v4.9.140-47-g77e519ecd736
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.140-47-g77e519ecd736


No regressions (compared to build v4.9.140)

No fixes (compared to build v4.9.140)

Ran 21300 total tests in the following environments and test suites.

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
