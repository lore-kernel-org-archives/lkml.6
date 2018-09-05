Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88038C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E2C20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THJ/k7C1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E2C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeIEPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:14:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34768 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIEPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:14:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so5837222ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U2oIWdZjVzk+oXHsd9NQlAbfvEsy2pnn/uamumTKWi4=;
        b=THJ/k7C1D4vYz+T8MQgSN5AueeVpMjLVsUNTTDvuaOkgrivBwyh31IjXjM8Th7ABBn
         f1ObtemHZpuUp4RlczvKz9Jx08c5EcN1Nkr2g3ouT0kxn+FVm+Jigots2i6ukU97aFm0
         qEjREi2iPJsif8/kRGdHGrSAoq7mofI9kMOFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U2oIWdZjVzk+oXHsd9NQlAbfvEsy2pnn/uamumTKWi4=;
        b=NTamOC2j7oH5VIcxQc6zqEOg3H4CZgwDyW03M7X/i1QMqtP9apiztLpN1EqSTmBvci
         IHDyZRqLk5NqJ1ctP1T2MN+YrVImeVEvOPsVcIs/Q5G750GP5mwoqZPPFrbUiGloP+3k
         Og0MRbp2V02/4PZNAdbgciJMEgSLdJwKMYBy1gOhJJtuPc6qbnFsUimCGoHCebJGeCpj
         foXQWjmEFE0TED3LQNhUYkjTYY/GvOVXLjp7Q3Jn6v8iVdYJo+QiUzz4cNiSu6EaZO7V
         TvnZKgqLmH1amTeJPn/jLzPwxDKJAAO9puZC82kGwPQ8zAI5YzECL2BvuPPUyMw63j+S
         u0Ng==
X-Gm-Message-State: APzg51A9ODFKCzCj/2pmS0UJJyWtNrHhl3ljQfW6XVRSYEJu7bvEEhwY
        20jmSOfjmsExhBh2sM5L0Lqjm5PqbGRP6/qJgAq/gg==
X-Google-Smtp-Source: ANB0VdYCkfZti5lbvU1CpvWhxNUf+I5NCImMVhGXV2Y2ghIxUyHWkR85kNTNCpLmq7ECnqUop2Wite0gXVI/SC6EcNI=
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr22679073ljh.49.1536144275680;
 Wed, 05 Sep 2018 03:44:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9a94:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 03:44:34 -0700 (PDT)
In-Reply-To: <20180904193246.GB17846@kroah.com>
References: <20180903165655.003605184@linuxfoundation.org> <CA+G9fYtAu2Hs5vpT0+P03LRfa_cvwresMT48HgH0HsHQEaEujQ@mail.gmail.com>
 <20180904193246.GB17846@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Sep 2018 16:14:34 +0530
Message-ID: <CA+G9fYtrS8kR_9uaw+wO+S98vG4Z319bGL6LaGjWzFpRQgOh4g@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/165] 4.14.68-stable review
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

> I have pushed out a -rc2 to hopefully fix this problem.

4.14.68-rc2 results looks good.
Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.68-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: e2d662d77f7aace50c2647cb7439acc9a97b1b70
git describe: v4.14.67-167-ge2d662d77f7a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.67-167-ge2d662d77f7a


No regressions (compared to build v4.14.67)


Ran 21181 total tests in the following environments and test suites.

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
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-fcntl-locktests-tests
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org

>
> thanks,
>
> greg k-h
