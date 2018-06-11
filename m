Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D6288C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875D3208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ieir3JK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875D3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeFKRrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:47:13 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42174 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933385AbeFKRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:47:10 -0400
Received: by mail-yb0-f193.google.com with SMTP id d123-v6so6976022ybh.9;
        Mon, 11 Jun 2018 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WLGScaBHVojP48okyhDwHpJ3zAItkqtwn11jZTDqoZ4=;
        b=Ieir3JK99yUQpKykwFf0CYacR4wQgpY5n1suq0me6mZwjfR2iene9gRBDRHk3Bbfqg
         PKw1MsIvG4Eq8P2SVNcHxnmJY4HoHemgJCQ42hYajWsnITGoQCi1e7uyRMqAh8Pcx16V
         dy3ifTxOgd2znhNor87DKKvHajJsbPRtCf9b5ofttgHqChq56qpYbrj4VRvsUX/L9e+s
         ouPKal/yCRmG0AuAlcWDwHpsP0tGz7v9SbIgCM3jMjMymw/hnjkVGgXjDQmtN2TqK9BN
         PffB548IlS6+N/gzFUn8EtZVjO64NX1pGeElzirx+wFM1MEShJ3/zKjQ1pG567M9aGNM
         xSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WLGScaBHVojP48okyhDwHpJ3zAItkqtwn11jZTDqoZ4=;
        b=uROqfmRnuxxztLXKqh6YWvX0ox27mol1q+cTLLngOJFoieenJ3dkqM5yXms09eWLvg
         +s3kpaiPk/iZAgW/huJ9nGXlD/mCrix3jRp+JuTosCxqxl27ecUDcx3T8V+VkPXXVa3w
         cbsCTAYfoIndR0E4K7gP4EQwJJ+ysm0KBb6HrQr3/p0oW5MjOBLYiAG3xJFT4RbF4gUn
         7ZQmi9Jaui/GQz4K3dnMUQdEYR/rMpBttrbGqUDFHt17zJAXUpA+sdx2Q0OMDmW3eUes
         AjY+x/whSiZUiPusgjLD936L4K5XLTQ6RKI3BOKirh31eBcSrNAXdn6lt4Pa6JZV/smt
         6KbQ==
X-Gm-Message-State: APt69E25hOchfmLWxiC2fzZWtBswOlFfVqdspBkciWL0xAxsk9pwDO+t
        yDF8WACZJQwvPrZJcQ0QkCLZIFWSD13vL5LPli8=
X-Google-Smtp-Source: ADUXVKImNLv7/LpZFEFCtTOiMf1RABQybPNCVZHFKmndLaK81m3NoKcAYmOBYnWCmqdjYDPaP1kb5WOakKll5KdqGac=
X-Received: by 2002:a25:ac12:: with SMTP id w18-v6mr82939ybi.77.1528739229728;
 Mon, 11 Jun 2018 10:47:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:a0cb:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 10:47:09
 -0700 (PDT)
In-Reply-To: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
References: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Mon, 11 Jun 2018 14:47:09 -0300
Message-ID: <CA+ToGPGtMfzMYEgS=y+CxwYDAzjmRbvr1JE-i6PeVGpfm_7wOA@mail.gmail.com>
Subject: Re: Regression: x86/tsc: Fix mark_tsc_unstable()
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, len.brown@intel.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:59 AM, Jeremy Cline <jeremy@jcline.org> wrote:
> Hi folks,
>
> A few Fedora users have reported[0] a regression starting in v4.16.8
> where the boot will hang ~1/3 of the time with the following RCU stall
> warning:
>
> INFO: rcu_sched detected stalls on CPUs/tasks:
> o1-...!: (0 ticks this GP) idle=688/0/0 softirq=171/171 fqs=0
> o(detected by 0, t=60002 jiffies, g=-142, c=-143, q=9)
> Sending NMI from CPU 0 to CPU 1:
> NMI backtrace for cpu 1 skipped: idling at
> acpi_processor_ffh_cstate_enter+0x65/0xb0
> rcu_sched kthread starved for 60002 jiffies! g18446744073709551474
> c1844674407370955143 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 -> cpu=1
> RCU grace-period kthread stack dump:
> rcu_sched       I    0     9      2 0x80000000
> Call Trace:
>  ? __schedule+0x234/0x850
>  schedule+0x28/0x80
>  schedule_timeout+0x166/0x380
>  ? __next_timer_interrupt+0xc0/0xc0
>  rcu_gp_kthread+0x368/0x830
>  ? rcu_process_callbacks+0x4f0/0x4f0
>  kthread+0x112/0x130
>  ? kthread_create_worker_on_cpu+0x70/0x70
>  ret_from_fork+0x35/0x40
>
> A user has bisected the problem to the v4.16 commit 1ab4ca7c59d4
> ("x86/tsc: Fix mark_tsc_unstable()"). According to the reporter,
> explicitly setting "tsc=" on the kernel command line causes the boot to
> always succeed. All the users have Thinkpad T500s or T400s (Core 2 Duos)
>
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1579925
>
>
> Thanks,
> Jeremy

Everything works fine here with 4.16.8+ on my desktop with E5500 CPU.

[diego@dualcore ~]$ uname -a
Linux dualcore 4.16.13-2-ARCH #1 SMP PREEMPT Fri Jun 1 18:46:11 UTC
2018 x86_64 GNU/Linux
[diego@dualcore ~]$
