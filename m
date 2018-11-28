Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A682081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht0lntfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A682081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeK1ULF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:11:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1ULE (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:11:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so1721358wmc.5
        for <Linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e2iQISHrec2bKuxmj5M6sV6evn+cDR4oI/onJCum89w=;
        b=ht0lntfIV9CbUvohSsjd5MkTMYAAnZR8HFGH/4KdhtGBAiZ8IjzbyRHoFURdUrrOvE
         1x69LxoW40/7jMjkyMHHyfiDQD12MJKKe0ltRyy5moMOFesJK6JB1TpMxs3DkKaGOygZ
         UJUbujLPdKd6rmsUe02HLsEbJsHjFEtriyM8B8UDkirnxEt0wRjjF6TA9BaK2Wo/Axxf
         ESKUTVeIWGTexTF6ZHd+TKj0mbbJGX0wtdTlozV9OocIeTtWcfb3rqGQNl0rVU3Qars1
         tF+pFSILLux+iroyW9m4EYz6IrGABUSPEza+6OuyhahxYYbNcxJVdrw5QCUz34Nub87T
         M5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e2iQISHrec2bKuxmj5M6sV6evn+cDR4oI/onJCum89w=;
        b=JSTk4mu6yrEFz+EQ3FETCszR9Pw2fFsUIkMc5OEcfnlL3qWv2jdfJ7NRkBdznGnulI
         +I/9XQdcixSGREtrxBLj+VGXGshMjXfhkJ/1nyo0tr72WSgFeeHRQuCCOILZ8vnkzQta
         WN7atWiFAmQCCEPuU0UdJeGCCZLzUk+N6zahVBII5CEam7CYv4LhmxHE4cevS1Lp4KKg
         /P/s09q39PnN7iBmAv2/yodwoAPQzpI8aqIvsbrZbmg5TNHYEYTYqEgLvEKOUrhadf7i
         35Ro1+croKUxjt1vOQr27yXvrVYh3Oh+LvjE6b5AyxCV1Oo6Q/r/hZUBGth16whN5Iqa
         AryA==
X-Gm-Message-State: AA+aEWb+ianm1Iz42xFXmSN62TM//xxN9qHo+8Y56StYGgDv2kAQqOLd
        6aFGUaQxwdCU+ePEQxH5RhU=
X-Google-Smtp-Source: AFSGD/XoZKmXhn/fc/mqKYrlhjKcnNnoWZbSs3hwBlzPQ2EOP3wLPVIWkjxNIhXV+IgaqKECpIA1RA==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr1800472wmd.29.1543396208493;
        Wed, 28 Nov 2018 01:10:08 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h203sm4415189wma.19.2018.11.28.01.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:10:07 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:10:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 0/3] perf report/annotate: Support average IPC and IPC
 coverage for function
Message-ID: <20181128091005.GA8645@gmail.com>
References: <1543418098-10435-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543418098-10435-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jin Yao <yao.jin@linux.intel.com> wrote:

> Add supporting of displaying the average IPC and IPC coverage
> percentage per function.
> 
> For example,
> 
> $ perf record -b ...
> $ perf report -s symbol or
>   perf report -s symbol --stdio
> 
> Overhead  Symbol                           IPC   [IPC Coverage]
>   39.60%  [.] __random                     2.30  [ 54.8%]
>   18.02%  [.] main                         0.43  [ 54.3%]
>   14.21%  [.] compute_flag                 2.29  [100.0%]
>   14.16%  [.] rand                         0.36  [100.0%]
>    7.06%  [.] __random_r                   2.57  [ 70.5%]
>    6.85%  [.] rand@plt                     0.00  [  0.0%]
>   ...
> 
> $ perf annotate --stdio2
> 
> Percent  IPC Cycle (Average IPC: 2.30, IPC Coverage: 54.8%)
> 
>                         Disassembly of section .text:
> 
>                         000000000003aac0 <random@@GLIBC_2.2.5>:
>   8.32  3.28              sub    $0x18,%rsp
>         3.28              mov    $0x1,%esi
>         3.28              xor    %eax,%eax
>         3.28              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x1e0
>  11.57  3.28     1      ↓ je     20
>                           lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
>                         ↓ jne    29
>                         ↓ jmp    43
>  11.57  1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0

That's a nice feature: please add meaningful documentation, accessible 
via the perf help system preferably, that outlines how the IPC metrics 
should be interpreted and how they are useful when optimizing programs.

Thanks,

	Ingo
