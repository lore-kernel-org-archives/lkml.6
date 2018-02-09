Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2177121-1518208848-2-14771209710313491329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518208847; b=SDGFrDdnIsIt2r155k03TFkPWqpWQAVFflqFfJVO5KT7q1o
    Oqw6tVMF9fPBShNttazi5A5MKYCp8UdLsRC9jciGjIbr655LUoyE8mdSHUUUR3PS
    ryUniz3BJTvt7gUmgq3ler3n3xU/gC9wBhag9OsR4oiqLawTOpKYvdO2Z3bqSkXh
    wbXsOQazi5BPeHZaoZUZA1jR/tX5tfDSUyQJgs9FVDAXz2+R0UWzGCzj2xpBsS2+
    FA2wAUXCdhhVofSnwCxyqti27v+kgVsOrLGba8g9fXeE7Gf2wwIg5h8qRKLH3DSD
    KxwUsu35Sliwi07HCYRqB7ZHSLyAw9NLDgLbNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518208847; bh=oq9goR3
    8XNTbzwHGkBMpwkaoMEa1tA2PSZ/aPlr0Dns=; b=Qxqy9k3/X2qZ0neMfgnFJi5
    qGWPYanKK/S8zHH0Y+vmvCATNEoiRQyZVQgZroimoDxCiBT95NFhltSV995gwICj
    cZLPgWkHP+A/0P+yE2Lx0jfjQAcOk8sbiEiHJhrnOAb8jkGMVB7m+wtBcSNopV5o
    qworKYUym73zgLT3LB86M5OhI1yjznHFQIEnudkNUUT2dYJmouicXHI4hwXT19ft
    oPO0DFCb1EGFyeliXz4ep1sBUT+yQVTgv/YpZLN/4636PpyJvHxDJKDFUZ6Oj7/P
    fSaHLgJ019j9Oml7Aw67JKFk1pZhRN9mi3XWAIfv7HqmMCfOK83nBIL42Gt7hGw=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Tn7c2wBq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WFZL371B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Tn7c2wBq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WFZL371B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeBIUko (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 15:40:44 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43329 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIUkn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 15:40:43 -0500
X-Google-Smtp-Source: AH8x227NQDh0ktO/7dKPe3EiwnQMxJ+gVcqHDW5vtF4yGJjkE0GdZ/abpuBzvBkuD6VDiERsfjq6wQ==
Date: Fri, 9 Feb 2018 14:40:41 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
Message-ID: <20180209204041.vupzthy4cphzem4p@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180209133938.366024920@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 02:39:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.3 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.3-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Since the last RC, we have upgraded LTP from release version 20170929 to
release version 20180118. The fanotify06 (and "runltp_syscalls")
regressions listed below are due to a problem in LTP itself (see
http://lists.linux.it/pipermail/ltp/2018-January/006915.html). We will
either carry a patch to fix fanotify06, or skip it until the next LTP
release. You'll see this noise in the other branches as well.

Summary
------------------------------------------------------------------------

kernel: 4.15.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.15.y
git commit: f253047fc1615940f91756b2dda08aca97d57d6c
git describe: v4.15.2-24-gf253047fc161
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/build/v4.15.2-24-gf253047fc161

Regressions (compared to build v4.15.2-23-g1b51f4a14c4b)
------------------------------------------------------------------------

hi6220-hikey - arm64:
  ltp-syscalls-tests:
    * fanotify06
    * runltp_syscalls

    * test src: git://github.com/linux-test-project/ltp.git

juno-r2 - arm64:
  ltp-syscalls-tests:
    * fanotify06
    * runltp_syscalls

    * test src: git://github.com/linux-test-project/ltp.git

x15 - arm:
  ltp-syscalls-tests:
    * runltp_syscalls

    * test src: git://github.com/linux-test-project/ltp.git

x86_64:
  ltp-syscalls-tests:
    * runltp_syscalls

    * test src: git://github.com/linux-test-project/ltp.git


Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 9, pass: 57
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
* ltp-syscalls-tests - fail: 2, skip: 152, pass: 996
* ltp-timers-tests - skip: 1, pass: 12

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 10, pass: 56
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
* ltp-syscalls-tests - fail: 2, skip: 149, pass: 999
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 12, pass: 53
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - fail: 2, skip: 17, pass: 62
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
* ltp-syscalls-tests - fail: 2, skip: 97, pass: 1051
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 20
* kselftest - skip: 10, pass: 71
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
* ltp-syscalls-tests - fail: 2, skip: 118, pass: 1030
* ltp-timers-tests - skip: 1, pass: 12



--
Linaro QA (beta)
https://qa-reports.linaro.org
