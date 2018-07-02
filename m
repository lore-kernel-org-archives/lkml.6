Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E435C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D825DAD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrXXGEWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2D825DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeGBNW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:22:29 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37871 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeGBNW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:22:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so2421588lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TMH3ufA4J/4rwdjeXn3iSCiebTDA2+5OEd6SH3pt+VE=;
        b=jrXXGEWLW4Q66ualGwSz63dQdpq4xcigC4Zq7vc0Kg56mYH9+zmLgZo1EwPtJg6qn5
         5iVRCRRjAU3psYpkUCpsflWKhblcq7hCRaW0fLGU/epIlimroVwY3mjW0tSeqT9Glcsz
         VWMcUHlvACUnStVrfU+3fPs3yiALXZzrhB8r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TMH3ufA4J/4rwdjeXn3iSCiebTDA2+5OEd6SH3pt+VE=;
        b=LSNQZw4smMKNSVH/f6k6olH7nH60HIkNR/IYJ79zO7MjGI6fTT2x61k1eQc8Gg/ugy
         EmqSGNsOjGYV84gQvVf4wWSQEh5chi2ojYVez9NvlaRNPKSSp3Q6WB+BHFPmPpsKRjtb
         ZW0gYT6ppFlWlJy4jnceFgEOUBjxt5lHtw1LEvmrg69nrQOobT9dJAKWOFmDELD/Fg9g
         5flY1gt8p1WpSoQnsuWf7vQuZ4gwL2ohMB85VgCjkoTQLX/rOCPMtbfXM6tQ6O7fybr9
         TRVq1tvgu1+wRpY/hUFx2ikX78GbMAQ+zh7f92MpoOSxFOYlpaldXtRDUDjdTnCyhvgw
         aRrQ==
X-Gm-Message-State: APt69E2GJuytbYIs0CJ4Bxhyvtg6UfUbA6ILVRU6J+W7J0PYGjeMWiyT
        naumvYKYelKinsYfq5u+fo2BH1gAK54F29tHurvpiw==
X-Google-Smtp-Source: AAOMgpcELQWoG0mI2gtaskCu/iz6+KIpohGpmYLYDzKiujcgCcW6bsPodhUQCuljdEu7di3c9Sr8r4OinvKjIJKOfIA=
X-Received: by 2002:a19:e955:: with SMTP id g82-v6mr16037768lfh.44.1530537746624;
 Mon, 02 Jul 2018 06:22:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:22:25 -0700 (PDT)
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 Jul 2018 18:52:25 +0530
Message-ID: <CA+G9fYsxP+-2R7M2LRffmwmucWNXPnC4J75C3v3CV6n+2iDOkA@mail.gmail.com>
Subject: Re: [PATCH 4.17 000/220] 4.17.4-stable review
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

On 1 July 2018 at 21:50, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.17.4 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jul  3 16:08:27 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.4-rc1.gz
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

kernel: 4.17.4-rc1
git repo:
 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: 7cde32fbe2ccb991623eb74b50c45abf51eec58f
git describe: v4.17.3-221-g7cde32fbe2cc
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe\
/build/v4.17.3-221-g7cde32fbe2cc
^please join url


No regressions (compared to build v4.17.3-222-g5cff622a798f)


Ran 11389 total tests in the following environments and test suites.

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
