Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605DFC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFA820857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T95fik5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFA820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeIIJSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 05:18:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41259 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeIIJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 05:18:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so14929702lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 21:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kyO3H5cvv7N8LCZfjhuq8LQ/OebVc0tSNiqu2Uaqqjg=;
        b=T95fik5+6Lq1veBDMGz64dONbb9hVoaBdGev3678VMlxLuh5dqZHrK7M/u/9fjSbHY
         G6DKRR3r0mdiVylmFc0jfjmzQQ3r0unt0I56tiwJ7c+45+nzgl5RxULQzebdzFmCyuA8
         6FwSNWL6Cx4ieNhwPIs5cVaQs9oR3cQ7CRApk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kyO3H5cvv7N8LCZfjhuq8LQ/OebVc0tSNiqu2Uaqqjg=;
        b=DOO9vdaSRCZ2ba5kLICF0ck2yYZPRcjh0f76oa1NRNgRdSHQ75nrvvyrwYQOdzm1DE
         qR0lEO28XEGMQzlot+wDx+hUKYab8Kf29OdkcBErdju0tyYMSJohRAhI9iF5tFRD1ofa
         bXMOZEW2TAuG1EEHPEXfTM1QXBoTW8j/2FTWVb3Y7zKmvTTq42y7xHWRxCbG41LoRj3w
         auPdYfvxItqxfXFltMi8DJo2XHjlBIv3I7k2YVDZ/eZQ85AUGA4zPlpO83awgUhR/qiO
         aHxzuKUt3PgCSkMpCIuugXUgsiPneznVHxClOscLLXDdiOLAitVvLXHlCq21D9J5Qpjd
         0Uug==
X-Gm-Message-State: APzg51ACuwuklRXOZPo0mxpRrcwfzqOTjBOeLvkYgGqkZWIbW9u0S1+7
        hGLONo/d7lZZ2cX/YOK+9cdr4Eaj0dw5tyN7xpwo9Q==
X-Google-Smtp-Source: ANB0VdbGr9Q4UjIC8jKym32UCdJjMPmjIpsRYfie/v1LWnXPoebgkBq/hjix4Vbe6ZCrMcaS8RvCSwOcACv2AJwR8MI=
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr9594434lfd.17.1536467413416;
 Sat, 08 Sep 2018 21:30:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 21:30:12 -0700 (PDT)
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 9 Sep 2018 10:00:12 +0530
Message-ID: <CA+G9fYvVCE+QKFYCzzOPtupnUhu1Gt+g938Un0xBmkNrDZr8hg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/63] 4.9.126-stable review
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

On 8 September 2018 at 02:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.126 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Sep  9 21:09:58 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.126-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.126-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 189fbc4d1993bdac9e743e81f3907d6f16cc1f1b
git describe: v4.9.124-172-g189fbc4d1993
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.124-172-g189fbc4d1993

No regressions (compared to build v4.9.124-108-g31b3687b22c5)


Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 21,
* kselftest - pass: 47, skip: 50, fail: 11
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 26, skip: 9,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1012, skip: 137,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 21,
* kselftest - pass: 48, skip: 44, fail: 11
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 27, skip: 8,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1011, skip: 138,
* ltp-timers-tests - pass: 13,

i386
* boot - pass: 22,
* kselftest - pass: 71, skip: 45, fail: 14
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 79, skip: 1,
* ltp-cve-tests - pass: 27, skip: 4, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 8,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1682, skip: 46, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1085, skip: 59, fail: 2
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 22,
* kselftest - pass: 51, skip: 46, fail: 12
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 26, skip: 9,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1689, skip: 41, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1012, skip: 137,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 21,
* kselftest - pass: 48, skip: 53, fail: 7
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 79, skip: 2,
* ltp-cve-tests - pass: 23, skip: 12,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 8, skip: 6,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1050, skip: 99,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 21,
* kselftest - pass: 49, skip: 51, fail: 11
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 25, skip: 10,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 8, skip: 6,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 988, skip: 161,
* ltp-timers-tests - pass: 13,

qemu_i386
* boot - pass: 21,
* kselftest - pass: 70, skip: 47, fail: 14
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 29, skip: 4, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1058, skip: 91,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 21,
* kselftest - pass: 64, skip: 53, fail: 9
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 30, skip: 5,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 994, skip: 155,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 22,
* kselftest - pass: 50, skip: 48, fail: 8
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 79, skip: 2,
* ltp-cve-tests - pass: 25, skip: 10,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1690, skip: 40, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1071, skip: 78,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 24,
* kselftest - pass: 66, skip: 48, fail: 9
* kselftest-vsyscall-mode-native - pass: 64, skip: 48, fail: 10
* kselftest-vsyscall-mode-none - pass: 65, skip: 48, fail: 9
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 30, skip: 5,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1686, skip: 44, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 118,
* ltp-timers-tests - pass: 13,



--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
