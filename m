Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AC0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C8E222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXn8estg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404827AbfBNQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:30:09 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:32953 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfBNQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:30:09 -0500
Received: by mail-it1-f193.google.com with SMTP id g137so5168172ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7C3wVrH+brtAmRHo4pBM4SaBoW0AGeV6iPk2ddfqwXY=;
        b=rXn8estgmxxsvNjnIb4j2iZLxKb//FJFWGJrq4Iys92t1+pcNBk/u0T6OkFN7bwNyA
         984pbZH2DtZHN27zEQOSP+KKPegSJRfvm9erLEIq+ECxPJkoNLIgFmqDLarBN3aKU/mE
         tpVGcx7ACmpnQ0c+/fOYHu/tN+HIWkxMFwTYnPzFHZ3Gox2WZreiWpCWtuBogs5ssSew
         mup2WXW0k98aCQqIvlA2tmDwxqQpb77MSYjRildEnKUunhC51Hhh9iDbYFfOxdJDK64D
         KV0ehZROo3yFFnIZqlCW8sPS07WxX7dH6OKHCh7P+g8BJIwErjrFNwShGhoIU6+XW71r
         GKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7C3wVrH+brtAmRHo4pBM4SaBoW0AGeV6iPk2ddfqwXY=;
        b=K7RpdSuqHISCofCyYAw1+2cODE7dGM9qbhBzN4QJ6/+ua9/1IMYuSXZpZDlYxRhiRF
         3IsyKcpT+FulJEz+UJBz406WWow+lDmJ/704vkMlNRiaKulqbWzFZj7KJKmK/9AnhKyd
         6Hag7/W6NzofCf4vFWEhaU1iRxGcmYYqHKlfF8YYSyl8yP80ob/fWmIAoAV1dvebqy9e
         atc6s0qdVwd3p7N15B1pkNjbAqGjznj+mndIY3pAHAmdBDQUJ99Yf64jZ1Qy10VmbwwH
         X3gIxbBX19z9O7sqLsN5hrvQmeG0kzAyQZAGkdvba9kPJPEnQeKT71ONONIvHmXMi/Bj
         ms7Q==
X-Gm-Message-State: AHQUAuYlB3CK9u5dkcKpPNx9ztIZbpV37IHXsr6iK5U6qaFpAdVkB+50
        iY8sVHdspXP1Nm5Wmi7m4ZSifA==
X-Google-Smtp-Source: AHgI3IZzxFDw2MKpGVrBwWWuC5/+rem+XffQAIyee5LPMlYZgxG9eAIqGgL5r1AJ1B6GBHIjF4YtRA==
X-Received: by 2002:a5d:8248:: with SMTP id n8mr2695396ioo.246.1550161808062;
        Thu, 14 Feb 2019 08:30:08 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id k12sm1198992iop.8.2019.02.14.08.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 08:30:07 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:30:06 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/24] 4.9.157-stable review
Message-ID: <20190214163006.lxuhp4iem4tmr2u6@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20190213183647.333441569@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:37:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.157 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:26 UTC 2019.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.157-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: faa3b6b1ed9c5a1671bf42cf23aff7c202b7d360
git describe: v4.9.156-25-gfaa3b6b1ed9c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.156-25-gfaa3b6b1ed9c


No regressions (compared to build v4.9.156)

No Fixes (compared to build v4.9.156)

Ran 22192 total tests in the following environments and test suites.

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
* ltp-mm-tests
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
