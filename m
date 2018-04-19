Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3917498-1524168251-2-10054117171094019738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524168250; b=fScupgqL8bKAMzwin2T7hxdPtCGuneyG2RZZwmA7ZqwFMTfQbI
    i05goF0zMYUXWHsrUoKYMCM88FV09rzxd6HvqfCPaegOnoeg7sNp5KdItWavm7je
    k2MH/ntifP8yOFI0WF11SWcDlMv4tg66TFwYjcVJ+O9sX5yk4YDjB/9df/VNVAw7
    LkKoHlbFb50nOjwiF6xVRsAZT94QqdGXlCdCoCf2ElY0rKkxN47aQIbq/yIYqgVQ
    1t4ffBzlcl9shOUaw1CvVjeMPUGpJma7iBpM6yG9Kz6PBa5hqRLKyBKyIVCFC5Mz
    5Tw0GaTAbSPmkC+dClLDSYAt/f0rVqm2iluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524168250; bh=S+Uvt8wZc3i
    EDaEYLwhz41kMifZRuxD6QlAfaO+/FD8=; b=Vz2Y/9/oNu3py2iBWcThi8yaK5Z
    cQtgCzl70ibRRbDeaG4k/9izZzCvDgXRx8cpbkDe804IDYXVjm0vRgeyntyNZxau
    sFTu9u5QbZUmXV7MQVpMjcL2C1XS/DNruwHjE2FpnokqBgFjWRHACPE2ggN7TdFr
    tmWAEd8l4Ev3i7lRk2Bykeq6Vqon5ZtidlT3Me7IYq+WoqPrsSv1/n9lLjwUvbZm
    D12XFJLXXNvdlg+I8E+lwXGPAM4LSKm2wNd/UcQ+Q7loZEbucqwyoUVQ8krc1orX
    oFYgriEYTeNXdds2ChClQpEYU/I/MFqp5sbD6+LnbJR71AYUkGwkBjQBBPA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GBdrZE0i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qpwy7Lyo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GBdrZE0i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qpwy7Lyo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfECkeHKk+9stbXgIJbg55zMtYmodRRxKkePH20OGCY7u19RXUfSb3MtTvd1NlsEc/nm1xIqptd2wD+cgWG3PALQnBpnqdQgRoKCRktjIkfeeUKG914za
    8XUmdWjZpRvxkQ4mSxbP8jhrux3LTEvOXhli280YfgQXoIEuAiTicXj6oIVBur+WAwFMOLwTswvBWn7SzbUZaEHp4nmw/7sdQ0mHHRcPJn7T1dLlGah79UiX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=J7Nbbob27coA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=2mgwYJWpr-xIC06M7JIA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeDSUEJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 16:04:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33955 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeDSUEH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 16:04:07 -0400
X-Google-Smtp-Source: AIpwx48F4XhvNe2ATFKsGDDbchjE605TCvp3Sc2gknJaHEE0Oqs6tK15Km9z6nSSrBNuCEbFriVGFQ==
Date: Thu, 19 Apr 2018 15:04:05 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
Message-ID: <20180419200405.uxm7etj3yc4i6bdj@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180417155645.868055442@linuxfoundation.org>
 <20180418174244.ke5n4uhbj5geijco@xps>
 <20180419075608.GA4230@kroah.com>
 <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
 <20180419140305.GD16862@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419140305.GD16862@kroah.com>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 04:03:05PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 19, 2018 at 04:42:56PM +0530, Naresh Kamboju wrote:
> > >
> > > Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
> > > gets figured out.
> > 
> > After reverting this patch, network started works on arm32 x15 device.
> > d7ba3c00047d ("net: phy: micrel: Restore led_mode and clk_sel on resume")
> 
> Thanks for letting me know, I've now reverted that commit.

Alright here we go.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

A few notes about these results. Since yesterday, we have enabled qemu
arm 32 and qemu arm 64 testing, and also upgraded kselftest to 4.16 from
4.15. These changes have caused some new failures and noise that will be
triaged over the next couple of days. These aren't considered
regressions because they're a result of upgrading the test / introducing
new environments, not some change in kernel. I removed some of these
false regressions from the below email report, but you would see them if
you looked at qa-reports.

The x15 issue that was previously reported is resolved, but we have
learned that running 'ethtool --phy-statistics eth0' causes an oops.
This isn't a new issue, and we'll be tracking it going forward until
it's resolved.

Summary
------------------------------------------------------------------------

kernel: 4.9.95-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 0afd4120faa7df778d227670fc91f49234be202b
git describe: v4.9.94-69-g0afd4120faa7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.94-69-g0afd4120faa7


No regressions (compared to build v4.9.94-67-g148bd16b9893)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20,
* kselftest - pass: 35, skip: 27, fail: 4
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1015, skip: 135,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 38, skip: 24, fail: 4
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1014, skip: 136,
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 38, skip: 24, fail: 4
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1015, skip: 135,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - fail: 20
^ This is the first run for qemu_arm and this boot problem is due to an
error in our job template.

qemu_arm64
* boot - pass: 20,
* kselftest - pass: 37, skip: 27, fail: 4
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 592, skip: 74, fail: 5
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - pass: 49, skip: 27, fail: 4
* kselftest-vsyscall-mode-native - pass: 49, skip: 27, fail: 4
* kselftest-vsyscall-mode-none - pass: 49, skip: 27, fail: 4
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1003, skip: 147,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 37, skip: 24, fail: 4
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5,
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
* ltp-syscalls-tests - pass: 1075, skip: 75,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - pass: 51, skip: 25, fail: 4
* kselftest-vsyscall-mode-native - pass: 50, skip: 25, fail: 5
* kselftest-vsyscall-mode-none - pass: 51, skip: 25, fail: 4
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1034, skip: 116,
* ltp-timers-tests - pass: 13,

-- 
Linaro QA (beta)
https://qa-reports.linaro.org
