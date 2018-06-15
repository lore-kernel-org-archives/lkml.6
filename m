Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A2EBCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D38A208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyotMfcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D38A208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965335AbeFOAYv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:24:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36595 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965143AbeFOAYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:24:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id u4-v6so12107102lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7k477ND6m3ztIITlTR+/whns+EsExbW3ohIgugUiGdw=;
        b=jyotMfcdIjWhb+GAGJeo107zsc2smZvDCkADTEdSG57qKyKOFFk75Ma5Qzo4pOsLfN
         datfYp/bOBeewpwzNKq6Clgfa5R7REHApmu1ppMW1LP5RfL3nHwwpQbdKTOnh6Z/t9Nd
         cXzv51lH6sG2fcyun8yEAqF5jQh3C3YAK4XSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7k477ND6m3ztIITlTR+/whns+EsExbW3ohIgugUiGdw=;
        b=M1U02Ioski/sR7oM/1sMpU17V4f+dZzvfVaYnU8mhNLYQjsFmn/7RzRoyC60/wb30l
         aGAK6VKpAnErgMZ2eSE/IsngGlizMaILdY7VEC26WFj7FArkibKx4EeIl3Ix+EnRlHOL
         PCGB8a7lUxs0Wiedp7w7flEznHjSMtwhMvZJjgaVAifbMv+kpI5SOZnRx5Bn+n6Ys7h0
         YWnNfyXgCHswmOUytI00OJv3QEJpYdbghoMjEozgmq0HniUq6rECRHEyQqaZIMwTkIZv
         gD3KzyCuKRx+9g/v89OEKwfWR0cklWpWYMK4opiVkjGx8UraRszhklj9yUdpd3nFtGik
         q7mw==
X-Gm-Message-State: APt69E3mddeOzVerxERYkR1PMzRP/KAPvu2MLY4W8605ZleJ0URrSEvb
        5a1e/q6BaQB21MysMysTwNWSqPNAqRPFuUR4Li2FOQ==
X-Google-Smtp-Source: ADUXVKIU1D3RCbOG8bTEVN5skfZyoIv5Vh0B4x21KA3R9XJ9hsOgo97MFECQlicHSAJMYZ+al1b1gFQu0SDrWWyhI60=
X-Received: by 2002:a19:51db:: with SMTP id g88-v6mr7607855lfl.78.1529022288228;
 Thu, 14 Jun 2018 17:24:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 17:24:47
 -0700 (PDT)
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Jun 2018 05:54:47 +0530
Message-ID: <CA+G9fYvaPVrntD58f5VnWGWDT6HMuyms_4-q-dHRq4VaS=RVFg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/24] 4.4.138-stable review
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

On 14 June 2018 at 19:34, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.4.138 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jun 16 13:27:15 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.138-rc1.gz
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

NOTE:
1) ealier reported CVE-2011-2496 failure test got PASS now.
vma03       1  TPASS  :  mremap failed as expected

2) LTP: cve-2015-3290 failed intermittently on qemu_x86_64
https://bugs.linaro.org/show_bug.cgi?id=3D3910
We will investigate.

Summary
------------------------------------------------------------------------

kernel: 4.4.138-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 64f298340be794f1500c602285b542c4bfd3eb21
git describe: v4.4.137-25-g64f298340be7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld \
/v4.4.137-25-g64f298340be7
^ Please join URL

No regressions (compared to build v4.4.137-15-g7d690c56754e)
------------------------------------------------------------------------

Ran 7174 total tests in the following environments and test suites.

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

kernel: 4.4.138-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.138-rc1-hikey-20180614-218
git commit: 55a4e4dfb0ebf4bbc212a778883e72f06d3735b7
git describe: 4.4.138-rc1-hikey-20180614-218
Test details: https://qa-reports.linaro.org/lkft/ \
linaro-hikey-stable-rc-4.4-oe/build/4.4.138-rc1-hikey-20180614-218
^ Please join URL

No regressions (compared to build 4.4.138-rc1-hikey-20180613-217)


Ran 2629 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
