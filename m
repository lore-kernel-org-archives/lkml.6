Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AB7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A420880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKgFU63h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeGXInX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:43:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34286 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388367AbeGXInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:43:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so2747979ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7hmikwJ2TP9fMPXins1MD1EDYhbQdC9FR1/nzJ+ennU=;
        b=GKgFU63hj/rAzWea1+cw92kBVDmbNYvp9I6oHAcCt/Jsz0pdu4XvJ+oZZ/seYYrKBt
         cmg22pzgYBAClyfRaXN2SELcnSAg4V6kI2/merUBDPnY10oR0XEDIhbuefDoyHaUggRM
         aKC+eMS4UnccmfePBBrg7+uFb+9rtb/aaiBTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7hmikwJ2TP9fMPXins1MD1EDYhbQdC9FR1/nzJ+ennU=;
        b=Xw9CNL8TovUkFm9rJiBxoQfa5cU97D1obHwZT2YbXfk3ikXTpOVpxPE1uKcOoFuW2b
         TKnzOQU8CmznvfWXr+RR5tjnHnJznZv50wFZhXdYDWBj8xyCwBz3vGu3wlZwQFFGUi3g
         ufHbuQS0lYhQr01/86B8AUbrMGQ/yCnA1Pz5U6/f+0Wq1cu/R9tf6gp57NsqL2t85eeI
         dTUxenOceEujrarzLDvZgzl8VG/4OaBHeadkKCLd3JO0s3ypHMUPTPSjXPIagN1wf0gn
         XZ+oj2HxKaGMeHBfK7+ircrp+UscObvDFrxTwGBYWIF9RV1w0ia7cfmUgcMCm6wsy548
         jmZQ==
X-Gm-Message-State: AOUpUlEFxjJhSkz95qtb/xCThcV2BpGJgty70dYdFi/x4azGSaSaTcuY
        dktcpwMm2CzGcQtoYRZrwvB6Q/TfJ1aDlR/u6UXrvR3PeqIYeQ==
X-Google-Smtp-Source: AAOMgpfzpESW7S8HLIzKqVWMDFS1B3sTpfkV/x+Ffe1FkxptJXc6Bw6IKwvQG94Mai6/h0+20NDu3iXqRAfPqp+FVfc=
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr10657247ljj.153.1532417893388;
 Tue, 24 Jul 2018 00:38:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 00:38:12
 -0700 (PDT)
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 24 Jul 2018 13:08:12 +0530
Message-ID: <CA+G9fYurRz+s2hD4-=2L2z2Z7VGHV2sgktxvnO=vkN4N8CafxQ@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/63] 4.17.10-stable review
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

On 23 July 2018 at 17:54, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.17.10 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jul 25 12:24:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.10-rc1.gz
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

kernel: 4.17.10-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 2ef7dcee1485aefb44ba4fdd7ed149147c542501
git describe: v4.17.9-64-g2ef7dcee1485
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.9-64-g2ef7dcee1485

No regressions (compared to build v4.17.8-102-g8055764ff6b0)


Ran 16282 total tests in the following environments and test suites.

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
* ltp-fs_bind-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
