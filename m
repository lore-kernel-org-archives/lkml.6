Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3D7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861D42080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKv5x2hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeLOQvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:51:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35050 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLOQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:51:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so8442843otj.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EQZcCSDagZwmMS1SwRCyR9DKySur6xOuWlEuJpp5UC0=;
        b=XKv5x2hyarewttNnPGQ0WKNwIotEUOHeI4AD+LxLHw0vtAPcjAwZZ1gNxawJAgOvjP
         V2Fr4HGD0vEYENbNX3yt5OZCpagkE0ysyyTvT2HFx4pB2MPMothPzNFgL0NvLtMXWHty
         C16WCuHGVWG3GvlLsoo0Ur2qSc9DhmGvs4uQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EQZcCSDagZwmMS1SwRCyR9DKySur6xOuWlEuJpp5UC0=;
        b=RyzVtOsEY5Wt/5Mqr7/VLc5NUdPR3EaEPC7fyDQfBool7i7Kl3KL8+5DLcX8gxqvgO
         kbbfIuPHl6lzhunhO5YlFHT0X7mzhwkIExTk2TfBspLeLgO/rkgZ5mJHpk5fdo5p2Kh6
         wz5P1ubWeICG0fho/jY3L1shh5o8Q6DxjZreDai5hRcWn6TZtK6YsIlBm39mRjieoev7
         V1VZv6MBZP+uTIOcQULHoqJz++Ntcnobs+M7VYcaQILMH7SRSAWYxtIPXbstzWBSu7C9
         kVIJY40z3azIUuC50mWV6Tl5JMwGaCVObcgY1xMEsApftNcszCObyFovKq8UMSlbHItS
         R6mw==
X-Gm-Message-State: AA+aEWalclHC3Wx2mA4kRkd86R2c4hS8hGoYivKzi2C8/WInpeWcUjHX
        /4F2XKDFMF34mS6KgMuJaqrEsw==
X-Google-Smtp-Source: AFSGD/XlpTwzNb3KGdEwDYgBR9NADtiQt5fbYnAKaJgTjFALF9IgtL8LTQXBcrocwq7HLvIH5KTaFQ==
X-Received: by 2002:a9d:1421:: with SMTP id h30mr4947466oth.321.1544892670983;
        Sat, 15 Dec 2018 08:51:10 -0800 (PST)
Received: from localhost ([2603:3016:300:100::968a])
        by smtp.gmail.com with ESMTPSA id z18sm3690589otp.41.2018.12.15.08.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 08:51:10 -0800 (PST)
Date:   Sat, 15 Dec 2018 10:51:09 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/51] 4.9.146-stable review
Message-ID: <20181215165109.nouyscqmaelr62ba@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181214115713.244259772@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 01:00:02PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.146 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:56:52 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.146-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 88d902c956b8078676b83e964db1f896bb548134
git describe: v4.9.145-52-g88d902c956b8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.145-52-g88d902c956b8


No regressions (compared to build v4.9.145)

No fixes (compared to build v4.9.145)

Ran 21461 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
