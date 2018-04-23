Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-788869-1524469093-2-1244418651280510292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524469092; b=YG4u5fm6tXWbTWCR2OXwtWR/UK1NxfGtY2VKpvJPUX6tV+YxOL
    zVSvc+zlPxkZ4Fp/EUdc+aUQSjoHtb3SVGIEoacdgHairBgrCJjVxyBfl+G74lKf
    l6oQO0c52EdnJChBG7k0lSf/IiTjc09t08fUCvyX7osmDMHdfqc5dmfpVcn6PPQq
    S1Hta6iMZqKN5gEaZhEzAsCfpbBlSToFzm4Jo/QiEJq4svT2f3q63iOdI1VLaQiE
    0Mr2zBHmihVytC6zdTLx20k4R4rEHzfQMcXoetuhC0Kc0OZ9R9/w7oSjGr4PTtPx
    qKiCPBaDaIjALbB4LrSg71vxh2XWJNyjN7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524469092;
    bh=pRKjSaBlE2zxk7H/SB1EC5RgfVA0a8uhBNjrf/uzGaQ=; b=TguX5djSrRU8
    ZIccO2iO6mQFcOZgMt5EUGTWctJeHIzwnIDrOWjTLol6lFyw5ytbUnEuYE+61/8E
    bb78qD+K093uPOQRX0JXJWo69J1qtstz3ToDQ8jJz96qc6CHLnGb2AAWTnF4U4zh
    gRyQed9xjD1G+CmxJV0oxORA3u3h3Zd/yrewJazx6OGRDHCfkF8yHI9pHa4JR+kX
    jGjNDSxvPIDFhcvCT6AShHhLcmVAdMSTI4Qogf56HZh9o5CUm+05UMyosF1pUE/E
    ehK3g79dTbTmOoRq2vYD9F6hro4Tmx8kfCBaTu7zagLqRlC+X0Vb9JsKSGt9Izgk
    sjyrmldRTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FNBnat8o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kvcKK3fo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FNBnat8o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kvcKK3fo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJyXSSQRzA+2VXKn1d/7+88PWCODJEC6j2E+nP56RPDqz0AKNbcQtSW1+7/kJtCai35pixpU2rrgZ+ZDn8D9B1cq4lkiHeQFgQTpBU9wv8OobWilWyPr
    JZiae3VIC2IwwvC/VJeTx14wfglm/RjVzZ4i67bGwToBO08VCD7QwvRTeMTiK3H9Im1Ju2GDnhlxzJCi+Y1KQ5USzgrvQoWl+uKK+dKGIGwhrwFWtwc4ZT7p
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=BKw5nfpAfisA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=1HnzkDpujKn0UxlyhJAA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeDWHiI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 03:38:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45778 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeDWHiH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 03:38:07 -0400
X-Google-Smtp-Source: AIpwx4+3QX7+v0igxvRCh/DBc6DBMlppvjQdU9dXVtktVNjNMct0yRdcBVGgTHWISeSKqWQOyG2ozraJobrwkOx53Dc=
MIME-Version: 1.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 23 Apr 2018 13:08:04 +0530
Message-ID: <CA+G9fYsXmje8OF_uaJSHDTSrdxngyq_YQ=Nvg90Tj-GKpFbx5w@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/97] 4.4.129-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 April 2018 at 19:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.129 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Apr 24 13:52:47 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.129-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.


Summary
------------------------------------------------------------------------

kernel: 4.4.129-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 7f61d298acbc397846d74572c39fd4920cb317af
git describe: v4.4.128-98-g7f61d298acbc
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.128-98-g7f61d298acbc

No regressions (compared to build v4.4.128-19-ga168d28608b3)
------------------------------------------------------------------------


Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20,
* kselftest - fail: 6, pass: 30, skip: 30
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 28, skip: 53
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1010, skip: 140
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - fail: 6, pass: 42, skip: 32
* kselftest-vsyscall-mode-native - fail: 6, pass: 42, skip: 32
* kselftest-vsyscall-mode-none - fail: 6, pass: 42, skip: 32
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1000, skip: 150
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - fail: 6, pass: 30, skip: 29
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1072, skip: 78
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - fail: 6, pass: 42, skip: 28
* kselftest-vsyscall-mode-native - fail: 6, pass: 41, skip: 29
* kselftest-vsyscall-mode-none - fail: 5, pass: 42, skip: 30
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 119
* ltp-timers-tests - pass: 13,

Hikey test results,
Summary
------------------------------------------------------------------------

kernel: 4.4.129-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.129-rc1-hikey-20180422-175
git commit: 0a1a7ef3621b3edfdfac49700d09565a5c05eec0
git describe: 4.4.129-rc1-hikey-20180422-175
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.129-rc1-hikey-20180422-175

No regressions (compared to build 4.4.129-rc1-hikey-20180417-173)
------------------------------------------------------------------------

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - fail: 6, pass: 28, skip: 32
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 28, skip: 53
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1008, skip: 142
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (beta)
https://qa-reports.linaro.org
