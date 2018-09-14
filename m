Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA940FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913E820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsFHAheA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913E820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeINR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:56:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45689 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeINR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:56:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id u83-v6so7380923lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aMf5e/Tjmk8ipeguWdJbvagdSlaJ3/QFOJZ3H5BJcFQ=;
        b=GsFHAheAErMjqieG+hRkLq4lRfl9VcoXUQr3VsGIuoOsnSDRcI+BG+HzKoktCE+s5Z
         Ij4tQ9yMaq9Nq8QQ+EwTGpW6kHIB/f/pARV5afXKfZMOP5uHKzEaBXg09EfN2vEJtnET
         5YF5m0WeJlXei1A9UOOCkZKFjqhhERLMtbq7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aMf5e/Tjmk8ipeguWdJbvagdSlaJ3/QFOJZ3H5BJcFQ=;
        b=cp45R7T+ap1rLGpIM21m8yiOMqQuvUsEKvDam9ka2Ctfv5IPleeu7f2zPqYVOiIu7+
         mbxKNjGHQah2wjQ/7MkTxMjc6HvyXVWsqb8AdKFhrjFaelQFk9VRb9KYldBkUysul3wt
         BrTfyoFBAd23PZmqqqFpTrKYakk/swJX43l5twNfQX+/siypGwEXpd548wn2GdxrXN6I
         nXOQ+orlX/H7XoyxBYAqrI94BW5e6kY2Q7aXZ3/lUe0OkhBw02ooyJj59Lq80wgUbARi
         jRYcTsrhx9CvOirFc6DGw6VeEqFdZl/sNvzzSylb2f+Kx7WAepMOxKiSSM5RoE3cmWTF
         niKA==
X-Gm-Message-State: APzg51CQMG6opOlkFnNHFBA5rgsu3oeCgaUE1B1Qn5KVBdfNYox3210h
        YcmYsKeVhFEAQ0Lw1eYuBz84wnCcCu2Z5l3EdH28q90fETE=
X-Google-Smtp-Source: ANB0VdapkJIfSBgjP1h6W0uswDy/hJ86yaN5jxJSWdHpwfyhAEFrzmMv4eg7C69AKnATIiL53cTifnF8hpVYRidv5X4=
X-Received: by 2002:a2e:650e:: with SMTP id z14-v6mr7461047ljb.62.1536928944315;
 Fri, 14 Sep 2018 05:42:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 05:42:23
 -0700 (PDT)
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Sep 2018 18:12:23 +0530
Message-ID: <CA+G9fYsEpn+Mi-_Zxy+8_3FENM6eEknL87YJQyX8QjDHcyP_YQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/78] 4.9.127-stable review
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

On 13 September 2018 at 19:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.127 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Sep 15 13:17:41 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.127-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

This report is on 4.9.127-rc2.

Summary
------------------------------------------------------------------------

kernel: 4.9.127-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 2d4a2997954fc37bbd2ba52f43381b929b9e9ca4
git describe: v4.9.126-79-g2d4a2997954f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.126-79-g2d4a2997954f

No regressions (compared to build v4.9.126)


Ran 21306 total tests in the following environments and test suites.

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
