Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77016C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2321F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sHQKTJJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2321F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeILUyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:54:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33636 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:54:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id b30-v6so1187503pla.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JXM/xIvk6YvYOB09tAomtkIs5VEdkjrFvRtp8qDA/VE=;
        b=sHQKTJJNdLPvV/c+Xg1WVTabtYu/yqfw9EUQBb0oc+/kJaCwiugKlc0bgQZUziXkHC
         5Rjvbj3rbmd/mKFHn9N+pDkv0LpwnGOt10P2yhXLRJdw2fnGB1eWI8pqnEVhQTPkTALX
         sUNJtov//cVReqpMRRpUXcR9bwRn2azUUn96o4CVwo0SI8RYFMSpuBy1OXhfswNNB4no
         DMpOlx/YqkhF/iMlCuT9DjQqbyUkAuVgeRJtaKNmxZhI4gQNHy/XZph9JERVTkT1Q7c4
         0gLYZl7CUf2R+b+4s7OaUFU77sq8y8K2g8vokd0lJvmT+QFJohupsvhXoSGWGTtj75Mk
         4jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JXM/xIvk6YvYOB09tAomtkIs5VEdkjrFvRtp8qDA/VE=;
        b=pjPaYx2rBhYlUO+/MZIC3+UhHWn0fJRHJ0hHXTczjFKJzVbbtY0FpX17CfIH3H8X/1
         RhPYIFr5ch7HNqPUm1GkQujgaeK+u9vHttJCudU+0iZz8rkZceNxAxFexdTT7SQ+iY1q
         FCdkRKe522P2quTqvT4kE6b4xehqfi+qet1HvXAQ1lM6wlld+4d19eI2qc51AxcJN6OR
         BAimnctUaJTlIkJBEilcPlkdKzFBKl8EKmGrtbPyxzQfQjCGNfrI3OP6MapAUSROEBYl
         lcDYPR1KuupKCfaHlLfP96Gd7jcyDpio9XyAA+iq/MJ4KF9PcDq0U+dpvgc3qlG53Lyc
         tRUg==
X-Gm-Message-State: APzg51AVRY0PG3izO8CQj7EE+EtE0P/eeNR5TpisQzerp1jxn/oKgBPN
        7QkvqKe3HpKMVdxiwLl6L0IpfQ==
X-Google-Smtp-Source: ANB0VdarfuT8d1tsaThxThlpN7cPrJQU7QcqAecgzO7ylTD5hPZHVCHtYPcXgODOXo6Oienu4fj6wg==
X-Received: by 2002:a17:902:4601:: with SMTP id o1-v6mr3029094pld.202.1536767343590;
        Wed, 12 Sep 2018 08:49:03 -0700 (PDT)
Received: from [192.168.0.239] (c-71-202-137-17.hsd1.ca.comcast.net. [71.202.137.17])
        by smtp.gmail.com with ESMTPSA id t70-v6sm1913035pgd.54.2018.09.12.08.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:49:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 04/10] x86/fpu: eager switch PKRU state
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <a1ee2e5226c780312bd8ef5658f4b6422e7cf434.camel@surriel.com>
Date:   Wed, 12 Sep 2018 08:49:01 -0700
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C1494C8-C6CA-4599-A6B3-0833F358E3A2@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-5-bigeasy@linutronix.de> <181B4EB8-9FEB-415C-8069-192FB8A5B418@amacapital.net> <a1ee2e5226c780312bd8ef5658f4b6422e7cf434.camel@surriel.com>
To:     Rik van Riel <riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 12, 2018, at 8:30 AM, Rik van Riel <riel@surriel.com> wrote:
>=20
> On Wed, 2018-09-12 at 08:20 -0700, Andy Lutomirski wrote:
>>>=20
>>> --- a/arch/x86/mm/pkeys.c
>>> +++ b/arch/x86/mm/pkeys.c
>>> @@ -18,6 +18,20 @@
>>>=20
>>> #include <asm/cpufeature.h>             /* boot_cpu_has,
>>> ...            */
>>> #include <asm/mmu_context.h>            /*
>>> vma_pkey()                   */
>>> +#include <asm/fpu/internal.h>
>>> +
>>> +void write_pkru(u32 pkru)
>>> +{
>>> +    if (!boot_cpu_has(X86_FEATURE_OSPKE))
>>> +        return;
>>> +
>>> +    current->thread.fpu.pkru =3D pkru;
>>> +
>>=20
>> I thought that the offset of PKRU in the xstate was fixed after boot.
>=20
> You are right, it is.  However, that offset would need
> to be stored somewhere, and the value read every time
> we wanted to read or store the PKRU value from/to the
> floating point state.
>=20
> I suspect that would not be any faster than keeping a
> copy of the PKRU value in a known location.
>=20
>> Anyway, as written, this needs a lockdep assertion that we=E2=80=99re not=

>> preemptible, an explicit preempt_disable(), or a comment explaining
>> why it=E2=80=99s okay if we get preempted in this function.
>>=20
>>> +    __fpregs_changes_begin();
>=20
> This handles the preemption disabling, see patch
> 3 of the series.

Sure, but the first write is *before* this. So we can be preempted with the t=
wo copies of PKRU being out of sync.

>=20
>>> +    __fpregs_load_activate(&current->thread.fpu,
>>> smp_processor_id());
>>> +    __write_pkru(pkru);
>>> +    __fpregs_changes_end();
>>> +}
>>>=20
>>> int __execute_only_pkey(struct mm_struct *mm)
>>> {
>>> --=20
>>> 2.19.0
>>>=20
>>=20
>>=20
> --=20
> All Rights Reversed.
