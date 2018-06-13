Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B54FAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF25208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kR31zjZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF25208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935799AbeFMONw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:13:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46694 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935664AbeFMONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:13:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so2918412wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RHfQ46Rb4fFxQoA9H+a9CbcKM6m5AY5NIoYX8Rn9eus=;
        b=kR31zjZ/yWiXPl+rRI/Px/MglO/8b3GvzEVu4/tnCqGh6eK/bRfmXR4wKz98ss/wlE
         UDBb8ti7iGbxuTwfOV7tcAf3X70hWFlRMgEFXhYmXg5Vkn1Bph3/Rh4CvzXM3CaQmYms
         Cow5PeG+Mn7K4QvQO8VH0DQWzLA6I2kEd+Ka8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RHfQ46Rb4fFxQoA9H+a9CbcKM6m5AY5NIoYX8Rn9eus=;
        b=TK0pUnZDjHwSTH4RludJtlqe6XD2yrIej2gNLbgCw8fk38HVxO7yhd1vsaC0gl1FQ+
         PJhoBhIZmtuRjF0VHoBe5iNHyjoxzzbfVg4xmxw2cNrcKPmTZGxhyJm8NC9jLX5B6sbg
         p8kcd0JQAYMmlJzr0dJKEV2wk277QDW43DFbTRGKcNhWGnwHInO3WS0ZKDMssNHR70te
         QQhHF9zd2S9RM6KgtwgzedqsblWXHA9Yua6HlQnlsAYkTadqDFsIWKwLXArmv08+kHNR
         dCeRgxvrAcnNva83psfAKNh7n/tm6rLn8u3GUbUoTqR0PieW2cW6ZUUmgpA3uQM9GUWG
         9Xfw==
X-Gm-Message-State: APt69E39sesT3mmqjNqYeOsCYRo+57kYRc6h6Em7oBFD4US71Ha6nMOz
        8Ti9TpRRtiEgKxSddSSqLhqQzMO71GEWCN+EG2rmcCTy+fY=
X-Google-Smtp-Source: ADUXVKLBBicjq85P+/lfIvbw7vg4ikgsMVLa9hGZHt4JbZfsEKM3o3wc8+jJ2FIKL1Cov8No7MTajWXyA6Cme38ll4s=
X-Received: by 2002:adf:aadd:: with SMTP id i29-v6mr4299080wrc.149.1528899229536;
 Wed, 13 Jun 2018 07:13:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c389:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 07:13:08
 -0700 (PDT)
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 13 Jun 2018 11:13:08 -0300
Message-ID: <CADtBP2DHZFAC4m6LH1qR8njySdAeXq9Z-fvgRzpikiRzQL7Jzw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/31] 4.9.108-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 13:46, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.9.108 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jun 14 16:46:09 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.108-rc1.gz
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

NOTE:
There is an intermittent failure LTP fs read_all_sys on specific to arm64 H=
ikey
board we will investigate further.
https://bugs.linaro.org/show_bug.cgi?id=3D3903

Summary
------------------------------------------------------------------------

kernel: 4.9.108-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 9b3f06c8225324c48370ed02288023578494f050
git describe: v4.9.107-32-g9b3f06c82253
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.107-32-g9b

No Regressions (compared to build v4.9.107)
------------------------------------------------------------------------

Ran 11373 total tests in the following environments and test suites.

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

--
Linaro LKFT
https://lkft.linaro.org
