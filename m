Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCC3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C209B2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQIOjKCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C209B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeGUIaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 04:30:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41273 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeGUIaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 04:30:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so12872566ljy.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FeoEjlmoXbHEQ0dzLykSTZWUn8vm9AS+dRYFXBtEZsU=;
        b=RQIOjKCimh9qIwPTqS93M0KdpORkGliO9h+nbS9TmLj+AJY4G+5iFRqVcHjTaHmnfu
         +QNWOzIfWTuiWoivu0sABZyCZy0vyA2H+z3QkJayJfjn8S2e2v7n90y/NzC11Vay9AKI
         erS2swNLWwEwQ3CnBB/gGEXwjQCXNuNogejRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FeoEjlmoXbHEQ0dzLykSTZWUn8vm9AS+dRYFXBtEZsU=;
        b=RBy0WGa4kp1bt/ELC9pR6wS2UksSfC0XNwpy1w+zJtqDEMsP7cIiLP1ekLiOYB3qt5
         oXnNF3Zhb/3IXyPl4JYI6CQ2AX/f3wCstfrlTItX6Zyb9mSqGlYEjnTbIO0glYD/zx1E
         fX3cB1dGlxNOmw0NzOMj/fXkR2cmMskOruGhQifHylT+avxwvNilhNo2cPPkGhpEtt2X
         +UrMRM9gsUeEbyv3pqsSU1GjbnmMtzGPnJec/okXkHi0YWu8H1oXIxUs5EV1JAg7BBcu
         eVxHAfKiBE3XvYEkqA1NZn+buXsLK2nD8UFMerE7Y/VVvsnr84DZBPuc+FKc6K/rU2AW
         IU5A==
X-Gm-Message-State: AOUpUlG7ahC9BdNdtZHkCmnJg1Cp3v4YgjM5QS3QBZhqsRikTxoCeAob
        PEDSId00tKHltllgBfGkDImEF08RyKWSz8/4gLToeg==
X-Google-Smtp-Source: AAOMgpc/L6+Bzmuce0h+AHr95tYSHkEdkFr9INWpyEtqWipxrUveKL6Tajs+TJaFkaZESjoRkSUZzzWka41oMcMs8k4=
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr3807312ljk.116.1532158707186;
 Sat, 21 Jul 2018 00:38:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 00:38:26
 -0700 (PDT)
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Jul 2018 13:08:26 +0530
Message-ID: <CA+G9fYuzotKGrJfFh1b3VhKoOhCFr40qqcV01Qjurb7n_Todtw@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/31] 4.4.143-stable review
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

On 20 July 2018 at 17:43, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.4.143 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 22 12:13:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.143-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.143-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 6c3754d773f4d9c27b2409bae852f83530314d29
git describe: v4.4.142-32-g6c3754d773f4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.142-32-g6c3754d773f4


No regressions (compared to build v4.4.142-32-g3d09af2f0fb8)


Ran 12130 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.143-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.143-rc1-hikey-20180720-238
git commit: 231d528076773b398a822ce163f0ff50bb15304f
git describe: 4.4.143-rc1-hikey-20180720-238
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.143-rc1-hikey-20180720-238

no regressions (compared to build 4.4.142-rc1-hikey-20180718-235)

Ran 2570 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-fs-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests

--=20
Linaro LKFT
https://lkft.linaro.org
