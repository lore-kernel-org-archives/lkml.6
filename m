Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2377CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15EF2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aU3psCf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15EF2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJQXIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:08:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50482 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeJQXIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:08:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so2379496wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bzUjkj6Bxrd5dupGvd9+e/6O7JcLavOjW0pw773iieE=;
        b=aU3psCf9AMXTPDGTD2jLTsTGPqmEMkBcaUAOwpVg6vSl6DwGk6MIh+9vyM/jQ4FwDr
         exy/GqzZWKPJ5j5Sf5RnyI0wmngkkwMlFkviNSTFrn5DHjtX9NmkKJVowN59zMa8Aw8X
         VFIElyqNU5IgpHiUDyBrcwbotH4UtHdlHIzRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bzUjkj6Bxrd5dupGvd9+e/6O7JcLavOjW0pw773iieE=;
        b=Gk1ZE9yFT2uMAzXND3lhWiEVW+K+k0n9klwCtUHGy/F6aQmd+Coy3s4++QQwyG1yQI
         zFll064L6Ly71xzeT7iwezunaVB4UOftgJwksjETe4Nt7klOSFTZqWOTvesN9IeDZJ/F
         dPeBkrLC00Ovc1o14QmzpLdnCK3eNWFkMPM9DvMY5sTB3ndpWV0AXJLPMTAT5GYCDpSf
         4kPwAnCwxNeKjGI9XDjJ0CorBW0jsuyU4VGU1ayUdpK5Fu+yx8HIbQY3fm44LIgJLaZg
         bSuhCgME5S+4ouBwCATSpAiv2UdNPW6u8Hn7OrHim6L0gQJFBGw1Djr3wKqSEaP0clHR
         ZhDQ==
X-Gm-Message-State: ABuFfohhJ9i0DjSwnP8Lb4+LH6KDAqgC0rQqYjgCA9atKwu42Lw2f2fM
        XEsLsaGgVJGjh546MW0N9dew1tr001i6xx3B4TZzFA==
X-Google-Smtp-Source: ACcGV6212/0Fi9W6uOufLpwlyuxu3wmvaDE1aBmPdFs4c3qoF8NVtGP4Kl5SlGHwFxuPtfR6BvdrLeo4DAuBx0rkIgI=
X-Received: by 2002:a1c:4c16:: with SMTP id z22-v6mr3115623wmf.89.1539789140824;
 Wed, 17 Oct 2018 08:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181016170539.315587743@linuxfoundation.org>
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 17 Oct 2018 12:11:44 -0300
Message-ID: <CADtBP2Dh-CNkpGZPXMT4xOtb3fArBTjJSpnkrnKMc8WDWxC+=w@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/71] 4.9.134-stable review
To:     gregkh@linuxfoundation.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 2:23 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.134 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Oct 18 17:05:18 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.134-rc1.gz
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

kernel: 4.9.134-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 9e48abe2679cbb419f7472c31d11c06711b5ebc7
git describe: v4.9.133-71-g9e48abe2679c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.133-71-g9e48abe2679c


No regressions (compared to build v4.9.133-72-gda849e5647be)


No fixes (compared to build v4.9.133-72-gda849e5647be)


Ran 20932 total tests in the following environments and test suites.

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
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
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
* kselftest
* libhugetlbfs
* ltp-fs-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
