Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B549C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF071254CE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWPlI+Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF071254CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeFYGkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:40:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32801 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeFYGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:40:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id b7-v6so2643017lfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i/NAEmbT8X/AqDY1y/w8TTEj2yG3Qk6PVRvIbuZN+qY=;
        b=iWPlI+LrPw8w4U5nhWfy5Ip02njtf1HlOQ9Aw6eyUSR+HOAk0EaC0IboLudAS4Vx5e
         09Fho1poiFIn/ftVgd8aUsEhwY2Aq807j8SQyO7a4osTmHO55NYl7+oUssQ1SaKhPJ9z
         bIyKUWfGGuR1ui9T5us+a32vciB9q/mU1xIYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i/NAEmbT8X/AqDY1y/w8TTEj2yG3Qk6PVRvIbuZN+qY=;
        b=XaF6BVjz5cgSfKo9im/clQOI5EM2lAgda6mKomvCulnJbGJhXoy2YfcIHqtVC106TB
         Zr3wheNS8IMz5CxxgjDbJufUzZBOvaoa6hWFYCfeAaoLhB9eDZj/wRsPR5i2+u6udpeg
         pN0UEV5ifS7BohVsNkFt0reSwQirhTL199m/Sa+bH3voCcy01MlRQ1VOKCFjWpK3Jp1/
         +6l9fLy21QYvExQ1ol63ONYoZN5g6uTmhHulKF/2Uo/jyN5MKljgM6deeRRxoofQIg8h
         3f1q25Fm/gdRn6kBLNaP8gttURcx88G2jyH7igPoD6otsHUHXuHO5oxKVKrVNmfzng8z
         ispQ==
X-Gm-Message-State: APt69E14H23wiMHmWmCNigupwmQZSulnnIWZ7rfCybjbn8BOm160VOlo
        TnBetn/Xw5jOYoS23Hg8v2NcTwY4fF2NsEIg2eUheIj/ERc=
X-Google-Smtp-Source: ADUXVKJju+iou2dilcpNOQZ4MrgBriqbeavrAgvH9dtnuqEGTGlBNiIZk5H749c/rUXkaSw2y4uMAxVMSPd4iwXbSUM=
X-Received: by 2002:a19:e955:: with SMTP id g82-v6mr4792746lfh.44.1529908808926;
 Sun, 24 Jun 2018 23:40:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 23:40:08
 -0700 (PDT)
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Jun 2018 12:10:08 +0530
Message-ID: <CA+G9fYsxWVXZH=VB9tCvBcJ_K4pOPs51J1XnnCjF8vcBVMadDg@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/70] 4.17.3-stable review
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

On 24 June 2018 at 20:51, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.17.3 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jun 26 14:27:20 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64 and arm.

Kselftest test case mov_ss_trap_64 is causing kernel panic on
qemu-system-x86_64 and PASS on real x86_64 hardware.

[RUN] MOV SS; CSx14 INT3
[  762.263790] PANIC: double fault, error_code: 0x0
[  762.265169] CPU: 2 PID: 3380 Comm: mov_ss_trap_64 Not tainted 4.17.3-rc1=
 #1
[  762.267588] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  762.273190] RIP: 0010:error_entry+0x12/0x100

Test code snippet,
main() {
<>
    printf("[RUN]\tMOV SS; CS CS INT3\n");
    asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss=
));
<>
}

Reported upstream,
https://lkml.org/lkml/2018/6/25/19

Summary
------------------------------------------------------------------------

kernel: 4.17.3-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: 4e56d190f826dbe3dc77b99291db99e22ad918d6
git describe: v4.17.2-71-g4e56d190f826
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild\
/v4.17.2-71-g4e56d190f826
^please join above link

No regressions (compared to build v4.17.2-15-g894caab83aab)


Ran 11451 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
