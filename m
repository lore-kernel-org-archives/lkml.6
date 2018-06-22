Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE74FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B7C2476A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="w9g4BsXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B7C2476A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeFVSrw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:47:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39046 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeFVSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:47:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so3609384pfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3EpskJ1RdODrEMELQk0qlXjsi8QyEG1vcYiYrgyCZTs=;
        b=w9g4BsXhgb6LsdoEDk5VLWHTpEaqWc/wKar5WbqsxJJap/P5LRDgPzRS1w17i353sS
         LIS9oBkm9Eg10bgK+UD1aNwRUl8DBJ7QD3c9zdZmqtEcJX4aZNKjW5OVeTdg+Nh9D09Z
         8Zabe/CaRq2WHY8eAyFNNiqyXVkWgasodBCnBnbkMGEl5vLlFBsfD2RD4SdzSRctKhg+
         C84V68zj4T60ss1mjpVDBV4VXHCQe7YSpJkd43MmtJ++oRLXhyUCFNKKUSBq1biAjhG8
         22h4UiKPCqLKiDMgqRPnetgRZuTCniRfmaBsNlEVRhhAaql6/cQQ+fwUWRHNpjaL4KBi
         s98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3EpskJ1RdODrEMELQk0qlXjsi8QyEG1vcYiYrgyCZTs=;
        b=Jtd1lYlD5JSSx5hcZFlXRaMZSVWgRqKOSWQuO/ZxoiI/pTTe/nkUUtWEntkRXW/7ig
         O19OMv1pavj5UYqJYFRGKpCwSIuAB4g8dY0TG9iLHd30+lRCMTOv2Q9roUn6EaHBe88s
         C6hqecDGVBgN/L1ULMkUYJZ+suaCWk+60V+ECXWJ8ULCFpNdgEpFgFKbPstMhzMDX20Q
         riLmoiVVlWTP3e4gNW93eL95ev9eAxnKnjFDxO6B1I3sbXupkXI8t/r5BNlso7VURM2v
         VYC0jsAA88YNJ4Pt9oCuYZiI3yfMUzFEcaXk/QtAz2KffuYGoAiZzXSbyo7YSGOJhyfG
         owVw==
X-Gm-Message-State: APt69E33nUNR2KvXSKsV4Sq8H85aKhVUKFy6HAJ5gTNPlEPiF9wnQdSy
        WPg6aMd2LMaOzYF4Ux2ZBy/FBQ==
X-Google-Smtp-Source: ADUXVKK7iiaUV9Eqx3ShDQEpMSlj5wQEmJkdj3lCJi8JXIzNjPkCWW04G87TtZ8TeG7OPe4f+2CZcg==
X-Received: by 2002:a63:704a:: with SMTP id a10-v6mr2414561pgn.443.1529693270736;
        Fri, 22 Jun 2018 11:47:50 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:2cd9:e530:8535:a508:f820? ([2600:1010:b065:2cd9:e530:8535:a508:f820])
        by smtp.gmail.com with ESMTPSA id f3-v6sm12733623pfn.149.2018.06.22.11.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:47:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in refresh_ldt_segments()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <408ed97a-c64d-c523-c403-4e066d1f34c3@intel.com>
Date:   Fri, 22 Jun 2018 11:47:48 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB113DE3-5841-49B2-A11E-CE785EF0C763@amacapital.net>
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180621211754.12757-2-h.peter.anvin@intel.com> <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com> <408ed97a-c64d-c523-c403-4e066d1f34c3@intel.com>
To:     "H. Peter Anvin" <h.peter.anvin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Jun 22, 2018, at 11:29 AM, H. Peter Anvin <h.peter.anvin@intel.com> wro=
te:
>=20
>> On 06/22/18 07:24, Andy Lutomirski wrote:
>>=20
>> That RPL3 part is false.  The following program does:
>>=20
>> #include <stdio.h>
>>=20
>> int main()
>> {
>>    unsigned short sel;
>>    asm volatile ("mov %%ss, %0" : "=3Drm" (sel));
>>    sel &=3D ~3;
>>    printf("Will write 0x%hx to GS\n", sel);
>>    asm volatile ("mov %0, %%gs" :: "rm" (sel & ~3));
>>    asm volatile ("mov %%gs, %0" : "=3Drm" (sel));
>>    printf("GS =3D 0x%hx\n", sel);
>>    return 0;
>> }
>>=20
>> prints:
>>=20
>> Will write 0x28 to GS
>> GS =3D 0x28
>>=20
>> The x86 architecture is *insane*.
>>=20
>> Other than that, this patch seems generally sensible.  But my
>> objection that it's incorrect with FSGSBASE enabled for %fs and %gs
>> still applies.
>>=20
>=20
> Ugh, you're right... I misremembered.  The CPL simply overrides the RPL
> rather than trapping.
>=20
> We still need to give legacy applications which have zero idea about the
> separate bases that apply only to 64-bit mode a way to DTRT.  Requiring
> these old crufty applications to do something new is not an option.

>=20
> As ugly as it is, I'm thinking the Right Thing is to simply make it a
> part of the Linux ABI that if the FS or GS selector registers point into
> the LDT then we will requalify them; if a 64-bit app does that then they
> get that behavior.  This isn't something that will happen
> asynchronously, and if a 64-bit process loads an LDT value into FS or
> GS, they are considered to have opted in to that behavior.

But the old and crusty apps don=E2=80=99t depend on requalification because w=
e never used to do it.

I=E2=80=99m not convinced we ever need to refresh the base. In fact, we coul=
d start preserving the base of LDT-referencing FS/GS across context switches=
 even without FSGSBASE at some minor performance cost, but I don=E2=80=99t r=
eally see the point. I still think my proposed semantics are easy to impleme=
nt and preserve the ABI even if they have the sad property that the FSGSBASE=
 behavior and the non-FSGSBASE behavior end up different.

>=20
> The only other sensible option is to conditionalize this on the affected
> process being in !64-bit mode.  I don't like that myself.

Please no.

I really wish Intel had made WRGSBASE at CPL 3 require GS=3D=3D0. The curren=
t ISA was a mistake.

>=20
>    -hpa
