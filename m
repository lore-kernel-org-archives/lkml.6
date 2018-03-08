Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1810880-1520510479-2-15991718628907678268
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520510477; b=tOdfXiOax5pWC5Dw7+hMiqJVQjAW3RMB6YLgdy39mgp3Xn0
    mapKeBcDO++NAxAh7F97wTkKsKHJoB7b5F72/8ztrqsOTF9cSuQXGMJ6nOcnKFzM
    ZV2yj+P68IH0AWGltvrrsoE1epxIUs25Z3rBvbUJ9BV10YQs0/mGTj70wXIWnSnY
    eZuZGmmH/UEX1q+zSTNERhHZI59DOtnfhrN8pVNBCw2cDPnKL8mM44bx/lDu5i8X
    j+hFsF6tC/qs3t3kp2Dm4qozTg/KaGe4FTeKyazk5VkUpXkzgGESs2UV7sE5FM5S
    CRpBwq50oRPBN2Lge9UwG9TQbaftZg1NlpT3u7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520510477; bh=yull103aIXYFkzz8xjkzybsmKoyLTc8KxoRqUut503o=; b=O
    liCY48s6oO6qfi+uE+Pk3qRggC+LBuJ0YXfRfqvdrglkgQduI8Ljt1ZV4s9G28sN
    BsKQWgA7awswE3CXmqcjiybfl4wq91AUy9ZHFbbM/yYtBBXyC0TjtqGbX0QLU9h9
    HmwkXS3V4ytX5/i6zJhR11vedqfIPf//uIEVd8jkTltItdRN3znyY4k3TZr+aYDU
    HSaiivDuUZXAldXOrtq4aZNwdBwjRI7TkPmlmBQtb227ADpilfxzXYUbxw7+2ni9
    HnxDc8+/5fWGiS6Ejj8GyRML1NZGHKWHaBWQkUtS8QKDTo0X3XCuNKXjcU0R6MDK
    gAJhV8YNqLWELuRFSdaIw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=fH3lJIHB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nBRKAbrM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=fH3lJIHB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nBRKAbrM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeCHMBB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 07:01:01 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41393 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754837AbeCHMA7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 07:00:59 -0500
X-Google-Smtp-Source: AG47ELsPKOw4eryJVTYN6YEoV8Hlkw67sQb7kfCMxMRKUI40DfQsZDndSu2yaNp9YFQjmPzVftixp65VWonbfltw0bA=
MIME-Version: 1.0
In-Reply-To: <CA+G9fYsXfxi4WJ+29S+5xcwEFLg08=tYVE3_Xu0SSXrKV07KcA@mail.gmail.com>
References: <20180307191039.748351103@linuxfoundation.org> <CA+G9fYsXfxi4WJ+29S+5xcwEFLg08=tYVE3_Xu0SSXrKV07KcA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 8 Mar 2018 17:30:57 +0530
Message-ID: <CA+G9fYs7puAK+jy9bjFBTzB4ErazKwzXEYB_nTkUZu4-he8j1Q@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
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

On 8 March 2018 at 14:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> On 8 March 2018 at 01:07, Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
 wrote:
>> This is the start of the stable review cycle for the 4.14.25 release.
>> There are 110 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri Mar  9 19:10:03 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch=
-4.14.25-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git linux-4.14.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64 and arm.
>
> x86_64 results not available due to infrastructure issues and
> we will share x86_64 results when available.

No regressions on arm64, arm and x86_64.
x86_64 and qemu_x86_64 results summary published in the bottom of this emai=
l.

>
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.14.25-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> git branch: linux-4.14.y
> git commit: 66060ac1dfa02f02646a55f6ed888c0f2001623e
> git describe: v4.14.24-111-g66060ac1dfa0
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/=
build/v4.14.24-111-g66060ac1dfa0
>
>
> No regressions (compared to build v4.14.24)
>
> Boards, architectures and test suites:
> -------------------------------------
>
> hi6220-hikey - arm64
> * boot - pass: 20,
> * kselftest - pass: 48, skip: 17
> * libhugetlbfs - pass: 90, skip: 1
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 64, skip: 17
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 61, skip: 2
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 21, skip: 1
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 10, skip: 4
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 999, skip: 151
> * ltp-timers-tests - pass: 12, skip: 1
>
> juno-r2 - arm64
> * boot - pass: 20,
> * kselftest - pass: 48, skip: 17
> * libhugetlbfs - pass: 90, skip: 1
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 64, skip: 17
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 61, skip: 2
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 22,
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 10, skip: 4
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 1001, skip: 149
> * ltp-timers-tests - pass: 12, skip: 1
>
> x15 - arm
> * boot - pass: 20,
> * kselftest - pass: 43, fail: 2, skip: 19
> * libhugetlbfs - pass: 87, skip: 1
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 62, fail: 2, skip: 17
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 61, skip: 2
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 20, skip: 2
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 13, skip: 1
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 1053, skip: 97
> * ltp-timers-tests - pass: 12, skip: 1

qemu_x86_64
* boot - pass: 21,
* kselftest - pass: 68, skip: 14
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
* ltp-syscalls-tests - pass: 1002, skip: 148
* ltp-timers-tests - pass: 12, skip: 1

x86_64
* boot - pass: 20,
* kselftest - pass: 61, skip: 19
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 62, skip: 1
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
* ltp-timers-tests - pass: 12, skip: 1


>
> --
> Linaro QA (beta)
> https://qa-reports.linaro.org
