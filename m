Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7D420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="fSFPy3SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7D420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeKFCnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:43:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46135 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeKFCnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:43:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so4503487pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k1INU1pnFYgrBmHlY0ecbAtkdCLQ8Gp82wEYXROI4I0=;
        b=fSFPy3SG2q503zzs20lVIJnDKUbz1uSNNufMhYSULBvfrvtilyQ4ug5bZN0/b/7pSy
         EE9trnBOYDFhQMX0G5al41Zjga9qoF3eMm6B22JmVoqULcGGsBIUx5ZRRfzwxY3B8j1a
         cYh9kwrFkqi3//I0J9QLKGPfIrs3jcRTMt4G7Ov0xUdmNoaeHy7jHL1ZwYYO92qukkp1
         DEIflX9WO5Jt0ENB6nGrlxaNxwRorGseEcwrvF1UwjWdd7MXwBUMwVqH51is9Xjtc/Ah
         EFDafAzBJw3pGNxWTc8hgLEHS/0Bv7Y/+p49PrttcOrWbsrtgb2WYSpgMKTLtv8HGzoM
         Sz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k1INU1pnFYgrBmHlY0ecbAtkdCLQ8Gp82wEYXROI4I0=;
        b=PvkwXy4XKsojR0QLFY9aI8i0umOGXs2WGfIIuX+ydSzf/2397JxO2z3l45hRyVRnsQ
         JkWmMfT8qZQO/yfpWGNL4KCtiT2/G1dYpYi9DDslMPHMY+DTfD3ccs2cBzRKQGeX9auR
         XsJnQ5Vixe6mtk8XkdT9iX7v3QeRdWFHoU0q/pLOEJ0vLy8zC+j3QIO7Y7RG4xAz7i7q
         l38FUHSXrE0UIaTBgYaYRca2Pmm/ivsbCywEio1zTKN/TJPWZFr8m5XBNRaBjYX5uFUT
         QufgIFUs1twOBgMiJsqHM8Lo6FLE4Q8TGWf5ILfxCWj/X9NxPqe57VXe1Gu/fuMB8RGR
         zDOw==
X-Gm-Message-State: AGRZ1gKmisM0DZEcvcNjb4w/aP7MF6YinI26An7X+4xuo++nvUeFGeXq
        +ec+F/apdKIlRrIhRjkr8Dt/KQ==
X-Google-Smtp-Source: AJdET5eV+DaMek8LOaOpN81Ye3ww0WNxYV40yN2JFbRjVVbeAL3b2T7q0Fg6F9Uf5XGDyh6oGbWOSQ==
X-Received: by 2002:a63:f515:: with SMTP id w21mr1838276pgh.220.1541438555760;
        Mon, 05 Nov 2018 09:22:35 -0800 (PST)
Received: from ?IPv6:2600:1010:b022:50cc:40e8:641b:7bb4:fb59? ([2600:1010:b022:50cc:40e8:641b:7bb4:fb59])
        by smtp.gmail.com with ESMTPSA id m17-v6sm12715744pfi.102.2018.11.05.09.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 09:22:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during early_init
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181105140925.GD22467@hirez.programming.kicks-ass.net>
Date:   Mon, 5 Nov 2018 09:22:32 -0800
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net>
References: <20181102232946.98461-1-namit@vmware.com> <20181102232946.98461-3-namit@vmware.com> <20181105140925.GD22467@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 5, 2018, at 6:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Nov 02, 2018 at 04:29:41PM -0700, Nadav Amit wrote:
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index aac0c1f7e354..367c1d0c20a3 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -52,7 +52,13 @@ static void __ref __jump_label_transform(struct jump_e=
ntry *entry,
>>    jmp.offset =3D jump_entry_target(entry) -
>>             (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>>=20
>> -    if (early_boot_irqs_disabled)
>> +    /*
>> +     * As long as we are in early boot, we can use text_poke_early(), wh=
ich
>> +     * is more efficient: the memory was still not marked as read-only (=
it
>> +     * is only marked after poking_init()). This also prevents us from u=
sing
>> +     * text_poke() before poking_init() is called.
>> +     */
>> +    if (!early_boot_done)
>>        poker =3D text_poke_early;
>>=20
>>    if (type =3D=3D JUMP_LABEL_JMP) {
>=20
> It took me a while to untangle init/maze^H^Hin.c... but I think this
> is all we need:
>=20
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index aac0c1f7e354..ed5fe274a7d8 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -52,7 +52,12 @@ static void __ref __jump_label_transform(struct jump_en=
try *entry,
>    jmp.offset =3D jump_entry_target(entry) -
>             (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>=20
> -    if (early_boot_irqs_disabled)
> +    /*
> +     * As long as we're UP and not yet marked RO, we can use
> +     * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to
> +     * SYSTEM_SCHEDULING before going either.
> +     */
> +    if (system_state =3D=3D SYSTEM_BOOTING)
>        poker =3D text_poke_early;
>=20
>    if (type =3D=3D JUMP_LABEL_JMP) {

Can we move this logic into text_poke() and get rid of text_poke_early()?

FWIW, alternative patching was, at some point, a significant fraction of tot=
al boot time in some cases. This was probably mostly due to unnecessary sync=
_core() calls.  Although I think this was reported on a VM, and sync_core() u=
sed to be *extremely* expensive on a VM, but that=E2=80=99s fixed now, and i=
t even got backported, I think.

(Hmm. Maybe we can also make jump label patching work in early boot, too!)=
