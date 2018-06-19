Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F568C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A122083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3OF4kG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A122083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755920AbeFSFxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:53:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39243 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755783AbeFSFxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:53:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so21801882lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2MTVAUf9I+Saq00m84qYDJAGOLc3ExRaeFlCVUtzirI=;
        b=Z3OF4kG7Iy6RT9Aj1ZkhfuAGd38xfJPhYlCF84JhGxA9tuAjLCO5OUhl445WpYxiJX
         jxBlTc9vAEgSF4F3Yml5z0cjG0NptCQze9yupWiVHBY+peUVlnI1cRfELOOhBkUfuo4M
         ibCSZftr7yHDnx35tXNerVFYO7pgCEd6Nqu7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2MTVAUf9I+Saq00m84qYDJAGOLc3ExRaeFlCVUtzirI=;
        b=tvdHrW5CTKotCf5DoIsy78SF5lVhSLnhK6ZbSH7WS/L7ScD76wdccttnoBw1PFaw0+
         xtwlyNaPvT3TnhG4e1Ggcmb2o4d04jRWsUhzs4EE71d3/yPgCRuhEThehlLH08RsmFQJ
         Lop6LKeDnhAkF6kM3BZYbqYTeN2oqXAaA/QKAmygcr4tqFHBmJzgMZBXeipR7BpUXZkS
         6R8vZIKNNstY6XlvesZlkFPngdbpfMwYmTvcrkQlp/jRsQo1kIPY7cIxFM03PBgFpfDC
         8Lcf7C2ecarRLnlZe50qXSaP4UFSq1HDQzgDkA9KFRNp/Wx+GwRHEizSXm31qi2q0eCk
         Yfnw==
X-Gm-Message-State: APt69E1oVo3DAv1jPX1zqT3iHkV2hKMCjjOoCIBp5dWw1Q2U2chcY3oU
        Nq1FGg/T2LWWqZy5JYLspAS0Z1RdD8WuJdx8MbANsQ==
X-Google-Smtp-Source: ADUXVKJ0ozce0vxTDamP4YXs9jXSTPuxRTKQmH0eVH+PiFi1XZs2e/2t7xLhNYtKt/tosDs0pmIAW28aQdFc7/785oI=
X-Received: by 2002:a2e:2948:: with SMTP id u69-v6mr9843894lje.130.1529387623775;
 Mon, 18 Jun 2018 22:53:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 22:53:43
 -0700 (PDT)
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Jun 2018 11:23:43 +0530
Message-ID: <CA+G9fYsW7-G8af_x6bJuQ3Qj8ZD3FZkv6VVF-ERckUobEHzjrg@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/189] 4.14.51-stable review
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

On 18 June 2018 at 13:41, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.51 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jun 20 08:11:38 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.51-rc1.gz
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

kernel: 4.14.51-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 3e67e2023733ff0796077205a09178330bdac357
git describe: v4.14.50-189-g3e67e2023733
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.50-189-g3e67e2023733


No regressions (compared to build v4.14.50-190-gc758a48da7f5)


Ran 11416 total tests in the following environments and test suites.

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
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-io-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
