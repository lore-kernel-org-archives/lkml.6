Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65515C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AB8222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8ZGYzFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408054AbfBNQmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:42:19 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40096 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405240AbfBNQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:42:17 -0500
Received: by mail-it1-f194.google.com with SMTP id i2so15844965ite.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=elK1VqeJUczh4c4WkBI5eTXEbb7swWI9/1cbeaU89uw=;
        b=M8ZGYzFW3doWjRwEEvFY5pNrXJxnlRqlQsDadRwoQGb6BiO5D4nplte2AsPu0L4vHK
         TuujFa1IRGQsoBnsII/ht4BTJHTfAG1nlWu+nMVwtpRCS/3BeIEYJL47Z04Kg3C3Q37J
         OwOEJMARNtCCMJW8bUPgA2qRmYC3/amKdgO7+stAAqCvRGxrUo0bwRjyiXmJ37micpBK
         ElNsoFguhiS1V9k6P2jWqPt8IfRjdVn6ntGfhLJBlnt2hipCM75r5Pn9D31IbqCMQTBB
         um4XkuCX7g4XCyDJJ+Q9hcsiaOHlkFZIvTVti2TpuEBzKlhMS5FDDCD6zHg8dFcl6XvL
         UQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=elK1VqeJUczh4c4WkBI5eTXEbb7swWI9/1cbeaU89uw=;
        b=DVvWe2lh/Ur7y3TuBDOje4Ar/DscOU/0K60PKKBGMPplI+ryJvQP2Aiqcy9t7/cMDG
         OZjoJGbxCk9cCYUjTWCyV4Q+X+S+Aie4AmPO2MZ5GFqIl8bjoKFK8rr1eLl7oM1u3Twr
         /4J1vIl3O0V6VJ+0uvovqLTweilgCk8JkruWqDmrHFdMAetYSNpyWzXAt9HZlVDK5Z4X
         2cRn62LguGEop0so0vGeOI6qG5OYN1xUm7qcm0aNlU3QH98node5EK2KqZvMQ1oNiYx9
         /SqtzzRPVC3PFSjxCQFBPOVdYPkHy7+Kv6cpzzVJd5NHjq4EihNudnV1Rqa+s1NHFdPi
         LhMQ==
X-Gm-Message-State: AHQUAuYRTI5mto6hUveaSBovuCJFNtKn2EWogwgRKHW9qbqPoJcG5/mw
        +hhsw2z8D/rf+ApiZC53tVUgxkvdQNc=
X-Google-Smtp-Source: AHgI3IYStQbnfyWXwF9TD8wEaI7KLD364Arjignl4rCTw4+T3ajxh4cKdU7uKcNFQIg3kCYFiX6x8g==
X-Received: by 2002:a24:628a:: with SMTP id d132mr1066357itc.164.1550162536741;
        Thu, 14 Feb 2019 08:42:16 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id g10sm1296009ioa.67.2019.02.14.08.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 08:42:16 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:42:15 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/35] 4.14.100-stable review
Message-ID: <20190214164215.vbcorl5r5spei4p3@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20190213183706.176685027@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:37:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.100 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:47 UTC 2019.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.100-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: b27110a485424c7a5b570a05e692e7c21cb3f768
git describe: v4.14.99-36-gb27110a48542
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.99-36-gb27110a48542

No regressions (compared to build v4.14.99)

No fixes (compared to build v4.14.99)

Ran 22415 total tests in the following environments and test suites.

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
