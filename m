Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7B7254DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNX6iFRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7B7254DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeFYGnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:43:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44779 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbeFYGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:43:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id j26-v6so5627233lfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZyfQG4PDpNAEanlR4B4nL74Sk1ZUsFxmXWFZlb/FELI=;
        b=PNX6iFRoYkMrnAtej978So7d8/9D1NJkhGNKXl8avcPYY7Y+k5ftqOy0GngQSSIUcE
         iPZ2kOHqBzi1iaGodP/ZJgCIeWr6I+9wvaI0+iz1biEY0qAD/2+D0BxtzPTR9cCO4R3X
         JL2gPFmGfqJD6rhaeozoY34KxVmDNeMb/XzPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZyfQG4PDpNAEanlR4B4nL74Sk1ZUsFxmXWFZlb/FELI=;
        b=W5ucApYMDhiHnRuZ5KYXtUSPAdZjmaDKkrD0UYKq16kb0Pp1oVG9wgBrYjPtwI4hdz
         ituh1cX9nHY+HCTay+TEH9FJemudgX2/nm3TvlhMU7ZKbGfmjHfHtx0yG+hQXUtgmnYG
         XPPH4OdVlGGfoVJIyGc7QyDnONA3ic6YtsL/DqQQfqW7lJcMZQpsigPHYmvOZXAdb4VM
         k23imesOvQk7RZ52hts6q2Jm/R2msKl97FUCO0nmuj8wIfwdMncNN/4e58DzlEuFqfbb
         WOkFwA12pvCeXRjHM0u/BmbujQiM+Vj4gxpmLpMpSaUnWoXFUvAsj3tLtGytVxZ4jp88
         zvpw==
X-Gm-Message-State: APt69E0zRMnd5/0nil/49WbzpiO/mrjM10gU44ip9nXEtkwitY1MwMxv
        11aXveEJO5GNlTQtQdE45MGBSbKMbCSCIBib9dGi3A==
X-Google-Smtp-Source: ADUXVKI0fw8BdwEvFyXGbuP9svB2Z1A/kYGIIP+qTgSCPGH+PjL3tTHI9I2TViXNtVZmuaAhEwntQTHZ5h2bVBTI/+U=
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr5159462lfa.43.1529908993655;
 Sun, 24 Jun 2018 23:43:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 23:43:12
 -0700 (PDT)
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Jun 2018 12:13:12 +0530
Message-ID: <CA+G9fYusQviGQdNZe_fz1ju=cumSmcYvW_8Efh_GO3O526hQew@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/52] 4.14.52-stable review
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

On 24 June 2018 at 20:50, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.52 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jun 26 14:27:24 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.52-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64 and arm.

Kselftest test case mov_ss_trap_64 is causing kernel panic on
qemu-system-x86_64 and PASS on real x86_64 hardware.

Reported upstream,
https://lkml.org/lkml/2018/6/25/19

Summary
------------------------------------------------------------------------

kernel: 4.14.52-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 197647acb3aff4711772a6cda73187b3031c57f3
git describe: v4.14.51-53-g197647acb3af
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild\
/v4.14.51-53-g197647acb3af
^ please join link

No regressions (compared to build v4.14.51-12-g6c12052ba18a)


Ran 11468 total tests in the following environments and test suites.

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
