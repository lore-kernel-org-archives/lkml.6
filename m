Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F478C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F6721854
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3kQCsom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F6721854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeHEN5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:57:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46619 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeHEN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:57:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id l16-v6so7065608lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lOdqG5EK7elnlplphtOW7IwoyBRSMK+FswzxA8xgfAQ=;
        b=c3kQCsom61XblxZhZKQjmshLwncL9eu7wFme0xEN+XJw4MMXlIM0/0FMTvLM9Ehn2t
         vQVp7/7WP8+2Kerbg6UuwOaOBz9Z7yHURFwU/mA0gXDL9xz/cfnHepvpBhQX65Xe+KlJ
         6rCWtX1sc0DJLAXhb4XPPigc2PlZGmlOwhAhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lOdqG5EK7elnlplphtOW7IwoyBRSMK+FswzxA8xgfAQ=;
        b=d+hcIF0ec+wcFMCQ+pZOOxVban59sUlOeELPYyDRz7t/2/unuvrkPUZbnjv0lWCaAM
         mXef+e1symnYvphmvF52MKpfPJ7sz6zDqDIoM52RbdI4/kdBiZyydrjzF25QducY1wTR
         b9Lwo3NpLQKRDAylm8guOmQTDte13wBmuaCbHWK4iAvbkZ2diWf/eV+FxSmESSVzTW7M
         bWpS1Ns3Oy5s9K7EJTf+pkbgVAjCwmezg6SoRPlfcg1pdBQ/vovtuFtrRMsUE743s4Q8
         p0UXokExMmHadRfm8E42zxYTwVt2yPETP80s4DjzMlgVE68lY1yaCSp+boGQgTcztPgc
         Y50w==
X-Gm-Message-State: AOUpUlHvwQta9yvIVDY0lkEdOivOJrCQTqX4uV8+8VdLJGGlfBwc9mQP
        U9G0/BHSJV7bIPqUZSAceUsJfeamCUsJXHcGn4QH+A==
X-Google-Smtp-Source: AAOMgpd+05fl8BcrvxlXRTXimyu2twHKnInR150nUsEiMaEThlxgYF6zJ5TJ0Gqg0Kla36EdH/DPesb5YX97zoZEgNg=
X-Received: by 2002:a19:9345:: with SMTP id v66-v6mr9332359lfd.89.1533469982358;
 Sun, 05 Aug 2018 04:53:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 04:53:01 -0700 (PDT)
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 5 Aug 2018 17:23:01 +0530
Message-ID: <CA+G9fYsNvi282Vrr7_k981Zsp7Q8Hf3=zkB=FNM6dsr8tcEAbg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/32] 4.9.118-stable review
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

On 4 August 2018 at 14:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.118 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Aug  6 08:26:35 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.118-rc1.gz
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

kernel: 4.9.118-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 54552119e851c10bcc103f36c19901d2239b751c
git describe: v4.9.117-33-g54552119e851
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.117-33-g54552119e851


No regressions (compared to build v4.9.117-18-g17b0ebc4dc40)


Ran 16223 total tests in the following environments and test suites.

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
