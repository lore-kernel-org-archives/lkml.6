Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-755436-1524861080-5-4381517237350697979
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
    1524861080; b=dOcdpRhDHBzLg2hkrOGz9YFwl/FPoLGSKH2BPl3oP8N6zIrnp9
    gU773O7HT1Gk0hCFOQRPH8T0DjQ/glSOpJIvOJA8e5ImftEJinoOa8dPg0ZrZbhI
    fTA2NweyzDaMQPMieOz4ieWM1sVY5nRUOahtie/kBSGFgZTKHV2FXkK8fLawNFMF
    b6bhcJ8WojSV4FIRL9MQrO5705cnJH8W/hOUwVYRx4xlA2OluJK1yQsGUaZVTMgo
    zpjMnHl0alWqHKG+WINbcTjftKMmWxpxz1n70klf0cfHiQiOHEEqrFFG5xbjD9C8
    7VAqmvhUsVlt6S99p8z3yJoYfy1xT6ZlLhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524861080; bh=YDsz1jI8W8N
    Io8DQLNjkJaT0EfNBy9u14XZg245Sr4w=; b=c5BR71Vl/shaUlvrO2u2EOH9yc/
    MxgC1jjPn9jUd6IZHi+c0b7opCRO7sxpvO/4vC54WZlWasChxfm5MFh1y5ba9wVt
    2ocj+gzuKQtK2lneOY1erqaJWUX9fUJm3qKBO2BJClU+2Cmrtrx0i00YdFdof1lL
    M7CM1764uVl+yTvihpDoTKLVGvbgX+g2NrBYZoAkR7kiOZkFqxOjBc1xr/3KEB1R
    JSMWtfwpmdohS1CWh5aGQh+gw2Iagkn25ETvdE89Q5EJO5dKWgWi8XJ+DhN8cptT
    s6niINIJF2PD6LcZT4gwPvzfpZk+gRURtpAmPyeA3I3tuTv2vbTbPMkFogg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kYNeNep0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tMuCwDJl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kYNeNep0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tMuCwDJl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNTyNxpkCDzkv2sBy691eK10by3HnZNlGyfP0vtE7runT60ebYcM3jaEHHcPQvi2wdg5YBb8ml9qkpMQ9wVS1JnAlc+eQsHKi+3907xnYOsyo5YlizmA
    LoEhCtXWoT/sTShRvXmyTlzt9dpJyD5ksNPkd9UyijQRQ5/hF8CkwczJi9eNmQyPihdDo/nMPNk7IisI+MYgpzxLeDlsQzNygYF/PEjuGuwlMssXNDp2Xg2Z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=oZq4rTz8mb0A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=wXgm1kXcElLLYlBMbPYA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759087AbeD0UbG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 16:31:06 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40870 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759077AbeD0UbE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 16:31:04 -0400
X-Google-Smtp-Source: AB8JxZrOeep3eCWi8PbzjB+lpjXvODp4jyR2Ry5bou07/QSAmiGbu4OvymlEnZsm8GMY1WRvI5ZYSw==
Date: Fri, 27 Apr 2018 15:31:02 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/50] 4.4.130-stable review
Message-ID: <20180427203102.lsnf7ldgij2uy3ne@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180427135655.623669681@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:58:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.130 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:56:42 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.130-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: aedfcc63a1a9aca5a263e7733131589117195778
git describe: v4.4.129-51-gaedfcc63a1a9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.129-51-gaedfcc63a1a9


No regressions (compared to build v4.4.129)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 37, pass: 29,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 53, pass: 28,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 10, fail: 24
* ltp-cap_bounds-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,

qemu_x86_64
* boot - pass: 22,
* kselftest - skip: 40, pass: 40,
* kselftest-vsyscall-mode-native - skip: 40, pass: 40,
* kselftest-vsyscall-mode-none - skip: 40, pass: 40,
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
* ltp-syscalls-tests - skip: 155, pass: 995,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - skip: 36, pass: 29,
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
* ltp-syscalls-tests - skip: 78, pass: 1072,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - skip: 37, pass: 41,
* kselftest-vsyscall-mode-native - skip: 37, pass: 40, fail: 1
* kselftest-vsyscall-mode-none - skip: 37, pass: 41,
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
* ltp-syscalls-tests - skip: 119, pass: 1031,
* ltp-timers-tests - pass: 13,


Summary
------------------------------------------------------------------------

kernel: 4.4.130-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.130-rc1-hikey-20180427-178
git commit: 2f9fbcd225029f66acc57b4fe3f037e1b65e1804
git describe: 4.4.130-rc1-hikey-20180427-178
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.130-rc1-hikey-20180427-178


No regressions (compared to build 4.4.129-rc2-hikey-20180423-176)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 19,
* kselftest - skip: 38, pass: 27,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 53, pass: 28,
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
* ltp-syscalls-tests - skip: 142, pass: 1008,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 3, fail: 17
* ltp-cap_bounds-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-syscalls-tests - skip: 162, pass: 986, fail: 2

-- 
Linaro QA (BETA)
https://qa-reports.linaro.org
