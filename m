Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B34C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D8520870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQaT1ViL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfAVNlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:41:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40717 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfAVNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:41:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so18085792lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8qtZ8Pg9/M16ifJgjRXGukjT2HTvXYYztb4sfXP7XjI=;
        b=dQaT1ViLqwaXSfa+8ZPq6ykCUCrMXI7svfm3kdlK81Et93r0Si6L+0qS26MLpB2+b3
         WNEDwLDReXwaULjjTw65D7AsAcdFLV1zofXGK1RnAlPzPRvtiKdYoiazsnFiz+P4Cp/r
         6+Tksfz7HZh5SQPLnVG0dTk6Eeu/bdjAqsBPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8qtZ8Pg9/M16ifJgjRXGukjT2HTvXYYztb4sfXP7XjI=;
        b=iECrmSydw/UwemleN8bUYy968avjTma6121mgL9LnxuDVE8IxV7644mn0LXWLfTJp9
         pgD67gvLjYje44S1DPExrJIsfkyTTqVy43ifyjPlux1M7LOK5IROYSKS16D+oZWizAE3
         NKRkbvQoRM6G9NDTmSE4pMqlvNpWuFfxZgFcKcPXbBZV6teOnZAufZVJJgx4P6RyeIui
         QUpjm6esdoo1809jd62yqAQuIew0+8sLi+9I5jqjoBObku716NsLxKZU5mAnZt8pvfcO
         bEldXNegsekFdLRDPc7ADvSVN6TmrVqenjOYlc50R0PInk2zB1mOuM/PukmPDiaaju0G
         bLpQ==
X-Gm-Message-State: AJcUukdLlFT6B+Nyy8h7y8lp+RnkC18D3tnWiTC+ox5NqKEOmm09Z8ve
        nQgp/uOyH11LlH+iwxZqjsvtMIuh0cN7Ntqkuxn9caV4OkqGHg==
X-Google-Smtp-Source: ALg8bN7SJ5W3HJjnrM959F0vK2Aqnov8t/wy73dHWuGujNkGiHm1YPVyUEPkKyMCCLFAuQmZ2Nmmkc1u5PFfE821ZR8=
X-Received: by 2002:a19:10a4:: with SMTP id 36mr20755210lfq.60.1548164461885;
 Tue, 22 Jan 2019 05:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20190121122453.700446926@linuxfoundation.org>
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Jan 2019 19:10:50 +0530
Message-ID: <CA+G9fYtLw6kTAT_hPrE0aK2y++bD6hp2R16DKsCpM1OrdGNDpw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/51] 4.9.152-stable review
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

On Mon, 21 Jan 2019 at 19:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.152 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jan 23 12:24:02 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.152-rc1.gz
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

kernel: 4.9.152-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 5e5ea6306dfd1c05e5a09b0c6859511f9c7a2c5c
git describe: v4.9.151-55-g5e5ea6306dfd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.151-55-g5e5ea6306dfd

No regressions (compared to build v4.9.151)

No fixes (compared to build v4.9.151)


Ran 21456 total tests in the following environments and test suites.

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
* ltp-cpuhotplug-tests
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
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
