Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-25649-1517632536-3-17418567033668056356
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
    t=1517632535; b=htfmeBNrobCjT/fOSYZc3kpyVwmPgtafNXTfPjqetnaHv6A
    D+RHXmRrx/X8nLfhkc65Tpr3KwvYP97p1GVJA8u87sy4t7VbHFp9/2JEhTLEQI1u
    rBJruq684C6Z5TrLvS75hwVFPoUM+abgEC/z1Di28UQbyDYvE7MWAFvtAgWhOI8R
    MsP8aGFbunPXFfBnxCcrlBIWQILHmOCE0fdc0vOhWiPqjIm4nERXgsjTNOKYDGqN
    u6AeHi56qeRdV2z8jZKbRz+/l39oVhK1M6dnvvd3cYEYFYUf1EkWtOwdiOA6WHIw
    WSmNLM8xdlqzd+BP70bo6a1wIXWT7csFATc8ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517632535; bh=cCcJ+XH
    hdp1dvDIQyBEZjl3CUGAk0UiQ3CRW22IGoiY=; b=l5FT/PFDqCxun/EmUBBANAb
    C+4tkq75E0Vfw7RpBUgMEftwTFsPacMfCsvsszd6DPACyMmB3aqT9nJ5HS58P/zc
    U05ZhEEtgypmN+plkHtQhWZCYoJbaImzW9TLaoBZ6kwQYI9uDfZ+MKV2nVdaPPPC
    Jh9Lfc0IGR4/9AZKqfHUj1lh5i842JzFL4qQB0LznsvJYNxAWmrifUfXxsXP9bpy
    MFMi1qqSq0UcQAGlKnDohHNZSQQ5sIZBwXLKb6QzvXGjQPI6kGcoaz2U3Gkb4pkI
    Y4OrJptRUR7GzkZYEOKV7rlfevSx7uAiEWjLOSW32fQUQABP+2dm+ZRVjuvC4jQ=
    =
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ELxuSPZX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t4B8LLfT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ELxuSPZX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t4B8LLfT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBCEfX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 23:35:23 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:54398 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeBCEfW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 23:35:22 -0500
X-Google-Smtp-Source: AH8x224sHnzSmNuQUT5VCRFaplufztqsMSALaRC/U9JhgaMP2Fnv2Df6sdd8YUbOtNYcoeMpj7ulAw==
Date: Fri, 2 Feb 2018 22:35:19 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.15 00/55] 4.15.1-stable review
Message-ID: <20180203043519.eut367kib3dwbybt@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180202140826.117602411@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:58:18PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.1 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.1-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.

Results from Linaro’s test farm.

No regressions since 4.15 release, but you'll notice high failure counts
in kselftest. These are because it was the first RC and I ran the tests
multiple times - first without a skipfile, and then again with a partial
skipfile. All of the failures look like known issues that we also saw on
4.15 release.

Summary
------------------------------------------------------------------------

kernel: 4.15.1-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.15.y
git commit: b01b3d9519f250398695c7cc6493ba1e8fb072f4
git describe: v4.15-56-gb01b3d9519f2
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/build/v4.15-56-gb01b3d9519f2


No regressions (compared to build )

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 38,
* kselftest - pass: 98, skip: 14, fail: 12
* libhugetlbfs - pass: 180, skip: 2,
* ltp-cap_bounds-tests - pass: 4,
* ltp-containers-tests - pass: 128,
* ltp-fcntl-locktests-tests - pass: 4,
* ltp-filecaps-tests - pass: 4,
* ltp-fs-tests - pass: 120,
* ltp-fs_bind-tests - pass: 4,
* ltp-fs_perms_simple-tests - pass: 38,
* ltp-fsx-tests - pass: 4,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 6,
* ltp-ipc-tests - pass: 18,
* ltp-math-tests - pass: 22,
* ltp-nptl-tests - pass: 4,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 20,
* ltp-securebits-tests - pass: 8,
* ltp-syscalls-tests - pass: 1968, skip: 242,
* ltp-timers-tests - pass: 24,

juno-r2 - arm64
* boot - pass: 31,
* kselftest - pass: 111, skip: 28, fail: 12
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 4,
* ltp-containers-tests - pass: 128,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 4,
* ltp-fs-tests - pass: 120,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 38,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 44,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 18,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 4,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 987, skip: 121,
* ltp-timers-tests - pass: 24,

x15 - arm
* boot - pass: 41,
* kselftest - pass: 92, skip: 32, fail: 15
* libhugetlbfs - pass: 174, skip: 2,
* ltp-cap_bounds-tests - pass: 4,
* ltp-containers-tests - pass: 124, fail: 4
* ltp-fcntl-locktests-tests - pass: 4,
* ltp-filecaps-tests - pass: 4,
* ltp-fs-tests - pass: 120,
* ltp-fs_bind-tests - pass: 4,
* ltp-fs_perms_simple-tests - pass: 38,
* ltp-fsx-tests - pass: 4,
* ltp-hugetlb-tests - pass: 40, skip: 4,
* ltp-io-tests - pass: 6,
* ltp-ipc-tests - pass: 18,
* ltp-math-tests - pass: 22,
* ltp-nptl-tests - pass: 4,
* ltp-pty-tests - pass: 8,
* ltp-sched-tests - pass: 26, skip: 2,
* ltp-securebits-tests - pass: 8,
* ltp-syscalls-tests - pass: 2076, skip: 132,
* ltp-timers-tests - pass: 24,

x86_64
* boot - pass: 40,
* kselftest - pass: 121, skip: 16, fail: 14
* libhugetlbfs - pass: 180, skip: 2,
* ltp-cap_bounds-tests - pass: 4,
* ltp-containers-tests - pass: 128,
* ltp-fcntl-locktests-tests - pass: 4,
* ltp-filecaps-tests - pass: 4,
* ltp-fs-tests - pass: 122, skip: 2,
* ltp-fs_bind-tests - pass: 4,
* ltp-fs_perms_simple-tests - pass: 38,
* ltp-fsx-tests - pass: 4,
* ltp-hugetlb-tests - pass: 44,
* ltp-io-tests - pass: 6,
* ltp-ipc-tests - pass: 18,
* ltp-math-tests - pass: 22,
* ltp-nptl-tests - pass: 4,
* ltp-pty-tests - pass: 8,
* ltp-sched-tests - pass: 18, skip: 2,
* ltp-securebits-tests - pass: 8,
* ltp-syscalls-tests - pass: 2032, skip: 232,
* ltp-timers-tests - pass: 24,


--
Linaro QA (beta)
https://qa-reports.linaro.org
