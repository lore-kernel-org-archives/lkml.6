Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E34CC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E4620897
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1kPci/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E4620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeG1IUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:20:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39565 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeG1IUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:20:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id a134-v6so4937829lfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 23:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=guiY1fHVxXYi3VZUY9UWJppH2MmCStVw4evIQfdu8Vw=;
        b=X1kPci/I9uANW5sWPgf4FpMMaV8cbr8h4amZnWe1mbOKLcgFqwuG/MvyDYn/kf0XNy
         ZqzP36C6sKCyLHX+FnywRJRwFKPyCEa3NVuzlYdV/Ss1uuBumAqHD8fztVPmcsFbYGFq
         izxRheXSA/cznQzwi7FO1JhvnwWR38y1sPYmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=guiY1fHVxXYi3VZUY9UWJppH2MmCStVw4evIQfdu8Vw=;
        b=PI+hePIi5sJrffL9nArbNM+xvpDdDPB0mXikNp9PNPNxQAI6G68a0+T/n7ELqUOMAC
         20DfmiB3Ejk1zd16npWQaszeeVGAMCZV+LlwJjJdhksYto+HcOYamnBDos6Enqt2Onwg
         EtNHb62mbCdy/a525gIsVln77rfglOUGzqAoxJyxIa8nfGwDKNKEnTkvui0hXPXpGOHZ
         2EdFaI7Pm5wDSd1bdWasKRBN3RCNADf8Y10/ejwJEHIqqArhNPqhUxjUOudDadgoeqF/
         /Pi6v8l4KNGPdWM1f9YdHmVdaHcMjFbRzCxBeSvaQG8MP6K8I3HMzg/oV4Fdymoli+Kr
         1kBg==
X-Gm-Message-State: AOUpUlHKHEVRSHU9BJCKYBCmjKoLyNSA+kM8/liT4WY2GVLZgAAziWa/
        wBDo0KWKqTYoa3M66RZGAo4EgZ7LQc3lRSWdjQcxoA==
X-Google-Smtp-Source: AAOMgpcvLSoS0MGLI3HjhFZGbOTJ2jjmKGgwLYOcecS/MvDNmnYt5dU/526p1wRprVBzq1LkotGLLmHrPv3z342L/gs=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr5504723lfg.142.1532760899202;
 Fri, 27 Jul 2018 23:54:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 23:54:58
 -0700 (PDT)
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 28 Jul 2018 12:24:58 +0530
Message-ID: <CA+G9fYuBeY-aT02LvHR4dvHWYNoBLR4kqk=J5JUyP6-fZEM=iQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/48] 4.14.59-stable review
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

On 27 July 2018 at 15:29, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.59 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 29 09:58:59 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.59-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.59-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: d103c702186cd05c2677d95c7e878e1a6ad3848f
git describe: v4.14.58-49-gd103c702186c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.58-49-gd103c702186c

No regressions (compared to build v4.14.58)


Ran 16505 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-cve-tests
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
* ltp-cap_bounds-tests
* ltp-fcntl-locktests-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
