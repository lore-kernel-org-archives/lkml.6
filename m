Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341832-1527186659-2-12051483925626909751
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
    1527186658; b=Rscv1iCk5/wDuwLn66C6SvMkotZl76rCoCaNkrOZDHxrUeiF2d
    FG9OIErQDGtU2CzKxCPTmzC7kzp7NJ/5L61f0mrMw7q2TDs2X3ii/1FHygIUXs4v
    VnAZtr18EluXCnMj0YK0hUnfPH1ciA2E7LF8MiAe4M3UxIlPBdxzdacuUhnDCFYq
    GJe5KZXDyxDzuoswXI0e+PTe4HrUbhifmTrjUuD5/j0yQu/EtuOujK8m3YD8AAm0
    tNreLOC9Z/O+vyhY4SLmS4MurC+l1WZwljszThkiGW2T+9Y9/bgrGVyU/WUW2YeB
    UjGpFSihVAQe35VYyp4UKmnHpZm8UWlauRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1527186658; bh=58/nOuiaoJu
    szES2yRXkCrPzFwL23rsQYB8esJZUA94=; b=T2+ItrGUh9aiKU11uHdtVTHMzTs
    zcMD9ZiEjnf+2riba0fj45z5unBOlegalJxZJPzobiO2kDdCdPX4uniJtzQ0jUi9
    UadX+EgX2VL++V0/J+TQ7we/WrIIVmjFdqiWn4VX8lJ1ROAf0sfez6TjtOg3uNZb
    7ClNinwQ+B6xFk7MQ0X/qC0HDVdhy+ENudUfuBmqa7AjXs5gJtgO+su8zPPMjWC7
    1v8Wcy/QFYKft6t4MWYbTM4G8rVhFVvJNA3qzeAu706BsPZM4d6D2zZ/RxcDR8HF
    WT0vMbBwYQCMZW8SG2CfRtB99bLEwugf07mYbhkjdwbI+Ifclf/r/S7+++g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=YQI4fsNU x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=C+2Jr4NV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=YQI4fsNU x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=C+2Jr4NV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXhImCU8iJOrDUUOO4tskdMMZgNIyktRBnYH3E+HGOdapQQ71o6TQCvx7mz3qz3q33xqO3lhXU4Gwgn8tQlYtDWiu/QWBVRSX42dtBZQKoDxLAEpq0B
    cumafbepRv3c7hR5PCN7jhsn0Ke7Gil1h7SMvOgD3D42w2fhhrKbHopSHIr+hAsvsvb0Jir15W/y5oO2T7BDkneVLxOtKQTBT4PyvKNySJMkZtVL+JANz1P4
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=6xLPOHPkGDIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=RIn3unpX5Q4wyN0J67YA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032729AbeEXSa5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:30:57 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38645 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030433AbeEXSaz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 14:30:55 -0400
X-Google-Smtp-Source: ADUXVKLZDsOPL76sUDPnuhsfXuh6TKo5otf3V0I02PJTaKMQGhSvyVm02PsX0Ma5sMzDwJDjpbBV3g==
Date: Thu, 24 May 2018 13:30:53 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 4.14 000/165] 4.14.44-stable review
Message-ID: <20180524183053.6hreuxcw5ap6hjif@xps>
Mail-Followup-To: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
References: <20180524093621.979359379@linuxfoundation.org>
 <20180524181209.it5mqiweynr66c5c@xps>
 <20180524181921.GC13327@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524181921.GC13327@roeck-us.net>
User-Agent: NeoMutt/20180512
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:19:21AM -0700, Guenter Roeck wrote:
> On Thu, May 24, 2018 at 01:12:09PM -0500, Dan Rue wrote:
> > On Thu, May 24, 2018 at 11:36:46AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.44 release.
> > > There are 165 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat May 26 09:35:46 UTC 2018.
> > > Anything received after that time might be too late.
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm and x86_64.
> > 
> > Summary
> > ------------------------------------------------------------------------
> > 
> > kernel: 4.14.44-rc1
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > git branch: linux-4.14.y
> > git commit: 04c57158a60d4a6b72a8d04b39390eb2dbad0e73
> > git describe: v4.14.43-165-g04c57158a60d
> > Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.43-165-g04c57158a60d
> > 
> > 
> > No regressions (compared to build v4.14.43-166-ga3881b7a4d3c)
> > 
> 
> Same question as before. Why not against v4.14.43 ?

It's because the system just looks at the previous build. I agree that
it should compare against the release. In any event, we go through all
failures manually before reporting "no regressions" just in case the
automatic regression detection missed it. We also review the report for
any intermediary test results for the same reason.

> 
> Thanks,
> Guenter
> 
> > 
> > Ran 11106 total tests in the following environments and test suites.
> > 
> > Environments
> > --------------
> > - dragonboard-410c - arm64
> > - hi6220-hikey - arm64
> > - juno-r2 - arm64
> > - qemu_arm
> > - qemu_arm64
> > - qemu_x86_64
> > - x15 - arm
> > - x86_64
> > 
> > Test Suites
> > -----------
> > * boot
> > * kselftest
> > * libhugetlbfs
> > * ltp-containers-tests
> > * ltp-fcntl-locktests-tests
> > * ltp-filecaps-tests
> > * ltp-fs-tests
> > * ltp-fs_bind-tests
> > * ltp-fs_perms_simple-tests
> > * ltp-fsx-tests
> > * ltp-hugetlb-tests
> > * ltp-io-tests
> > * ltp-ipc-tests
> > * ltp-math-tests
> > * ltp-nptl-tests
> > * ltp-pty-tests
> > * ltp-sched-tests
> > * ltp-securebits-tests
> > * ltp-syscalls-tests
> > * ltp-timers-tests
> > * ltp-cap_bounds-tests
> > * kselftest-vsyscall-mode-native
> > * kselftest-vsyscall-mode-none
> > 
> > -- 
> > Linaro LKFT
> > https://lkft.linaro.org
