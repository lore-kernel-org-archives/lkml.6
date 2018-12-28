Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E0C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D7020873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEPiOveC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbeL1SMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:12:15 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39087 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbeL1SMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:12:14 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so17265626iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 10:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YvN5XzGEE5f57wuqld1AUnhuW43YgetQQF7INKbOvoQ=;
        b=AEPiOveC1yivxHKPymqfJKJBjnZZ9x/ymZ2xRMIF4SJpTJB/JhN/xBZgJcJa/lxo7o
         MK7JKbyV6p0vpc84pv0qJMh0aj6FZOuMD74UzpmmYaiuTyymYecGI8fBPKIXd8pgxhgA
         7qtqDmBaFUWU4BFqEd8jzMwqaOytJg+M842hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YvN5XzGEE5f57wuqld1AUnhuW43YgetQQF7INKbOvoQ=;
        b=Z6LyRQxjsPMNx9/7Vuj1dg3jhlK+aQYvambhYElIMIVFoLou3YRfe/OefI1bWDYiGp
         U2EjsdavrXClpJNwJl/lz8MZAmZ8DK/FbwN494aU5DrgD5CQO6XoUL+es63C+YFi2Wab
         yXX5ZTNC0pwCr/hcP3bqODUYLhotAlCxJ50NXGKzaE9EznEyP9AENDvzk5iPTnxNZM7t
         y4Ma3DMUBcEotptULc6k3Ta1oD5zU0DUUGQzhhM4TCD1ACUwowjOyCa1ec0Ff7BpbLt5
         EKXR9RbTkYBP7O3RE4NWiKkW5uHhyiTiBTq4c8vy/3oL/deQqz1EPTL0YI/gdPrZFfPd
         mEWA==
X-Gm-Message-State: AJcUuke1isXxrS40kaMQpNpuqY7waiKPlGUyW0PNHSzVv3/FrOjlOJ6Y
        f3ZmYcxjxpK91Gg4mLZmPe/xkQ==
X-Google-Smtp-Source: ALg8bN7dAUt2zMXcYA20JBEczGMLWKntOEOcI3OSRf1HCpR75u92mW4eOJ0Iz223N1CiqXeSOetzAg==
X-Received: by 2002:a6b:6604:: with SMTP id a4mr19274508ioc.10.1546020733576;
        Fri, 28 Dec 2018 10:12:13 -0800 (PST)
Received: from localhost (c-73-24-4-37.hsd1.mn.comcast.net. [73.24.4.37])
        by smtp.gmail.com with ESMTPSA id q9sm18439496ioh.32.2018.12.28.10.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 10:12:12 -0800 (PST)
Date:   Fri, 28 Dec 2018 12:12:11 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/22] 4.9.148-stable review
Message-ID: <20181228181211.izpzyi24nwxpfyxm@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181228113126.144310132@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:52:37PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.148 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.148-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 90e2ba75f3b479bb8fb03958c1882389aeb50c45
git describe: v4.9.147-23-g90e2ba75f3b4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.147-23-g90e2ba75f3b4

No regressions (compared to build v4.9.146-62-gbbfc30f29cb3)

No fixes (compared to build v4.9.146-62-gbbfc30f29cb3)

Ran 21367 total tests in the following environments and test suites.

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
