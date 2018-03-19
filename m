Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2207741-1521447570-2-5837875944075290439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521447569; b=ZgXjztL3hNS4h1nmVHWNEyHvgRAn3upu6KTvL6XtJR0l5qy
    19ihukiNmLfCW6N9YIjqUniGAUbASdJGNKk5/tFUcIo7cIn1/TgkrZk5A7WLNUzI
    V3tcd5za61ChjxEW74xTii9Ls1KqzRRs/SF6DWByzTeoBPWAeCfbJfgHvHGA0Nl1
    cD6ysETpEZ4yDeThJkNXCKkEvocIjEaJNlwgPYShjpxOOUf96DvKxNZtgWYBpHkl
    LprHIZeMOMdRnQNrA0F6nyx42Y+57+0k0245ywUS3ZY+tls3VgIGnIexMSR40Q5K
    EKphs587yY+eEeFP2Fi7pZAHod7kowzficI07YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521447569; bh=kuOVkrIgFwQ503fWhHc8rNGRtF
    fa+OGNtDrS84nu9BU=; b=KZdWZM9ONshsI3qNiatn79lp5D4Qt/FbPqUhhl+1yA
    aMFpoLYvhxpcDUUIwrdODN8mz7A4DT6nEA0SqSgI5rINOuLINusUGnnHfotBxu+j
    NkOEhEIc59S5mQcg3H7qcfCTSXpKmnjovr+FxehYS+p/V6osVCE9TMP3oQu+1PXs
    tuKNf2BhJgehdZSmoRirPj3SZxMx4FOE0vSx4D4kZMT1TkASSeKgeA17R3ntPJ19
    pzdDn1wLPj+Qf4K1vLeXhwyl6PpTG7YKWoHOCO7UdeJmfL49354R8ru/8tUUS9PQ
    hTdc2EyWQbC9NqWaansH5altAWkHFM45dMOu3bviHUfg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=HiTfFxsg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepffgrnhcutfhuvgcuoegurghnrdhruhgvsehlihhnrghrohdrohhrgheqnecuffhomhgrihhnpehlihhnrghrohdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvddukedrvdehhedrleelrdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtfedvvdenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=em4nVY48;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=HiTfFxsg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepffgrnhcutfhuvgcuoegurghnrdhruhgvsehlihhnrghrohdrohhrgheqnecuffhomhgrihhnpehlihhnrghrohdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvddukedrvdehhedrleelrdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtfedvvdenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=em4nVY48;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755285AbeCSIT2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 04:19:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32826 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeCSITZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 04:19:25 -0400
X-Google-Smtp-Source: AG47ELtmuH1QXEePrQ0mwK9InegoXOyJS1Iku6gk95fvzjDtSYRxD+GjFJqkdMAGNCb4WaBJnE/FRA==
Date: Mon, 19 Mar 2018 16:19:22 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180319081922.drki54qg4foqvnsf@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180316152329.844663293@linuxfoundation.org>
 <20180318102454.GB30164@kroah.com>
 <20180318111442.GA4607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318111442.GA4607@kroah.com>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 12:14:42PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 18, 2018 at 11:24:54AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 16, 2018 at 04:22:29PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.28 release.
> > > There are 109 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > and the diffstat can be found below.
> > 
> > -rc2 is out to fix a build problem on some configs:
> >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc2.gz
> 
> Ok, that sucked, let's try this again...
> 
> -rc3 is out, and this time it at least passed _my_ build tests:
>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc3.gz

As reported, arm32 build failed and so tests did not run. No regressions on
arm64 or x86_64.

There are two 'regressions' listed below which are not regressions.
reuseport_bpf is a test issue that's fixed in mainline kselftest, which we'll
pick up when 4.16 is released. sigreturn_64 is an intermittent failure that
we've been seeing on qemu only. It works fine on real hardware.

Summary
------------------------------------------------------------------------

kernel: 4.14.28-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: de586f09b77dafe110c0689218b860aefd7e4ed6
git describe: v4.14.27-108-gde586f09b77d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.27-108-gde586f09b77d

Regressions (compared to build v4.14.27-110-g96676597127d)
------------------------------------------------------------------------

qemu_x86_64:
  kselftest-vsyscall-mode-native:
    * reuseport_bpf
    * sigreturn_64

    * test src: not informed
  kselftest-vsyscall-mode-none:
    * sigreturn_64

    * test src: not informed


Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20
* kselftest - skip: 20, pass: 45
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
* boot - pass: 28
* kselftest - skip: 20, pass: 62
* kselftest-vsyscall-mode-native - skip: 40, fail: 2, pass: 122
* kselftest-vsyscall-mode-none - skip: 40, fail: 1, pass: 123
* libhugetlbfs - skip: 2, pass: 180
* ltp-cap_bounds-tests - pass: 4
* ltp-containers-tests - skip: 34, pass: 128
* ltp-fcntl-locktests-tests - pass: 4
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

x86_64
* boot - pass: 22
* kselftest - skip: 19, pass: 61
* kselftest-vsyscall-mode-native - skip: 19, pass: 61
* kselftest-vsyscall-mode-none - skip: 19, fail: 1, pass: 60
* libhugetlbfs - skip: 1, pass: 89
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
_______________________________________________
Kernel-build-reports mailing list
Kernel-build-reports@lists.linaro.org
https://lists.linaro.org/mailman/listinfo/kernel-build-reports
