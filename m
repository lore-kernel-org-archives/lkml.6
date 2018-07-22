Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BF1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 20:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CB820779
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TP5fcaKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CB820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeGVV5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 17:57:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44917 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbeGVV5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 17:57:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so10727272pgp.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R79B4xq1MDdo4+TK/HmVUqKu7t1kJyhyARYtcCjwUrQ=;
        b=TP5fcaKrkOBc9nXbF8znCwmr6HOI94LDp701rm+04DhPMAK5SEU9hiY19BreBEf51H
         Hsh9hYMTuakQWLhMkkmKubuHvku8TF9yzjQumRr9Fp5PeqZFQjNVbINgeA51M1b6Cz4J
         VU8iHX2xsR7vA1dIgEc7kDPNIpidqEf/yjioOLoWB1C+y+RSgBoDvTvqyK9Y/kKDDlk3
         uuXR+bRrcEkG0LkWPTRw1AzQvMnFNDugFYbvJ3friuqDUABIT5S7no5i41kgpVDc6+Xp
         3X+8PL11hSaO909Vk8xxBG1BtbNS/OCG2H4Qr2Zhd9dphDrDT6ebIJGPXJLvwIeRnXKo
         JpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R79B4xq1MDdo4+TK/HmVUqKu7t1kJyhyARYtcCjwUrQ=;
        b=nnUbjNmhp3esSXgMkgePvkej8y/dGQFw0YSwWh6KI/oUuD7d0N/x5XaKkVQeKEUVw7
         OCK+Z3yBv9ZRiZb5+KbONmEz0dRYCHqm3FJ4AfaqVCK/78L8p8ln/P8Z+BnhAHGFSTML
         Xxgey7wpy5hdZciAj4fvGy9VD0xHyXlelYtFUS6Fy4teqieaotoIWicUT3nd6FFRUq5M
         LYV2m4bqsXoiBxo+3GThUB2QC3XhqDE0rgtENOaW0exkSuuVz+RuVRS0nOssE/CWjb/4
         3wkwkmfGIJ53jj+tmlssdl1A3yG1wC1Ake23e+KZfMxS09RGW9CyDVVg71E1aI5sT8q0
         mnpQ==
X-Gm-Message-State: AOUpUlG8sDaJpoGEc9KUp7ru/kDv60SM5LCDRq0dgjjesaLeXhNed7Kr
        lV0uKf4o5Jgf6JUfE4fv6Ql6Ng==
X-Google-Smtp-Source: AAOMgpdyDkein6sLZjvDKETo4nWC3h9KPcMvb5Gw+YPexVb16LUnerqQqBINRWTuiyeWnbEpbDYzhQ==
X-Received: by 2002:a62:170c:: with SMTP id 12-v6mr10515851pfx.139.1532293164250;
        Sun, 22 Jul 2018 13:59:24 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:c03e:2ca6:ca95:c68d:5143? ([2600:1010:b052:c03e:2ca6:ca95:c68d:5143])
        by smtp.gmail.com with ESMTPSA id v23-v6sm1539437pfm.80.2018.07.22.13.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 13:59:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 2/2] x86/pti/64: Remove the SYSCALL64 entry trampoline
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CA+55aFz1ne3KTzni2Yvsp8ZRFzk+s78ZhKyGeLZvmRivBhFMfA@mail.gmail.com>
Date:   Sun, 22 Jul 2018 13:59:21 -0700
Cc:     Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <422DF5AC-6B45-406F-B3FC-DD1AA9BC18F6@amacapital.net>
References: <cover.1532281180.git.luto@kernel.org> <1e3d01ce04315218d3f8ee269528bb774a4d1d60.1532281180.git.luto@kernel.org> <CA+55aFz1ne3KTzni2Yvsp8ZRFzk+s78ZhKyGeLZvmRivBhFMfA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 22, 2018, at 11:27 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
>> On Sun, Jul 22, 2018 at 10:45 AM Andy Lutomirski <luto@kernel.org> wrote:=

>>=20
>> This patch changes the code to map the percpu TSS into the user page
>> tables to allow the non-trampoline SYSCALL64 path to work under PTI.
>=20
> Me likey.
>=20
> However:
>=20
>> This does not add a new direct information leak, since the TSS is
>> readable by Meltdown from the cpu_entry_area alias regardless.
>=20
> Afaik, it does now potentially expose through meltdown the per-thread
> entry stack info, which is new.

It=E2=80=99s always been exposed through the RO alias. The only new exposure=
 is the *address* of the RW alias, I think.

>=20
> But I don't think that's a show-stopper.
>=20
>> static void __init pti_clone_user_shared(void)
>> {
>> +       for_each_possible_cpu(cpu) {
>=20
> But this code is pretty disgusting and seems wrong.
>=20
> Do you really want to do all trhe _possible_ cpu's, not just the
> online ones? I'd rather expose less (think MAXCPU) and then have the
> CPU hotplug code expose the page as the CPU comes up?

We already have exactly the same issue for cpu_entry_area. If we change it, I=
 think we should do cpu_entry_area at the same time.  But that=E2=80=99s awk=
ward because cpu_entry_area is mapped one PMD at a time right now.

It=E2=80=99s also awkward to expose a percpu page dynamically, because (I th=
ink) percpu data isn=E2=80=99t guaranteed to all be in the same PGD-sized ar=
ea. A vmalloc fault in the early SYSCALL64 path is fatal.

>=20
>> +               unsigned long va =3D (unsigned long)&per_cpu(cpu_tss_rw, c=
pu);
>> +               phys_addr_t pa =3D per_cpu_ptr_to_phys((void *)va);
>> +               pte_t *target_pte;
>> +
>> +               target_pte =3D pti_user_pagetable_walk_pte(va);
>=20
> This function only exists if CONFIG_X86_VSYSCALL_EMULATION, so it
> won't even compile under (very unusual) configurations.

Oops.

>=20
> The "disgusting" part is that I think it could/should share more code
> with the vsyscall case, and the whole target-pte checking and setting
> should be shared too.

I tried that. It was uglier. The percpu code wants to make up a new PTE beca=
use the real kernel mapping uses large pages. The vsyscall code wants to cop=
y a PTE because it=E2=80=99s really a PTE and it has unusual permissions.

>=20
> Beause not being shared, I react to this:
>=20
>> +               set_pte(target_pte, pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL=
));
>=20
> Hmm. The vsyscall code just does
>=20
>        *target_pte =3D ..
>=20
> without any set_pte() stuff. Do we want/need the PVOP cases, and if
> so, why doesn't the vsyscall case need it?

It doesn=E2=80=99t need it. I could use plain assignment.

>=20
> Anyway, I love the approach, and how this gets rid of the nasty
> trampoline, so no real complaints, just "this needs some fixups".
>=20
>=20

I=E2=80=99ll do the fixups. I think that, if we want to unmap the pages for C=
PUs that aren=E2=80=99t present, that should be a separate patch. I=E2=80=99=
m also not convinced it adds much value.

In general, PTI is fairly crappy, and it leaks all kinds of information. I s=
uspect the worst leak is the NMI stack for local and remote CPUs. Fixing *th=
at* is going to be fugly, but may actually be important, because I can easil=
y imagine malicious user code that causes arbitrary kernel memory to get rea=
d and spilled on the NMI stack.

What we *should* do IMO is defer allocation of percpu space for not-present C=
PUs to save a bunch of memory.  But that=E2=80=99s a major change and will p=
robably break things.=
