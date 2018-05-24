Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2363342-1527185534-2-7035285636413837619
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
    1527185534; b=eD7w113oOKW+u3Uol1mXt7c+Mla6rsXZVppibYWMT/o1Qkk/Cl
    uLP49vFK1V1M4PBSnOdjqhOA6/PcWCbah+IFXlBspHcihDHXvLsScMWWT+6S1jr7
    EYZcldA7ZDlD/99L31hYoEXaIRa6E3S9xIqME48/dbZZymOAbIdnwBKdrq3rP7wk
    LHELrSqGEHGRJ58LgCb10QQlePQyrcoGnzOQfMYZ6M2vofni/QxTCw61Ups7K7nc
    Kykb+wuNBZyKEuOwBs/0gsIn4u/sREwWwl8s7RgjsryPsAuig1mvzE/2CYZfjsIr
    ZdWZKRO9uAdsc7IMBqgI3Fsz2VhKRVp9Lodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1527185534; bh=rSzQg8UFfhA
    AS4AVi19RMLrH+8bdVlMYaSg86E7IKYM=; b=TWrScrBFNgLMiEr5RXTNh5LA5Qj
    DesHZvFNmjnniEPqkd3Zm17ZSTfGtHz5KzI9299czSPM66lKzjmfik3lRONcwBSn
    YOFi0iOFJMrT/qzBqlAewsYvk44J8dRPLowa73gv4l7JrNMLSAOaCUIq/Khl098u
    FTj++qm6jSpYmBfkM5Isw2q6uqxTjm3P/ulrAPVoqjEjDeZSapz31zptFcRJXI4P
    BmCGvndouPGyE1ZschDMYh7vsr4xNkFfyduksPMkY0u/a6l/7KT+OouJSqyQQM/R
    YH+iTEYLf3BTykNGG/vw/5dyE0xKZ3Tc+YtXsdGIfb7GI51VoZa6E/UHJ2g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=f9iFFXhM x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=MxzEcT8A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=f9iFFXhM x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=MxzEcT8A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPfZ9ugOJAkLeaEKVWlN6N2oyVzhUECLqvrv9b8jizNQrnRgQAp4ztXgoB2/9+QIUkJQDwOvJnAYGU4J98hdplND1qWSqUlM1B1Nf3g5NzG5mpjnsTv2
    69vpaY4wrYE4MFf9PoH/L30AapCSJoGcH++AAGFIhRrXVT3rzzO/LONpQ4+D/4ZhTdppQtlDsuuAna/QIrHucMsVaqIgpz8Q9uhfITZGq9NnOnckyW+ukmjr
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=6xLPOHPkGDIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=xkFRySFMC8545P5zKRsA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032638AbeEXSMM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:12:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33108 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031356AbeEXSML (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 14:12:11 -0400
X-Google-Smtp-Source: AB8JxZrDkEaPS0ByAU3BIWK3TesnDcowt8HqQuY+GX2dQcCrtTyF/aPPNHU6anYO+v31lo5amPab6Q==
Date: Thu, 24 May 2018 13:12:09 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.14 000/165] 4.14.44-stable review
Message-ID: <20180524181209.it5mqiweynr66c5c@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180524093621.979359379@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
User-Agent: NeoMutt/20180512
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:36:46AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.44 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:35:46 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.44-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 04c57158a60d4a6b72a8d04b39390eb2dbad0e73
git describe: v4.14.43-165-g04c57158a60d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.43-165-g04c57158a60d


No regressions (compared to build v4.14.43-166-ga3881b7a4d3c)


Ran 11106 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-cap_bounds-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
