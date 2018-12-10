Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BC3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879E52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="csQdxTI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879E52082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeLJVEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:04:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34158 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbeLJVE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:04:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so5830025plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gZlkw5nTHOnCTz+mG0sFvAxoSn9cEC79ZLW/77t2A78=;
        b=csQdxTI93bknbWpra3S3cRG9gO8dC4EnrAvWN/2sBCad2b4jg9o8ZTpEc7/1YMpDTS
         kFG5kSIQVRMCTB8F0ted3Cw0ZDlyv/eG3tn/kmgBQAkUhE+xpVrEy4Scxh7bAZMFxsNl
         Ea4pUMIPgVCajTISAkz9wj/2zCiRu0tM7/5wJMBtglJ0jXAq9eV6204YLDnhv8pVDSyj
         otM+VsJjYLMBMwEDhWkcYkDOfgymtdcQIH/LyYSVs+5blaE8ttqeUDq4Q5/TVPAG8PuY
         Z8+GhNOezfxF3IeHFvNm8iop2y+1ZnQv6Dvv0lgTwv6Tvgkgpip0Cf9R3RkQAGYG1jo1
         S0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gZlkw5nTHOnCTz+mG0sFvAxoSn9cEC79ZLW/77t2A78=;
        b=PDLe+TmZRhVTONUXLcXF2LMA1/sRsdkgdxjca1yStmw6++OjGAjLmeu5F4eEulJrBr
         youBmpYlw+g6LixXWDooKn82xa3DAsD413HcvJQ2tQpVFDVkuHTIKm9RfqsThM2sfJWo
         xhxp/acyxCdZpWBEpL+nlE7r31sFdktgY1L8VUY16ljPTgdfPkgGiqLpYftc8d+liZNP
         u3bck/ldQxsUnMiojpKZQCYmmuFOx+XPrRGfEqreKnrP/wBRNerai4yUS34T3hsp00TT
         ve3Jw+Txe4cp5OHC1p2iTpGkhgVHrBzbZj0XJGSXXqFAcS0P4GA2E5YTlYlxOq1oE4I8
         lLdg==
X-Gm-Message-State: AA+aEWawpe8pvjYU13vG4zR2mpNY8xuPjFyEBSqYuLml1QNwfWkBp/ME
        /2+YBT0NvvFtmRL8LJewMs9grw==
X-Google-Smtp-Source: AFSGD/U283ChgEegOmWNfaWwONQlSPPp+tgFWdQyu0iY62emWPfQiS/WLg2RRGRPG8F2wXNAgVrxlA==
X-Received: by 2002:a17:902:b118:: with SMTP id q24mr13718623plr.209.1544475866627;
        Mon, 10 Dec 2018 13:04:26 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b2sm17315351pgg.87.2018.12.10.13.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 13:04:25 -0800 (PST)
Date:   Mon, 10 Dec 2018 13:04:25 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 11:14:25 PST (-0800)
Subject:     Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
In-Reply-To: <20181210180421.wq3ruldbpvu2jpfm@pburton-laptop>
CC:     ldv@altlinux.org, ralf@linux-mips.org, jhogan@kernel.org,
        oleg@redhat.com, luto@kernel.org, lineprinter@altlinux.org,
        esyr@redhat.com, keescook@chromium.org, jannh@google.com,
        linux-api@vger.kernel.org, strace-devel@lists.strace.io,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     paul.burton@mips.com
Message-ID: <mhng-6b6b1220-80dc-4acf-8a4b-649ef2c38919@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 10:04:22 PST (-0800), paul.burton@mips.com wrote:
> Hi Dmitry,
>
> On Mon, Dec 10, 2018 at 07:09:40PM +0300, Dmitry V. Levin wrote:
>> We decided to add .frame_pointer to struct ptrace_syscall_info just for
>> consistency with .instruction_pointer and .stack_pointer; I must have been
>> misled by comments in asm-generic/ptrace.h into thinking that
>> frame_pointer() is universally available across architectures.
>
> Is it correct to say that you're using frame_pointer() purely on user
> register state, not kernel?
>
> If so then one option would be to define it for MIPS as something like:
>
>     static inline unsigned long frame_pointer(struct pt_regs *regs)
>     {
>     	return regs->regs[30];
>     }
>
> My concern with that though would be that providing frame_pointer()
> unconditionally might mislead people into thinking that the kernel
> always has frame pointers, when in reality current MIPS kernels never
> do. In fact a comment in MIPS' asm/ptrace.h seems to suggest the lack of
> frame_pointer() is intentional for exactly that reason:
>
>> Don't use asm-generic/ptrace.h it defines FP accessors that don't make
>> sense on MIPS.  We rather want an error if they get invoked.
>
> Looking across architectures though MIPS isn't going to be the only one
> missing frame_pointer(). With a little grepping it appears that these
> architectures provide frame_pointer():
>
>   arm
>   arm64
>   hexagon
>   nds32
>   powerpc
>   riscv
>   sparc
>   um
>   x86
>
> That leaves a whole bunch of other architectures (16) which don't have
> frame_pointer(), or at least not in a way that I could see at a glance.

We (RISC-V) default to compiling without frame pointers.  I'm not sure if it 
even makes sense have frame_pointer() on RISC-V, as it'll usually return 
garbage.

>> Unlike .instruction_pointer and .stack_pointer that are actually needed
>> in strace, .frame_pointer is not used, so from strace PoV we don't really
>> need it.
>> 
>> So the question is, does anybody need a
>> struct ptrace_syscall_info.frame_pointer?
>> 
>> If yes, how can frame_pointer() be defined on MIPS?
>> Or should we just forget about making sense of frame_pointer() and remove
>> struct ptrace_syscall_info.frame_pointer from the proposed API?
>
> So, along these lines my suggestion would be to avoid it if you don't
> really need it anyway.
>
> Thanks,
>     Paul
