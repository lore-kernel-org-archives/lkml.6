Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC01A2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP/oeqIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC01A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeH2F6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:58:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46919 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeH2F6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:58:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id a4-v6so1551340plm.13;
        Tue, 28 Aug 2018 19:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=wDh5DFetOSuIrZ9UcJDkefx2S2tR7sbhXwvqy+1VJLE=;
        b=jP/oeqIMMxKW+JGi9pM3ZALpAXRaGSVB/n2r4cbJlwsXG6tdda/oEMAQCbXs3URpHQ
         XhShstP5ZE0hforX5Hff14DWf3GYsnp3rjka6z7GiEnvTawi1gMU99JW0wqev9kK539h
         NAw3eVqXHTWtCLJb5IMXBcntk6K3tysL3w5b83Vg6SyO//MzmRoW/rkKswT3MrU0N0XX
         Adleh7Yyv/tpndf5TybPZk+uS7VHCAbjJENe4ZNnOq/4b2fZJ/3/0eUD9qMJ8t4yvaIJ
         /+rIc0Nn04X+mBovI/7D+FJ2e9QItof7llU7PRxrax06/CzyTqoB/1+aHKMpwu9WrI7M
         fGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=wDh5DFetOSuIrZ9UcJDkefx2S2tR7sbhXwvqy+1VJLE=;
        b=OC8Wt0kM2aZ5thloo6XPFReV1ZyFGho29a51JN2MllLUvpXSret/jexy0g1bO1UOY0
         /BTHpfOezF2yNf3ZHk2rPd76v+30lbDbY//3ZaAx1eouF/qDQkmAcmxiFMfXucUGUIo2
         XaDF4tH9ElK+bJLbcPx6hE9eYVPVXXA5Lbu6BJv7cjSW9uUSLjPRW7Ybk6gBdMclDe2r
         X+B9S2Wp29A2usCmAA/ZEcGll+k8Gwotjk0Z41ILir2A9vk0WKc8Ods2VZVWMTlmlZXk
         HmgVOWCGDOxhdjtG164Fv0e48EsPXW3L9lCBwTEe8QBg/IsVDgQXXsFQw3xLeWyGUSSt
         rXZQ==
X-Gm-Message-State: APzg51AumZxwRTFHvg7KXQGaVggQBpSgvbsk78oJTI/vPxbGL0s3EWfR
        Zbtwaqy/ns2V1fVhojY/y0Q=
X-Google-Smtp-Source: ANB0Vdas3QklNkjeuEopGLVSF9fty1DyYDqsG4oWLmgxT+Eb9m95wRv9vrYphhQ6ds8hOj3GPN5lYg==
X-Received: by 2002:a17:902:c7:: with SMTP id a65-v6mr3982546pla.208.1535508246984;
        Tue, 28 Aug 2018 19:04:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:cb40:570f:4148:c992:66fd:90ee? ([2600:1700:cb40:570f:4148:c992:66fd:90ee])
        by smtp.gmail.com with ESMTPSA id s9-v6sm3877880pgc.16.2018.08.28.19.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 19:04:05 -0700 (PDT)
Subject: Re: [PATCH] x86/speculation/l1tf: fix off-by-one error when warning
 that system has too much RAM
To:     Andre Tomt <andre@tomt.net>, Andi Kleen <ak@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org,
        George Anchev <studio@anchev.net>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823154437.GC12066@tassilo.jf.intel.com>
 <0fa72221-2272-4489-d9d3-0f68cb874087@tomt.net>
From:   Christopher Snowhill <kode54@gmail.com>
Message-ID: <73314d45-85bc-2a7d-a839-9c9ab4260592@gmail.com>
Date:   Tue, 28 Aug 2018 19:04:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0fa72221-2272-4489-d9d3-0f68cb874087@tomt.net>
Content-Type: multipart/mixed;
 boundary="------------CC8BAF4C829EACC00A65DCF6"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CC8BAF4C829EACC00A65DCF6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/23/2018 07:22 PM, Andre Tomt wrote:
> On 23. aug. 2018 17:44, Andi Kleen wrote:
>> On Thu, Aug 23, 2018 at 03:44:18PM +0200, Vlastimil Babka wrote:
>>> Two users have reported [1] that they have an "extremely unlikely"
>>> system
>>> with more than MAX_PA/2 memory and L1TF mitigation is not effective.
>>> In fact
>>> it's a CPU with 36bits phys limit (64GB) and 32GB memory, but due to
>>> holes
>>> in the e820 map, the main region is almost 500MB over the 32GB limit:=

>>
>> Ah I see it's a client part with very large DIMMs and someone being
>> very brave and using that much memory without ECC.
>
> FYI; It is also happening on Xeon E3v2 (Ivy Bridge generation) w/ 32GB
> of ECC RAM here, a low-end server part that officially supports up to
> 32GB.
>

Indeed, I must be "very brave" to not have chucked this CPU and
motherboard and RAM in the bin, and bought a new board, Xeon CPU, and
ECC RAM. Maybe I'll consider that in the future, when I again have
$1000+ to buy new kit. Which will probably be never, at this rate.

>> [=C2=A0=C2=A0=C2=A0 0.000000] microcode: microcode updated early to re=
vision 0x20,
>> date =3D 2018-04-10
>> [=C2=A0=C2=A0=C2=A0 0.029728] L1TF: System has more than MAX_PA/2 memo=
ry. L1TF
>> mitigation not effective.
>> [=C2=A0=C2=A0=C2=A0 1.063155] microcode: sig=3D0x306a9, pf=3D0x2, revi=
sion=3D0x20
>
>
>> processor=C2=A0=C2=A0=C2=A0 : 7
>> vendor_id=C2=A0=C2=A0=C2=A0 : GenuineIntel
>> cpu family=C2=A0=C2=A0=C2=A0 : 6
>> model=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 58
>> model name=C2=A0=C2=A0=C2=A0 : Intel(R) Xeon(R) CPU E3-1230 V2 @ 3.30G=
Hz
>> stepping=C2=A0=C2=A0=C2=A0 : 9
>> microcode=C2=A0=C2=A0=C2=A0 : 0x20
>> cpu MHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 3500.044
>> cache size=C2=A0=C2=A0=C2=A0 : 8192 KB
>> physical id=C2=A0=C2=A0=C2=A0 : 0
>> siblings=C2=A0=C2=A0=C2=A0 : 8
>> core id=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 3
>> cpu cores=C2=A0=C2=A0=C2=A0 : 4
>> apicid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 7
>> initial apicid=C2=A0=C2=A0=C2=A0 : 7
>> fpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : yes
>> fpu_exception=C2=A0=C2=A0=C2=A0 : yes
>> cpuid level=C2=A0=C2=A0=C2=A0 : 13
>> wp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : yes
>> flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : fpu vme de pse tsc m=
sr pae mce cx8 apic sep mtrr pge
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
>> syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>> xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
>> ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
>> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
>> cpuid_fault epb pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority
>> ept vpid fsgsbase smep erms xsaveopt dtherm ida arat pln pts flush_l1d=

>> bugs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : cpu_meltdown spectre_=
v1 spectre_v2 spec_store_bypass l1tf
>> bogomips=C2=A0=C2=A0=C2=A0 : 6602.15
>> clflush size=C2=A0=C2=A0=C2=A0 : 64
>> cache_alignment=C2=A0=C2=A0=C2=A0 : 64
>> address sizes=C2=A0=C2=A0=C2=A0 : 36 bits physical, 48 bits virtual
>> power management:
>
>


--------------CC8BAF4C829EACC00A65DCF6
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3DCUg/
-----END PGP PUBLIC KEY BLOCK-----

--------------CC8BAF4C829EACC00A65DCF6--
