Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC00AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E5214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK/QqR/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2E5214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeHUV2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:28:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39490 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeHUV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:28:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so15012823lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0cFBZp/HMM6k/aaSK/NaSzVyEhwyeG/ooYnUh+WdJxw=;
        b=gK/QqR/tzU0kGlp6+LGlKT9YZdwvoylu3DN9sPcV9KwcnB7yZMfNzErAW4fbRR0MoM
         m2afdw6vMPKTuhugy7ylc3tdJIIpwj4rzoOuyKWKyNvmJj9TKluiOkCFzbYzm0/Uzd8C
         isu+H4mGjA+XosbdAeaGexZh22uREYpCK8Mb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0cFBZp/HMM6k/aaSK/NaSzVyEhwyeG/ooYnUh+WdJxw=;
        b=gHF3XaHHNrE94qW2NZfeP/i/2d5305u8Vrlj34vFFQw7w7EYOHNzs2iWUswp/URs+3
         iGVJGDt3sb/qd1KkpXx+SBiCQl+k8K8DRPaOcJ90lkNG8wupmWxUixuW/N1UY3IbKm8N
         qYUfUdYkFN+UyPuP8kKSXvCQMYZ3m2SVV7llH7Vp+m29MDvIcxV8+WBKx0Hm35S237gN
         x23LfSI//CoqlSdnIJIrnbGmloQABbV9+i0r9uQpf5mPiDqD0r+h0bV9TyRgEv7XzBWT
         d+GH3fWRpB25Mx1FFdHzKZB3+xnNS7oto+5nmHxWNYBQd3hC9TdvbPMAUMoBmD8DOP3s
         5Ddw==
X-Gm-Message-State: AOUpUlEGH8DPxVlzz23VG4Y+GMmEkRHe+1uCYSqCC4CxWKIWwNwSpy94
        eD7gvfEzjRqusNBrJbi5Ki8M1EEPJHPKULV+F/38dA==
X-Google-Smtp-Source: AA+uWPxpb9u5e94/z6OxScMNLtnN+Vys5BWtmD74ibbxQFkm/f/SPPNvXQNoKXLyKdRdTfW/X8QWIgY1/AabWH0tdjM=
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr33618092ljj.153.1534874849709;
 Tue, 21 Aug 2018 11:07:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 11:07:28
 -0700 (PDT)
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Aug 2018 23:37:28 +0530
Message-ID: <CA+G9fYuJtzq+0nSSqXF3naOAqSBMKAR7m=CaBRL7jn1=OxNEhw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/29] 4.14.66-stable review
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

On 21 August 2018 at 11:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.66 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug 23 05:50:58 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.66-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.66-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 2f63949a6fc3f267e365d9d4920131bf3cc62aa1
git describe: v4.14.65-30-g2f63949a6fc3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.65-30-g2f63949a6fc3

No regressions (compared to build v4.14.65)



Ran 13880 total tests in the following environments and test suites.

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
