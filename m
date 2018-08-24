Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E4EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6362157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWjXGYto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6362157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHXI7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:59:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34034 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeHXI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:59:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id g9-v6so5809864lfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 22:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IUyI4BaDZ6W8m9kURDLWuwkhOpeyiYfDo6dHOzPo2sE=;
        b=KWjXGYtozZlIogLgRWNIlEXae8s4bA0kEtAj9IQl8cpyfzzWrzmrWjQJgvUhXWcOl+
         dNnyJrUSYxDwo9KEpp0nyt7XTa23P/sI1mVT0MOCkuc0azJuuUbi8ucEA7TNZQDR7k+R
         2Cx7qf8tQ5bMdk0KXNqUpNfR20JPieH9a5b5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IUyI4BaDZ6W8m9kURDLWuwkhOpeyiYfDo6dHOzPo2sE=;
        b=mfoL4s9d91JWnrXolISXqfZLvgAp8mSZnD8QmO3ju7gwtgjnuv78TqfDIBLHcZuwE+
         pjM8i7pTjNhc0N/d17Q5sQULW1kvyjCbgjDWtlrEE/uuPDbSTYTn6q5VYlp4QxPnIYae
         gzTCjUxC39WCSW0FQu4WxgwxvaCbcGACuskjdIMIQUkCHwk3m4Lt6rLm/jtBx/u9cRop
         bihft5HZqUWZHZKgqKDL4SfLwTltV/vBWmhMroL57ntjcacoKdG7Q7cL8HBkwZfaYyFB
         TsgK+FhmGcy8T9OLwviIv41e//PVGeVAFGx/biAHVoA8LH6M3qW2xGw68+7tN171zvWb
         N2wQ==
X-Gm-Message-State: APzg51A/EKwRXy/UuENrS77+kdFzyxu9xV1UvzO90dyvXcN+NmgU6DYD
        QRRcmJbcxuxgnmeF1YYvabQx+1X90PGFzBJwWruP6NyOFmA=
X-Google-Smtp-Source: ANB0Vda92AemEWqlMflQoFNboYeKDfTkAdZT0wjXXOQKc/YATQKxiQURsHODW8w9mcABXpf/eZ6o7/rABaqpsI/cN3E=
X-Received: by 2002:a19:164a:: with SMTP id m71-v6mr125626lfi.82.1535088391597;
 Thu, 23 Aug 2018 22:26:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 22:26:30
 -0700 (PDT)
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Aug 2018 10:56:30 +0530
Message-ID: <CA+G9fYsEvSDTAFOt1f4roErZirsmJOJ1PvzaTpW-CpZ1unCcnw@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/130] 4.9.124-stable review
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
> This is the start of the stable review cycle for the 4.9.124 release.
> There are 130 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Aug 25 07:48:45 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.124-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.124-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d8c335b8a13deabf0c024b9728d62d686a2a9d0f
git describe: v4.9.123-131-gd8c335b8a13d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.123-131-gd8c335b8a13d


No regressions (compared to build v4.9.122)


Ran 12411 total tests in the following environments and test suites.

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
