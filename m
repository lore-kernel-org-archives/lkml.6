Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3E1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7362B2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QO9pO8ID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7362B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJLL5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:57:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40285 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeJLL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:57:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id t22-v6so8351737lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MqFEpk4+cu0BU8obaDIf7lgks+UBqivHg2aCMHVSMCQ=;
        b=QO9pO8IDxOC+aOdj+VKBX/hYe/xfC/iuZYnQwm9NbhHevycSPQv/aSS1fPsPmD5F31
         ohcac/khnWH3RvJiB3eJOTHNOWMMdTtXtK2Uh4yydHqR8TVtERRIYihyQu6rnSxl78rL
         2nDNbnVfVC1sogl3XmuPwu5FnE2Tei1ESlDyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MqFEpk4+cu0BU8obaDIf7lgks+UBqivHg2aCMHVSMCQ=;
        b=BBq4Ef/nXiXPHP3WX2NOl1O/1EiZW1yf1F+OhHgZGu4gc0SjTIel85G/wxyMY+3rhJ
         lfp7f5yasz311Yooicf0o0z1sNZOf2vqWjo4iah29qTElesIHjz/3kSU+T7f+9aZSqq6
         bFa7gFxJlJC15q+i4LZFwLnXmSenbaV2HXB33gJClCOnxSxiVTALPLsPCVHGOClZTk2L
         UuXRZCJtn616Iexd3V4me3tKswcjhRc6v0CqEmq7jlq6Z2lJFlfdBHGxvt+IlWxJF/Fu
         nSGQsOZwGjGBfXihlwFqoBIH3DZnR5JfDj2//+M8j2Bi8ekAvICzAH5lLRsLJYm3LIj9
         KSiw==
X-Gm-Message-State: ABuFfohkAWNZzuLFOOyZrFRnSDqtGS72Wh+PHy9dxBzO1vMlCJVZFVhs
        UnXGlwsPrGeWrRbT5myDpJggh4+rdVaC6VLluq6fXw==
X-Google-Smtp-Source: ACcGV61TKSCKIJh8/lg/b0yJxFHSHdOUIk6t6zLPbOcyfEnKX5GsAympmJ7KW5bDbUyHo9jUGQ7Yv2TS0+sqbe5ngnU=
X-Received: by 2002:a19:6719:: with SMTP id b25-v6mr2700815lfc.54.1539318444177;
 Thu, 11 Oct 2018 21:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181011152508.885515042@linuxfoundation.org>
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 12 Oct 2018 09:57:12 +0530
Message-ID: <CA+G9fYv7+m7nyCO1THnqm5tUVVa5D39u2TLXSW8fY3eMS6cRtg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/45] 4.14.76-stable review
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

On Thu, 11 Oct 2018 at 21:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.76 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Oct 13 15:24:53 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.76-rc1.gz
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

kernel: 4.14.76-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c0c2a4359275ed099acb465f0c929abd22647d64
git describe: v4.14.75-46-gc0c2a4359275
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.75-46-gc0c2a4359275

No regressions (compared to build v4.14.75)

No fixes (compared to build v4.14.75)


Ran 18438 total tests in the following environments and test suites.

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
