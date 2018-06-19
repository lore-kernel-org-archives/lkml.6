Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C19205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="o2soD1yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C19205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966630AbeFSPXI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:23:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37572 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbeFSPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:23:06 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so32604plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SaN4Frn4nribuqiKUuDZC+THHVdnIlI6VvpmHTO1oZ4=;
        b=o2soD1yhJdW7yfOGwrWAKWCPgOQxA+n4pfpRqfTQX4x8+VuF+1fZIBtYWNkpeJNJcJ
         t+9+hmfH17sRmg3o1aJ204s5g5QxgUPXVIOYJ7VomIYfaXh7oodlcmvy8CFDMeRy00g+
         3FNzbE+TncQcWjN5FypqOilQvaFHVFPZUoMAB7XD3FKceQN0Jtr4Xz2Xs7Q/t/CVcBDK
         4X13wRP98TXFmCLlPlBi0fXdI7XrQmOE3ab0TjKjOeabToDM5zXUqGsTE6Jlz8cSSaxQ
         pbr7wPZ6hplfLoJupS+BFrqEkRCY4XwZtiarVwUlUgjlBOb/DbfJkm7szvBoMmf6gjyG
         AB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SaN4Frn4nribuqiKUuDZC+THHVdnIlI6VvpmHTO1oZ4=;
        b=nM1wrT9McL+w2TIKrNdhPyTQLGehxORKZFloP17o7FLMJ33Gk62pqkwbnEcUKK//iS
         uz4tUaWZLFh25WdDLAjbvuLHRAloF0VYUdojf7SYp65jlKHCn0+imSnMBPudklQKV7f1
         U3yZiJluSloKWxWs7ey2/VFNqqS5oKuu5wvack3nZPiFevEi9SNZvGikOAjdnxUwEjFM
         qPzITRh3tkw9Pvrey7g4PATh8Kafwh1TLlKm8zb8NE0jF9NczllHD6O3flJU1vSop6C8
         2ku7Na9enfRoPBBQXlSPrc8/raefLi56oLXrHVJxvkHn4XLc0lyWx1COy8W/Eiq2zZJT
         xUcA==
X-Gm-Message-State: APt69E2RwXLw75+bhnBuzYx8N/OE0gKxs3Rz7wuG+a1tQjukz3S29pcD
        iofQdgbGe5gHMdm1aC0huc0DMsqZXms=
X-Google-Smtp-Source: ADUXVKLnNoKUGF7FoWdNuC/zsrpRXDkBRRKmceHTNrhDo2QidickveQzwG5Tm9u/qeH9ifJsvfmRoA==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr19189101plb.274.1529421786250;
        Tue, 19 Jun 2018 08:23:06 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:c12a:9165:dc8d:85a7:914? ([2600:1010:b023:c12a:9165:dc8d:85a7:914])
        by smtp.gmail.com with ESMTPSA id p16-v6sm45203548pfd.47.2018.06.19.08.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:23:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: Call fixup_exception() before notify_die() in math_error()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <alpine.DEB.2.21.1806190820210.1692@nanos.tec.linutronix.de>
Date:   Tue, 19 Jun 2018 08:23:03 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, Siarhei.Liakh@concurrent-rt.com,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bpetkov@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <048143ED-D567-4B6B-ABF4-EFE5F1B87607@amacapital.net>
References: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com> <CALCETrXUdLZTnf0EF2LVM4ru2G6nkFX--gQ=6JpBRNZ7Gm+MsQ@mail.gmail.com> <alpine.DEB.2.21.1806190820210.1692@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2018, at 11:23 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Mon, 18 Jun 2018, Andy Lutomirski wrote:
>>=20
>> On Thu, Jun 14, 2018 at 10:10 PM Siarhei Liakh
>> <Siarhei.Liakh@concurrent-rt.com> wrote:
>>>=20
>>> fpu__drop() has an explicit fwait which under some conditions can trigge=
r
>>> a fixable FPU exception while in kernel. Thus, we should attempt to fixu=
p
>>> the exception first, and only call notify_die() if the fixup failed just=

>>> like in do_general_protection(). The original call sequence incorrectly
>>> triggers KDB entry on debug kernels under particular FPU-intensive
>>> workloads. This issue had been privately observed, fixed, and tested
>>> on 4.9.98, while this patch brings the fix to the upstream.
>>=20
>> Reviewed-by: Andy Lutomirski <luto@kernel.org>
>>=20
>> With the caveat that you are perpetuating what is arguably a bug in
>> some of the other entries: math_error() can now be called with IRQs
>> off and return with IRQs on.  If we actually start asserting good
>> behavior in the entry code, we'll need to fix this.
>=20
> Confused. math_error() is still invoked with interrupts off. What's
> different now is that notify_die() is called with interrupts conditionally=

> enabled while upstream it's always called with interrupts disabled.

True, but I don=E2=80=99t think that matters. What I=E2=80=99m grumbling abo=
ut is that we can do cond_local_irq_enable() and then return without local_i=
rq_disable().

Anyway, I think the patch is fine as is. We can unsuck the entry IRQ handlin=
g another day.

>=20
> Thanks,
>=20
>    tglx
>=20
>=20
>=20
