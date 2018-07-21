Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2417ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5163020856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6p1A6/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5163020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeGUKIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 06:08:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33360 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeGUKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 06:08:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so13007266ljj.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 02:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UsdIT5kR7HmhyZy1LEYLxDNfI4hjSfylJK5GVw55M6A=;
        b=E6p1A6/5QgQl7Lr2WvcV+t+SvnOQ/i2PSoGHgioF+urTMxankagRtSzqydU6feeUZj
         nLI+/Ga9fXAibX56Q7vn5fMRJ5UFPaB4xu3+UkJwEeXSPltvMfByJX0fN3Vo0qhpS8FC
         P142Y9ZrixEL+4OT6wp58sB6R6+njy7Ev63RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UsdIT5kR7HmhyZy1LEYLxDNfI4hjSfylJK5GVw55M6A=;
        b=SWBTch+CCgYAnlyrWJLAjApLZ1rphtwn8hdveTuOTgec2c2umwg+6QXptV22vJY/sX
         hr2QPNpTZYKQD7HjOoQgnkXuwVedyXaKmJjNTnN9CJ3JAGWlyEadGVSXyiLbddRJSUba
         K9y3sYk3Vn/MRICCUuSe9zmPFy3iMDGwx7yPavC0M31jbftsO5vDXHMmXL1+mfB4TmB5
         4V6BiZf5CD7XYKi1/4f59gWhFcrYH3UZeqhUOjm4Ql+fN0JZTPAundmWIEgaUQPeQy2W
         8mK7Qti34wTHF5P2a3rzOdOhhHCD7lvt8aw1q+f4zT8C6IXa1OVcoyTfQxQ/QrNbibNU
         aR+g==
X-Gm-Message-State: AOUpUlFwCdA5bA93KTuHL06vVk7PKTKgstJWRAKXl6s7p3F5SoP2LXr/
        keYsasMFi0zo3zyg27ZOiB/apaKtfIX/J7WUGE/2xj1QYCNJPA==
X-Google-Smtp-Source: AAOMgpcpOUPJ5+zGZdZXZjhSda5QmJ/4YPlCr/4aPuZkrYG7u1qVh0BSNaNKz5K73y+KEs1YHkz9XtQtYVAiJiEIFAs=
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr3961161ljf.79.1532164569550;
 Sat, 21 Jul 2018 02:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 02:16:08
 -0700 (PDT)
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Jul 2018 14:46:08 +0530
Message-ID: <CA+G9fYv7xsurc92qhWCUrr+uyrTW50O_JsRXTq_Rn4LjwW6Thg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/92] 4.14.57-stable review
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

On 20 July 2018 at 17:43, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.57 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 22 12:13:50 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.57-rc1.gz
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

kernel: 4.14.57-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: ec86d5e19e14ae1ee40cf8f41c4b960472bccf89
git describe: v4.14.56-93-gec86d5e19e14
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.56-93-gec86d5e19e14

No regressions (compared to build v4.14.56-93-ga3636f4156e6)


Ran 16439 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
