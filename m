Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C5CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C42086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UF2kiaeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924C42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeIDMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:47:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41018 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeIDMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:47:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so2231297lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uUNFNDsjeFhOAuCk7YbTvL3S5bxc0TcJQLIqL+6OC24=;
        b=UF2kiaeWyHtN4qZGdJ+8Elu8imS2zVgQgvIrDAvJej32Cvet5JxzI/QZTZrBjkxk61
         CWfWiXiZ76c9NNahqHtDdWLtPcR5rsshf0GsLka5zM9oJ3W+4S4WBNQ/wltWwhUxTQtm
         Wonl58oRYYxksGsdeOzmTTC5RF+uqOTKijudg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uUNFNDsjeFhOAuCk7YbTvL3S5bxc0TcJQLIqL+6OC24=;
        b=c/Xxai35zItjooovtnIwoJ8Y2554vIRy6sIKp59lxwyCK8SrOmEV3B9NzUHE+aAiU6
         vSixAd5wYRp+bjaTJ1ZoQGs23DQBsJLQri2uAdId72e4PluzlyNe9Fw2eUS+npgJJb8c
         h+Ald8UNrrC7mg3Khiwzc8xjw4YHTDMPlBtqFVeA9XWsIyW/oQsm6llvxl4Ks1ihQvwp
         jbcG/hIEkPFTk3ReDck9GmgYuJZsO0RJI0zSJeZORInkn0k/qKyvoCZ2pSeVxMBELT3d
         1ekeBd1LlX7JSpUNx94tB+r9YykQ7V9PSFe9WJ4nQC3jtjPEaxrvanEJP6RRlP0J5wNC
         ZWTw==
X-Gm-Message-State: APzg51D8N/0LQdqu+gltch04JSiYpnHg1zIuYu6JGCG1VXGFplfjpYWi
        Up1y4244AP+0jJEi0dqkW0ripg/U49wnrMRxA1bRsQ==
X-Google-Smtp-Source: ANB0VdY+V6AbkakeAklLYctxfnGGl4+Fdw941rpnh+xMShfs3DKORRIrZKWqDC25a26MCElXi7Y+XdMtxpn71vuy770=
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr20650264lfg.68.1536049431100;
 Tue, 04 Sep 2018 01:23:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:180c:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 01:23:50 -0700 (PDT)
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Sep 2018 13:53:50 +0530
Message-ID: <CA+G9fYvzcUonik6zhJDLbbNnrmEed6nqSOYv6j5Ezi_sQndVhg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/80] 4.4.154-stable review
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

On 3 September 2018 at 22:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.154 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Sep  5 16:49:18 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.154-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

x86_64 and i386 testing is still on going.
but qemu_x86_64 and qemu_i386 were finished.


Summary
------------------------------------------------------------------------

kernel: 4.4.154-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: c9eed05cd5dd6431baa46476df2cf05e3c7a36c8
git describe: v4.4.153-81-gc9eed05cd5dd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.153-81-gc9eed05cd5dd


No regressions (compared to build v4.4.153-81-gcca2878104c8)


Ran 16784 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.154-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.154-rc1-hikey-20180903-275
git commit: 7048ee43ee3065e53fa65eeed32abe4959e136e3
git describe: 4.4.154-rc1-hikey-20180903-275
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.154-rc1-hikey-20180903-275

No regressions (compared to build 4.4.154-rc1-hikey-20180903-274)


Ran 2722 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
