Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C5C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280E02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="p4qx5UU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280E02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIKXF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:05:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43075 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKXFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:05:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so12631241pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8om5IPMIir/i0mRgWtf51A5W7VMLQm0+ityiOvXunpg=;
        b=p4qx5UU/5KnFW3M0/xpxAWu+IOvSfE8aTvS1OTT3ED2CRM7R0QwzjQ2tKxAsoEGlUA
         vOMiPjRHYXtSPdm9evuF/qKlAq42jG5FMM/4DuaPX2DcBPm781S4FtphFsu8UdQ6rh2m
         m+u2J3d1kbQQNtjtvH6Eyeo3j/LVyGzhxxHViUM4jjk9g0kSGsn02W4esGpWUgIZV1K5
         SFx5be5dJjW/5FfRUvIpc0rv+2NzKTSO4KvoAzaLhvBPKNnE8x4u6FXH55fLbLLB8PYD
         xo/mMFjmId724ReZO/nJ6cLw2C2A0vD/GhQ55zb4VN4QKBoAzM9i/w7/wiHWuAhy/6XI
         DexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8om5IPMIir/i0mRgWtf51A5W7VMLQm0+ityiOvXunpg=;
        b=DF6NYH25AAW0wWkkWqs9/ia/h7AuZS01XQStRdhNzaGs3qaobmiRY3bvLkGr2cEJBi
         gxra+1h/j+g5KCgc5MT5aowYaG3lWKoibSOEmXLJieVVtzkKdqHTZ4i3bQTfwhvOl5jl
         MhsnWBDMmw2dWXCGb0sgTJV18MWAlb6SFqhQmhPRr2VjxbOHjFNGgaBmjwHp4SOwtNi+
         9ulCDS8Pjmm/mr3myKcwAvgj1BEEmZqMLq1iF2y01ETHviFWCthk4YHpBZQh+IhtIVlF
         wSctMmjC0taLmSYZ2nNJoGMwZ8Un7T4yHuGrYMjdRYH7N+gofyqrR/36+cmg/GD+NIkR
         R94w==
X-Gm-Message-State: APzg51Cbq2JAnv10Pn4A5RPpdqbgdCa1id4D61cTh+LIZznrhdQXFENM
        9ZlMeydpIT6F6dHG3TQRWXsSDw==
X-Google-Smtp-Source: ANB0VdY26GL/bUKvjMRwjDfifFNsBkMjz7/yAtM4uAgMjBOn7JdIDPSXMN67g05ejMF0EBeXmwVzpg==
X-Received: by 2002:a62:f555:: with SMTP id n82-v6mr30552387pfh.59.1536689128361;
        Tue, 11 Sep 2018 11:05:28 -0700 (PDT)
Received: from [100.125.110.147] ([104.129.198.50])
        by smtp.gmail.com with ESMTPSA id t12-v6sm23815911pgg.72.2018.09.11.11.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:05:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Random crashes with i386 and efi boots
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
Date:   Tue, 11 Sep 2018 11:05:25 -0700
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org,
        x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <51FDF5AF-2FE8-4817-9A5C-8CE4A8BC23AB@amacapital.net>
References: <20180910215659.GA17966@roeck-us.net> <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net> <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net> <90A7FF2E-F186-49CF-A028-CDE317BE13E1@amacapital.net> <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
To:     Joerg Roedel <jroedel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2018, at 10:41 AM, Joerg Roedel <jroedel@suse.de> wrote:
>=20
> On Tue, Sep 11, 2018 at 09:36:51AM -0700, Andy Lutomirski wrote:
>>>   save_pgd =3D efi_call_phys_prolog();
>>>   local_irq_save(flags);
>>>   status =3D efi_call_phys(...);
>>>       local_irq_restore(flags);
>>>=20
>>>       efi_call_phys_epilog(save_pgd);
>>>=20
>>> So, yes, interrupts are very much enabled.
>>=20
>> Does fixing that solve the problem?  It seems more robust.
>=20
> The problem is still that in efi_call_phys_prolog() we load the gdt with
> its physical address, and when we reload the %cr3 in _epilog from
> initial_page_table to swapper_pg_dir again the gdt is no longer mapped.
> Blocking interrupts is more robust, but we can't block NMIs that way
> that would also trigger the issue, no?
>=20
> So I am in favor of changing the order in efi_call_phys_epilog() too.
>=20

I=E2=80=99m rather confused here.  We=E2=80=99re loading CR3 with page table=
s that don=E2=80=99t have the fixmap mapped?  With interrupts on?  And we ex=
pect it to work?  This is *nuts*.

There are IMO only three sane fixes here:

1. Load the fixmap, cpu_entry_area, etc into the EFI page table.  Drop the G=
DT reload entirely.

2. Do this whole virtual map dance earlier so we don=E2=80=99t have IRQs and=
 NMIs and such. Maybe while we=E2=80=99re still using the initial page table=
?

3. Just identity map all the EFI regions. Make EFI page tables that literall=
y map them at their physical addresses *and* map the entire kernel, just lik=
e we do for normal user mms.

Sure, as a stopgap, turning off IRQs and applying Guenter=E2=80=99s patch se=
ems okay, but this code is not okay.=
