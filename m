Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uMduGhvqHFvSPwAAmS7hNA
	; Sun, 10 Jun 2018 09:06:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 51CA160850; Sun, 10 Jun 2018 09:06:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bru/gg3H"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 91B7B606DD;
	Sun, 10 Jun 2018 09:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91B7B606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbeFJJG2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 05:06:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45703 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbeFJJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 05:06:26 -0400
Received: by mail-lf0-f67.google.com with SMTP id n3-v6so26115671lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GXAQko7abApR6xOpl+PI/BsLteY/Htwlxob1hWazZfw=;
        b=bru/gg3HRB5pomdPUaCcfiD0YFoE4fTeSJjlMHnm8455xfO4Ila7kf1a5ycHOYbTOQ
         kV5ZvqJ7OhFxEvMe1yJSr8q3z+ZVt7XIuXihJQ7fXiOXpedQNNoQmsDMpVeXHn+39Kzi
         yBr/rsI7EE275g0sKhx5vU33qRUburTmdFeGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GXAQko7abApR6xOpl+PI/BsLteY/Htwlxob1hWazZfw=;
        b=I9ekpP8SrWHTELMGEP8aI2SirBMGfwolw13FvteDgSP5s1rqsLFeCcoN4S1NYsYDca
         vANdl4148Ucq+b68rEzCjFCQ+alxpK5vYd+Ky1gC2sIQUkCuXXtKoKPxVhNH7FIipvRh
         KATCP0dhxyBKWgWEXIjqVmj0aaGLLcoeQdd/H2YQ7u9BE9xxe3O6q7Xy7r+H6YZfbiJZ
         qusUpIvAv+jPwSGf/UWDX1AVK6UDca7tMdMlKuk6Nj7kAJ0pL71lZ09ybFdDOzpYUZjp
         2EEu0ZpqE+cxY8A7tVcDeztT7iyaAmvl2FpJOlBrQxDvJ8swGpdoNV13NXvjF1lFqdow
         r4+Q==
X-Gm-Message-State: APt69E2GbRedWiUC77tvqBAkAa52EwCZ2G94PzoSEVgWA5xiDzWpaJgv
        aIxYuyvN34oBDskAv3tgJPQ5zDNjyvTsYSSbu17txA==
X-Google-Smtp-Source: ADUXVKJMljkcxnzhVIzQZ0HijIZNDg1v8Kr3hZCapCiCE8aitK7nu2mOOZaNDYEM0WlQGqz/cP4cq2S12z8UDnOKjtY=
X-Received: by 2002:a19:944f:: with SMTP id w76-v6mr8236632lfd.90.1528621584218;
 Sun, 10 Jun 2018 02:06:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 02:06:23
 -0700 (PDT)
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 10 Jun 2018 14:36:23 +0530
Message-ID: <CA+G9fYtdPj=yuANi7S3fvRn0B5ff1jQocktB2Y+yV6MtTBiDVg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/41] 4.14.49-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
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

On 9 June 2018 at 20:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.14.49 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Jun 11 15:29:07 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.49-rc1.gz
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

kernel: 4.14.49-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 8a073119a25f3a91734d482e869c6f8203cd6171
git describe: v4.14.48-42-g8a073119a25f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.48-42-g8a073119a25f

No regressions (compared to build v4.14.48-43-gcb411db6da07)
------------------------------------------------------------------------

Ran 11405 total tests in the following environments and test suites.

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
