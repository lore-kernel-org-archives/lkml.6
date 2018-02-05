Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3756707-1517875157-2-18208504860668707450
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
    t=1517875156; b=moHqJgEbIVhgc6pOjqe3ANYPQGfbpEQ1Op5qQnrut0wa5Dq
    K4f219vCrwDujff5WNOKQUztIfiWU1goni7O9AwASMO7aYqDeNRy0tCA6pbb5D0f
    TcH4SUU1iMDyRSwMFJpE6DRpseSe38YIvPB6chLY29QzmbG9WBg9eeT2/8e2MSIT
    KB4wvNRdzFBfx2kxllaEM+e3Rdemwxv+0rQ/9HAKZdTRVMyn13OTdSRwthNn514P
    8vBDbMMewID2gWNwMSkMBNkoRzw6f11RLcJ2vnk+OSWKl7OVrmzOHl1ZKLTJHo1x
    N1+Xv2/C7T2gQmda8KHPJYvfhtdUsGqVZg1T/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517875156; bh=XvEX+fX
    7pb/2sqCCbzcid7NZVgT4SfC1HOCzfZZdAt0=; b=Pd6nwuEtdV8b7YrMT4xjcGl
    DpCc2dnxoK6hkkna9oriISbq85uOrJzS5Wj5gPVSi7do6VCDTdKVCnyIOSTEesOG
    de0MvWH6p56sT2qJwSO+jm59PAVdUdOboTxa5aeS81G2/5brXlLSAf4f2wLhpHaD
    M9SrAUajBox1Cuv7M2c82fBBZICQoFaQWewdg9urhJ3aO3BP/YmJLANUjy1knqcU
    BcvGULCjkX4qKa8dOfNfF498DAcQ0/OHf0T2ulG93dWr+O4kG8sHTG+MEZU7gFuA
    Ey9oTjqTasD+yQgDZwyJbKxpZ/M8uv1K5nk1UzSoFH8dB852i8k1j/wKgjeYFGg=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Hj1K98+V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fdKmAdPb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Hj1K98+V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fdKmAdPb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBEX7N (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 18:59:13 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34038 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeBEX6Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 18:58:25 -0500
X-Google-Smtp-Source: AH8x225u1ObGA1FaJw4S+5uQBE4oZkwpBc8/LItU8NSNbTf2X93xiZAKntj09A+U/rgmXaHXezZMMA==
Date: Mon, 5 Feb 2018 15:58:23 -0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
Message-ID: <20180205235823.vjqdgvwbsdh7olqe@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180205182213.902626065@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 10:22:33AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.2 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:21:57 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.2-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.15.2-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.15.y
git commit: 7ab5513e4cbc716221fa956decd2842373c54452
git describe: v4.15.1-61-g7ab5513e4cbc
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/build/v4.15.1-61-g7ab5513e4cbc


No regressions (compared to build v4.15.1)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 45, skip: 14, fail: 2
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 984, skip: 121,
* ltp-timers-tests - pass: 12,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 46, skip: 14, fail: 2
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 987, skip: 121,
* ltp-timers-tests - pass: 12,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 41, skip: 16, fail: 4
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1038, skip: 66,
* ltp-timers-tests - pass: 12,

x86_64
* boot - pass: 20,
* kselftest - pass: 56, skip: 16, fail: 3
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 1,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1016, skip: 116,
* ltp-timers-tests - pass: 12,



--
Linaro QA (beta)
https://qa-reports.linaro.org
