Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3862C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFED220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVwy36Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFED220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeIRW1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:27:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39503 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeIRW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:27:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so2408546lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QtBPcTtJ+HW704z4/pg6Ly/YUKBlE06KNAZMpoSljys=;
        b=OVwy36BbR+VB+SH1qmjt7g1eFrJA/8h8zauzU5wFw5YwFUwZu9SpMg7gRiIOpW5iSl
         CF5tWvcO9mB/Ch3swwT9fLgzTflqhFFBOnyRHyD5tkhBduswSI4FOJA+9PGB2U6Al/rQ
         pPjIAHMFh979QJZ/t1fS2DFzE0fXTqz2Qdd8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QtBPcTtJ+HW704z4/pg6Ly/YUKBlE06KNAZMpoSljys=;
        b=tuYeCZxS/ZPFTXjIKmnU5blZ9Ku+ISfXDGxaQ8eWToTEvsfoSgnOTenyw4JcOgb61W
         LyFjKlDOYMRKbsVadIUKXPbX/NE67ppTOsV/GL4xOCIQoZFz6P1oc72HepGLslPJfpNQ
         kwFa2VLmpwU5/8GG0guEbT+irbhflrJKSzakR+mzDLCwCsNXIRxN8M6Dfd35vwfZjMZa
         HPWSDygi5775liQC2+BFpDH9mNVpQzc4vRZ3kr4PAaDTDe1cLnFQPjw1+p9/mlJxzzeB
         wxO8oE3cDOnR6/Ms62W4416gwddUqkkfWil/2NeVIK0SvZliacJZbHTve6NEkKZmJQAy
         83Fw==
X-Gm-Message-State: APzg51ArW1Im9ypq6ESfmQWm8Fv3Gl0sYXUdwh7eP7vJYSYuk0LoJa9y
        9NLDKJTefvVP9ubDdHLKxJb57ah49TJpa5ikVAA/HQ==
X-Google-Smtp-Source: ANB0VdYzaYVDvleY5bCScSpZnMuqOlH+Ad05dToo8moNRhy/9HhuloLDnWdY4M3s39E5WCWcOjvcicIuFnOiNnmwhic=
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr20463654ljk.116.1537289620006;
 Tue, 18 Sep 2018 09:53:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:53:38
 -0700 (PDT)
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Sep 2018 22:23:38 +0530
Message-ID: <CA+G9fYuSC_RhvMmbH1EUgWhTNT00G_QjsprSetpqte6U6kbahQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/126] 4.14.71-stable review
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
> This is the start of the stable review cycle for the 4.14.71 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Sep 19 21:16:12 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.71-rc1.gz
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

kernel: 4.14.71-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 117adc51b16e0068c963f8c1339a0360ccf29f17
git describe: v4.14.70-127-g117adc51b16e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.70-127-g117adc51b16e

No regressions (compared to build v4.14.70)


Ran 19763 total tests in the following environments and test suites.

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
