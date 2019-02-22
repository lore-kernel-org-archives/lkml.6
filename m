Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B24206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfBVWmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:42:02 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57934 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbfBVWmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:42:01 -0500
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x1MMg0m6006423
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 17:42:00 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x1MMft9a009596
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 17:42:00 -0500
Received: by mail-qk1-f199.google.com with SMTP id a65so2721444qkf.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=NLECEbCIH6cCw334hPotN4oqXxXbzA48pBvT+ZNftAU=;
        b=Hz2ewOKVaX6N7d8XpiiI+/MGNkRoYVvqTfQmSRM951yIwsn5DiIbUSE+30nBWIRPKU
         jfSpGZcIMdG4KpUlzuGwxi42iGu50MGZF81DpsD7X0e69Kze+vmh22s9d9E8/bteGcCt
         wm1s8qZEea7FzIq6WmRhB6NyoVdGSzyTAkhslsoIzTz3ybFzBaciYLdogytcLmIqRE/E
         N0p87f9LSEVKDnFcCeNJkU3FiIO65iigxmFv1dLSQ59Vj9/T6YfYvE5jHVFC032RYUUn
         SMYw9PHOTXxe2VMylFHHCl4+ocnotxGgsIvyDlf5hshD0uuM/Lz4pXnLWpZfTWrw841K
         MpIw==
X-Gm-Message-State: AHQUAua6WFCRQ9Xi5eRdTXnNEPwv+t43A9f/f/WxjG2Lihmo8gsnGBhT
        M89UD740tXwNjWlPDldIJsU2P9+bi1YN1mEFUTGLHV0JleesTxbmKmQ1IQ53iNwkEj5vKZiQYdj
        Q3q+38rg2IddtMnrTP+TAF5JtzwHpOWX/Dvo=
X-Received: by 2002:a0c:9ad4:: with SMTP id k20mr5069052qvf.220.1550875315292;
        Fri, 22 Feb 2019 14:41:55 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYJfTjpIfB8zJcobo+cOa75+ynlX7/4WvgsjR91LpfDH7BBxAMMtABzAs6O/uLFRnwQs7uYUQ==
X-Received: by 2002:a0c:9ad4:: with SMTP id k20mr5069039qvf.220.1550875315066;
        Fri, 22 Feb 2019 14:41:55 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:5952:f06b:5958:9b7c])
        by smtp.gmail.com with ESMTPSA id r44sm1566649qtb.53.2019.02.22.14.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 14:41:53 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Daniel Borkmann <daniel@iogearbox.net>
cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [bpf] 568f196756: BUG:assuming_atomic_context_at_kernel/seccomp.c
In-reply-to: <cdd8143b-7719-b51e-5a6a-6bdc065cc773@iogearbox.net>
References: <20190221133556.eqzclahgngq53s64@inn2.lkp.intel.com>
 <cdd8143b-7719-b51e-5a6a-6bdc065cc773@iogearbox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 22 Feb 2019 17:41:52 -0500
Message-ID: <14415.1550875312@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 14:39:27 +0100, Daniel Borkmann said:
> Fyi, false positive and already fixed in bpf-next.
>
> (https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=435b3ff5b08a99a15647be32735abf8db66cea9a)

Is there a reason this commit appeared in next-20190221 but did not seem to be
in next-20190222 (confirmed via 'git tag --contains')?

[/usr/src/linux-next] git tag -l next-20190222
next-20190222
 [/usr/src/linux-next] git tag --contains 435b3ff5b08a99a15647be32735abf8db66cea9a
next-20190221

(I went ahead and 'git cherry-pick -n' it on top of 0222)
