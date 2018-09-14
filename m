Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC72CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BBE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTm3qP4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BBE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeINRlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:41:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36799 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeINRlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:41:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so7375328ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IuqJ988JHm7HPVOx4hvd7xrz9HWcvF6gvGPQAT+0wIY=;
        b=WTm3qP4cRSMhcFt8vwmVQiSKzB5l/sg26zOrPE8bY8t0W4s2vj/WFWE6QB+OKDjKBL
         ITFfcWge/pSP4bTNxF2bBEQd3jPiXqgF3QaZmgjY0bUFaRBqL7LSuggsAavKwcmh4VE1
         ZsInrlLMPBscX3wf6jr+YDC/MaqRXlISTZC5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IuqJ988JHm7HPVOx4hvd7xrz9HWcvF6gvGPQAT+0wIY=;
        b=Uodl2+bGB4v8wMNdy8sR5zY4Zdz+R+7K8yVzmcl3q9xAyWyAizGMZ+HLloajzWqJzv
         ec9pSDQBR5/tNtcnoylL7qY7GWFNzt2OyS/qBx/JTiAWvE+ZU/fY5q2APstHlueLsXr0
         qI+Jm89DPK485DpBd0YSsYy0Ongon1y7XIobH5XKnd0mF6v0QlEujl8uKTHmBUKOd7Bx
         zxXma/OjhX3vcx8ry7pv+PcWEnU/qRmb4WZvmVkUtWxF/8RSFLQlgjCgIwisF6bagqFt
         nN81DyeNDXq13dmfHkujzztuXBPS2b9FcHCa7D9BbZHZ91kyCLyQnJFsEKIdDswU2BI1
         Eh1A==
X-Gm-Message-State: APzg51AAiA0eBo5vbrt6iOom/XHgpWhhl9yi7nrB7ySvMI48uXSDTdX2
        u/GHIGDSX76eJuuLec89WUtrBq3QB7rb9md5WQEB/A==
X-Google-Smtp-Source: ANB0VdakfyaEfM6Qnrrxopyj4/Mb4sT4LHM9uyv7ZJyBHSjrQmRkoTqkRj1mlTh+zVLxVnJzJx7VjqkFbza4ECPdwQ8=
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr7908035ljh.18.1536928028042;
 Fri, 14 Sep 2018 05:27:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 05:27:07
 -0700 (PDT)
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Sep 2018 17:57:07 +0530
Message-ID: <CA+G9fYtUJxWDgH9E1Kdp0HC0i3ANc4-FKLTu8fe3SkDZeHmwLA@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/197] 4.18.8-stable review
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

On 13 September 2018 at 18:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.18.8 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Sep 15 13:17:57 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.


Summary
------------------------------------------------------------------------

kernel: 4.18.8-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: ae285c20144a3ff94c31498fe34ca1decb2f0b4c
git describe: v4.18.7-198-gae285c20144a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.7-198-gae285c20144a

No regressions (compared to build v4.18.7)


Ran 20231 total tests in the following environments and test suites.

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
