Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D167B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZomqWvC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D167B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeLERay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:30:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50376 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeLERay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:30:54 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so22630499iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wskZ0qfNKUUdBcsiK0VH5sEI3aPtHs4ubjTQkoA5Bbc=;
        b=ZomqWvC55fYtRBb7uhGS/YJMTpaaySWQHDgm+tB8mPv/om/zcT1dGtCnfPj+ktTxRy
         gbGrdaXNCRVWGJFXBGGHgJc4pF42zd80jHbEifVikqEebPBp/GjYVAXoRfBOkHhdQ+Mg
         DIVOrmk4bxkaV1XKx+k7DfR/kJdsXdJ6fTcx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wskZ0qfNKUUdBcsiK0VH5sEI3aPtHs4ubjTQkoA5Bbc=;
        b=gdO/P/Zu065n8xdNXC69knAbY+HqGEdAcNEUSGgf/PWP8OCeGwCdZk2Wry/TtLQLhE
         Lv9e6VAsd5b6EEvd3sqI+TU9Jjg3vQC9yoenLedLBUNg2JL75ommORC+k2S0KTpJTlhY
         au7NJo2VKvfZplqdd0Qy9r0Wy/v/aVVPCHLHouCp7QWaeuMCuH25OUVf4AV3TIYiRmg1
         gAmbQWP3dumh/q0/Z25Ks6jaZW0sOioOH/3ULHfcogYpEkOM1TuIjm66CpBkgzWPY8Sc
         pjezbv6+L/QPd+/x+bWa+s5ICEB/wQ1XAfJpflVOuKb4yvBgvl8xBg1y5VSmeR04hPrR
         646g==
X-Gm-Message-State: AA+aEWYBZqLTA527I0Q4ZqNrsQj4CYDtnJbAGERQzmrW6E1zgthylpRl
        m1nwqqyWYaV4LXzNJqHpfUHQgg==
X-Google-Smtp-Source: AFSGD/W6e9aKibX5i8XCh1MyVhSDgNyfgtDmOBD4eAf8FGVnXg0+rdefXCrsYzk4hQ9pPNk61XRtRQ==
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr23392481jak.49.1544031052936;
        Wed, 05 Dec 2018 09:30:52 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id u5sm7220487itb.33.2018.12.05.09.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 09:30:52 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:30:50 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
Message-ID: <20181205173050.wwewgmv4ey4wwsp2@xps.therub.org>
Mail-Followup-To: Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20181204103649.950154335@linuxfoundation.org>
 <98b81960-a81b-765a-797f-d59dfd8da8b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b81960-a81b-765a-797f-d59dfd8da8b0@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:44:59PM -0200, Rafael David Tinoco wrote:
> On 12/4/18 8:48 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.7 release.
> > There are 139 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Note: As a consequence of the retpoline backport, we upgraded our
> toolchain that is used to build the kernel and userspace from 7.0 to
> 7.3 (containing retpoline support).

Specifically, we went from Linaro's gcc version 7.1.1 20170707 (Linaro
GCC 7.1-2017.08) to upstream's gcc version 7.3.0 (GCC).

> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.19.7-rc1
> git repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.19.y
> git commit: 987a6da5152c29e37cc11de9a2d10a23a48015c9
> git describe: v4.19.6-140-g987a6da5152c
> Test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.6-140-g987a6da5152c
> 
> 
> No Regressions (compared to build v4.19.6)
> 
> 
> No Fixes (compared to build v4.19.6)
> 
> 
> Ran 20285 total tests in the following environments and test suites.
> 
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - i386
> - juno-r2 - arm64
> - qemu_arm
> - qemu_arm64
> - qemu_i386
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * boot
> * install-android-platform-tools-r2600
> * kselftest
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-cve-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * ltp-open-posix-tests
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
