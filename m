Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1395846-1524692546-2-13646623062566722924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524692545; b=SsySLInNnPmV1iBxWn6fVmAWqUct91+st4vkFdA7oJnbTSqIYV
    Zwx2EAwgNhUIJ2832zzqZ6k+ovXSd8uL/JXCYJrNq+0zSpYBjRWLJl1CJpU+tSJQ
    /hzmAPqoc13t0o/sLU/LpeZ0ggrR9pZvq9TxWVtddGJJ9Wbmmsb14mPqCOWgBmf6
    aY7cfADYengRR8Deul9Nfg0mDxCg+Ifukx5zkQC8yxAB8epVQVhvKXbXzEPWHBA7
    8tnhVbVOc3t1VCpBgi5sqipWlyMeFK1XLLTaTnvs/i0JE6bMa30my5KXAGtXYUrs
    VEtfakDAYMkDqS29DfB6X46Uv6Bu0wlALjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524692545; bh=JTHzXa3tizl
    Ak+NbcXc2N/fruD+95MdYUwWSsWfN7ik=; b=C6f306IFp+lM/pQtBhKGHO09fZl
    M7jma13jAjqMxQlPHi/EUiPPHOxLNs/+kxL4/13p8YBp5Q0n/WABGJTZc0jyqpiE
    UiWoJX/mkJ7j6+y0pghKzRut2JkWco6Dwjshps7mIjjYJDiHOsl+HmuuvffDN5+k
    2qJlxJEYkWLuTmEY6aOAbDdF6pJb0qBnQooQ33b3yMO4dcyy4C8IM/fMcuoGE09e
    lFipsn98DdMpk25yTQxYaa+fX2Y5K9QVngsWUycs5AujB1i7g++QCxyrGPuwZtku
    kdk+AGYzNgaMWa2YQf0ryMYUC2fbVjPMGuGU48/V5V02hq/VihpE5g7J0kQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jV3BLivP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KMX00t+o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jV3BLivP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KMX00t+o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJqY48BX6n1uk9jOyZ+w0wUXjVw6qqrhvUlY3q6xm/qrs/kBbiLGnNUX2+enBHoU4AcNJZvggnAtJoYub+8Ue3s7o6s9EmpgHMDdNF1IwT+4XfAZQCo
    j+hYhdqmgEFUmHWYVqkrruanqw0Ez5xcuEP1VnHgRYGTjTAw1wXTaQqunjGeeNwB9T+WgkodYpSGcnykeiGSS+QPuwyRJffPer8eEXRXZz4/bhIb4e9z2vlB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=hoiGki7t42oA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=esFOxJfal33-Z0JOBAwA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeDYVmY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 17:42:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41561 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeDYVmX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 17:42:23 -0400
X-Google-Smtp-Source: AB8JxZrjpbjk6b9/OGZYGCEHs8v0jfdSeOvO7Nn84ts2vKyHq44r6Lv+v1lovF/KcQyPbMQJ5+usSQ==
Date: Wed, 25 Apr 2018 16:42:20 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH 4.16 00/26] 4.16.5-stable review
Message-ID: <20180425214220.iec6p5elwu676xrc@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
References: <20180425103314.842517924@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:33:09PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.5 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 27 10:33:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

We did find a regression in 4.16.4 that is dragonboard-410c specific
that we missed the first time around. Discovered using
kselftest/printf.sh:

    /sbin/modprobe test_printf
    [   22.725551] test_printf: hashing plain 'p' has unexpected format
    [   22.726031] test_printf: failed 1 out of 236 tests
    modprobe: ERROR: could not insert 'test_printf': Invalid argument

We'll bisect it and find the issue but since it was already released,
I assume you won't want to hold up 4.16.5 for it.

Summary
------------------------------------------------------------------------

kernel: 4.16.5-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.16.y
git commit: 9a7eb4ea64f3850a0fabfdf2d95f4c8cbffcb324
git describe: v4.16.4-27-g9a7eb4ea64f3
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/build/v4.16.4-27-g9a7eb4ea64f3


No regressions (compared to build v4.16.4)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 18, fail: 2,
* kselftest - pass: 41, fail: 1, skip: 26
* libhugetlbfs - pass: 89, fail: 1, skip: 1
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1017, skip: 133
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 45, skip: 22
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1016, skip: 134
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1017, skip: 133
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 15, fail: 5,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 62, fail: 2, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 15, fail: 5,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - pass: 50, skip: 30
* kselftest-vsyscall-mode-native - pass: 50, skip: 30
* kselftest-vsyscall-mode-none - pass: 50, skip: 30
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 998, skip: 152
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 37, skip: 28
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1075, skip: 75
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - pass: 55, skip: 20
* kselftest-vsyscall-mode-native - pass: 55, skip: 20
* kselftest-vsyscall-mode-none - pass: 55, skip: 20
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1034, skip: 116
* ltp-timers-tests - pass: 13,

-- 
Linaro QA (BETA)
https://qa-reports.linaro.org
