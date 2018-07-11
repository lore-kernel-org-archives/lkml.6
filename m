Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A04C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA48920B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKZ8ryFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA48920B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeGKKYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:24:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55653 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732466AbeGKKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:24:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id v128-v6so1872495wme.5;
        Wed, 11 Jul 2018 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nSp3+wzsdAhxLCvXlZ+mk8sdJkEDYAeAFB3cwn5eQZE=;
        b=aKZ8ryFYidsJqErEl30iE3sVb8LmUVOGPG2IhTJViJlBK4yWdeBW97puG2sy0jkIBs
         FyOOU90ordpLFEPLRMGJzFiAIm14hHJ0bZvZtQmSUUjtzmWLxUGRZuFoK5zc5bxQg5V/
         8jigbqrf1ut60Dr/ZIu3K3HiGaNXmWFr49D7dTASJ5cXf/1khfnf1gSZj6hb1vWp2QXd
         vjetvwGzjdV+pIalBAoztCwOXxyQuidJ92nrLC1geJmGuAhSAquruDWamDvdEMt07BFj
         5yBfi5zQWCIZLUYX8qCnMib2vPtUYkTEt1q8WL36++kWFeHEgDzDXFJZvxrEwHMsVsF5
         IAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nSp3+wzsdAhxLCvXlZ+mk8sdJkEDYAeAFB3cwn5eQZE=;
        b=nhdwpWD3zu2Jbe12wj/DisUPlnlGS2aBo0pSPCI2m/QrK01YExf78P4jr6EkpOZ92d
         +MbvV2PVhAEf6X8qbpqnlQyTane/HB3QKPCCOeDzmvxnYwGUWyE/VlSBm3nH41eULhq0
         PC2R7co5vEWbzQ2pw80BPBVLMDU4ucVOJu1QMzA6+MD32NGMMYewJrHg5vCS2K5WBjAJ
         WAK6Rf78Zi8NLIjXy6lecj1rjn5YTzr+Q0duCV6i8YpKhvE/rTWbAc8LzHAbZ7FuKQiy
         7NwQ2oDNhFKTUj0WRYue2GBMGbIJu4gRQvWTv0kGYWq1zrscSnABdYxEs8Mm+x6lqBy4
         YXKw==
X-Gm-Message-State: APt69E2MnAp2hcqqsPpmmRDiiIGuH4deNPpoproEax9/9+ZHimq+GkCL
        r3C7IqslkYukvVGAf0PO7xA=
X-Google-Smtp-Source: AAOMgpePvDpkTvaBxWA+FvwlO276KC6bPAv4ybXNKhxXKHk9WqkQNirLQ+L4weWxzHLZ3Q/QIp/gqg==
X-Received: by 2002:a1c:928c:: with SMTP id u134-v6mr16275316wmd.106.1531304438785;
        Wed, 11 Jul 2018 03:20:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g17-v6sm1685587wmd.25.2018.07.11.03.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 03:20:38 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:20:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
Message-ID: <20180711102035.GB8574@gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-26-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222639.8241-26-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> Add PTRACE interface for CET MSRs.

Please *always* describe new ABIs in the changelog, in a precise, well-documented 
way.

> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index e2ee403865eb..ac2bc3a18427 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -49,7 +49,9 @@ enum x86_regset {
>  	REGSET_IOPERM64 = REGSET_XFP,
>  	REGSET_XSTATE,
>  	REGSET_TLS,
> +	REGSET_CET64 = REGSET_TLS,
>  	REGSET_IOPERM32,
> +	REGSET_CET32,
>  };

Why does REGSET_CET64 alias on REGSET_TLS?

>  struct pt_regs_offset {
> @@ -1276,6 +1278,13 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
>  		.size = sizeof(long), .align = sizeof(long),
>  		.active = ioperm_active, .get = ioperm_get
>  	},
> +	[REGSET_CET64] = {
> +		.core_note_type = NT_X86_CET,
> +		.n = sizeof(struct cet_user_state) / sizeof(u64),
> +		.size = sizeof(u64), .align = sizeof(u64),
> +		.active = cetregs_active, .get = cetregs_get,
> +		.set = cetregs_set
> +	},

Ok, could we first please make this part of the regset code more readable and 
start the series with a standalone clean-up patch that changes these initializers 
to something more readable:

	[REGSET_CET64] = {
		.core_note_type	= NT_X86_CET,
		.n		= sizeof(struct cet_user_state) / sizeof(u64),
		.size		= sizeof(u64),
		.align		= sizeof(u64),
		.active		= cetregs_active,
		.get		= cetregs_get,
		.set		= cetregs_set
	},

? (I'm demonstrating the cleanup based on REGSET_CET64, but this should be done on 
every other entry first.)


> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -401,6 +401,7 @@ typedef struct elf64_shdr {
>  #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
>  #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
>  #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
> +#define NT_X86_CET	0x203		/* x86 cet state */

Acronyms in comments should be in capital letters.

Also, I think I asked this before: why does "Control Flow Enforcement" abbreviate 
to "CET" (which is a well-known acronym for "Central European Time"), not to CFE?

Thanks,

	Ingo
