Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B147C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FA32156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtCFQEwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FA32156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHXIw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:52:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44899 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeHXIw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:52:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so5902926ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nSDxgvWnGQyPvxX69TA7Mwe9dFymA0csjFi0dk+19eU=;
        b=CtCFQEwjY6JewNDOag5Jmy/sq/Bzpje7brxQ6nw3O8JrckSyyotiTv0f/6NDCA7cXV
         mQo8lK4QKHc4D/dW2p5LaEEpH0NOBYjojvwKkjMEfuE/5jL0YD0I4Ol/lJevY4ZXl/4Y
         SR1Od0q6GD5WayLb8MzcLk5RLbIGOjF1ugxOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nSDxgvWnGQyPvxX69TA7Mwe9dFymA0csjFi0dk+19eU=;
        b=MEmWnQcRLQJ5vVJGkvDJzcwtimMF8OrKfuEo7AyB4HIkiWMs7K1dS9yG6lbY289V3o
         1BHRRNW6Hw1+V67gWDetpLjaOPJ5lsgWYaBbr02FQnV8Eo/g8sLFzGzxOiyhWKhtaRC0
         mfcS5Mm7WEuRyVoGUtn2bL3X3iYAHfSec/m2KnHYIOjfh8riolsPRNt39bUXq7ImE+o5
         T/xFZSaRVjVXbcerog1oL3PKilEtTyfUMy9wbI7//2yKJZvW4C4q+DQJTn9U2/Zt2Xxf
         zvNdOrPCb2BdGRYSXHWru5RaQzaGbLka+SAKrZpfRjxdz9eceeF1rxrGCpuNdL2DRsXT
         wTKA==
X-Gm-Message-State: APzg51B1Ett237mzOK/bnBVGhsUpR+Lqc/PzdcVoUeJLwhFWO++fOOfh
        CK1AbypSoShFO1nJkV3pyILOlijNSEKUtu04CUR+tw==
X-Google-Smtp-Source: ANB0Vda5OXjFC3mXTV7d7oN2PuJyX6uVwWaUvTOyZXs6NVHCpeCCK9IE9o0xaqrBwi5Zi7JhKVHoN6SDXP/j7ecvQGA=
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr101657ljf.79.1535087997814;
 Thu, 23 Aug 2018 22:19:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 22:19:56
 -0700 (PDT)
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Aug 2018 10:49:56 +0530
Message-ID: <CA+G9fYvbupMk-czka=Th+7uR5hzVsXCiDnnsek0Ujv9AyMjt+g@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/217] 4.14.67-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 13:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.67 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Aug 25 07:54:25 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.67-rc1.gz
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

kernel: 4.14.67-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c896707b8c8af7d51ca8575c395d03418984c94c
git describe: v4.14.66-218-gc896707b8c8a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.66-218-gc896707b8c8a

No regressions (compared to build v4.14.65)


Ran 12451 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
