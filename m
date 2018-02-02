Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3568581-1517611531-2-2662914923102121960
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
    t=1517611531; b=NEAMef/1X56dPb536PAYdP1gnmV+oUGtr0CP//W15iDajCm
    ZSojLohDEYorWxJro1WVCsngxZ4jF1TNkFbRHdUDyjS9v4brNBFVI457YVTGOqAo
    8V4ipBgkxIGSjAL72IyzNCpBKPf5Cv0ogh0MJs25GXEUcQGjeASNBrfdLuPjWM6u
    uLfTlgqs8ZOcIISXx2JgRS7F2rInNUE3sSLih+o8cA6gny03roQL1LBQ/TZ0Fnwd
    NreqzaWSGvhyS4GzQsZlJoPtgot464qoz1yVMJOB+m3ZIqlC8bYPYJRzHm4bCkpM
    44X3HTt7eYIjxExOTK2oRYHChK84t609BUhaI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517611531; bh=o1GkBre
    sjBKwuO59uzAxqhabcvwB8FNKKNP1p3rNDBE=; b=nuvYBsqiNqYcmP3zumu50nm
    ykHm8+Bu3AS2t+sAkL+HyPunvO5Y6lTnapxBrTGkKxOi94o8azBARCJSaHStNvjt
    5Zg+EuGipGLV86INy42qQkS73u7rcsAct7ZAuWu5CDORWbSwb3otbJc7IwEPnzIn
    w0T1QbbRvjzY5Iq60G8/HYbDQSvpmx2fi9NbgdXhlsVAF9mDiRm7L46w2cRpZnNy
    iiQWucbTgy/UF5WLbnEcfNlZMF1I7dnDdeTkpjyDD9TLUt8kkVE/27dl9L6pBDcf
    oUGVJSrbSdZp05Z68/9/KCLh7zGzS3bk1jknh/X4X6wlZgn3ArMxDNqxL1MTV5Q=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jV9lXvFu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=e0A1/qt0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jV9lXvFu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=e0A1/qt0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeBBWp2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 17:45:28 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37913 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBBWp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 17:45:27 -0500
X-Google-Smtp-Source: AH8x224uvfTd0oCO/UpiV8zTl7sglhGJgrlEM5PKQIUrG2gOGjAzsEDYtPqpSTEUsBuQuGe3OIo3UA==
Date: Fri, 2 Feb 2018 16:45:25 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.9 00/86] 4.9.80-stable review
Message-ID: <20180202224525.iweiz6er5p3imnph@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180202140822.679101338@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:57:20PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.80 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:37 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.80-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.


Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Regarding bpf, I ran the bpf kselftests manually on arm64 and arm32 and
they both passed, but there are only four in 4.9:
- net/reuseport_bpf
- net/test_bpf.sh
- net/reuseport_bpf_cpu
- seccomp/seccomp_bpf


Summary
------------------------------------------------------------------------

kernel: 4.9.80-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: f905cfa204ed0785b72eace99942230b08b506bc
git describe: v4.9.79-87-gf905cfa204ed
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.79-87-gf905cfa204ed


No regressions (compared to build v4.9.79-71-geba6f567f652)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 40, skip: 23,
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
* boot - pass: 21,
* kselftest - pass: 41, skip: 22,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 4,
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
* kselftest - pass: 38, skip: 24,
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
* kselftest - pass: 51, skip: 26,
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
* ltp-syscalls-tests - pass: 1016, skip: 115,
* ltp-timers-tests - pass: 12,


--
Linaro QA (beta)
https://qa-reports.linaro.org
