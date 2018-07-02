Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F56C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A242148E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edar7b3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A242148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeGBNeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:34:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46957 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeGBNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:34:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so12573102lju.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OjfIYAVq8uObH6kVQRW6k43SWPApsJ+gYFtG21j3Rds=;
        b=Edar7b3ZdXvnW67/X8eFBTtpFmAWRDyP+wuanc7cL7fSaCSZkYt5KfUQkSCNAHZz8r
         rN0Qhf+PEhwXkiZOsqXEwYe+We5ifava1LKWO8V+Uk09UqklCpAMSHKFuVm+egUIY+q/
         h54xy5kbtfOqjZS+oTGoYNKcpe0HioTl+VNZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OjfIYAVq8uObH6kVQRW6k43SWPApsJ+gYFtG21j3Rds=;
        b=QUJM3cXrPxuWTk+uTY8Ur5gElYu3wlPDXAkNCu3C6WtmtsCFjUzied3WlRCUegGl+o
         GIxqicgibqb73rF6YSgxGaJCI+R9ca/BiLJiagNLqQPzz0HKIcOHEa3IpCzmbPNdmopE
         hw8Rbjuir4TsOONw1pw/RVejET1SZZ9haerRs2fy81eJ3JUWpw8sH25CvrotOu/e2aB3
         vdS3KjNYLgR/RiXSfV+w0/TLeg36kiS8D5eaVPm7NFm2OFCG+hBu57lzH7uqNi6znMYK
         t7DVcEslr4jWXpiCDA+vbVXPskGQYVspkxKYgJP7818pKYjogueALMdybF5P9xbq829x
         SDzA==
X-Gm-Message-State: APt69E0ZL/6p/CQTXyqz7aVIBjTY4NhNzRYNuMmcOSs1W5HgATrpq9A7
        lqOlLp3/m0wQaKqfr/so4pEpf+Y/Pd+RXPgIGbtmhA==
X-Google-Smtp-Source: AAOMgpcUeVG+vlKJXSAsyow6ifX0lxn6iR7BR9VD4j7MIHApea5WlZfucYBFld2ccrJSDVoUQD0poP7e16WqrAgpe68=
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr4162466ljh.95.1530538086261;
 Mon, 02 Jul 2018 06:28:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:28:05 -0700 (PDT)
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 Jul 2018 18:58:05 +0530
Message-ID: <CA+G9fYuNV14tn-2Ls5eZMCPnGFJoXD4sLoZii2rYZ=wpA6-=YA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/157] 4.14.53-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 July 2018 at 21:51, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.14.53 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jul  3 16:08:21 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.53-rc1.gz
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

kernel: 4.14.53-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c142659d316c32d37d59e4057be8bc25556b840c
git describe: v4.14.52-158-gc142659d316c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.52-158-gc142659d316c


No regressions (compared to build v4.14.52-158-gdb3abe281d91)


Ran 11319 total tests in the following environments and test suites.

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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-pty-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
