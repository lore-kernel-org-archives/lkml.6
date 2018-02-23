Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4146530-1519429557-5-13755740832633697144
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519429557; b=qImSCLpCFyUpcaI2Nws/PXiPVOyKfsDl1gZ8JQMtdpfi7M6
    pWMwfXzsdWq2G/jv0V7RbVJpNGiJ55eQJNymJyXRsizYSjvT3WZilZ+m/E65ELex
    +b2vqDi3djauE0UKW+lbdQIiwyVY7df759b47GLCNXFkDwwmEgymH99EeqNRXFf3
    akbkFvMvR/eW+OoBbLXZeJM4WZtb6JlRH8LCDjgLvVBX8IW/oQ/+akp5MDnjl6po
    knog3FJ/dst2caekeA+Tkw8Pn7dmgoprkLfrKVVKZHb2QyXNjU38tKMf0fqs9YNr
    LCLAY0N4HRxVvFk95DXCvJRSgi1pu7qTr0Fg5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519429557; bh=tUDAW3U
    Ga3z8/BAogjIFdm6kUhEpOq34HvCVkC/tHzU=; b=wp2JNCJ8qiB2WjQU1IDzRnM
    212Z8i0PD0hNDmdRQamRN63uQuxPpw+U7GFCuXSBunT3wtDbQqJUDoTdfucrABPD
    ac6oTnVyILc0/Ow8fbYQiv/Fz7Ou7wezpqzELGGb2ke5FPfPIJj2s/Z8AcAp1jhf
    AnlTI+xJGhgx9i8ls4xATE4XP1Ub2x3kUEuZ7KcRXPa7bWtemIgb+poCQdPEl7rQ
    HQnmhCJ99fvXAt1mYOIXACE8CIVv5+aDU8Kjs8OXc9EathlQ49rTJPsLQ7gW7ngD
    EuNexgy6Ad6j1ye8YwUyQtFoFExhdhfMJgcksQm7yK7xvb3MbOg5Dy5M+uP5Lfw=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Zh4kKHCq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nDB2NkrR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Zh4kKHCq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nDB2NkrR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeBWXpy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 18:45:54 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:35056 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeBWXpw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 18:45:52 -0500
X-Google-Smtp-Source: AG47ELttyxK223iJMT2lKPqK2Ey1D2S2P8INY2CWxCMN/KlppvDF212ZvgyOZNSNcQTCIp2Yl9rn+Q==
Date: Fri, 23 Feb 2018 17:45:50 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.14 000/159] 4.14.22-stable review
Message-ID: <20180223234550.ztjubws6wsqri4md@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180223170743.086611315@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:25:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.22 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:06:38 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.22-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.22-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 61e5ffb08842d3b466d2a321bc8d199c7e768892
git describe: v4.14.21-160-g61e5ffb08842
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.21-160-g61e5ffb08842


No regressions (compared to build v4.14.21-154-gac0921d9f7a8)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 48, skip: 17
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
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
* ltp-syscalls-tests - pass: 999, skip: 151
* ltp-timers-tests - pass: 12, skip: 1

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 48, skip: 17
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
* ltp-fs_bind-tests - pass: 2,
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
* ltp-syscalls-tests - pass: 1001, skip: 149
* ltp-timers-tests - pass: 12, skip: 1

x15 - arm
* boot - pass: 20,
* kselftest - pass: 45, skip: 19
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
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
* ltp-syscalls-tests - pass: 1053, skip: 97
* ltp-timers-tests - pass: 12, skip: 1

x86_64
* boot - pass: 20,
* kselftest - pass: 61, skip: 19
* libhugetlbfs - pass: 89, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 62, skip: 1
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
* ltp-syscalls-tests - pass: 1031, skip: 119
* ltp-timers-tests - pass: 12, skip: 1

--
Linaro QA (beta)
https://qa-reports.linaro.org
