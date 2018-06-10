Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vMduGhvqHFvSPwAAmS7hNA
	; Sun, 10 Jun 2018 09:07:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CA8E60850; Sun, 10 Jun 2018 09:07:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCYTpmWN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CB9CE60791;
	Sun, 10 Jun 2018 09:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB9CE60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeFJJHn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 05:07:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43154 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbeFJJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 05:07:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so26112652lfn.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N2GLPRZAT2TXI0ff4Qn5mikf/JcW4TspeMYrSXOhTkI=;
        b=KCYTpmWN7/VFWWydG9PBr7dHN/UOabVQKktZS9Ufmm2eLqL48Nf79JXi9gvQQzC1po
         KL+LfUSD6qEY7yEDFe1XHJeO4LOmI09vEK2gjrAYXk38NW2ot2A4+HCtyTbbdMBkZJH5
         TnuaN6o3JOe1w9OhMQyulKUqX3NBUPy5Hle2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N2GLPRZAT2TXI0ff4Qn5mikf/JcW4TspeMYrSXOhTkI=;
        b=kjDnRl/4eG8xRQGqAC9MqzfCKVT5/sLqRTeRz4Dm772P4Ai/h5ANbVY5zoAkpJtyas
         GciJQLkCGcLUf5AJWs3CoTp67rhJfQV9X0MivsPhOG1DT+oGEYyBZF2jdgalw+WFhaXm
         7pZv0SXyquAm7CUM9MhjAa2qNFGOE4Q2SlclwNJn3Om30eHhLd6pp5uZzZ0otB5gaz5K
         oy1g/b7nUafzdWbNw03phtHcMZf8dxc7pRQ+/mn2BxmksWT/pmyvEM+5mZWbpPhQDZKM
         lFFt0DIbcZ7ZojWydDhJI1akUSW9LFuMe8FqS+nKEhTv+JuY+i/ZzM2RKvylDrmiiyVE
         bpJg==
X-Gm-Message-State: APt69E1gmsbhGXc4kO4nRQw3Kryoaffj85bb9Ok42CW9O3YgS4jS6BxL
        zMMtQ9pLOeu3dwH4zeZ3xDJlctemZTJKYdI48sF8sQ==
X-Google-Smtp-Source: ADUXVKKMeQ2juZ64XCgmxALi0LfeyGXpCJCdHHr3CeUvIoBzlY86MOB/5xyRb/mBGQf2wtgDZ7KAi1BH0X6CLSREd7w=
X-Received: by 2002:a19:8f1d:: with SMTP id r29-v6mr8232797lfd.88.1528621659994;
 Sun, 10 Jun 2018 02:07:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 02:07:39
 -0700 (PDT)
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 10 Jun 2018 14:37:39 +0530
Message-ID: <CA+G9fYsWZNWeGeZzknVts5iF5h40y+-tBnoMNL5yZJx3sxfc8Q@mail.gmail.com>
Subject: Re: [PATCH 4.16 00/48] 4.16.15-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 June 2018 at 20:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.16.15 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Jun 11 14:59:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.16.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.16.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.16.y
git commit: 0f447b621dc169007a7c7a87db5a5ca0b8070833
git describe: v4.16.14-49-g0f447b621dc1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/bu=
ild/v4.16.14-49-g0f447b621dc1


No regressions (compared to build v4.16.14)


Ran 11375 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
