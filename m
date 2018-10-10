Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E47C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAE8214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFKwwW4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAE8214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJJLeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:34:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41069 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJJLeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:34:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so3555223lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aw1s1VcnYWrfLPY4a77jirN8dkvfMhbS2hnwyUyNlks=;
        b=aFKwwW4ihOHJmrX2aR1TqLkytr0yD5Udsaff3+cYDWdmPoiAwRRF58a6giQtrk/HnW
         OdnoM7p6sXlSm1xJiUdx2abOUMG2LOjW7/sBcSOoNpEj2CFO58RhhuJCtOI2VOlqzOfg
         CA4b4WPvwpTXvLLBwYj+9kgjRp+7hRANo+kgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aw1s1VcnYWrfLPY4a77jirN8dkvfMhbS2hnwyUyNlks=;
        b=sFdfOAn4Pd1P5nZ6GX7Cqt53bOEWqvt4p5Ot9ZuWP0R09DRZet5KbhLGP4zw8rRWXO
         Wd5HaO27ArN4Aq1F8Ux2r0ZvImAmxamWsURFnIGmoLAVxUM0AF8vOGpNUXysU0B4BMPx
         k8svBScv8NPK0sjQwQneCPIzxXZqJbxBs9ZStQnOfO9MMsOonlh9rnxrLBd4guUd3Yqb
         fZPd4ojKz9lExbqon/M6htpbU60eN4z1qWaItvIhAXCPLuhAxmkyrF4td91wPpfOoUK4
         ga5bIzDGsT/ubJlhf3G/7yE43D1G7vTftJF/NjhC3mmEBQ2RcBetMSqqu/ZBXb0oFbkh
         Pjcg==
X-Gm-Message-State: ABuFfojsQQEexnS9w6tvvJquR21rpmWWYwJId9oLFrsSknPUX018UeCM
        wr/3clWO90dPYHI3iV0/JIlJR3jBPIuCWkzTnMQBnw==
X-Google-Smtp-Source: ACcGV62JJxou47nG6Ptx9mrvJIKpJrfim9G1AXutOkJXht+3u8rVZQF9I71EvSxRHT5nU9rHW7Joe+8WGqnS/EpBaBs=
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr19569964ljj.30.1539144834638;
 Tue, 09 Oct 2018 21:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181008175605.067676667@linuxfoundation.org> <20181009161520.GB7220@kroah.com>
In-Reply-To: <20181009161520.GB7220@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Oct 2018 09:43:43 +0530
Message-ID: <CA+G9fYvDJTdnNiRSjd88bX8p9UEJ92Tz8nTaXbYAVNk3E4QPnw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/94] 4.14.75-stable review
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

On Tue, 9 Oct 2018 at 21:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 08, 2018 at 08:30:41PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.75 release.
> > There are 94 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Oct 10 17:55:37 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.75-rc1.gz
>
> -rc2 is out to resolve some reported issues:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.75-rc2.gz
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.75-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 2040d5afb6ee8186df604b87a7e49c4ad71d3ecf
git describe: v4.14.74-94-g2040d5afb6ee
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.74-94-g2040d5afb6ee


No regressions (compared to build v4.14.74)


No fixes (compared to build v4.14.74)


Ran 21078 total tests in the following environments and test suites.

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
* ltp-fsx-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
