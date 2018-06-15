Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7BC5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9020A208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwdp5xhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9020A208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965385AbeFOAvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:51:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33797 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965325AbeFOAvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:51:02 -0400
Received: by mail-lf0-f67.google.com with SMTP id o9-v6so12178026lfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 17:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YLWH96P+Siwj+DYWpMvi3b7NaOzvQ55KsvcB8sp8B6Y=;
        b=hwdp5xhvNEoDrH0mX4tOLIoCz+Y5KBI88eIoi438EVRENhJVjBNOBLGIT2vUfWcG9W
         m0rBGdtIKB4rvNSYMXlllBb+2+z46Kp4jlHKtEt4QZJX8A/i9YpzydtJSgtPhvfiRek1
         vs+jWtyNunRBtWL09Pg44GglOSooRvOYkcqq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YLWH96P+Siwj+DYWpMvi3b7NaOzvQ55KsvcB8sp8B6Y=;
        b=iXr3BXAltcH1kGQJFpYymIRq6lJ8c6ZsIj2blJ9PW9+/fiEgo+USgQswPun8eN4NHb
         m8BENlMLVA2ULGrbZQyQYkC/TQ3AFh+elqn8724WlKh3vORodf+assOC4K4e8JeRjWWC
         8h2KqdrheJfs4cGI8g2YZqHjhCuTT6AmRSC2gCjVRnqFV/dVNSn2hLYER/tTnbiJEB+N
         zOOvRV9ZmIdvkfMFBnqKog6j8IcudDABSBHGZgAhbRswMGo0ErZGZfGZDvMfSvp+6UFZ
         NMOk406hxBHHzRruOmdwrhaVaWiQmHmHlN1gYr/kXX9r+G8WEDKHI/VTsScw1yvc8Yc9
         qHYg==
X-Gm-Message-State: APt69E2mINltsKfHnOmKXeK4S7Ida5DXvf8pUkrFcoleGyl0MiGmlF+9
        ytqKBfsubqkRZ5gNxXiK9PkErjNibU+6AiRfnPBf7Q==
X-Google-Smtp-Source: ADUXVKKX6BPyXxrrCXfYGS93EDCyG7rueIpJdNgsEe2nucpGl6LewR1BBrpBkU7XLYn3j6mnJGgTNTmae7hyHsFVZuc=
X-Received: by 2002:a2e:9789:: with SMTP id y9-v6mr3346817lji.52.1529023860714;
 Thu, 14 Jun 2018 17:51:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 17:51:00
 -0700 (PDT)
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Jun 2018 06:21:00 +0530
Message-ID: <CA+G9fYuHqjnDfEeMF7e=TXfdv26VHSQoZeFJcmEqXw4CSVoBcA@mail.gmail.com>
Subject: Re: [PATCH 4.16 00/43] 4.16.16-stable review
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
> This is the start of the stable review cycle for the 4.16.16 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jun 16 13:21:17 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.16.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.16.16-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.16.y
git commit: c61f86d679044facaf48c475eb4edb7e6c2d8d22
git describe: v4.16.15-44-gc61f86d67904
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/bu=
ild\
/v4.16.15-44-gc61f86d67904
^ Please join URL

No regressions (compared to build v4.16.15)


Ran 11513 total tests in the following environments and test suites.

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
