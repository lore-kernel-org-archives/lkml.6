Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C368DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E18D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM0UBMXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E18D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440794AbeKXECa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:02:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41938 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391344AbeKXEC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:02:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so10890639plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGi0emgTa06p+yUprJyoLzfAXBRqlWEGUgLHqTV8RGY=;
        b=HM0UBMXqEkPKdKRHj4CaKWfi4Ogz/cX509ajceDTlGj2TezPHM9ewQJjLU4BUKjw76
         2J1J+0SRT+yAp0kWXWiv4aOdtWbmJ2MKHGckulrcDsirenYjJ97Wm1px8PgCLjRNMhF5
         G1pIJSyDIr8kHXm2cDApJxN90WlM/RMOdfXlHUCsrEpVLDE2g7z8oQKGI+r0Y83ZKsps
         /nEWiGpL/jxr4xvID+K7E0UHOcItcjyjQ5IAj0u5JhCBm7g5k9hZ/VA4qVmT6zI1v8k1
         T3+Nn9xnIblBcXQnzM4wawySxj6Yatzo1WM8DZKPXELNLrMQfMtQOv2JHiVXloIGlHdH
         JUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGi0emgTa06p+yUprJyoLzfAXBRqlWEGUgLHqTV8RGY=;
        b=kdcYj75KmTbFskqrpNOvtXTi0O/foEQXaTsvP7EuMSjgQhl4kUweCr64fHNikv1ESO
         5reDIh4Ygrydvm8IUHNq3LdOzuTUfomyai3pkQESW3hYO4A2n82M6/9Xl3UE8PLyohgG
         NuYzEEgAVYl633i0XCklWO5WoT7aogWhyDOZHIyvB31nBzyRI3dkGjhYqQ9cTtnm7TMQ
         2csXl2AGUeZKt58JOcR2USXM7HGxPQ1uNnmPJXMVLHjIGtxHpHjEhZRcbMbpGjuzQkOI
         E7bv3MXYdI5TqAr8cqpBtkSfy7mMeDZYPA4aV43N0IWiT0ktVf9df4M+DE6E1Zk2WfxF
         qvbw==
X-Gm-Message-State: AA+aEWbVvmEHBCuEyuL25+Tl5zdS28TjO9YiUZeJbpfjVlcv9qcuf92v
        7QqOvcecmRjWZWmUAKm3LmM=
X-Google-Smtp-Source: AFSGD/VCEmRqml8vhRtCAbTKcXK4GkwzPOUMJWYApIIM1xO4XJ7O6aeduLNXTQjRGoAJu047Rv+yNw==
X-Received: by 2002:a17:902:887:: with SMTP id 7mr16411921pll.164.1542993442137;
        Fri, 23 Nov 2018 09:17:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17sm72931896pgm.26.2018.11.23.09.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 09:17:21 -0800 (PST)
Date:   Fri, 23 Nov 2018 09:17:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
Message-ID: <20181123171720.GA18841@roeck-us.net>
References: <20181112160910.GA28440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160910.GA28440@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 12, 2018 at 05:09:10PM +0100, Oleg Nesterov wrote:
> get_arg_page() checks bprm->rlim_stack.rlim_cur and re-calculates the
> "extra" size for argv/envp pointers every time, this is a bit ugly and
> even not strictly correct: acct_arg_size() must not account this size.
> 
> Remove all the rlimit code in get_arg_page(). Instead, add bprm->argmin
> calculated once at the start of __do_execve_file() and change copy_strings
> to check bprm->p >= bprm->argmin.
> 
> The patch adds the new helper, prepare_arg_pages() which initializes
> bprm->argc/envc and bprm->argmin.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>

This patch results in various qemu boot failures in -next. Bisect logs
are attached. It looks like all nommu boots are failing. I bisected an385
and m68k, but xtensa (kc705-nommu) fails with the same error.

[    5.416926] Run /sbin/init as init process
[    5.419792] Failed to execute /sbin/init (error -7)
[    5.421128] Run /sbin/init as init process
[    5.423284] Starting init: /sbin/init exists but couldn't execute it (error -7)
[    5.424747] Run /etc/init as init process
[    5.428507] Run /bin/init as init process
[    5.430478] Run /bin/sh as init process
[    5.433179] Starting init: /bin/sh exists but couldn't execute it (error -7)

Guenter

---
an385:

# bad: [8c9733fd9806c71e7f2313a280f98cb3051f93df] Add linux-next specific files for 20181123
# good: [9ff01193a20d391e8dbce4403dd5ef87c7eaaca6] Linux 4.20-rc3
git bisect start 'HEAD' 'v4.20-rc3'
# good: [34c2101b4f765edf1b91c2837da9c60fbf9f6912] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good 34c2101b4f765edf1b91c2837da9c60fbf9f6912
# good: [15367a0657fc8027ff3466bf0202bde9f270259b] Merge remote-tracking branch 'kgdb/kgdb-next'
git bisect good 15367a0657fc8027ff3466bf0202bde9f270259b
# good: [d29686ab179c34c5dbaac067a9effbeeb6a8073e] Merge remote-tracking branch 'soundwire/next'
git bisect good d29686ab179c34c5dbaac067a9effbeeb6a8073e
# good: [3381311f9a261c9d2863f0d52e9499c88ccb1f44] Merge remote-tracking branch 'cgroup/for-next'
git bisect good 3381311f9a261c9d2863f0d52e9499c88ccb1f44
# good: [b5bf9c4c28a25b74475c3f3d3fe6d5d737629ab7] Merge remote-tracking branch 'pinctrl/for-next'
git bisect good b5bf9c4c28a25b74475c3f3d3fe6d5d737629ab7
# good: [a75f6952444a401f5464e977caff2a84118b66c9] fs/epoll: deal with wait_queue only once
git bisect good a75f6952444a401f5464e977caff2a84118b66c9
# good: [d83de16290eefb4372520a61744b11bddb6e8f7e] Merge remote-tracking branch 'slimbus/for-next'
git bisect good d83de16290eefb4372520a61744b11bddb6e8f7e
# good: [f2d2d58687c8300fe4ebf09d78b26cd68c825df7] Merge remote-tracking branch 'xarray/xarray'
git bisect good f2d2d58687c8300fe4ebf09d78b26cd68c825df7
# bad: [eac22eb65c3cc96d8cb2c7aac7dd816030a86955] ipc: allow boot time extension of IPCMNI from 32k to 8M
git bisect bad eac22eb65c3cc96d8cb2c7aac7dd816030a86955
# good: [fb95dde314b136e9598a56350b3de3994d272486] exec: increase BINPRM_BUF_SIZE to 256
git bisect good fb95dde314b136e9598a56350b3de3994d272486
# bad: [fb704fe633a3ca80a68282d5c3c665c4382f500b] exec-separate-mm_anonpages-and-rlimit_stack-accounting-checkpatch-fixes
git bisect bad fb704fe633a3ca80a68282d5c3c665c4382f500b
# bad: [eed684faf14610c2063c1f03e0a1f5ef56f23bb4] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
git bisect bad eed684faf14610c2063c1f03e0a1f5ef56f23bb4
# first bad commit: [eed684faf14610c2063c1f03e0a1f5ef56f23bb4] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting

---
m68k:

# bad: [8c9733fd9806c71e7f2313a280f98cb3051f93df] Add linux-next specific files for 20181123
# good: [9ff01193a20d391e8dbce4403dd5ef87c7eaaca6] Linux 4.20-rc3
git bisect start 'HEAD' 'v4.20-rc3'
# good: [34c2101b4f765edf1b91c2837da9c60fbf9f6912] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good 34c2101b4f765edf1b91c2837da9c60fbf9f6912
# good: [15367a0657fc8027ff3466bf0202bde9f270259b] Merge remote-tracking branch 'kgdb/kgdb-next'
git bisect good 15367a0657fc8027ff3466bf0202bde9f270259b
# good: [d29686ab179c34c5dbaac067a9effbeeb6a8073e] Merge remote-tracking branch 'soundwire/next'
git bisect good d29686ab179c34c5dbaac067a9effbeeb6a8073e
# good: [3381311f9a261c9d2863f0d52e9499c88ccb1f44] Merge remote-tracking branch 'cgroup/for-next'
git bisect good 3381311f9a261c9d2863f0d52e9499c88ccb1f44
# good: [b5bf9c4c28a25b74475c3f3d3fe6d5d737629ab7] Merge remote-tracking branch 'pinctrl/for-next'
git bisect good b5bf9c4c28a25b74475c3f3d3fe6d5d737629ab7
# good: [a75f6952444a401f5464e977caff2a84118b66c9] fs/epoll: deal with wait_queue only once
git bisect good a75f6952444a401f5464e977caff2a84118b66c9
# good: [d83de16290eefb4372520a61744b11bddb6e8f7e] Merge remote-tracking branch 'slimbus/for-next'
git bisect good d83de16290eefb4372520a61744b11bddb6e8f7e
# good: [f2d2d58687c8300fe4ebf09d78b26cd68c825df7] Merge remote-tracking branch 'xarray/xarray'
git bisect good f2d2d58687c8300fe4ebf09d78b26cd68c825df7
# bad: [eac22eb65c3cc96d8cb2c7aac7dd816030a86955] ipc: allow boot time extension of IPCMNI from 32k to 8M
git bisect bad eac22eb65c3cc96d8cb2c7aac7dd816030a86955
# good: [fb95dde314b136e9598a56350b3de3994d272486] exec: increase BINPRM_BUF_SIZE to 256
git bisect good fb95dde314b136e9598a56350b3de3994d272486
# bad: [fb704fe633a3ca80a68282d5c3c665c4382f500b] exec-separate-mm_anonpages-and-rlimit_stack-accounting-checkpatch-fixes
git bisect bad fb704fe633a3ca80a68282d5c3c665c4382f500b
# bad: [eed684faf14610c2063c1f03e0a1f5ef56f23bb4] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
git bisect bad eed684faf14610c2063c1f03e0a1f5ef56f23bb4
# first bad commit: [eed684faf14610c2063c1f03e0a1f5ef56f23bb4] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
