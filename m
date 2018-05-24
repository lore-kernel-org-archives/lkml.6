Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2363342-1527185965-2-13613396552459809296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527185965; b=eita9WgTlrN3YidORmfLyDFSE8/OHCUeAmMYiXzFy4+3qgsADK
    HOT1FUPgz491QsyMwTwUf2+wMlX1bHu4jPACvgpu7ER3uC4XdGUfsj19JgDSXEM3
    4nHL0dF2gFqJoX0Eq8PDT3QOwHzRU2BgDdeQIk+t9LT0bJdKVX5tL9RHCMVQ3D36
    ail3Xb7J3U3X1q/ZpWGXd1sqBwNxZVCVo9QMFj4uZ//o7Do1rYTT2odWQehTc1Zu
    PmCCe1oXkfrff/s6Lr2m73bnc6r53doxRFDbeyIo3I0o+c38c0kfL53rmEe82+5v
    YJPRwdssZxjKTe6hhyWtElnH0Nf31D5TF87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1527185965; bh=OT8s2n4f8XO
    qrBa5sSwglkE5Qt8hdsqP/ow2tDJuifk=; b=AHclMP8WmC7/qTNn2QVLv8xPsNC
    B3X0g1+AcDE21jR3L5dJG2vE/ntCkQLQSF6V+s393O9EntQv8uNx80MfkNn6DyXi
    nytwFMeudZxQvnr8544AeBFYkmTPfHKh8aRgijWL4mzWTKVaBFkxvjgNRtCTbrmh
    6w2n6E9JmwFV/vABFsPS+awPPjUpTI0nA1zFemk4/66IyrZ1mOwJc4uFGq5VtCJ9
    6qGFWYs6352hiLPix9LOjwuWAUqYMcgTS3B1Wn1irXvUtb3X6UbnyaJd6jArXXOG
    exmUReXiq0i83+B1zJFO07HxKQ6Tz6oYvYIq6NHQ287LhjGBSlogp+SJP/g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=2upC3/CI
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=2upC3/CI
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTPcKcJ2PbOI0C5XbpO/hxSmtdwuAazI+ATXojiTmGteIJTGxmVzsinkgSEEH+Qj74ZML2eyrY9h8t1Lv8zDRh0PobXCAArIVI1X/A+5rJpPeMIZZTM
    aXUuFA8uP+tWZR0heO2EZv+CwCreJ6eSKh4AHUebyrxgRDb87pqWC/+jQQgTy2HgZsB7ByirhteLP1KBhMTzb/z/alv8WOF9WP4K5IHLme95h/AjA/IWCBNl
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=IkcTkHD0fZMA:10 a=6xLPOHPkGDIA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=KKAkSRfTAAAA:8 a=wZcrcOo3JclKMcUf3qwA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031233AbeEXSTX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:19:23 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:37435 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030439AbeEXSTX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 14:19:23 -0400
Date: Thu, 24 May 2018 11:19:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 4.14 000/165] 4.14.44-stable review
Message-ID: <20180524181921.GC13327@roeck-us.net>
References: <20180524093621.979359379@linuxfoundation.org>
 <20180524181209.it5mqiweynr66c5c@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524181209.it5mqiweynr66c5c@xps>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 01:12:09PM -0500, Dan Rue wrote:
> On Thu, May 24, 2018 at 11:36:46AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.44 release.
> > There are 165 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat May 26 09:35:46 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.14.44-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.14.y
> git commit: 04c57158a60d4a6b72a8d04b39390eb2dbad0e73
> git describe: v4.14.43-165-g04c57158a60d
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.43-165-g04c57158a60d
> 
> 
> No regressions (compared to build v4.14.43-166-ga3881b7a4d3c)
> 

Same question as before. Why not against v4.14.43 ?

Thanks,
Guenter

> 
> Ran 11106 total tests in the following environments and test suites.
> 
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - juno-r2 - arm64
> - qemu_arm
> - qemu_arm64
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * boot
> * kselftest
> * libhugetlbfs
> * ltp-containers-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * ltp-cap_bounds-tests
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org
