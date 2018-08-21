Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20BBC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615521884
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eULyGbJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6615521884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHUVUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:20:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37578 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHUVUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:20:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so14984199ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X4lkUDLGKIT1fngsk9SRk/CdNpC5rQDCP3LkOqKWAJU=;
        b=eULyGbJToxoT4GCQhld1GDWPiFXw2c5CNDtMbYjkFKmtSO+prA0ogqoMQB6wa54or5
         QimtxnmkCSFImuJj9cQbXcYN+usJUwRaeejxcEOW5Cs7sjhUVBSmt7TToE/aLZmI2jCo
         +TxJpNUqEFfkgAf6DEZxTTxOG9eh2nqrypv5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X4lkUDLGKIT1fngsk9SRk/CdNpC5rQDCP3LkOqKWAJU=;
        b=HSvvBiCqMMJqYZ0o1JHLo2phYJEmbcY5Ri6r1B9uw9BJjEzqilLjnPQV09UFa49rwJ
         1CUTk3M7f9KIUOZsEdQ2/oSu2ubQ+BjLDmWQZ7v/jTkyBWt4SsIe7PWw6kJEd2urluFC
         PwSZiNHaP3ut7LD2X5itEU7+mdv0YsejRVLn5oYFpgjbUgkaEmKGeZpO3upPRgne8nmF
         l3SX0el7lJ/NHq/Wglbvk43aWbOKiV+mEaGG4DJyadyC4dFkrFiujm1ImFqa5O54h8jj
         VXt41BISRBtrIuxWrb8q76GucGWw26ydbiLsdEVmoEw52cI36wHEZRyHKS4XyF+eHKBi
         ZBZQ==
X-Gm-Message-State: APzg51C51JRhmtGnxikl30QFr9BSfbWl32JAyau+6EdoRHedteEuf0+t
        kSW/za5bMV8Kr5885tDGl7XsjXSh3XVS+wVQ0iuCng==
X-Google-Smtp-Source: ANB0VdZ7v0+LwzwFawDR8Bx7e6QPbNhUWaGdBSvVmUmAfkbkjPMTo5e8N/mRTdojFq75KI561MHePSue6u3bZ4rDfTk=
X-Received: by 2002:a2e:650e:: with SMTP id z14-v6mr748807ljb.62.1534874330153;
 Tue, 21 Aug 2018 10:58:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 10:58:49
 -0700 (PDT)
In-Reply-To: <20180821055124.909865464@linuxfoundation.org>
References: <20180821055124.909865464@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Aug 2018 23:28:49 +0530
Message-ID: <CA+G9fYs_XQ+B69+jM2s0ft90+VtVQrOkdqye0s5AYUQ2_epSXg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/25] 4.9.123-stable review
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

On 21 August 2018 at 11:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.123 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug 23 05:51:15 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.123-rc1.gz
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

kernel: 4.9.123-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: a9700096981e636b193c4b95999a061403c8f1f4
git describe: v4.9.122-26-ga9700096981e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.122-26-ga9700096981e

No regressions (compared to build v4.9.122)


Ran 16687 total tests in the following environments and test suites.

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
