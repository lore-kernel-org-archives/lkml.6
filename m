Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E6D7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EFE208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkUWBeOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EFE208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935727AbeFMUsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:48:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41214 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935524AbeFMUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:48:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so4099437wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5nzn7Z1WAx5i3BHD2ZxIJUrzmf7dTis1n/gueNb9ZdU=;
        b=AkUWBeOw7ov2k0l7pD+/nmcyDGr4QiJotKGTQl9MlRoOYLI35mrjPoolhXnoAQf+4K
         mAbPNaEvY40pYvbcmnsjxrLjRho9bQczXgknNWsuM7hajhAptl9DNSpXN9nWij34DH/0
         5ScAJe++WBR37GDoolzgW/UZAW0uRg0JPqXnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5nzn7Z1WAx5i3BHD2ZxIJUrzmf7dTis1n/gueNb9ZdU=;
        b=OF2BsR22jlQz3CWOfV7f1Hlp/erF187pRUC5g12juEjMzzdWGa9aHNmQahaZ+WbjZh
         AXJDUBZepSOFrslOWIvIlySxRNTLhtRObtfpbYBN/eQYqTvwUwS5Bbob+yfJXRL9RRKC
         8DxLkTGvey7EU5++NEEAUvK775krVO11GNtMgIv8wLz3XoQMddGP87FghVF7NF+OdsKt
         Nc20kyRRPSyJQU0G7D7a86mY0Gk4JMnMJDdPV5DrQYAptgWrkktUJufUqT3quJaD5qJM
         MX0qBjBmLJ9dSAm3y0J1ZsD/NOoTY+01SfGH4N5EwsPMD3CyApAGiBJlXgarBtFPEE7/
         r/lQ==
X-Gm-Message-State: APt69E3CrsgRZQm6lO64Q1RUDoJGR3L1sZt+V0WfrrsHcNYY8dlTw0aO
        RZDTgwf0+RzzQrqJruBY0awM/C+F8Cl5ch2Q13A3PGRp0rM=
X-Google-Smtp-Source: ADUXVKLfiH/sPBN7+O5/rubPlHMpSAt+glJxiK+1wLDNJmN3rkV0KyDhu3IQjDQH+5+Bm0HtTRqHXw2r9JXwxjPUmO4=
X-Received: by 2002:adf:b782:: with SMTP id s2-v6mr5102375wre.247.1528922910441;
 Wed, 13 Jun 2018 13:48:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c389:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 13:47:49
 -0700 (PDT)
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 13 Jun 2018 17:47:49 -0300
Message-ID: <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Results from Linaro=E2=80=99s test farm.
Regressions detected.

NOTE:

1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because of:

     6ea1dc96a03a mmap: relax file size limit for regular files
     bd2f9ce5bacb mmap: introduce sane default mmap limits

   discussion:

     https://github.com/linux-test-project/ltp/issues/341

   mainline commit (v4.13-rc7):

     0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros

   should be backported to 4.4.138-rc2 and fixes the issue.

2) select04 failure on x15 board will be investigated in:

     https://bugs.linaro.org/show_bug.cgi?id=3D3852

   and seems to be a timing issue (HW related).

Summary
------------------------------------------------------------------------

kernel: 4.4.137-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 678437d36d4e14a029309f1c282802ce47fda36a
git describe: v4.4.136-25-g678437d36d4e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.136-25-g678437d36d4e

Regressions (compared to build v4.4.136)
------------------------------------------------------------------------

qemu_arm:
  ltp-cve-tests:
    * cve-2011-2496
    * runltp_cve

    * test src: git://github.com/linux-test-project/ltp.git

x15 - arm:
  ltp-cve-tests:
    * cve-2011-2496
    * runltp_cve

    * test src: git://github.com/linux-test-project/ltp.git
  ltp-syscalls-tests:
    * runltp_syscalls
    * select04

    * test src: git://github.com/linux-test-project/ltp.git

Ran 7100 total tests in the following environments and test suites.

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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.137-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.137-rc1-hikey-20180612-214
git commit: e5d5cb57472f9f98a68f872664de3d70610019e1
git describe: 4.4.137-rc1-hikey-20180612-214
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.137-rc1-hikey-20180612-214

No regressions (compared to build 4.4.136-rc2-hikey-20180606-212)

Ran 2611 total tests in the following environments and test suites.

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
* ltp-fs-tests

--
Linaro LKFT
https://lkft.linaro.org

On 12 June 2018 at 13:51, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.4.137 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jun 14 16:48:07 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.137-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
