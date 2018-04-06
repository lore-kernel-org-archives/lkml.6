Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2440482-1523053530-3-13271921888099282564
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523053529; b=i/WY7SOkxKJQCus3CtrQiHysRW/5Uzru4AEh8bzrfg8gwkBK2u
    t/Txofek9wpWujZCChVpuwPJwWGqMryP5n6CkgKZAMqLuG8g3dgkygX68DlvGLyX
    NQkjyBOjb/fYvDWevt/HR4W2Y0mhRsb4uLi8omrgIoVoa1Vkbp3VLgEQInHmrOB+
    gtnxVJnygXS6RwX8isVo0S1FJMqdmtB/nECcaVoxJ0ah8ilW5+bbOZWNOLNqwyho
    +b7p2QhseYzhOz3S/WRTOCmKpIJKfCyftfdgoky94FZqx1NnP6HasB5qbA6FLbTt
    cIwFeJQgQti1OGNpSAUdzlcai4sOMbPWXWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523053529; bh=fnT2V/qp0N+
    GY11GHq5oBUAJuTk7d1Yg8DKn4hIV/t8=; b=BcI9yq06L9cgfqUL/JLHsUGtR8w
    i3zNfh4dQOszmLzUfucMCoQfF3mzYXCKu8AQDXx6JTiauTYLlkBg2MSn1FOjyx49
    hORDO9cVG7eT0LZqFN2XDXtGlCsKZgkBgallujVrnL0CXVJX6y9gpk8udkRb2Oxu
    hS68JbI3rC29OcCCvNd+iFf8SUN94Ngj+TGBrbXyka+xnN5+O/9/TVJsaOU8nggy
    eh3GAkpG/UbPwCAvNkK55L/uABIs7w0QAENBLmqJ6BWYhbOFngzdQymCnngZKEXn
    hj7P60XPcMEDq83QrtdJUXB9Sodks80dNlGXfvLp1PSdwcffCRyTy1L7RbA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bHjX76rq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ppB1s8m2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bHjX76rq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ppB1s8m2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDZ+na+7sQlDMUYILR1iiqA37RkokOuH1ynNU0qkPQGQvCRtP5nfAOekFnAZL3AsHUJYbTvGgOjbRsgm57ZHwJ/+3N47CcVJTPR/jwSWbju8nEfJ7Dys
    52F2zZWsHactAfTbUg2oCTrJckOBRl8ht+6wSJO5PLBWtmzOO9d7X3yINvXynh9veEx1FRwEt8eQWPeosa60GPdXmOnt0TMxm4VvYwRhUMIL/OJ5QxsfVUip
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zoehSAk54XIA:10
    a=Kd1tUaAdevIA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=DoGZR-QQEQCsrVOZE3IA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeDFWZ1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 18:25:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55296 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeDFWZ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 18:25:26 -0400
X-Google-Smtp-Source: AIpwx48snlOqThfBbrGJORbKboekiNRq86LCSwE1H8rO5k6qdbmfJn3lOIu5XuFI1s4AbZAKgNk3Qg==
Date: Fri, 6 Apr 2018 17:25:24 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.9 000/102] 4.9.93-stable review
Message-ID: <20180406222524.dzzyzh3su3ytgh3u@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        Will Deacon <will.deacon@arm.com>
References: <20180406084331.507038179@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 03:22:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.93 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr  8 08:42:55 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

There is a new test failure on dragonboard 410c (arm64) in
kselftest/cpu-on-off-test. However, it looks like the test was failing
but giving a false "PASS" on previous versions of 4.9. This -RC seems to
have changed the behavior enough to cause the test to actually mark a
failure.

In any event, this looks like a db410c-specific pre-existing issue that we have
already escalated to our Qualcomm team. Details can be found at
https://bugs.linaro.org/show_bug.cgi?id=3723 for those interested.


Summary
------------------------------------------------------------------------

kernel: 4.9.93-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 7eea6c2b79f0c0f15f8a519cd2797bcfffc47d4a
git describe: v4.9.92-103-g7eea6c2b79f0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.92-103-g7eea6c2b79f0


No regressions (compared to build v4.9.92-85-g6664986610a8)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 24
* kselftest - skip: 27, fail: 1, pass: 35
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 4
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 4
* ltp-fs_perms_simple-tests - pass: 38
* ltp-fsx-tests - pass: 4
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
* boot - pass: 28
* kselftest - skip: 47, pass: 78
* libhugetlbfs - skip: 2, pass: 180
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 4
* ltp-fs-tests - skip: 4, pass: 122
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 2, pass: 42
* ltp-io-tests - pass: 6
* ltp-ipc-tests - pass: 18
* ltp-math-tests - pass: 22
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 151, pass: 999
* ltp-timers-tests - skip: 1, pass: 12

juno-r2 - arm64
* boot - pass: 27
* kselftest - skip: 23, pass: 40
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
* ltp-math-tests - pass: 22
* ltp-nptl-tests - pass: 4
* ltp-pty-tests - pass: 8
* ltp-sched-tests - skip: 8, pass: 20
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 28, pass: 52
* kselftest-vsyscall-mode-native - skip: 28, pass: 52
* kselftest-vsyscall-mode-none - skip: 28, pass: 52
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
* boot - pass: 21
* kselftest - skip: 24, pass: 38
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
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
* ltp-timers-tests - skip: 2, pass: 24

x86_64
* boot - pass: 22
* kselftest - skip: 25, fail: 1, pass: 54
* kselftest-vsyscall-mode-native - skip: 25, fail: 1, pass: 54
* kselftest-vsyscall-mode-none - skip: 25, fail: 2, pass: 53
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
