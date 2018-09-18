Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A34BECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF722150E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwIYppox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF722150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeIRWWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:22:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46247 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeIRWWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:22:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id q22-v6so2458405lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/vBm5ltMjXBIItys2qLEnrjJZXlaOWtfsLRGFAubtE4=;
        b=hwIYppox07wytSzSBts69lu00tqVU8g3Gcn46IkTMoJWc8g2PPk8lNO6fJL3S+Ah3i
         Wqotovflo1RwF+0wgeKsXOwR3spUqFs6s2yQyx8QxYTNKXkaSw2aRXkN2tGxnpyI34yl
         9D0FTTpTFeDQtBPHwCcQisgsFPZzqqcrCGSUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/vBm5ltMjXBIItys2qLEnrjJZXlaOWtfsLRGFAubtE4=;
        b=gbZX68nC1HGK15U/AAjc5cXxvi94QUvi/Ca4oEacniMRIZmXXi9w+ukA4kjTeL3uIE
         Dgo2WLPy2KGhoaKL3Zv+adC/j6isd3Layx3qGoCf8fPJ34BLEppzA5WnYbt7BQaYb//B
         dQWhNGgUyT6eI43E45wcqM6LZAoUIaX25kgHVw9015fjRyy/VmDQXcwRaZglR9K+PYms
         OHVYCe2zft30xqbwuq7M4hsNBARr/MdEn0hRVSJWCaqvBxLSCt4FoZKPnsyX6vd9k4My
         kUxY87f6o/F9M9cB0coOPj1z0iwxoPsEeLJCgz/i++104DtVOHkkV1dcsHv79vOjxB1d
         j4ng==
X-Gm-Message-State: APzg51CdEFsN9yIOgfHTqnCobRfMZAK/boJkESDvo1mkploeI/lsYjwg
        N0a/dtEnvXAYsVHzcW1iCsN4OKXMWB0IZheUzrqtNQ==
X-Google-Smtp-Source: ANB0VdbMEOAaQKnerlCmOwn0UX4lqILj4BT2bcOgigB5hbS9ZyESYRPiZK8zPJODC6lD4GMLdlhX33JQhwySPL4h0Rs=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr19880245lfg.120.1537289338392;
 Tue, 18 Sep 2018 09:48:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:48:57
 -0700 (PDT)
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Sep 2018 22:18:57 +0530
Message-ID: <CA+G9fYsziiM2HbDbEohqiYANLgJZo3rdrPiwnmdBoOByiEqoVg@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/158] 4.18.9-stable review
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

On 18 September 2018 at 04:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.18.9 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Sep 19 21:16:14 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.9-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: 13135e412f3aa2eee7d773650f42f1334949aff7
git describe: v4.18.8-159-g13135e412f3a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.8-159-g13135e412f3a

No regressions (compared to build v4.18.8)


Ran 21243 total tests in the following environments and test suites.

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
