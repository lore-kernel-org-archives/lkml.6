Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E185C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EDA2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxBVSrqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfBFRdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:33:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45872 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfBFRdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:33:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3180725pgc.12;
        Wed, 06 Feb 2019 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rYbgX2FNZSLFQiDq0Ih+9oGqomi8Dxzpd7WK0+FcTcQ=;
        b=jxBVSrqhK2+6jA9mgt1ZG2E6Yi97wIPX6W+CP4vKddME0zOC5E6Nq1muZXBqDq66Ye
         VVAsjSUD9dScTXpLAZBgRw1MBsrpIoTC5JQhT21UolL971aHLI6k3RCW7jONQsJbBlzP
         t9jtC1tCPW113d7khRQ4pUr9iK6z6+Jl2znriGGF6Tc3h8tJm7WgEkq29wzTlX5g7Mg9
         7qQk6+j5bVvHFcSvP+fLT9HshRbtp0RQyolyO61o12w+C/C+MMWVvqfybCZv/UsMV/AI
         BKEhQZUPTuOaO1k+dtte1NfawOt3RDQ2LvtZ9jMask9lAZN5wdlfaI5HXjrthV8o5cSn
         2XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rYbgX2FNZSLFQiDq0Ih+9oGqomi8Dxzpd7WK0+FcTcQ=;
        b=SYsVM7QUyhCysuvVB0yUdZK7/URF+rK5JpLhsb/9KlekIXfyzsxuwHv3hz9fYgp8qk
         U82G/MaSONLfa4RzSDOUNbLA0cSoEKD8prqyJ4xru0XV/QizToYDt7vrlLAyUpa3hBqn
         Cfm56hlQtHKGzUD/ISD5hyqb881vwb+KJ9ybygZYuNGxqryUUQxMnCt8mBq4zXKIWlW/
         ZRuJ8PpCVYtNHkAf/WmOLTjYrKKACSdy+3NHvmqTxM/RTANyn3cq2/W8NMhoEupvCX9C
         xU7MqEt1om21qhUFbqmTL8KZrRrDKhDG7liMoRqa8V54xeBItbb8Z/YM3YUm/88dR/wP
         jH/g==
X-Gm-Message-State: AHQUAuY7qR7qlh3FNcracmHcPRd157zULVgFShopOGUDNOejhsqUFhzb
        wGeP2ADcjkjRRukyTVV0PHk=
X-Google-Smtp-Source: AHgI3IZO/nBxjBj7hWYe6SBT7x8lwLWKo0SvM/vK6C31+42XzDoMO/FAAmIlRnhVDYWo38sCKnYxiQ==
X-Received: by 2002:a65:62da:: with SMTP id m26mr10648561pgv.278.1549474419293;
        Wed, 06 Feb 2019 09:33:39 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a13sm436912pgw.34.2019.02.06.09.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:33:38 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 08/17] x86/ftrace: set trampoline pages as executable
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190206112213.2ec9dd5c@gandalf.local.home>
Date:   Wed, 6 Feb 2019 09:33:35 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        deneen.t.dock@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DFA1E3C-A335-4C4B-A86F-904A6CF6D871@gmail.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-9-rick.p.edgecombe@intel.com>
 <20190206112213.2ec9dd5c@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 6, 2019, at 8:22 AM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Wed, 16 Jan 2019 16:32:50 -0800
> Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
>=20
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Since alloc_module() will not set the pages as executable soon, we =
need
>> to do so for ftrace trampoline pages after they are allocated.
>>=20
>> For the time being, we do not change ftrace to use the text_poke()
>> interface. As a result, ftrace breaks still breaks W^X.
>>=20
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> ---
>> arch/x86/kernel/ftrace.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
>> index 8257a59704ae..eb4a1937e72c 100644
>> --- a/arch/x86/kernel/ftrace.c
>> +++ b/arch/x86/kernel/ftrace.c
>> @@ -742,6 +742,7 @@ create_trampoline(struct ftrace_ops *ops, =
unsigned int *tramp_size)
>> 	unsigned long end_offset;
>> 	unsigned long op_offset;
>> 	unsigned long offset;
>> +	unsigned long npages;
>> 	unsigned long size;
>> 	unsigned long retq;
>> 	unsigned long *ptr;
>> @@ -774,6 +775,7 @@ create_trampoline(struct ftrace_ops *ops, =
unsigned int *tramp_size)
>> 		return 0;
>>=20
>> 	*tramp_size =3D size + RET_SIZE + sizeof(void *);
>> +	npages =3D DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
>>=20
>> 	/* Copy ftrace_caller onto the trampoline memory */
>> 	ret =3D probe_kernel_read(trampoline, (void *)start_offset, =
size);
>> @@ -818,6 +820,13 @@ create_trampoline(struct ftrace_ops *ops, =
unsigned int *tramp_size)
>> 	/* ALLOC_TRAMP flags lets us know we created it */
>> 	ops->flags |=3D FTRACE_OPS_FL_ALLOC_TRAMP;
>>=20
>> +	/*
>> +	 * Module allocation needs to be completed by making the page
>> +	 * executable. The page is still writable, which is a security =
hazard,
>> +	 * but anyhow ftrace breaks W^X completely.
>> +	 */
>=20
> Perhaps we should set the page to non writable after the page is
> updated? And set it to writable only when we need to update it.

You remember that I sent you a patch that changed all these writes into
text_poke() and you said that I should defer it until this series is =
merged?

> As for this patch:
>=20
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

