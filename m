Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA86C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB31720875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FD+uJBk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB31720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937372AbeFSHoE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:44:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41996 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937310AbeFSHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:44:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so7227567lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SL9kqE4gC9WEiP8ZVS00isWRMb/KcvkqdW7V3H/mMw8=;
        b=FD+uJBk4VKt6Ib7+pPYBpFn/aQ6bYzqXsvRYkkJ3HZ21Y2i7m9DQChGaTQeOADJWz+
         7QtDxzNxbckzKvHN3isjVoUxImJwKmGS4yMWrS21Hyzrd6j6q4rmNxKVRQS1OUUITReK
         xQe6X6TvISFwqXJpK1v4E3JGOq1k+o4EVdc+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SL9kqE4gC9WEiP8ZVS00isWRMb/KcvkqdW7V3H/mMw8=;
        b=AOEQxgK4KxpDiKNI55ipLGjrMu5VwS3czJyQpCmBVRdwyTMD+WKGDM5qrm+00+hadI
         bEWZQ1pAH5yvQglOCU4XLziJYi+7KKIY2kXvhDQ6+d7rxw1uV2Yf5yNyQjUVYTar4IT1
         AWaeUJ47iVsW0ztRDRuaST017i19iE3b9obKSU8EIuoB7IAKPsGho1q1ng2mj3+4xiDk
         JMfFFlrUpn6nChUbi9np2YtERPm0cXq9THstr+kafq0UVZKYsVzfwLhqtMTNqdhLNUNU
         aEJk4NGfKOXpVxeHjNjnj0k9glf0Qqn+g9YFoM5GhWX7dcWL1B5wd5qNfsXyyQ+CbipW
         SrMQ==
X-Gm-Message-State: APt69E0tqK9HZXH3HWZz3Pc8Y+hlLnyrma8CXpwFo8a8L4tWk/V2ePAF
        tEayd2BNQAVnRHL/o527yWWmyOVhHhi6ZWIWq56vHg==
X-Google-Smtp-Source: ADUXVKJ1IMeE3cXBrqTONRxWHb0Us8C703HKQUHJacQY5OHZWIYhS7m0BbvhSqF2CmDEiW1RxhF9G0USecheradRLD0=
X-Received: by 2002:a2e:2408:: with SMTP id k8-v6mr3050289ljk.95.1529394241460;
 Tue, 19 Jun 2018 00:44:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 00:44:00
 -0700 (PDT)
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Jun 2018 13:14:00 +0530
Message-ID: <CA+G9fYuDOb6hdSRW6KUE9S6FHB9-dFCzwX09Tb_DsSFPf8EjDw@mail.gmail.com>
Subject: Re: [PATCH 4.16 000/279] 4.16.17-stable review
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

On 18 June 2018 at 13:39, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.16.17 release.
> There are 279 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jun 20 08:05:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.16.17-rc1.gz
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

kernel: 4.16.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.16.y
git commit: 957de898f0f3aac469028d303d1384bc0a975e93
git describe: v4.16.16-279-g957de898f0f3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/bu=
ild/v4.16.16-279-g957de898f0f3

No regressions (compared to build v4.16.16-280-g893364ab48d9)

Ran 11514 total tests in the following environments and test suites.

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
* ltp-filecaps-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
