Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A65721728
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aua4agX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A65721728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeHHHkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:40:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44439 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeHHHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:40:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so639450lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 22:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+vUdXWAldxiiScUYKcwga2t2eGeI+8IGYLL83/KMJ+4=;
        b=aua4agX42z3kEO12mBu22DC2BIXP/F7WeDo0L65xBCnY9dBaNZi3643jwvRcbXMLZf
         GHkU2b2V3yNew+2Tw4BAcQfVuMM1tKjdBNY2X3o2W6nxd46uvcDnLDqr2ryLatG82opU
         zOGhcPDO47/3I1zSPCkOB7wlYsTYsBWnAXd+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+vUdXWAldxiiScUYKcwga2t2eGeI+8IGYLL83/KMJ+4=;
        b=fNaO1fp+4ouaAFgBza3biObdjY99EDHNIQBxHCIPqZaQ2ROwj3njG5y2GHTUyegwso
         cJepkWxBDrfO+uoAWu8j7Yy0Jt8Jjb0OdNoW/TAMmioYZquVONmQ+5rKnHqA/GxALMe/
         /Djb+GWMcN/WCPx1cgEWpGzpZjQU44LGJvwstnAooiMs8T7P2466iT9SqXKSeZGkZFFq
         CkXHbwrHyK53dYZo6Ra5U9OX0nIS0tp4girsLpK1yaEMPqARDGZgw50qEjRri6/ziG+y
         pIfxJaqkzzVbV0vhFibc+Oa1pBQ+klIhjA9djKGqmvGR+X2Q8lOGYYOiBu/oYnSS6WDZ
         0zYQ==
X-Gm-Message-State: AOUpUlH/MCpUeKsd82GtRk2+CcMvtjhdGUaB8mlRxfBzLM8XDBMIcT0H
        n9K9NZWSjldFRLH4YPXyareSkGJS/4y6On6FcRCTnw==
X-Google-Smtp-Source: AA+uWPx7WP0/JDazdTy2nEt3a3zGbB3gBQLQwiLvzAvhWqCok1Ou0Ik3dHAIK2rPA6zSlu0TSqwaOsfhGRP14j5ihzI=
X-Received: by 2002:a19:9345:: with SMTP id v66-v6mr797471lfd.89.1533705774427;
 Tue, 07 Aug 2018 22:22:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 22:22:53 -0700 (PDT)
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
References: <20180807172342.071526922@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Aug 2018 10:52:53 +0530
Message-ID: <CA+G9fYuVk-kSuzXjn4nSe8myTe_GSW2ydso39moSF2u3ZfRi2w@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/17] 4.9.119-stable review
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

On 8 August 2018 at 00:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.119 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug  9 17:23:30 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.119-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.119-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 1e9cd04e077b33f5dbecb2ddbc53695724b0cf97
git describe: v4.9.118-18-g1e9cd04e077b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.118-18-g1e9cd04e077b

No regressions (compared to build v4.9.118-17-g575cd33d16af)


Ran 15539 total tests in the following environments and test suites.

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
