Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397CAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0020881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="isbQX+fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeINSDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:03:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38330 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeINSD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:03:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so2352723lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NRwdzV7ic9h0M3xY0g2RbuWGK7ta0n3rgub2bBvDnk4=;
        b=isbQX+fgWP8Z2OFGj/4V+yh2WgBKRjXa1XOBRHX42FXTiRT4koCe/OSZB77yBCFvvr
         4GsGJy2Mvi9WItR9y4ag1mFHt8LxDm3IMZSp79xlKRthuYJr0vDBCMxrcKEGAwFqqKKN
         sIqrzvgjx5Xs7oERw6evN1VSoUCmxIcfuTp3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NRwdzV7ic9h0M3xY0g2RbuWGK7ta0n3rgub2bBvDnk4=;
        b=MFPnmhgYUHr3S/JOqaVLMWF2X7Qzv9pUz4tbXgSUTxcN2ylT2YJsVu/BQ/vNsL+pm1
         Fa6Fx77QJWC53IKvrHiDKfATgeWaopTOjAA7G3jZpKG/dPzSqTF2UODvXJ/qbfi30umS
         evnfv4iHzPBQWU3HrJfyblfABaRTaEBq/uNcfPPDFA+OzRYG9qIcC0styGdcSpjito3E
         N4VV+nUYMertO8CuWmEMAUFeAQkMw7CDJl6MFbdDY/MyWb6JxGU92GXTJT0uIBp4eolA
         IZRKzy79Jr79moIw/6ovqjRqfAMdKnlh/eeEhpBLiajGubH6hPBUdZ3fa/zC2XbfoAu/
         frNQ==
X-Gm-Message-State: APzg51B6YEGWVl41DBqP7oPdNKbdhAVJStrBttTS2AFaCPvOFGRzrK/B
        lbWY+TDBeYpy74G4mOsRIvhTvvqk9Ln4gt07AHPQ+Q==
X-Google-Smtp-Source: ANB0Vda6sbiuAaX4Gke2T6vfMExDetgjd20ByCwYZrdcqF1Zz7FmcDIjQG66BLzJFJYbHklmXsdlB+UdN2UeqhbBJZc=
X-Received: by 2002:a19:2ad6:: with SMTP id q83-v6mr2812544lfq.74.1536929347066;
 Fri, 14 Sep 2018 05:49:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 05:49:06
 -0700 (PDT)
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Sep 2018 18:19:06 +0530
Message-ID: <CA+G9fYs7Q_rWeZ6Eqxs25VdosgSdwRfA+Xto_SrSOHYsW3LdMg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/60] 4.4.156-stable review
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

On 13 September 2018 at 19:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.156 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Sep 15 13:17:29 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.156-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.156-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 2052f80448e54f0f36a360bb5489f2818ae13026
git describe: v4.4.155-61-g2052f80448e5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.155-61-g2052f80448e5

No regressions (compared to build v4.4.155)


Ran 16889 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
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

kernel: 4.4.156-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.156-rc2-hikey-20180913-283
git commit: 8cbc538b759e57b63bc7bbb767bc7c3336634b3d
git describe: 4.4.156-rc2-hikey-20180913-283
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.156-rc2-hikey-20180913-283


No regressions (compared to build 4.4.156-rc1-hikey-20180913-282)


Ran 2724 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
