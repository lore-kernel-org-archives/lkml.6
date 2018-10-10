Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F37DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB1214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fc9Li4U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CB1214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJJLdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:33:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38580 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:33:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id g89-v6so2896668lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1Il30hZilQ6jhQHjsL6jqociVfUqUDPnHfpe7SIv1w=;
        b=fc9Li4U3lV6H9qddrwxOQcXJ2rXxgAGNQG3rjBBpe2pavVJFm0orIZacplaRUuwZjV
         WtFfC+VGXuVOiLG0cSWPpsuZpUutHkAHHkqlnR0MObM2AS6BTHVvM2itzZXF87ihQIWI
         hhCgM596Y9ljdCjInlD/lLokhzeDOyDiSjMjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1Il30hZilQ6jhQHjsL6jqociVfUqUDPnHfpe7SIv1w=;
        b=FSFEuySwvgSFjBy/cg3W5Er6poKB3OqMuRXuOygqZuGXylvkpPv2RBFnYejlgP0RIy
         xycH8CY0PVrL9rLNV2GlQ0YcX2Zvf5DgEaK71mFD+0WKh9+Wk+j4/H0vM5FwYBeq1lDE
         MD71yjB/kl27SGMsYkrNYnWywblw5QgUrhDIHHaUs8KNXr0sJCczb4IW3MhPfsjiYjF3
         eJbJZOGPai71ZFh5zJ7Kttt27yw9iTwCMmnRY7dy4RRq2wn4qeppkZWFC47XX9/v2Qb+
         vt+1+AMgkCTw7hmZJvuskzmf5zmkOpWXGe6pOUkUtKYfvhQDMPHiubz/tpgJ2gycCAQH
         BDEg==
X-Gm-Message-State: ABuFfogBPefPebbt10CIwHxEhKZX5/QR9KZJUN5oOwt/koIEYVbSrDMG
        IMtPkVqkMRCaZ16nzvrBu4s7KdpzOoNh4KAYGg8qXw==
X-Google-Smtp-Source: ACcGV61UNi1WBwXZ1rErRCEg4vkADd4GwZim7/REwdfSlHY0LwyyoEq6u5nN9Bqk66L7QEw+ex/yC++HaBn6G3SioxA=
X-Received: by 2002:a19:735d:: with SMTP id o90-v6mr17818068lfc.45.1539144778423;
 Tue, 09 Oct 2018 21:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181008175620.043587728@linuxfoundation.org> <20181009161445.GA7220@kroah.com>
In-Reply-To: <20181009161445.GA7220@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Oct 2018 09:42:46 +0530
Message-ID: <CA+G9fYti8P46YP70wvfRbw2-+CY6+nTcE7yqZ5PjF-W=-NP1pQ@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/168] 4.18.13-stable review
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

On Tue, 9 Oct 2018 at 21:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 08, 2018 at 08:29:40PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.13 release.
> > There are 168 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Oct 10 17:55:44 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.13-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
>
> -rc2 is out to resolve some reported issues:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.13-rc2.gz
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE: Now the reports gets regressions and fixes.

Summary
------------------------------------------------------------------------

kernel: 4.18.13-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: 5492998ebf547be45246ae72220e9429e329e05f
git describe: v4.18.12-169-g5492998ebf54
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.12-169-g5492998ebf54

No regressions (compared to build v4.18.12)

No fixes (compared to build v4.18.12)

Ran 20171 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
