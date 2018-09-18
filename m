Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF6ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C192150D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdvQbsb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C192150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbeIRW21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:28:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42772 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbeIRW21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:28:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id e11-v6so2486620lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EXnW5nNBjLhlX4CGDp8+rj5Ik1Z/gf6pLTOggI4k1qc=;
        b=gdvQbsb1iqvR3YcU0o5npekcpp/QMrDPyjRGLczYYKaDyWmDElPn2cw9xATSDNewI6
         Iqq7lKn+5oG6/k8ztGC3tUipihZaPvE+Rlrro8MltaBhzcLr+L88MUQdfJYmuxdcw6la
         X/ph4MipiLE0+8umPbqEaLtMuWmQ950x3U6II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EXnW5nNBjLhlX4CGDp8+rj5Ik1Z/gf6pLTOggI4k1qc=;
        b=XlJ/zeydcpJpd5oDItSBJlz/Em2vlqr/OzHZEuq5othcDIk/e8L7DIE52h6F6+cZU+
         YeGNkt/NqgLR1DD8cQIHcAoE5/jNuhy287ICRdRwuj/lSPZpFRlMo1novIRDtXQBzZF2
         /hIcefJnb4U0fRWDAQ3BLuGFnNu3qDU4KGVSl+BsYNOzwo3Cvuxnxgl9HeIGnOSA5bVT
         YcGEmvoMrbpS+8quTt5CNpG6lZ3AxCucWLnsXloqQqtNdaWGg7jGKdE6LZ7gvMqYd6N/
         j8nViUpJXi2tFnZG/O7JDsacUY2Dns9FfiXZkfoowY9zNi6g6UiICWUwwWljtK/bwhTd
         BBiA==
X-Gm-Message-State: APzg51BQzZQZSkrn7+qz7koDmFILaLNhcmwf3MKttBSPh6IYl1Wj7w2U
        M37CEXJZK76Z5ACKhhBy+xXxNPx6X33I62Gt7V+zwg==
X-Google-Smtp-Source: ANB0Vda1JQkyEP0Qh2KaCtFKoS0nggU+kLeuJXp/NjFy4VXrwsyiLR61HHy2KnSpJBnKYeH8z3liR/kTEPCzvJ0IpHo=
X-Received: by 2002:a19:988a:: with SMTP id a132-v6mr19673992lfe.76.1537289699517;
 Tue, 18 Sep 2018 09:54:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:54:58
 -0700 (PDT)
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Sep 2018 22:24:58 +0530
Message-ID: <CA+G9fYs0rVehuVVrzNLxAZK4OQEtfJoFH16bq0+Ut1NGTMTXKw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/70] 4.9.128-stable review
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

On 18 September 2018 at 04:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.128 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Sep 19 21:16:09 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.128-rc1.gz
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

kernel: 4.9.128-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d383414ab8f26a5895eec6bda54bb2834c7c79d7
git describe: v4.9.127-71-gd383414ab8f2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.127-71-gd383414ab8f2

No regressions (compared to build v4.9.127)


Ran 19546 total tests in the following environments and test suites.

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
