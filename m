Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523474379-2-15824112483724142937
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523474379; b=YyQ/l/xy2G8H9tfUukYPdLCnO5kytPNQUts9pbTas36Ecc0aNs
    Qjt3XNYhSqzY+XJBXTUJGKqxflQG/NV8ZTjDYhfO2MRwvXCX6W5IfyO4IX3gvX6x
    yA9Anyr1/2qQ9urUcb/a0ZCAfoOnvbziVf8enaTBPDPTH0zue158rcbBucUjpNlc
    MMzQ1n+LRMaPJZjkbo2uFzXJDUQrozuesYIUp8cdC/c/KfSR6LOBWomrorfHuLh5
    m8xCspdvEtMR/ETINQoQneXenSTJ4hfhrQqMuX+Bzeag9EzgbC+0jJHlacGrhOUE
    Yvf/7gdArMl55GHCbxTq0MKRhsU/KfsqcwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523474379; bh=Khc2G1t6T23
    Hjd1qrUf3RKIfE6esINHWIuH+P52U6YA=; b=FFGUnIYTqb0j13/swCum6auq8AB
    JPCsGcAy21a8J0SE3vsKyPxwAg3l5rIuiDHEcqzgkBprBmAbqavgxtZCAfjwc/Z0
    FxSNXUVZ+OMZKOPsPrOcpmYd5rqg/Ckpq4rWzS6POODeySHMbF3aPhBoaayAakdw
    WYR+deTgzwxBTVSBz9KstN56C2K7uRr4KUMblMjisyNbt5neqq8r5FN5gsCm1d8L
    JdJ+65L5pccWlUMWgI+GHqTFTJM9sLD/O8QjVgVKYHErV28RsUiPbQJKX2iA5ZZZ
    +FTTrBi8tDUQoSxVpE3FglBWDV3XtokLv2mxE3ZDutwyEDR+V0Fc/int8mQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K1m4RP0i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gf+LZ4ZZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K1m4RP0i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gf+LZ4ZZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEqRmc4X76Y1VmuyKfQA7X+g6A/LUHQiplvYi7BPfbezXHmBWpQGVFyItJUVIIrURpZ6Rjud456fHzvzyqwVUV4kWUWwO5oaORINbHdVQIJTjThyrVCY
    I3th9dsdoLudAugWFaRc/b6Z6d+p+tLlXqqD4fJutQQXjUcBASc0rHvm3+stfjfjzkpizPAhyBMum2LL/LUr9mxu/2hU4D2mGeb+Jqxk4Flx4rU6jnudyylD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=DFuB5R5a5QQA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=lUNDEtRtmkb4kZvUikUA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756912AbeDKTTY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:19:24 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43928 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756907AbeDKTTW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:19:22 -0400
X-Google-Smtp-Source: AIpwx49Ddx6rJvShf7ChziCj9Ve/eFsDXLXaR4Lbm0TMnhMxYRZrUkNfA7qZkh7kMPxcX6AvhAxOPA==
Date: Wed, 11 Apr 2018 14:19:20 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.14 000/138] 4.14.34-stable review
Message-ID: <20180411191920.rizr6s3d5nc3jxbx@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180410212902.121524696@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 12:23:10AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.34 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 12 21:28:20 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.


Summary
------------------------------------------------------------------------

kernel: 4.14.34-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: b8a8fc70e6b2de144668a066f87e4f94203c0caf
git describe: v4.14.33-139-gb8a8fc70e6b2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.33-139-gb8a8fc70e6b2


No regressions (compared to build v4.14.33-100-g0538e3088854)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - fail: 2, pass: 19
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - pass: 14
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 148, pass: 1002
* ltp-timers-tests - skip: 1, pass: 12

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 17, pass: 48
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 151, pass: 999
* ltp-timers-tests - skip: 1, pass: 12

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 18, pass: 47
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 22, pass: 58
* kselftest-vsyscall-mode-native - skip: 22, pass: 58
* kselftest-vsyscall-mode-none - skip: 22, pass: 58
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 148, pass: 1002
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 19, fail: 2, pass: 41
* libhugetlbfs - skip: 1, fail: 1, pass: 86
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, fail: 2, pass: 62
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 2, pass: 20
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 97, pass: 1053
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 19, pass: 61
* kselftest-vsyscall-mode-native - skip: 19, pass: 61
* kselftest-vsyscall-mode-none - skip: 19, fail: 1, pass: 60
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 1, pass: 62
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 5, pass: 9
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 119, pass: 1031
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org
