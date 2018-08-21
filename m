Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AB3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8DE2184F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMwORdlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8DE2184F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHUV0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:26:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44044 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeHUV0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:26:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so15012957ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L5FSfhi3IiqUlk2WtDuBx1dwSaTf14zDicoxmEeDI4c=;
        b=AMwORdlZcaqE62RzNm6p/KY7YrH0BPfCDrad1Uyy/ouVzAwopE+agU+YjsoltDMjpD
         7iOlcPnnjHe7ZJaEq63WLltxkH864KSUAd4kHRloHdKUPaf4/n0uNl3FfodOJjKQuy6i
         /Hmko5WJ8LQy1CaxsJ7B6SHqvvklmWkmq7yK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L5FSfhi3IiqUlk2WtDuBx1dwSaTf14zDicoxmEeDI4c=;
        b=C2FOfi0r1KvchXh1Z/0e1ugfdjwaD542bOVQsmpk6Ei+8atx+R53IQTHSH8awN5D9/
         pSN2NWox4PouD7A/5audYSo159nNf/qX+XrcNH9BQtjTCV6rgi2QnLSsfrvz/TlEkERY
         LgUfSp3iQg+jgjeHZck5GY4lN9Zg7PnCadU1BscagobzvImrLZDTRZVIdZ6WlE7GzXgr
         PPq1qbF0RkEo3nteC3nUftkAc6qBGwCiGVtXa+bparSQzNTzF6oT0z1/lG0ntMv63v8A
         GzIL55XjkTeJFkxORdG9Ny8/oR0XlveCfkGfW7MT7v1zGiW6pBa66m5j2YWVSLFglSMQ
         TBnQ==
X-Gm-Message-State: AOUpUlE9BDe79djZlp0sZIqoaF5I+Ux1knV9b4wDEqQ4BC7w7aing8w4
        XYkIxTwvOIzKGiqhJUAlClxYudQMhe9SccR5ggdGOQ==
X-Google-Smtp-Source: AA+uWPxpMxKYohRIG52MK1UBN5s6ICrh5U7ABwXuZ7A5pSBArrF24gv2K/IbN88+xjsfYl75cn2+HOZ+vsdPC2u+t40=
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr34482488ljf.67.1534874695365;
 Tue, 21 Aug 2018 11:04:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 11:04:54
 -0700 (PDT)
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Aug 2018 23:34:54 +0530
Message-ID: <CA+G9fYuV-TWx9WtgrjuoEPUmkB0AAwSUEn0ZcGiaCBSkBKGaTw@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/42] 4.17.18-stable review
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

On 21 August 2018 at 11:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.17.18 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug 23 05:50:04 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.18-rc1.gz
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

kernel: 4.17.18-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 25f352f073ea4269f32a899934072061ddda59a9
git describe: v4.17.17-43-g25f352f073ea
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.17-43-g25f352f073ea


No regressions (compared to build v4.17.17)


Ran 16734 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
