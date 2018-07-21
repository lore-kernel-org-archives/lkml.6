Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC31ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FB120856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuR5YZ//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FB120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbeGUIqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 04:46:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38873 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeGUIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 04:46:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so12891814ljc.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VcLta4kROF8urUzEcU35gi60xlUt0IwHq35Ro91tjD8=;
        b=EuR5YZ//GOeWq2d4fYLn+DhduePS6jZdflP1lyEOwDxEx0a8RLzh8iZFlNseNR5Qrs
         DlDLHyXYVijs+ZSU07uPAzE0IHGPXk9hHjw6wEMRgR9jPFIepMD8cGTiCQEyV4VJ3jSC
         nbg8yQXjb5cbUZhg+Nn7aydqiTo5JDbEo1OkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VcLta4kROF8urUzEcU35gi60xlUt0IwHq35Ro91tjD8=;
        b=PLSLkndrfDdhB6KSarAkzqqg4CGgHZZEvbZt6emByfZByDTlgyHQgTdGpARwGhsoIE
         P2UV7Htx3FaFnpjza29rZuqqV3E+JN3fIF4PCE2am6/BhL9833lyiXXuDB/jYga/1pKB
         gLERiqsj287vi08DTIGgP0k8tbs8BgHNTJQwZpxSJR5dIEolbB0fWy9rAKWLWxPGTB2M
         bH94Al41cpSWaaFLOovT8JgVAYIKnc9oDuOzyYV7r6kPvZEQkuypPyUom5DISwsiPMTX
         K4IvMnr3vVzYuqICnD1dmJDRPhWogNIEb+UZN8wm7AdOEcAC6oh0qDC4/6S0eINBaEWN
         zdGw==
X-Gm-Message-State: AOUpUlFCOVFsG3Ydvi8Fn7ow31V97thNkI3QggC9jhs+SdoUW4/Awn7d
        rdvYpBZUpuboPdPoQQOlORpUuNBvXvAUnDdjs/GH5A==
X-Google-Smtp-Source: AAOMgpcwifxoSellMQzivZazOkadOu07hJFZB5WHwDIYYXHLC3cLT/IcODHFBNi/QbmqKqxL8RYsJUbN9+9nNHXsqEs=
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr3840847ljk.116.1532159658349;
 Sat, 21 Jul 2018 00:54:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 00:54:17
 -0700 (PDT)
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Jul 2018 13:24:17 +0530
Message-ID: <CA+G9fYuGWJ6K+pmk9JMuqsDrjV+NWbYKWampsM52U1FtR3uqfw@mail.gmail.com>
Subject: Re: [PATCH 4.17 000/101] 4.17.9-stable review
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
> This is the start of the stable review cycle for the 4.17.9 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 22 12:13:52 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.9-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 8055764ff6b0c0f7e1b363542c7ffab1af1e498b
git describe: v4.17.8-102-g8055764ff6b0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.8-102-g8055764ff6b0

No regressions (compared to build v4.17.8)

Ran 16384 total tests in the following environments and test suites.

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
