Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C18C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3417120869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGejkEqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3417120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJQDYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:24:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43740 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQDYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:24:47 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so17279630ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tIkbwf32ikRMR7fj9veNiBSh9gZIzE+HLHfATNQrYqs=;
        b=UGejkEqA+yW1sx20YmHj+cA8+ti30AjWZBE7ie0xBfSD3rP0M3LZw7goIK7B9Cgi9c
         7aedskkK+pwRDM3xSxaE3Q3+tT2gwJ6E8apsIHGdLv6RMpeXYBITICMV3F/1xj/13g2t
         cbCIDiwhV/KXeL5cDZNIzVXhCUzdx7SLlCtMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tIkbwf32ikRMR7fj9veNiBSh9gZIzE+HLHfATNQrYqs=;
        b=ciS6SXQMTw8IJwYYmZ5mUUBTYx4rBZ48VnNgrafGuKT+NwHji9yOvBOX/uX66f4W2a
         7rTbJHyvTX38pJqx1VShj6UlmVD+m5zjHp7j9yIZbL4KwA8L2UWABB69N7SwZDJv2LbT
         4ZsyXMGLk1fJ1mGbiSSZQBT0dF5CUokcIUE+HmLRPzJNW3f7+uxl8cJJYlYWDEGzKquS
         k6BoRbKPjexKaUZeFmaFJTSEcwWDdFumeEDU/LMyJXKKF9Kgg7ZSGupJFMOVSXFl1o6L
         Z2AT+jXQkCBY4Zau8FMXfaBIommLdHVN93kBN7BHX8thrqRVnEzbWxsOdHUrmKxxd2TT
         Zcjg==
X-Gm-Message-State: ABuFfojwFLY8J8Mz+9/i+OTD5QjVSHzc/V9VT+Nn8hdzFLZ7HVr8QZ8l
        Dp4rUjxnZQf/0oNrF0IQciYdKQ==
X-Google-Smtp-Source: ACcGV61t4Vi3iJsWMf6NBqjTfd8INeo6VGaun+AdUU5PLkanwuasq9cYOoZ8r9hTxdxt9oZpGNxrnw==
X-Received: by 2002:a6b:ef03:: with SMTP id k3-v6mr14413055ioh.17.1539718369641;
        Tue, 16 Oct 2018 12:32:49 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id x13-v6sm4294227ioa.27.2018.10.16.12.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 12:32:48 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:32:46 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 4.19-rc8
Message-ID: <20181016193246.nqq5xoo2aacpkyoe@xps.therub.org>
References: <20181015064915.GA10710@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015064915.GA10710@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 08:49:15AM +0200, Greg KH wrote:
> Hi all,
> 
> As mentioned last week, here's a -rc8 release as it seems needed.
> 
> There were a lot of "little" pull requests this week, semi-normal for
> this late in the cycle, but a lot of them were "fix up the previous fix
> I just sent" which implies that people are having a few issues still.
> 
> I also know of at least one "bad" bug that finally has a proposed fix,
> so that should hopefully get merged this week.  And there are some
> outstanding USB fixes I know of that have not yet landed in the tree (I
> blame me for that...)
> 
> Anyway, the full shortlog is below, lots of tiny things all over the
> tree.  Please go and test and ensure that all works well for you.
> Hopefully this should be the last -rc release.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.0-rc8
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git branch: master
git commit: 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e
git describe: v4.19-rc8
Test details: https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v4.19-rc8

No regressions (compared to build v4.19-rc7)
------------------------------------------------------------------------

No fixes (compared to build v4.19-rc7)
------------------------------------------------------------------------

Ran 19898 total tests in the following environments and test suites.

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

-- 
Linaro LKFT
https://lkft.linaro.org
