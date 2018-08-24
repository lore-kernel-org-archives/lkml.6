Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC0AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681D021581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOvKfzMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681D021581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeHXIkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:40:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41173 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeHXIkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:40:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26-v6so5750877lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 22:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ch2Qdx6mbmZZPDVL1C21EuZPMpxSZ0jlFyLrOj6lW38=;
        b=WOvKfzMAcl976Zw/IKV7nw34d5K873RoqU6dHKroEnFe//ofn6u2DEb4/4wub8ca5f
         /SpcJKaQS6beiR2KZ0Ve4/+M3J8GJO9mSJ567dbuvHnHGLE3oZ9d4HQPZ+/Ef6wgd4C5
         R4TYQ89flhBuXZk5TSfy0WW/eHkS6rpTaz2I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ch2Qdx6mbmZZPDVL1C21EuZPMpxSZ0jlFyLrOj6lW38=;
        b=ZG94yVUDk2RvkOu0FTU/jwqKmAqzxUqldFoD1dyumJICyV5oJY+dEu57XmuVyhAhjM
         wcZfhPSDlguJqu3Lr9HFtk2F73SSKvesFv+1CkZDVCPM/N4LD/T6V0MZvj3U303ZjV9C
         +jSgkl2qjzmfWvikL35Qa+by3jT+U26QAquwXecdbsjzCtONSpkY0bHWYocPiEBs07e9
         /y8D8fhDywAnvvIdm5RncGhdmf8fAwJDCGZ+dh9CEqFxm+EV+eTQl1OrvYQDOxSv8pUl
         VIlS0lGq1uLXJv97TIBNHHGWUva5c98/mdecwoNWETWzyza/yDvLQdethTR9YUpdA3JA
         23YA==
X-Gm-Message-State: APzg51B5JWdSKbm6W8p+LUE7aIyEDumAh4g6ZIxm13sussTxAQqovzhm
        gQg1efuxFQIHlK6J1MUAnfyDlOr1tiwErUcps46paQ==
X-Google-Smtp-Source: ANB0VdblJQ11ksjcCNwB7hPF8NRgq8f69bKopphb0yMwoh+PFFAoOCzdVEB9lAEU6rr7CXm7T6VI5ZOrlaIwIpGBpLM=
X-Received: by 2002:a19:9bc2:: with SMTP id d185-v6mr77750lfe.76.1535087234209;
 Thu, 23 Aug 2018 22:07:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 22:07:13
 -0700 (PDT)
In-Reply-To: <20180823074759.234685844@linuxfoundation.org>
References: <20180823074759.234685844@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Aug 2018 10:37:13 +0530
Message-ID: <CA+G9fYur0AcfYv6pP61xKNi_r7HjEtLK2E5fCoLNTT6=u4o6sw@mail.gmail.com>
Subject: Re: [PATCH 4.18 00/22] 4.18.5-stable review
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

On 23 August 2018 at 13:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.18.5 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Aug 25 07:47:43 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.18.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: c456dc1ec5f92b9bab9cd6c3fa53ab7cc32c8d79
git describe: v4.18.4-23-gc456dc1ec5f9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.4-23-gc456dc1ec5f9


No regressions (compared to build v4.18.3)


Ran 11322 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
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
* ltp-cve-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
