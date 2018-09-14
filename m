Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A8ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960B120881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6Os6zl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960B120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeINRyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:54:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39663 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeINRyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:54:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so7396466lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0vCHEFgyRLvG5+hlyShw62WnZT9sQmSKSYw6LV/ciBU=;
        b=O6Os6zl9l37w9W1oFAC1YXgJSaJ5fh5gO70pzoKr+Nnp2MNOCNd8x+icT3KLDGookF
         vr0my2Meiz5Y61Kmz7IVgI7aSBKaJcpsGjykrZu4HDGgPcBcwTpF56/YQcD8gIpOuWgB
         2+IXap7G96E6IeCB4ggwi2A8bMX7+LMlcqTuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vCHEFgyRLvG5+hlyShw62WnZT9sQmSKSYw6LV/ciBU=;
        b=T9SDsznDIKsb0vs1aYoSsHQSYpT7I54AS6RemmE94T79/6eIBSqJcK/+hJrhuAjF/3
         vgRMbT2BNZX61my/TwOBx2TqKigmNJAMgMdEkn6QOhpoEybxeU3FXHwZqnb+Ye41SUdu
         ZCHG9jelZvteq8F90JT657NI81LhJflYNAAOizNR/dlSng1QQc1JFNb6iWKhvl7GYp03
         BZyfCW3zQ03OxX+YBEHzePs22f8eQ1EmlthBreXGcmbYt3SmBA+xJnhHBLSOWwJ+Vz96
         ESZmnqqAMiU8yoPRxW03Dq+Cp91PpiiypV/NdeSqv1ejcFtUnJGhYQhIhGmiewYROc4t
         IQdA==
X-Gm-Message-State: APzg51DrTOggGE2sM0VCEd8+I5C8vzQ2tzFRw7zaKM683eQGltxHc5a2
        4u7WHCkvh3gvuX4gp+l9CjeA00H9gP/QXZG9G65eSQ==
X-Google-Smtp-Source: ANB0VdaIKUAZmG9gvRBMFEpCrU/ao/OLEcJkActP7isSmlqMGSJmityYQ/qRZEuepoxU0FdM7Oj+UEy1/Gdyru/nRnA=
X-Received: by 2002:a2e:650e:: with SMTP id z14-v6mr7453950ljb.62.1536928795543;
 Fri, 14 Sep 2018 05:39:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 05:39:54
 -0700 (PDT)
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Sep 2018 18:09:54 +0530
Message-ID: <CA+G9fYvaake1T4uacZpg8Urk00CSvhBC8pr-N9PyBQnzpN-Mxw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/115] 4.14.70-stable review
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

On 13 September 2018 at 19:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.70 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Sep 15 13:17:48 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.70-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

This report is on 4.14.70-rc2

Summary
------------------------------------------------------------------------

kernel: 4.14.70-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 6b9eeb5455e913022106a6aa057eb9947d934a36
git describe: v4.14.69-116-g6b9eeb5455e9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.69-116-g6b9eeb5455e9

No regressions (compared to build v4.14.69)



Ran 21266 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
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
* ltp-cap_bounds-tests
* ltp-filecaps-tests
* ltp-[
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
