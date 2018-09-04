Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6174C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FD02086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGiwFfe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FD02086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeIDMqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:46:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDMqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:46:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so2367763ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SbeQw8V+14HJs7EYYoEHcNegVlfLAYl30HuqAH1Ymfo=;
        b=iGiwFfe+feWCiUapbjvDhH0X1FzNhGDsHootuCa0ONjAChOMv8gs1EIs/tpjr7qHd7
         9js2T9cPv9L8qIPklR9KQ/1BQz8+iu9WoyX7JGm6LMSJGBHBJbcHiUmI/5pBUhsapPvm
         G/wFhoB4f4Wu63+66xsnJ0fCgXD4W3lQLd8vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SbeQw8V+14HJs7EYYoEHcNegVlfLAYl30HuqAH1Ymfo=;
        b=VOKDfHEfSTm+5e2AUnDl24K78TAaz3oU3KcCCXvEY/he+h7KbquSwe+TbRJpwaYmFn
         +5tA70Es3XbTscut5/vJkUnxm3KW1YOLbjGB/1u+TSTYN81jXUOPdm98uCE5b37OxX8F
         1uy+Q/4GgiMa9rTft5dx81gRgoMBjw5pw3YwDloPnYXfW5KY5F1D8djshHYoi+kYMipr
         OgzKwO1GF/xPgwcc0NRAk1m//9DNYdGLBhyksu4k3/awOxVubudD8lKCJeQN6jW5zxnD
         ExTysnH7AwXPkJvWRjAGRjX/8wxeHq/RD1mDveNWKjyh3i56WPfwhQ6PdWYFdxRuJzEQ
         ErXA==
X-Gm-Message-State: APzg51BOjOOx57X8HSUbX3C70bkgZbYGHDkg376zeQ3l+rsTH0OvlOcr
        9+ZJFjWL28ExEtYjQRIiWBGhWYV5CpqfGvPV1xPwLdQI5WI=
X-Google-Smtp-Source: ANB0VdYRyk1g8kDJCq7JYp3IYpQ65vHjq3WRZg7018SwWq1ekZV0yVS1mOpwXeftyF+VcFYqPR0uBgTFvGD4rPlxgZ0=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr19421521lje.70.1536049345851;
 Tue, 04 Sep 2018 01:22:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:180c:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 01:22:25 -0700 (PDT)
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Sep 2018 13:52:25 +0530
Message-ID: <CA+G9fYv82PB85DtC8Mtu19rQ2bogzCkDy-1GP9uozh_dMD9=CQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/107] 4.9.125-stable review
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

On 3 September 2018 at 22:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.125 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Sep  5 16:56:13 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.125-rc1.gz
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

x86_64 and i386 testing is still on going.
but qemu_x86_64 and qemu_i386 were finished.

Summary
------------------------------------------------------------------------

kernel: 4.9.125-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 31b3687b22c5778612d4b82ee60979a59b3252ee
git describe: v4.9.124-108-g31b3687b22c5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.124-108-g31b3687b22c5


No regressions (compared to build v4.9.124-107-gcff3f42769f6)


Ran 14904 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm

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

--=20
Linaro LKFT
https://lkft.linaro.org
