Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C8DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E88E214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfiVfxmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E88E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLDINm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:13:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37135 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:13:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so14849290wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x9IjF5zEI3lcr5nKh24AlJ08SKJH2eZhyljTxQ0YBAc=;
        b=mfiVfxmA+Dgmd3B88d29MrTnTn2RteiiSdTSpIYVCcpVCXDDCnQDlH0uhKNc8E/5td
         dYCdjM2Oha04H58VsfbMKBRz4PyaWK7SvpQkD5CNSMXPU5SgwsG1mEVR4H8F74pg/6sf
         facu3Fc4JRvJyyHtkKkFNMIkq4E5rd8nMhT5a8+LjcdWQJRhU16MqOpX7Chd/576f7Fe
         ajrY+qd+yM/RydCOFkdEmUXEpYmzl0u0N3wJjJtQgGRq+nI8BUwIWLtwTHaDVnB32nGh
         ThQa+d71ir1qoUGtK1vW+bWTDU0pNpQqoXD05gUb/clIEMekXlEfuoyZzCc8e/1ShIQO
         ulVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x9IjF5zEI3lcr5nKh24AlJ08SKJH2eZhyljTxQ0YBAc=;
        b=Lwd/svA/NDWr1TYn20wfANLyGy5EbTTc98I7git33jR4FwvMDDtoD8QuTvPsalzctV
         zNSB5lPylgAXM7SGyWN8sZwGZT9/9RGOIgxCXCocDWG5M3rLuHTxHeDzMP2W5pp1oc7p
         y8XxqKNoTZ9qI7muFLrCN53ck2BMiDzekm2I5zNw/j4YYQRKp4CdsfcHfjc4+zG1z1LW
         8H6hAeBm8BdnjSLiA3JKcBpi6ooJuBT8XDpOl7NZw4bpIXouGFQ4uKkjzrV6mzE6tQ/2
         tUon7iWLiMn8SRqbJvjnREa8MYVbTV6Ddnr0IwQr1YR/bfWx7MnuIJvfuwWdLtMvIoLH
         NQ3A==
X-Gm-Message-State: AA+aEWa0raw5uL1FwW9jf4uh3dbKINatJdBZodl+f7cEScYwsIs5ONnO
        KAu6F90CgceIA2XUe/me98dIFnf4
X-Google-Smtp-Source: AFSGD/UTaPZQWWJblB0hHHeVFSScEdYhcXMTySlWbxwiwR+EgJ0/sj3eFoJqmRU3XUfUgf4oRhIECA==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr17577049wrt.327.1543911218752;
        Tue, 04 Dec 2018 00:13:38 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b7sm12742448wrs.47.2018.12.04.00.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 00:13:37 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:13:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michael Rodin <michael@rodin.online>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH -tip] kprobes/x86: Fix to copy RIP relative
 instruction correctly
Message-ID: <20181204081335.GB67285@gmail.com>
References: <153504457253.22602.1314289671019919596.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153504457253.22602.1314289671019919596.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since copy_optimized_instructions() misses to update real RIP
> address while copying several instructions to working buffer,
> it adjusts RIP-relative instruction with wrong RIP address for
> the 2nd and subsequent instructions.
> 
> This may break the kernel (like kernel freeze) because
> probed instruction can refer a wrong data. For example,
> putting kprobes on cpumask_next hit this bug.
> 
> cpumask_next is normally like below if CONFIG_CPUMASK_OFFSTACK=y
> (in this case nr_cpumask_bits is an alias of nr_cpu_ids)
> 
>  <cpumask_next>:
>        48 89 f0                mov    %rsi,%rax
>        8b 35 7b fb e2 00       mov    0xe2fb7b(%rip),%esi
>         # ffffffff82db9e64 <nr_cpu_ids>
>        55                      push   %rbp
> ...
> 
> If we put a kprobe on it and optimized with jump, it becomes
> like this.
> 
> 	e9 95 7d 07 1e	jmpq   0xffffffffa000207a
> 	7b fb	jnp    0xffffffff81f8a2e2 <cpumask_next+2>
> 	e2 00	loop   0xffffffff81f8a2e9 <cpumask_next+9>
> 	55	push   %rbp
> 
> This shows first 2 "mov" instructions are copied to trampoline
> buffer at 0xffffffffa000207a. Here is the disassembled result.
> (skipped optprobe template instructions)
> 
> Dump of assembler code from 0xffffffffa000207a to 0xffffffffa00020ea:
> 	54	push   %rsp
> ...
> 	48 83 c4 08	add    $0x8,%rsp
> 	9d	popfq
> 	48 89 f0	mov    %rsi,%rax
> 	8b 35 82 7d db e2	mov    -0x1d24827e(%rip),%esi
>         # 0xffffffff82db9e67 <nr_cpu_ids+3>
> 
> As it shows, the 2nd mov accesses *(nr_cpu_ids+3) instead of
> *nr_cpu_ids. This leads a kernel freeze because cpumask_next()
> always returns 0 and for_each_cpu() never ended.
> 
> Fixing this by adding len correctly to real RIP address while
> copying.
> 
> Fixes: 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()")
> Reported-by: Michael Rodin <michael@rodin.online>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kernel/kprobes/opt.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index eaf02f2e7300..e92672b8b490 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -189,7 +189,8 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
>  	int len = 0, ret;
>  
>  	while (len < RELATIVEJUMP_SIZE) {
> -		ret = __copy_instruction(dest + len, src + len, real, &insn);
> +		ret = __copy_instruction(dest + len, src + len, real + len,
> +			&insn);

I applied this, except that I unbroke the line: please ignore checkpatch 
in such cases where the cure is worse than the disease ...

I.e. even if slightly over 80 cols, this is more readable:

		ret = __copy_instruction(dest + len, src + len, real + len, &insn);

Thanks,

	Ingo
