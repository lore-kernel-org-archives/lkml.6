Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12C2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2McwbOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F12C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeGOW7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:59:14 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46346 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeGOW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:59:14 -0400
Received: by mail-wr1-f41.google.com with SMTP id s11-v6so30024092wra.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbkQXVQrZ64UEgGdmPrimNG6EFaJ5b+KTi3T4qbQuhY=;
        b=u2McwbOE502QL654bWITHBSQP1pKGQxfZjLTCmwXgMNIP5ly9kAyDVgA5FUnijSgXl
         w1oEDbsoRVtF/y0jx8c+zXBpwImCTG/vBtrol9YuaFF5f1wMXZnyyhmymT/Adul6RkBt
         6WWhafRMi/trHqeAMlqBzdYrR9HNabM0DnsuM1lbu+OBUKIqX/VoQdwUhivTRJmXjdhH
         k7MdsiftQ/3QwKza+QmiWQIPlIQ+NKTWLCNuLN/6+C3/l1h11+qj2HRqFoOMjqKju5Cn
         +4x1X+G0G1dVuukHTb+F1GcgCe8iI5eeHU5HPBQvGw1mlCYekTDrBgIMnmq7sb3px41b
         6taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbkQXVQrZ64UEgGdmPrimNG6EFaJ5b+KTi3T4qbQuhY=;
        b=cphBs2yqR1F+V4GePffiIdBt/LTOTQqopV6/JXXEcWemqN26IaXnclRVRfTA3GasXI
         WiCJfz7eNG3YNuhnPSK5DjIBq7whIGfFMHoAHJ/CRiYULAKUy9bY20PfOzNTDegSaTNA
         TM33uNHreWNb8N7Mw2HQWVjIyrqK0FZ063gkXuTgquBpkH1pyllT663LlLzsTA1cMBDW
         8oOqcTcmoATloLR2RzOW6URj7deViE2HTeXq9LzY64e5fj/GXBVPoEF3ss5dcnx5lxsF
         X7qb2h0ymS1OI9Bfek28Ah8JH33iCCRxI77Pj98KvGoaEOHZUs8Qhp7B8TbYSLW73xcp
         mNCg==
X-Gm-Message-State: AOUpUlF6e92YlmbzByrKqHOMZjMT6qSKaq6a/SINhEOJlRGSkOj85Gt8
        7baQfecLRfXqy/MCarrJXc8=
X-Google-Smtp-Source: AAOMgpfAxiApEwkAmxSuznhhDG8ewCm+Vq0Fthl+0FlymK/JGFdaOZK3RwIJ5N7txGfAshrwauwbPw==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr10939187wrw.209.1531694087116;
        Sun, 15 Jul 2018 15:34:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d7-v6sm21178924wro.92.2018.07.15.15.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 15:34:46 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:34:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Kan Liang <kan.liang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
Message-ID: <20180715223444.GA16209@gmail.com>
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710233158.21037-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
> Broadwell CPUs") introduced PCU.3 for Broadwell CPU. Unfortunately,
> the driver_data of PCU.3 conflicts to QPI Port 2 filter.
> 
>     { /* QPI Port 2 filter  */
>             PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
>             .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
> 
>     { /* PCU.3 (for Capability registers) */
>             PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
>             .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>                                                HSWEP_PCI_PCU_3),
>                              // HSWEP_PCI_PCU_3 == 2

> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1030,6 +1030,7 @@ enum {
>  	SNBEP_PCI_QPI_PORT0_FILTER,
>  	SNBEP_PCI_QPI_PORT1_FILTER,
>  	HSWEP_PCI_PCU_3,
> +	BDX_PCI_PCU_3,
>  };

So we use a magic '2' enumerator in the 'QPI Port 2 filter', and that overlaps 
with HSWEP_PCI_PCU_3, right?

Shouldn't we clean up all the enumerators and not use magic numbers, and this fix 
the conflict?

Thanks,

	Ingo
