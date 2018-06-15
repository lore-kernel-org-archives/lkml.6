Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8C2B4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFE020693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RA1rL8Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFE020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965328AbeFOA2g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:28:36 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40839 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965151AbeFOA2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:28:35 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so12098410lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 17:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fr+g+GqMCuCy5RxJOa+yhMQ1kJm4fMolVujODwqFWYc=;
        b=RA1rL8QhFTfcsoTp1XBaOwgDoSPk7XD41bDOnudXicmLa+06aNI8jXe1ZdMLbwuJbJ
         iTMPJLev9yQQOREDcE29SjKHmk7WZgnNpySeIZMe9BsdAnqRAWcB/Nnr9CRh86csmxIb
         bTlc1NQOtu+UJWVUAPgXb1vR2WFA7pJ/9sq1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fr+g+GqMCuCy5RxJOa+yhMQ1kJm4fMolVujODwqFWYc=;
        b=YtozOewi2xX621umpcghjaXvC3u0HlBJITNkkbNq9xhFSli1VKKSTYYN2udcDyidQt
         psUW2GVtRUFPTiDLL7qZQ5QW+qfTUJfBukw3jHSJ9EHYwPQPonYLnpOsGk0IR36BfP/w
         +qXQsT14wTow+lGPZ/SBorcm+xI5bskqo1LHSYHjxmnIGYABwM8pagYKwjWg35Yo5RFw
         jlCjl6xVJSc/CyurYCYHQpVcfdC6+ozVeLdvqSGgRstMWcH521AthnycR2tVJbQHWVMK
         v6NIP4j579zozzbkLgFIlrjpge6sBNky0DOgoQvX1q1ONedH8gvRb9skwDgQzx9TdXLk
         S+Nw==
X-Gm-Message-State: APt69E0bgoyXXIWqBXoS4ztJBGvnkrFL13ZOy5knMPii45kspSvAWvZn
        ZksXc4IJ9NFbuHuRRR8F/g1tmScB+hk4NnAIK3qCVw==
X-Google-Smtp-Source: ADUXVKIfOVZD3mO+arUapPt7kGLLOX7crAsNiZL6Iuxm+25bkFFI6/i99rFHYcHp8G42fQDKYnav4lu0NUVYKIaHk/g=
X-Received: by 2002:a2e:2408:: with SMTP id k8-v6mr3236725ljk.95.1529022513698;
 Thu, 14 Jun 2018 17:28:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 17:28:32
 -0700 (PDT)
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Jun 2018 05:58:32 +0530
Message-ID: <CA+G9fYvLk6QCmicnd1kkQ9asT+UT=4TRy=JJS7P7bOV76tW9qg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/30] 4.9.109-stable review
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

On 14 June 2018 at 19:34, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.9.109 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jun 16 13:25:48 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.109-rc1.gz
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

kernel: 4.9.109-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 9778721e03d9551ee231bf73f4b4fc418e1ad158
git describe: v4.9.108-31-g9778721e03d9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld \
/v4.9.108-31-g9778721e03d9
^ please join URL

No regressions (compared to build v4.9.108-12-g311d47aaa645)


Ran 11388 total tests in the following environments and test suites.

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
