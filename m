Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B475C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E863208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWFYA+5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E863208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeGaO7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:59:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37100 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbeGaO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:59:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so6105067pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xyrhXMRt1Sc9C7jAsL+2X2v0+6M1KWEp6f57A6YR1Ts=;
        b=EWFYA+5GxZXSRCR7Lc4K2gD3LhTzFplrmj7HHYodffgPuuE1PRKZcP3q/giFi2ZWqi
         Rr3JXkC9oykXRq5lwOd16wpTs0hJPWmv61nU6o0CbjlgMTejjze5t7XZiOw5/V8gI1Mh
         bA0/J8LBOtjhcp6YZI0I0S0s2b42tDp9Z58mqRTipycHXBmKCzpZz+drLy4fX/6VUxZg
         tx7/eqEQlegRh3QIv5E22jyWe7w8z7Nln31gFMNUe2iZgFxkJSvtYgOseBdo54p09/3n
         UOPf/2GF2BZGEC6uzfFd6ILASuK9XXuFDfqhPQzbqQ63YlosmqhPx1FNXTVpY9BGM9rj
         4YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xyrhXMRt1Sc9C7jAsL+2X2v0+6M1KWEp6f57A6YR1Ts=;
        b=jsxKuNXroVNyyFuPkyHIcnZkMTDkPJ36kXk1Z5fyqGExCVXxwb8rLA2CABPNTPkV+z
         IsgDTaCZB8ewEmMf0srLsKwEFDoHZm43lJ2nzo873K2rQNPZOf2m+0araLiYnHfJckyU
         J75CC1nYM82zae+iSYb+kRKXYQdpY+hXrBMFN1Qdt+e920V2ksG/u5/GMplivvLVooe6
         sN+uk2HBFpSDGoiAEAszNw3tLxlCS6337ZqyiBHxntyXRYiLTHkzWLZ+hF6jUav0avu7
         YRQEAi2tfL733rDRBRZ6GQpSO6MXW1LwQwTyd/HV64WnD8oxnsyCVvQXdi9H52FCsovP
         87BQ==
X-Gm-Message-State: AOUpUlEkB6OE2uIcmUgYO3HG9tnsIj5m4WedL7cZxFIzwHK5N8ZSiTrG
        QSERFtE9q3NH4xXFZWRFATg=
X-Google-Smtp-Source: AAOMgpdPodCt98t4kZ8edSHq6hJp6IrzFszKVCJFgIROJYqZ/k7Pdr3L/bbTMqj6ozXGMYePvBDsBQ==
X-Received: by 2002:a62:d24a:: with SMTP id c71-v6mr22272631pfg.242.1533043169656;
        Tue, 31 Jul 2018 06:19:29 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h24-v6sm30967062pfk.113.2018.07.31.06.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:19:28 -0700 (PDT)
Date:   Tue, 31 Jul 2018 06:19:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH] sched/clock: disable irq for generic_sched_clock_init
Message-ID: <20180731131927.GA8906@roeck-us.net>
References: <20180730135252.24599-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730135252.24599-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:52:52AM -0400, Pavel Tatashin wrote:
> sched_clock_init() used be called early in boot  when IRQs are still
> disabled. Now, it is called when IRQs are already enabled, and this
> triggers some warning:
> 
> WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:180
> sched_clock_register+0x44/0x278
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc6-next-20180724 #1
> Hardware name: ARM Integrator/CP (Device Tree)
> [<c0010cb4>] (unwind_backtrace) from [<c000dc24>] (show_stack+0x10/0x18)
> [<c000dc24>] (show_stack) from [<c03ffb94>] (dump_stack+0x18/0x24)
> [<c03ffb94>] (dump_stack) from [<c001a000>] (__warn+0xc8/0xf0)
> [<c001a000>] (__warn) from [<c001a13c>] (warn_slowpath_null+0x3c/0x4c)
> [<c001a13c>] (warn_slowpath_null) from [<c052367c>] (sched_clock_register+0x44/0x278)
> [<c052367c>] (sched_clock_register) from [<c05238d8>] (generic_sched_clock_init+0x28/0x88)
> [<c05238d8>] (generic_sched_clock_init) from [<c0521a00>] (sched_clock_init+0x54/0x74)
> [<c0521a00>] (sched_clock_init) from [<c0519c18>] (start_kernel+0x310/0x3e4)
> [<c0519c18>] (start_kernel) from [<00000000>] (  (null))
> ---[ end trace 08080eb81afa002c ]---
> 
> Disable IRQs for the duration of generic_sched_clock_init().
> 
> Fixes: 857baa87b642 ("sched/clock: Enable sched clock early")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
