Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AFB20869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3266Q5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AFB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIEPIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:08:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32841 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIEPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:08:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so5813337ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yus/3elztDMP/CxTk7PYJp4cOVLf5aJUWd25iTx+v9k=;
        b=N3266Q5Cs1zWd7H5f4G9shUNak2kGxmuNsK10bs6rpQ6OOd10AYm3tv1VeHnKDdg/j
         gJ0g3aNgpIjHuOUQaFdHGloVyn5kl5jnfwC7a16Fg6wLwGRyz+XGxn+QPZbI70vbsQgA
         c6XYxlUQcIFCoPlkQwVwJ6AB9tbb0K0D8icOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yus/3elztDMP/CxTk7PYJp4cOVLf5aJUWd25iTx+v9k=;
        b=fABF6m7DuPd0GvlPIdEyhbv3AzHw0PA7hiiInLGdMQFFXvxcBp7TqQINncvaimgTDP
         xNJK0GzxBEXlrnsyIPdoF3EhA3LoQujRNP9e0EHit3dLk4ttfWtoSXv2bmToOrB4yIMZ
         7q9cRvWkH2gghVWWCXrs8OUextqW1aPcNtqykJ0UMTn6ERDocIeJw5tWZY5griElo05U
         q+bNFYKuoHt3ZLkjJDguDzG6ugChbJw4wNRl/kMNQDKTDkrhKJrOtRTsYPX/eINf1Ztj
         /9fEhWhGwFuESh44P4I5MESiDDj2D+sqt0Mu1/NpxOe62ojAowTrzbVumJhgoF0RIij8
         chFQ==
X-Gm-Message-State: APzg51CHtGR4bh9D82XaODQxgKcaefJcFXHhWTUh2Vnkgwjf7B68EzUC
        sND43D4A++MYkNucpMYgZkTyIyAu8Stm0kduTSpIuw==
X-Google-Smtp-Source: ANB0VdYfN885F09XxWCu5BPahqIGwP8ddcsaV/jmKXGZw6cdhlBhs5SkhLUnA1LP5r7PqiDy3zhqhBqbaGDTCZ9x8qk=
X-Received: by 2002:a2e:550b:: with SMTP id j11-v6mr24063447ljb.124.1536143915798;
 Wed, 05 Sep 2018 03:38:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9a94:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 03:38:35 -0700 (PDT)
In-Reply-To: <20180904193202.GB17786@kroah.com>
References: <20180903165719.499675257@linuxfoundation.org> <20180904193202.GB17786@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Sep 2018 16:08:35 +0530
Message-ID: <CA+G9fYun7J_BCZ390oa5tY6jp6faaknczzDBuc7w5v6o8+WWVg@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
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

On 5 September 2018 at 01:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Sep 03, 2018 at 06:55:44PM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.18.6 release.
>> There are 123 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4=
.18.6-rc1.gz
>> or in the git tree and branch at:
>>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git linux-4.18.y
>> and the diffstat can be found below.
>
> I have released -rc2 to fix a reported problem:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.6-rc2.gz

I get to see  4.18.6-rc1 not rc2.
With the current results on given commit id are looking good.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.18.6-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: a6a229cf7e7f147eb6d118815a01758749fa6e8d
git describe: v4.18.5-124-ga6a229cf7e7f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.5-124-ga6a229cf7e7f


No regressions (compared to build v4.18.5)


Ran 21181 total tests in the following environments and test suites.

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
* prep-inline
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org

>
