Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0D6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F402081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2PVb51i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F402081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeKJAWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:22:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46144 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKJAWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:22:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so1765181ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a2oD+VkayYedLr9lbtqIFbVa2EMa+WFQhM2gae13Vmc=;
        b=K2PVb51iI1LB43H984+Ix2Eg3DzbDsnko7gS33Z2NM33WfGHfLpEw9ikg9ZSoiqqr5
         OHQnOPx14HxFsz475qzfb/1HYOAchpgA6oy5hp1YBby9Wj/LfekPkSwyCzcu6Jr5bur9
         /ews71elW/+7Li8R30gGoLcTKmr0cD9LGG6rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a2oD+VkayYedLr9lbtqIFbVa2EMa+WFQhM2gae13Vmc=;
        b=pFHpF4F7bH4/APtO4P2XZlHRjORNePIYIM2talkBz6+CjziQonnP3ZAOTQ5eo5YbjF
         6mvWnBMaPcG0+S5tVHGdt6BzSGh2iyg09VnmYm6W3RAAxkwglAWzcEmEfpzRaGaEAKhL
         uYrhnuxWh02YMu3amDE9e4OxMHyTFIzSUvee8xeJc4ihRxM+bxmFL2w2zu557OG7Av0o
         kJort31pRuZ2lI6VngzDU9XRUviGvDYZEDSzQ5AI0E1FdH13pUKLdwqkPeEtciGAbmXk
         IYWFDihOOJorsEpRdJZhP8nKDs5lWvVAbgGN2CD+sz1FWHaGTc3218Ykx6Ey1JesuY3m
         A02g==
X-Gm-Message-State: AGRZ1gIIwxx2CjljcE5uJL+MhXsHCyfPm7xsAR0XHpLzsTiWg++EqeVj
        35aElNSQcwKK/jdeXdKv/mXFHGahi+mNxN31rqMjNA==
X-Google-Smtp-Source: AJdET5ehKb3q6hRq+ALxwfNYb5DQb/vag//sv+r5nMslFBffk1k+NrNSXo9Jhf5m5dTzWQfcMzaCuHfPnVwr2W79S58=
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr3182974lje.88.1541774501216;
 Fri, 09 Nov 2018 06:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20181108215129.641434673@linuxfoundation.org>
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Nov 2018 20:11:30 +0530
Message-ID: <CA+G9fYt6fgk0v3wg-7jNbnhEjq-5Z07Fu37Xhk4wfWJSb5196g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/31] 4.14.80-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
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

On Fri, 9 Nov 2018 at 03:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.80 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Nov 10 21:51:09 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.80-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.80-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 24f453c41e18a0eeb83d7c5d65f210b4f3f2018b
git describe: v4.14.79-32-g24f453c41e18
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.79-32-g24f453c41e18


No regressions (compared to build v4.14.79)


No fixes (compared to build v4.14.79)


Ran 21205 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
