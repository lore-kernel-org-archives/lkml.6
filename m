Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3568581-1517612799-2-16089805534306074362
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
    t=1517612798; b=N1IVqkyjak4No9yCFlxSf4URBNw+CrNDukFp6vSmp2lbwnP
    jtkI7PBEEWR1pnBFJF561HG19RpWn7Elimm/ZkiLpS9rSzHSCX8rky9KeJsvr520
    cLZ3QFZf0vDGPIUMGCUEhSBFOrcn4wlKGXU2/CKkQCtJjUoaHwg0ZwOmq+I8TvZl
    +ofY57FkwD3SOOxaJdKh/oSmQo6jsHIbwvxvWoir2JbCf60tlSD8OYiETFlrORRZ
    o5djQ7eNNbOvCIDk3y54wGWCyxsYZFJdDTo2cgHIumi1SdJMlqiSP0CdDd89yMao
    aH70G+RALXWebGwQxCe5cUMBga+SFMqd0SI0Isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517612798; bh=3Flq7H8
    I1ZOyDlkCgtHCI0+YwAzCvsYjl8ntFuvYS0o=; b=WwfflLuP4evbmNZA8M0h8he
    GNYj1p9/hA2J11tqdgEKo7efv/TRIBZFdWApOzCc1fQA9I3YrcgrGR2HlmP4IJ9D
    BHM9N34AfziohELUsN+a8RwtHy/m7HPjJAGQaHvykvj0mAGt6VRq8jFJWCPLeen+
    RHMPrmmgks/ILu059S1RAGaM/WWXX5GDW2jjn4WAYzpPLML8cFUdZ76/LQjFMAvL
    gRHAJtSMLfl6Uyk3Q+XMzIMZxEYRtltAy4oJ8Pg5gjhI4tiy46/PliGWLe3J+HVk
    NkCXy/cPHwkSPVm1Mh9mfQavwp0+U8pe22VPox5SpgdJheVFhJTBWMO7V3/Oa0w=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LU1OljAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uzc4Ke8I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LU1OljAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uzc4Ke8I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeBBXGe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 18:06:34 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:38839 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeBBXGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 18:06:34 -0500
X-Google-Smtp-Source: AH8x225JgXHbmStUwmVUESnZnOXBXNzf8s2fleEYrHe1U+AskZ60GvBAyetGsJjrKBGGzPaiy7Nk7w==
Date: Fri, 2 Feb 2018 17:06:32 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.14 000/156] 4.14.17-stable review
Message-ID: <20180202230632.3y3mvo3fgpkxsaug@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180202140840.242829545@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:56:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.17 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:42 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.17-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.


Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Regarding bpf testing on 4.14, where there are good tests - We are
skipping some of them due to trouble we had in the past on other
branches. The skiplist for kselftest is getting audited in the next
couple weeks and as we re-evaluate on a more granular basis, I expect to
be enabling a lot of the bpf tests on 4.14+ as a part of that effort.

Summary
------------------------------------------------------------------------

kernel: 4.14.17-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: c9c30584bc1cdbb2fb1ba0bff03e88607a424a6c
git describe: v4.14.16-157-gc9c30584bc1c
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.16-157-gc9c30584bc1c


No regressions (compared to build v4.14.16-129-g0a66dfb6634c)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 46, skip: 16,
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
* kselftest - pass: 46, skip: 16,
* libhugetlbfs - pass: 90, skip: 1,
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
* kselftest - pass: 43, skip: 18,
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
* ltp-syscalls-tests - pass: 1038, skip: 66,
* ltp-timers-tests - pass: 12,

x86_64
* boot - pass: 20,
* kselftest - pass: 56, skip: 18, fail: 1
* libhugetlbfs - pass: 89, skip: 1,
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
