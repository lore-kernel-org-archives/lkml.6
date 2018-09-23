Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B72ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209C2214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1rcxRWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209C2214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeIWMlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 08:41:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52549 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIWMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 08:41:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id l7-v6so1846403wme.2;
        Sat, 22 Sep 2018 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6Q5AqId683ZOVDgSgYgyMi+eVDblYMC+fX5Er0E9ec=;
        b=I1rcxRWDU8w0kaRt5sEVA0SXxNaM3gK6sGsiMdBltmDgYG2Qxs6ZlbOycT6YEix0Up
         +7ZwNyPeQA8hmiX6zT2Mw5pZyvBqGZiXKlcfvaF4ikyyd9u9V4k1DuN1V9gDZtI92yhM
         Uc27mO+uRqLtMLiK/i+ZsZCTpb3wZS2ombtjnJgPZtTTyk87ipa/8Ju/+N1PIBXXbgLB
         FG/zwu2YFf32DIYTnkXABjafHegCPowThk+ZDMsUoBdQn/yX9TRt1lot6nNVJmUJVXEZ
         GMJFhvFuNOC2AAUcCiZ/2cAVImkHne6AVjvLXJyohzAEH3I+FGk00eQqJ7zUHgs3UOSD
         Lzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6Q5AqId683ZOVDgSgYgyMi+eVDblYMC+fX5Er0E9ec=;
        b=mhldT+z/cVkAkU9OM/U16pd49xRXyFOPlsUF2r/WHgYwAtqDGChQ08H+RlV8/t+pV4
         ry5pPBbF3CGrKLw80+JgMDRnCWZD/Tj9vxVK+RQefc+UAme3X7WlkPWQyflfDvWlxihy
         6sw1L8F5oE3i6kSbkWPVfj59hS7E1Ev4EuktH/E1VkKGbDougPRPI/vdnkmNGcMlDW9K
         iMpK4jl+CSjqPdIsSjcW72NwkhUycSauLWJrPuew74E0Qu2O94+FF/a2W4rGrrSSyTwa
         rflr/1DMgru4wSJuVxWcB6+oQPCo4aeNeb5OqPv5Xf7mp4h1G1cvAtL5WY3YsdAtPoI7
         Rb0g==
X-Gm-Message-State: ABuFfoiNcxAgs/y6blxdehxpAoX4AnuimYxIYgMOoGalPFdq0SH2KXOb
        lt6v3QoJrmBFnVCs7SKjF5c=
X-Google-Smtp-Source: ANB0VdbM9F9lassu5Bpvso9pAQCvVkrc3DLuX+L+mtnvcDGVjDOuCtAMnHvzC4UH3eKmFxklKysSMw==
X-Received: by 2002:a1c:ed4:: with SMTP id 203-v6mr3091269wmo.96.1537685087841;
        Sat, 22 Sep 2018 23:44:47 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v16-v6sm42296267wrw.12.2018.09.22.23.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 23:44:47 -0700 (PDT)
Date:   Sat, 22 Sep 2018 23:44:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for
 rds_ib_stats
Message-ID: <20180923064445.GC12338@flashbox>
References: <20180921180451.18711-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921180451.18711-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:04:51AM -0700, Nathan Chancellor wrote:
> Clang warns when two declarations' section attributes don't match.
> 
> net/rds/ib_stats.c:40:1: warning: section does not match previous
> declaration [-Wsection]
> DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);
> ^
> ./include/linux/percpu-defs.h:142:2: note: expanded from macro
> 'DEFINE_PER_CPU_SHARED_ALIGNED'
>         DEFINE_PER_CPU_SECTION(type, name,
> PER_CPU_SHARED_ALIGNED_SECTION) \
>         ^
> ./include/linux/percpu-defs.h:93:9: note: expanded from macro
> 'DEFINE_PER_CPU_SECTION'
>         extern __PCPU_ATTRS(sec) __typeof__(type) name;
> \
>                ^
> ./include/linux/percpu-defs.h:49:26: note: expanded from macro
> '__PCPU_ATTRS'
>         __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))
> \
>                                 ^
> net/rds/ib.h:446:1: note: previous attribute is here
> DECLARE_PER_CPU(struct rds_ib_statistics, rds_ib_stats);
> ^
> ./include/linux/percpu-defs.h:111:2: note: expanded from macro
> 'DECLARE_PER_CPU'
>         DECLARE_PER_CPU_SECTION(type, name, "")
>         ^
> ./include/linux/percpu-defs.h:87:9: note: expanded from macro
> 'DECLARE_PER_CPU_SECTION'
>         extern __PCPU_ATTRS(sec) __typeof__(type) name
>                ^
> ./include/linux/percpu-defs.h:49:26: note: expanded from macro
> '__PCPU_ATTRS'
>         __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))
> \
>                                 ^
> 1 warning generated.
> 
> The initial definition was added in commit ec16227e1414 ("RDS/IB:
> Infiniband transport") and the cache aligned definition was added in
> commit e6babe4cc4ce ("RDS/IB: Stats and sysctls") right after. The
> definition probably should have been updated in net/rds/ib.h, which is
> what this patch does.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/114
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  net/rds/ib.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/rds/ib.h b/net/rds/ib.h
> index 73427ff439f9..fd483760c910 100644
> --- a/net/rds/ib.h
> +++ b/net/rds/ib.h
> @@ -443,7 +443,7 @@ int rds_ib_send_grab_credits(struct rds_ib_connection *ic, u32 wanted,
>  int rds_ib_xmit_atomic(struct rds_connection *conn, struct rm_atomic_op *op);
>  
>  /* ib_stats.c */
> -DECLARE_PER_CPU(struct rds_ib_statistics, rds_ib_stats);
> +DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);

I have sent a v2 because this should be DECLARE_PER_CPU_SHARED_ALIGNED,
not DEFINE (thanks to 0day for catching it).

I will make sure the '--in-reply-to' option in the future.

Nathan

>  #define rds_ib_stats_inc(member) rds_stats_inc_which(rds_ib_stats, member)
>  #define rds_ib_stats_add(member, count) \
>  		rds_stats_add_which(rds_ib_stats, member, count)
> -- 
> 2.19.0
> 
