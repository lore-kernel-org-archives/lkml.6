Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277B7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C560B20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdtH4hIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C560B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeLEFMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:12:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35138 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEFMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:12:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so13760842lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mBA807hLZLpmG7axHI0Bx7D7qhoo0QV+XJGokLBJuHQ=;
        b=XdtH4hINOtPO8WdoWjZjBDJMFtzTiX6yPMc6kqFp0lAZlLemODvwW0m3mbvuiWd2Ow
         cqmdFTwZluj34E7zo7dwAku2q5DQTuNfCaJmTUFj+WgeeCJeLvy4E+ZV8lIS2d+WC1XC
         qqYSHOL1xVFLLhlraj++q7GlgC+fjMXsdzSOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mBA807hLZLpmG7axHI0Bx7D7qhoo0QV+XJGokLBJuHQ=;
        b=OPnC2dT2j0MOqbilJ8qXnDdXNjeqZkv6Xx74+VgnUEk8ZQjbU8YEvBcf9zNBwJLpnn
         YDaMukx2fPw4nhoEe0rgwjIGp7QDfXTHn6Ou2Om1FP+hLWpbkPUfuhciq4nKE/tO09CV
         uxU2PAga1Yax1YBUTiQ+smPOoURcsxfc5GVKBhnHfgoTTEgPvMLNb6S4IXxtu0ABen+T
         rFAm4p60hPa6gVFc/DnoUoS/I+ArjYM/QLz+DCrDBU9tztZ7Ixkl7M8I8Qi7EnPyvCRG
         Ro0DOC8WESS2+i9a5DhVMF8eB0/qVCz6JOD5aZ3+kVXHjd/A+EdPP/Ke5NsXY+CvjQzV
         acCA==
X-Gm-Message-State: AA+aEWYTW0sq2PwYbH/AAR9h4LiKyOqz6UxNEPRfS/BrNHZXRV2WH8qM
        q2mGeOO0rBN6TiSmpLr1KXQZuPjdqQRK3SbRvefnzw==
X-Google-Smtp-Source: AFSGD/V7unCxsr5xwQvjFgrzZ7LP0ZItfX/XGn1hco6MAuJRx51i1dMBNzyegQblc6uqAf7jbqifU61KuXGFbd3LoDw=
X-Received: by 2002:a19:1019:: with SMTP id f25mr13004033lfi.54.1543986732566;
 Tue, 04 Dec 2018 21:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20181204103714.485546262@linuxfoundation.org>
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Dec 2018 10:42:01 +0530
Message-ID: <CA+G9fYtk=t_AqNVmkQjZJJb5RiWcdo8qczK1Tm+C=XAH+5Lawg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/50] 4.9.143-stable review
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

On Tue, 4 Dec 2018 at 16:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.143 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Dec  6 10:36:59 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.143-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.143-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d453b6576ba5d750a0085cb26252c2a077fd60cc
git describe: v4.9.142-51-gd453b6576ba5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.142-51-gd453b6576ba5

No regressions (compared to build v4.9.142)

No fixes (compared to build v4.9.142)

Ran 21327 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
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
* ltp-fs_perms_simple-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
