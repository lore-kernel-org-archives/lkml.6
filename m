Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C53C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740B720862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BNcw/Kfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740B720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbeKFEY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:24:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36867 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbeKFEYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:24:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id p6-v6so4897981pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3L+klrtbwofXFKDqMB/m9WRLyeJc0wgENHDApiDsb24=;
        b=BNcw/KfaxkXfuEI4xEZ8NK9515h5GvkkQ4kQBbWaE+l+BcK3m1msXkQ1kM6UI8sf0F
         4eCcbpO/6Cl5J7wXP/bSX9bdivgbNkEezkoe+QlsZVX1FeBJEmuWACJRPS1tDT7LmGYF
         30ho7h/JvK3/ZHlr7vmnaQuzNo0h+elB7ZXO6xtRQS1Gf4X8d1hQ4hxYtOhZFEOOZwNk
         FJ9rP5iJIvycXp0/LRxCwuQpdcYfJ6BCxi7WUKAxZ1ZNEIMR+0EMDcGCdpv6IZ3m+MSO
         +7S6C6okWYoUjQoijaJ/8eblqVDKbjVY6JDEJzp+aw/o5e6KNLszpbOJukPFWG0+llBl
         UNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3L+klrtbwofXFKDqMB/m9WRLyeJc0wgENHDApiDsb24=;
        b=At1sFe8wXkFB2ktlcoAJP+z316Bui3Lvdmjw1Dcd9Yw0Iwr3tQM9I9hDeQxzR5MBa1
         aRtuePYIRP6VfiPVUJXEgXmDijeRjhzVimqoHlB2b+VBDp8VOLBL8epQZqQVMfO4xI5L
         dYY/IyLsjXWAaUMbTs5TW9GRA76AMnWNvvrT7v0xsws+RFYuexqrGdO7j9rlWDO3MlZh
         tJ4J5Rxz1aedVPGCV+aM9y8JWpMJSXXrltrRWhd2ghT7/PFHWzDQchXZFf5V3jY1AUIU
         /o2VQNJOvyOKVIxQkjmdujPu/hxoD5t79q/knc8Zok2kZF1whOEEYW7l66hkNvtm5jVg
         G1IQ==
X-Gm-Message-State: AGRZ1gLBF6xrwL2MxKKWnyTVZahzi6t232Cp3LetpyUAjA4upIf5YWC9
        KLJXgJODaKA72dZNotrKCbaXcA==
X-Google-Smtp-Source: AJdET5dPnhddPWYUfEE/19TC2AI10I8csKKVoPpdXqCPFTWDa4KuDLeoNoEAuMc1/InR3Bg4Yx6e1A==
X-Received: by 2002:a17:902:343:: with SMTP id 61-v6mr22455625pld.327.1541444631706;
        Mon, 05 Nov 2018 11:03:51 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:6d4e:7049:df8c:67df? ([2601:646:c200:7429:6d4e:7049:df8c:67df])
        by smtp.gmail.com with ESMTPSA id o70-v6sm14912620pfo.86.2018.11.05.11.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:03:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during early_init
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <4D260352-A9FF-47F2-B3B2-0A87DF16CB70@vmware.com>
Date:   Mon, 5 Nov 2018 11:03:49 -0800
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D67F7C19-DF59-4405-A5A3-B56C0E491B41@amacapital.net>
References: <20181102232946.98461-1-namit@vmware.com> <20181102232946.98461-3-namit@vmware.com> <20181105140925.GD22467@hirez.programming.kicks-ass.net> <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net> <4D260352-A9FF-47F2-B3B2-0A87DF16CB70@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2018, at 9:49 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
> From: Andy Lutomirski
> Sent: November 5, 2018 at 5:22:32 PM GMT
>> To: Peter Zijlstra <peterz@infradead.org>
>> Cc: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-=
kernel@vger.kernel.org, x86@kernel.org, H. Peter Anvin <hpa@zytor.com>, Thom=
as Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hanse=
n <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Kees Coo=
k <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Masami Hiram=
atsu <mhiramat@kernel.org>
>> Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during e=
arly_init
>>=20
>>=20
>>=20
>>>> On Nov 5, 2018, at 6:09 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>>>=20
>>>> On Fri, Nov 02, 2018 at 04:29:41PM -0700, Nadav Amit wrote:
>>>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.=
c
>>>> index aac0c1f7e354..367c1d0c20a3 100644
>>>> --- a/arch/x86/kernel/jump_label.c
>>>> +++ b/arch/x86/kernel/jump_label.c
>>>> @@ -52,7 +52,13 @@ static void __ref __jump_label_transform(struct jump=
_entry *entry,
>>>>  jmp.offset =3D jump_entry_target(entry) -
>>>>           (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>>>>=20
>>>> -    if (early_boot_irqs_disabled)
>>>> +    /*
>>>> +     * As long as we are in early boot, we can use text_poke_early(), w=
hich
>>>> +     * is more efficient: the memory was still not marked as read-only=
 (it
>>>> +     * is only marked after poking_init()). This also prevents us from=
 using
>>>> +     * text_poke() before poking_init() is called.
>>>> +     */
>>>> +    if (!early_boot_done)
>>>>      poker =3D text_poke_early;
>>>>=20
>>>>  if (type =3D=3D JUMP_LABEL_JMP) {
>>>=20
>>> It took me a while to untangle init/maze^H^Hin.c... but I think this
>>> is all we need:
>>>=20
>>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c=

>>> index aac0c1f7e354..ed5fe274a7d8 100644
>>> --- a/arch/x86/kernel/jump_label.c
>>> +++ b/arch/x86/kernel/jump_label.c
>>> @@ -52,7 +52,12 @@ static void __ref __jump_label_transform(struct jump_=
entry *entry,
>>>  jmp.offset =3D jump_entry_target(entry) -
>>>           (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>>>=20
>>> -    if (early_boot_irqs_disabled)
>>> +    /*
>>> +     * As long as we're UP and not yet marked RO, we can use
>>> +     * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to=

>>> +     * SYSTEM_SCHEDULING before going either.
>>> +     */
>>> +    if (system_state =3D=3D SYSTEM_BOOTING)
>>>      poker =3D text_poke_early;
>>>=20
>>>  if (type =3D=3D JUMP_LABEL_JMP) {
>>=20
>> Can we move this logic into text_poke() and get rid of text_poke_early()?=

>=20
> This will negatively affect poking of modules doing module loading, e.g.,
> apply_paravirt(). This can be resolved by keeping track when the module is=

> write-protected and giving a module parameter to text_poke(). Does it wort=
h
> the complexity?

Probably not.

OTOH, why does alternative patching need text_poke() at all?  Can=E2=80=99t i=
t just write to the text?

>=20
>> FWIW, alternative patching was, at some point, a significant fraction of
>> total boot time in some cases. This was probably mostly due to unnecessar=
y
>> sync_core() calls. Although I think this was reported on a VM, and
>> sync_core() used to be *extremely* expensive on a VM, but that=E2=80=99s f=
ixed
>> now, and it even got backported, I think.
>>=20
>> (Hmm. Maybe we can also make jump label patching work in early boot, too!=
)
>=20
> It may be possible to resolve the dependencies between poking_init() and t=
he
> other *_init(). I first considered doing that, yet, it makes the code very=

> fragile, and I don=E2=80=99t see the value in getting rid of text_poke_ear=
ly() from
> security or simplicity point of views. Let me know if you think otherwise.=

>=20
> Regards,
> Nadav
