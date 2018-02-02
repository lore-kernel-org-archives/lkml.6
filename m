Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3568581-1517610820-2-12464795786897764828
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
    t=1517610820; b=gW3giG+esqYgHagYt4zoXTi/XrPBTGNOdLKLUlhBEM5N+5Q
    7TOUDgIJ+oyRKCbpbPRd96ZhTBig8Fe2OICEsMwbhLwxzZU3ksu/GLRXM34N5kg6
    fydmyE2GXlnz3y4GPph1GbRVqrudSSzpOLGTuGynLS33BnqpXeXDmVffotpogu5M
    b4Cc6VKOR9dt6fHQGHA7zk3HkDPJUq0YLKsu4POtkMTw99MaCj+CpoG4At9IhZ4Q
    +0sqToJIBvdIL86TfXtk6BuXQMqJMUNc34gzY+1E14NLbgX7VqwrIq6tYc2qIODG
    DksVbmqXM0pVgjo+IG4nvcVQ33Rl0nMXbghziKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517610820; bh=TagwmfF
    pNf+XRyPitz0/SdFylm1Hkeksz9/e0qQMpyg=; b=Wa8C0ZjyoeHtyJxYcndDbcF
    x6uAqH5j+9dcD9c0G3psbD2jgilHrZDwMyaXZ2sdQwtqceGYo/o7h/2i0v7u0P0O
    5AVpgTgsKXQNrMQImPdtmKxKy94rHZXDc2AbCne/Qn4jmokO/l/5iNggy9DBxO9q
    AKuWjA/seZhXH6MEdqjGBnzMWiVZpISBozf1t4T34kXMku7HihIQ/mhpaG04GrHt
    dNdTaJMBBGEUoYVK7F7NWyKtq0CVQ9iQduftY4v1953nVByzdclnZyFt0kHZ9cLI
    t7A0V3EuuXGgmIcDW8YCjCF5didf/oB+AovydWlXWXxNAE5EEPzf7KF1hUBdrwQ=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gbrejd5r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=okOb2XI4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gbrejd5r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=okOb2XI4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeBBWdg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 17:33:36 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:55044 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeBBWdf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 17:33:35 -0500
X-Google-Smtp-Source: AH8x225nUcLBXB2rX+kmwjrjgD1rlD6b68yUOsE15fd2i/YlaphsoT+W101jLpGCsexLm7KHsotOWw==
Date: Fri, 2 Feb 2018 16:33:32 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/67] 4.4.115-stable review
Message-ID: <20180202223332.lcfe4qtptuvloxay@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180202140815.091718203@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:57:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.115 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:31 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.115-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Regarding bpf, I ran the bpf kselftests manually on arm64 and arm32 and
they both passed, but there are only two in 4.4:
- net/test_bpf.sh
- seccomp/seccomp_bpf

Summary
------------------------------------------------------------------------

kernel: 4.4.115-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 4b03f2681e21018655a0b84a348f4f152dfaa74e
git describe: v4.4.114-68-g4b03f2681e21
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.114-68-g4b03f2681e21


No regressions (compared to build v4.4.114-55-g36818c5413e0)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 33, skip: 28,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 28, skip: 36,
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
* ltp-syscalls-tests - pass: 984, skip: 124,
* ltp-timers-tests - pass: 12,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 32, skip: 28,
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
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
* ltp-syscalls-tests - pass: 1037, skip: 67,
* ltp-timers-tests - pass: 12,

x86_64
* boot - pass: 20,
* kselftest - pass: 45, skip: 31,
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
* ltp-syscalls-tests - pass: 1015, skip: 117,
* ltp-timers-tests - pass: 12,


Summary
------------------------------------------------------------------------

kernel: 4.4.115-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.115-rc1-hikey-20180202-124
git commit: c7f481905806190d02c71cd5fb46503dda795498
git describe: 4.4.115-rc1-hikey-20180202-124
Test details:
https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.115-rc1-hikey-20180202-124


No regressions (compared to build 4.4.115-rc1-hikey-20180201-123)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 30, skip: 31,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 28, skip: 36,
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
* ltp-syscalls-tests - pass: 981, skip: 124,
* ltp-timers-tests - pass: 12,



--
Linaro QA (beta)
https://qa-reports.linaro.org
