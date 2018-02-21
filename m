Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2071779-1519234624-2-1467343249494329592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519234624; b=Qihy5WBawdjZAs+PDaNDH5q44ylF/pALaYIFKax5S7b6aSA
    qs2GNgOkVpiM+TVUevO4X0DIgTJfBXpD30KJI7OOZytr76srCAcBG8SdV1RoeJlJ
    0zry4eE4NdyjCz4++WmA5FRTpYdFXfy1ePuiZcs/SeM4cY0eUQNMSB2ZSKxCvpEv
    2nA1nshbOLvvNM/SQlBi68NAQbJQQX60lZyI/j8Pf+kGIOU7HqZ1FehYVz7yo1bO
    21YqAajrQjEoj4iSi0O4gPp59PRFe2FianaD3263OUWu09JfGcH9kxNBT3jIF64k
    Dssg6no1GmO/FsrAdxFtCJ1JmEvcxJvusP+kOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519234624; bh=a7B/hpgLQMOC8cOOmy/kzs1KWZPB1Etg7BQH09ZmKZ8=; b=j
    kwQLuV39nLi+4v+p0JFbOJWBx/lCrgOKz7ooPan+BqZuGsZ4Ai3VBArzsMd+edrr
    m2cEHGfUVsJFgBIDPxL5HORJ9qcmZdWlsFETzJnovixnHVi04TH4Oon4g+njHZQG
    Wh8It1WbbyFPeZfiR6lMfeVbMZ8H00HPRU/tJCU7rY8Ni0Gh+nMtVlP4+zmDUY4w
    UPqSC3dAWu6Wk3H+HxGispeQ6x2dpEmTHSvp13CGtleQ+t5qJEpZB2AlGcl4WuVt
    O4pGoE3h73mDP+QSffb3voOZc+M+xT8Lh4h3dz5SgSOoDkUc9azG1+EKbfIpx1qA
    s8ONMjxV9ACMGJ7eNn6Uw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=MvrLar1y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NKkguywi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=MvrLar1y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NKkguywi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754932AbeBURgn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 12:36:43 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33961 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754272AbeBURgm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 12:36:42 -0500
X-Google-Smtp-Source: AH8x226V/wfddlg0/EOUgiTLCoUsOS/6V5y6PRtGLMwSTc5EisM2RXAoi+x/GDFGBBLlWNP1oqHJWQqz3dUDHQnnl0w=
MIME-Version: 1.0
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Feb 2018 23:06:40 +0530
Message-ID: <CA+G9fYtZinFR5cO7xST2Pohx2==b5DD7yjni7Lzbs9SEzuinDw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/167] 4.14.21-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21 February 2018 at 18:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.21 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Feb 23 12:44:42 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.21-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 20a80dd2bbb095f1b2ae2e72143f12ff8b605382
git describe: v4.14.20-168-g20a80dd2bbb0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.20-168-g20a80dd2bbb0


No regressions (compared to build v4.14.20-119-g1b1ab1d5c50b)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 17, pass: 48,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 2, pass: 61,
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
* ltp-syscalls-tests - skip: 151, pass: 999,
* ltp-timers-tests - skip: 1, pass: 12,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 17, pass: 48,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 2, pass: 61,
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
* ltp-syscalls-tests - skip: 149, pass: 1001,
* ltp-timers-tests - skip: 1, pass: 12,

x15 - arm
* boot - pass: 20,
* kselftest - skip: 19, pass: 45,
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 2, pass: 61,
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
* ltp-syscalls-tests - skip: 97, pass: 1053,
* ltp-timers-tests - skip: 1, pass: 12,

x86_64
* boot - pass: 20,
* kselftest - skip: 19, pass: 61,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 1, pass: 62,
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
* ltp-timers-tests - skip: 1, pass: 12,

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
