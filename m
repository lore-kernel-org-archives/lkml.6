Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937AEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B66E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F73A2YM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B66E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeGXPdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:33:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40523 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388460AbeGXPdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:33:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so4350014wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 07:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wV1gHw6KfqBzIJ8qKv0zVGYe+EEOwsi9aJrnnFubXLI=;
        b=F73A2YM7ze6mn5OuyBpSuZIV+q2m9aJxgIxA8kLNdH2IkOX4oYJ6my3QYBFc1Hk3+M
         hpKGH0shjOdJ2NjgyFt9mZ/sSGILsJjo4qnQtO1oOzAuwe2+2DmyZWsLUUh5mZrNT52Y
         w44dU8rrhnB7yl/aVfDcETniWFhP99nbbC5Cg++DeIyYZHUHSZz5Ns/7QQGWPrCPg35V
         zOPG1PY49pmWP1leaxG24niK86PffU3VaeeQApReaUnxmWDHeYQq3d6HNfxZJH9eM+Mn
         pS13hzfxO6nYyjfHbpSoPN5eyiVtZoNbO/SyLybhx4I69WpJlcl4l5Lkut/rGXBiIn1u
         +89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wV1gHw6KfqBzIJ8qKv0zVGYe+EEOwsi9aJrnnFubXLI=;
        b=GHjBMjkj6nd2hqZrNHNCLSsts+2ab16NeV7cfNJMXTNKYUJyrWm2muOlw2t7J2mbEa
         vvcMD/9+7FZx1IVBdlpNYQ1YeCt24RXZfCt+QZOQK7jo3PDYqXTAZshM/PvdkPIs17/q
         1yu+6+cIPTNZsj04pg6SOUbkmUmB7mDxVaoSyppQl6aRvT2rTHmYNwT5gaxtm7NKnXN0
         dNomXNrcvfy8zHC7wGdmRl0nccPwD5tW+U6ZIXpCVVvFb5BDajT49vcoIK2kBYFA9Gkz
         tOGUi6muwCqqVS6m4lVbkApC6tSp9jn+jv7+n5xCaNbvtVGuptyhfPFdyl/cdrmNClBn
         cb3Q==
X-Gm-Message-State: AOUpUlFV/x33Vjo9/tGZvqQ7oiVHvr15sSlty3mr98jz8jAg9xKoKcCv
        l9hwqv9Ts6jb8Znq5oW2Pfs=
X-Google-Smtp-Source: AAOMgpf/2ss29qsEDq2cpzdJpNJ9yJi4fLO/+YvXkrcBYYECWcTrU/4kEkM4dQhsyZrGEJ7SOHxgpg==
X-Received: by 2002:a5d:494c:: with SMTP id r12-v6mr11806527wrs.66.1532442410311;
        Tue, 24 Jul 2018 07:26:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w4-v6sm10565305wrt.40.2018.07.24.07.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 07:26:49 -0700 (PDT)
Date:   Tue, 24 Jul 2018 16:26:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v6 9/9] x86: jump-labels: use macros instead of inline
 assembly
Message-ID: <20180724142647.GA31700@gmail.com>
References: <20180622172212.199633-1-namit@vmware.com>
 <20180622172212.199633-10-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622172212.199633-10-namit@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> Use assembly macros for jump-labels and call them from inline assembly.
> This not only makes the code more readable, but also improves
> compilation decision, specifically inline decisions which GCC base on
> the number of new lines in inline assembly.
> 
> As a result the code size is slightly increased.
> 
>    text	   data	    bss	    dec	    hex	filename
> 18163528 10226300 2957312 31347140 1de51c4 ./vmlinux before
> 18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+1128)
> 
> And functions such as intel_pstate_adjust_policy_max(),
> kvm_cpu_accept_dm_intr(), kvm_register_readl() are inlined.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/entry/calling.h          |  2 +-
>  arch/x86/include/asm/jump_label.h | 77 +++++++++++--------------------
>  arch/x86/kernel/macros.S          |  1 +
>  3 files changed, 30 insertions(+), 50 deletions(-)

So I tried the series, and this patch causes a silent hard hang on bootup, with no 
(early-)console messages visible.

I've attached the config that triggers the problem, built with:

  gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC) 

it's 100% reproducible on both Intel and AMD test systems.

I'll continue to test the series with this patch left out.

So both the xtensa build failure and this boot failure needs to be fixed before I 
can apply this series.

Thanks,

	Ingo
