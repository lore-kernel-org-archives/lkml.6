Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E43C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DFB2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm3paOPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeLOQw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:52:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40534 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLOQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:52:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so8432734oth.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eDSywBWdnViDRMLIHf/mGKVRrbJXz/o6XSrZ6mXDIvo=;
        b=Tm3paOPz8X4YuhiPxcjjzHvC/9r8w4/+CcuTbzjCkUW+ryDdB8NSgEdbcFFmd/gU3D
         NOezEQ55WoBa+4brTqYEs0Bpl9mVJ33CbfSnFooZ6ugQEbMwR1EJ+ex9p49NwybWz1Pp
         T/mMkb/gBpsN07KzIhn2zh4C5TR3iTAozrUJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eDSywBWdnViDRMLIHf/mGKVRrbJXz/o6XSrZ6mXDIvo=;
        b=tSFQr4IbQrXgZePlm0sfGi6V47AeYMSDPAWToy0IfkMBGT7/nMb6HA9sf6eYT/exS6
         5w7W+4s4S8NXO1Wwp8G5DhkhfDP7ljjwmzheqOBvXZ78Nvf2KevhKzIL+g3ifZdGAKt0
         ZE3pOcL2/eRk41AQz6bkHvUwQKSIIRoj5mZK8jsbh/SqE6ajBHz9vM0efhf36C+AE4UX
         +Oo97bRXcrsjQknmFuVpNrkhp8YG8JXurJFyPuQzkKnPcKDHK4VSLU7+23NjvG1iTYFr
         tutNSGAv5iNVV/XBSDcItJLrKAMyUXEr+1i7HGgPXrdRtZoFtoWJC82LGp/orMqG4QjS
         tylA==
X-Gm-Message-State: AA+aEWbwzjAkbEr+yOTjx7ccDuwDM5BUMGGLDwts6GSa9V9X/eXebO90
        E1ged33/7ATnHW70vfSxbOXU65mNs1E=
X-Google-Smtp-Source: AFSGD/U+pMUKOwBsXxQ1SMQ2UEpe19VLgAh0cE5Pib6h1dfuwS1wBgKEis10GhRA1flSUycgNr+8ww==
X-Received: by 2002:a9d:4ec:: with SMTP id 99mr5419463otm.298.1544892776761;
        Sat, 15 Dec 2018 08:52:56 -0800 (PST)
Received: from localhost ([2603:3016:300:100::968a])
        by smtp.gmail.com with ESMTPSA id g25sm3360974otk.31.2018.12.15.08.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 08:52:56 -0800 (PST)
Date:   Sat, 15 Dec 2018 10:52:55 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/89] 4.14.89-stable review
Message-ID: <20181215165255.6ualvxyxxyyqbfwv@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181214115729.658859279@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:59:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.89 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:57:01 UTC 2018.
> Anything received after that time might be too late.


Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.89-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 159976987c2f89308c6293a31e8fa9543549b94b
git describe: v4.14.88-90-g159976987c2f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.88-90-g159976987c2f


No regressions (compared to build v4.14.88)

No fixes (compared to build v4.14.88)

Ran 21597 total tests in the following environments and test suites.

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
