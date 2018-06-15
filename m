Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42D39C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F06208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="iH6gru1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F06208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965990AbeFOQEv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:04:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39936 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965930AbeFOQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:04:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so15378878lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aPcQvmdLT70aNZA0Mzptu2XsCWgB41l+2K41lyaocjg=;
        b=iH6gru1cGa6NgbhYEeNKt050iESkt36MbHfl0wvnEz4q7BLtKRbu/GvtuJFt/LDSox
         Ns7cyCYwZAbCokkkSvBI5jkM+bdgV0F+SojZjnDujEF3a+ZbY7lPtalk62E4FIehvQeO
         aEm/9OZq3I9pURtydcSFWNCAmOKmmpX2Kt57dOrAOmI8sk+Tg2syg3kN5oEIDLgbdt/x
         qRmR3vuDzDXkp9QwqVgFNGsnm1Z/hpUo9jsrIPT598KOVq+BPj0rhehInBZXypiLNd2R
         jvnnC0zl29A/LuBQRYe9jg1Lj4K+/oSrhajiLnkx9+ZPSAGHc9AQ1T5dgnDKjZ6AJBLC
         tM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aPcQvmdLT70aNZA0Mzptu2XsCWgB41l+2K41lyaocjg=;
        b=MA/dgrWtd6F/+0nH63H1+0/pHkkGuaFFZuaVchhX4WhLRId37h5mEZvFt2Si/cMqF9
         R2gloLQACqlu4UEYi8YUaTIlAlwog3VdRK0BxcKmpcapuogx0uTG7yAxF2eWouqYtWdf
         lsWn6ftYIOrU4sIVVZjfPvZM9GxzqSkX+jcfbBNaTfA8v1cLBspPCsJlH+Zg/8zxX3kS
         YCUGfL5zXv7/lX2HvffxOdZ0dAVm6qoe+SPcv5P+rfOPBuR8xMKthADhAKLDRBLpYy1O
         4HbWX2vJz5/rGkIPg4UvhcWH+ixdCiEkMJoGzKQQEo6eUF/dMRCOLRKnCwJmF+1zcrmj
         KgNA==
X-Gm-Message-State: APt69E3UO4NSVDY1IXn+JmgcaR9TzeR1nG9SsH9Z+iSyHEw6bmYacP/6
        ce09vVS8IFapXI5Pd8bNsiQ+/9Ow94Y=
X-Google-Smtp-Source: ADUXVKIGpoXf4GrtIx3DdmAki9uBe4rXTnKbdGWRFiKNXlm3VHi43z9Bkzcd6Mp7hsMT/A5uCxDiWA==
X-Received: by 2002:a19:2c94:: with SMTP id s142-v6mr1643034lfs.121.1529078687606;
        Fri, 15 Jun 2018 09:04:47 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.128])
        by smtp.gmail.com with ESMTPSA id s18-v6sm1510337ljg.87.2018.06.15.09.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 09:04:46 -0700 (PDT)
Subject: Re: [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180615155237.8166-1-thomas.petazzoni@bootlin.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <474bbdcc-d78f-faa0-b2c3-3650cc870b36@cogentembedded.com>
Date:   Fri, 15 Jun 2018 19:04:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180615155237.8166-1-thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06/15/2018 06:52 PM, Thomas Petazzoni wrote:

> The fast path of get_user_pages_fast() disables IRQs and then does:
> 
>  - gup_pud_range()
>    - gup_pmd_range()
>      - gup_pte_range()
>        - flush_dcache_page()
> 
> However, flush_dcache_page() makes a smp_call_function(), and using
> smp_call_function() when IRQs are disabled is not allowed.
> 
> In order to work around this problem, this commit prevents the fast
> path from get_user_pages_fast() from being used on SMP, and directly
       ^^^^ of?
   Else it sounds a bit tautological...

> uses the slow path, which doesn't disable interrupts.
> 
> Fixes the following warning when get_futex_key() is called:
> 
> WARNING: CPU: 1 PID: 410 at kernel/smp.c:416 smp_call_function_many+0x1fc/0x2ac
> Modules linked in:
> 
> CPU: 1 PID: 410 Comm: wdc-pfmu-test Tainted: G           O    4.13.0-00035-g0d3023c733a0-dirty #363
> task: 97d9a120 task.stack: 97d2e000
> PC is at smp_call_function_many+0x1fc/0x2ac
> PR is at smp_call_function_many+0x1e2/0x2ac
> PC  : 88071fd4 SP  : 97d2fcd4 SR  : 400080f1
> TEA : c06d6840
> R0  : 000000f0 R1  : 00000002 R2  : 00000000 R3  : 8849c89c
> R4  : 886d62c4 R5  : 886d62c4 R6  : 886db928 R7  : 884a9dec
> R8  : 00000000 R9  : ffffffff R10 : 8844667c R11 : 29ee9000
> R12 : 8844667c R13 : 00000001 R14 : 97d2fcd4
> MACH: 000177e7 MACL: 0000018c GBR : 295742d0 PR  : 88071fba
> 
> Call trace:
>  [<8800fe2c>] sh4_flush_dcache_page+0x0/0xa4
>  [<880720a2>] smp_call_function+0x1e/0x50
>  [<8800fe2c>] sh4_flush_dcache_page+0x0/0xa4
>  [<8800ecc0>] flush_dcache_page+0x34/0x74
>  [<88010d1c>] gup_pte_range+0xd0/0x140
>  [<88010e04>] gup_pmd_range+0x78/0xa8
>  [<88010c4c>] gup_pte_range+0x0/0x140
>  [<88011006>] get_user_pages_fast+0xda/0x130
>  [<8806f376>] get_futex_key+0x72/0x3a0
>  [<8806f6a4>] futex_wait_setup+0x0/0x10c
>  [<88055a08>] __rcu_read_unlock+0x0/0x54
>  [<880559c8>] __rcu_read_lock+0x0/0x1c
>  [<88010f2c>] get_user_pages_fast+0x0/0x130
>  [<8806f6de>] futex_wait_setup+0x3a/0x10c
>  [<8806f6a4>] futex_wait_setup+0x0/0x10c
>  [<8806f852>] futex_wait+0xa2/0x1b8
>  [<8806f6a4>] futex_wait_setup+0x0/0x10c
>  [<88071c00>] smp_call_function_single+0xac/0x108
>  [<8800e908>] cache_noop+0x0/0xc
>  [<8800e908>] cache_noop+0x0/0xc
>  [<88071018>] do_futex+0x108/0x8f8
>  [<880bdfe4>] finish_fault+0x38/0x70
>  [<880bdff2>] finish_fault+0x46/0x70
>  [<880bf212>] handle_mm_fault+0x2f6/0x954
>  [<880bf21a>] handle_mm_fault+0x2fe/0x954
>  [<88030e64>] resched_curr+0x54/0x6c
>  [<8832be9e>] _raw_spin_lock_irqsave+0xa/0x18
>  [<880718dc>] SyS_futex+0xd4/0x124
>  [<8801488e>] SyS_clone+0x16/0x24
>  [<8800727e>] syscall_call+0x18/0x1e
>  [<88071808>] SyS_futex+0x0/0x124
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
[...]

MBR, Sergei

