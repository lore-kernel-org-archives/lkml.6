Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3189361-1525181806-2-16908921001395978289
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
    1525181805; b=XDWxEN6IZANg7MSQmlzdYmFSodh8KBsj2hE5e6aJl+tEPBw9gk
    JhiraL338LdyZ0BONO9RtNpchyq5aQMy4/1oY5jAHJa3IZI4coF3a+iBDrC9rg+R
    mcPw8tlYq64lYwU0i1gdDgWAoBpNsUxT85XdeNM0JiMqGmVP1e619APmfh4ozw2n
    rVkPX9dK75VNfDyiR6zn+zAZJOVHlXzadJnZfhc0f+kTEFgauI9dJAp7YuiKCO7t
    3P+V6VyzfYrbRaWl5TNKPlsCSYN34ZhUO3K6WITDQlrF1XUC0Yw/IqGczkfJpsL8
    LQQUFYYKR6VRavE8QrJDHypoNxav0fl9h8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525181805; bh=9QyaieF9oU0
    Q/UgFnkX16YqXsNZfZKomVQBPenniwXY=; b=doVYfdfCuEbkHNIgrlemF5hvmri
    M8j46YIDm+9ahanhVsye0mQ1p/jQsK1AhZ1tpBYpCzXeIwXcp7h/Ecz33xUYlkbo
    bTW4uN4ZVhIWiz6xuXlXEvFzq2JkRMNnB78U6t9N1T+NX67Lu2P8pGboXU5eNMTI
    HEqbVFgL4RrJDnA7RVse6rD7adavKkx8dgoCEnoG7knHuBjGSAqZv2Bqzdfs5RgH
    y2jVhxh6Rxlc3oSjrr2w78Rt+Bgwp3ECZBYRNqTIMqvSxSJ94H06g40GA39Vo2Nu
    6YGeQUAxzY2UDR8Gmt4zOTVRFtHH+svW0yQrZ5vPj8Fn0qf9fG3Yj/CZOYw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=Baf2kcJh x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=AzI81AdY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=Baf2kcJh x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=AzI81AdY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHyQ1Aj7zjEmLGhYQpISpBZodGN9IjcV2Nq8vWl61widM7pMC2Akr5Q/GuzCx0oioeN2YeQ3Cyu9TOeuPS2mJeWB7IcvcxzrFEPrlkAtSk16kU402Ghh
    4ZG4+AcX6eNayugQ/DUdn5OT59Wbhx+efmXPis/WjjzpAF304toCSivqA4YesWebmLgUWh3j6mXswirMgs+NjyRQxR/tx/OiR4RSYLZ7NmLrBj9FXpBvgcst
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=keWkJgPOSacA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=SPN1vCwFaTpG7Et2KtoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEANgl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 09:36:41 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36235 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeEANgg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 09:36:36 -0400
X-Google-Smtp-Source: AB8JxZr5V/+gITETrjAmVpxhW5FT3iEHSvnykAgidEpc2MBftfW7lA211HTMW8WPe3V3r0Rn8nnltg==
Date: Tue, 1 May 2018 08:36:34 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.16 000/113] 4.16.7-stable review
Message-ID: <20180501133634.whfubw7mxi6f2y23@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180430184015.043892819@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 12:23:31PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.7 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:46 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.16.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.16.y
git commit: 2556b63fc6172dd60f9d95749b5b8cfa6378cf78
git describe: v4.16.6-114-g2556b63fc617
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/build/v4.16.6-114-g2556b63fc617


No regressions (compared to build v4.16.6)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 20, fail: 3
* kselftest - skip: 26, pass: 41, fail: 1
* libhugetlbfs - skip: 1, pass: 89, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 133, pass: 1017,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 22, pass: 44,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 134, pass: 1016,
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 24, pass: 44,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 133, pass: 1017,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 12, fail: 8
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 62, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-securebits-tests - pass: 4,

qemu_arm64
* boot - pass: 18, fail: 2
* kselftest - skip: 29, pass: 41,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 6, pass: 8,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 155, pass: 993, fail: 2
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - skip: 30, pass: 50,
* kselftest-vsyscall-mode-native - skip: 30, pass: 50,
* kselftest-vsyscall-mode-none - skip: 30, pass: 50,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 152, pass: 998,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - skip: 28, pass: 37,
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 2, pass: 20,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 75, pass: 1075,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - skip: 21, pass: 55,
* kselftest-vsyscall-mode-native - skip: 21, pass: 55,
* kselftest-vsyscall-mode-none - skip: 21, pass: 54,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 116, pass: 1034,
* ltp-timers-tests - pass: 13,

-- 
Linaro QA (BETA)
https://qa-reports.linaro.org
