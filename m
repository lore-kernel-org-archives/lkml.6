Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C31BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F138206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YeiHnb9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F138206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGQXCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:02:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39761 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbeGQXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:02:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id p23-v6so1071670plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ys6t5zYFx91zD5Dzo9fY7COJJTT3rEFOd/PeiNe8cFw=;
        b=YeiHnb9BPK8/UI8+DOMcbV8xDektBXBAhs6BRcXuNEh8HjXuDRxRe0CywLZ32lp6Uo
         0PI8WmoDZS8e58AjLpD123tT2sCas9UVV+CpJSWxRUboKGnje7rGpbxCc8ET8UdkCeKp
         q6h8cNUV52+XETcpZdEvVFqOKGin0GZWwo+zq44wT/KUP1m4c3CIm4cv7Fyx1lRlmn7A
         +JYVnqXKUY23UXg5Iy9sptNQTv+NLm+eQexfDDVJD4a9lkQkMRWmT7r3h1tA088HsAYA
         v/TqkkAEL/4MRzHy1+ETjp/VPy3vI11hyNpDBO7qC/XsV6entOyzKDVeTLefTLp52D4z
         IP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ys6t5zYFx91zD5Dzo9fY7COJJTT3rEFOd/PeiNe8cFw=;
        b=r1l36wrYIqc2Ue4TW7w+h/J/R12hNi/wMAQKyoH+Z2uxYNxJnNtR/iLpsaFXmGoMXo
         nT2cnodmOomxAx5HrCLCTf8k2OfUOSNZHspOJvdYbcwLgbC0Cfc9bDjPqo07AecIsJGe
         1Xgy70lHTyJuITDnoeCXpVIxuyfwN304XmYEPp0PEg0NAmCmQuufJP8n3nlbdwFBOL7R
         fFHhfZSka593dplfra4Mo0vJdMLm4UQPeU6ZZQrhmrwdmvGUJOgKNKOGmULZDemXZIN5
         9DSs9FwSwid8pxD8HykAvQ6QpPQKleQVORnuG0DRXQuv8NnZ/EFN8NekYMUCFbrDNYTp
         rT6A==
X-Gm-Message-State: AOUpUlHiaJczqF40Z8RBXsI+uXgWW6Wg53dgEg/yM9zhwhnQ9vIRZg3A
        0X4JE/+9tk3iEdnGbb2vGSxPe21YnmU=
X-Google-Smtp-Source: AAOMgpe5aJCMIdwVwViOwNhCLKEtqVrDGOtlDbE+Vl18t4w/+JgfRpcNcgtpzqqzg42h1fR7CDoOLw==
X-Received: by 2002:a17:902:a981:: with SMTP id bh1-v6mr3334956plb.2.1531866479427;
        Tue, 17 Jul 2018 15:27:59 -0700 (PDT)
Received: from ?IPv6:2600:1013:b02f:8a6b:400a:40d5:690:b4ae? ([2600:1013:b02f:8a6b:400a:40d5:690:b4ae])
        by smtp.gmail.com with ESMTPSA id 1-v6sm3298353pfm.145.2018.07.17.15.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 15:27:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <A3FE5372-2418-4D83-A023-36ECE6E6F423@surriel.com>
Date:   Tue, 17 Jul 2018 12:27:53 -1000
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <67F32577-24D8-4E9F-ADB1-927B3AC18B5A@amacapital.net>
References: <20180716190337.26133-1-riel@surriel.com> <20180716190337.26133-5-riel@surriel.com> <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com> <FF977B78-140F-4787-AA57-0EA934017D85@surriel.com> <CALCETrXtpGPm2Hgm3R=p1ezvNQi==jhQWw5ee9K+H2avNNGsUg@mail.gmail.com> <A3FE5372-2418-4D83-A023-36ECE6E6F423@surriel.com>
To:     Rik van Riel <riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 17, 2018, at 12:05 PM, Rik van Riel <riel@surriel.com> wrote:
>=20
>=20
>=20
>> On Jul 17, 2018, at 5:29 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> On Tue, Jul 17, 2018 at 1:16 PM, Rik van Riel <riel@surriel.com> wrote:
>>> Can I skip both the cr4 and let switches when the TLB contents
>>> are no longer valid and got reloaded?
>>>=20
>>> If the TLB contents are still valid, either because we never went
>>> into lazy TLB mode, or because no invalidates happened while
>>> we were lazy, we immediately return.
>>>=20
>>> The cr4 and ldt reloads only happen if the TLB was invalidated
>>> while we were in lazy TLB mode.
>>=20
>> Yes, since the only events that would change the LDT or the required
>> CR4 value will unconditionally broadcast to every CPU in mm_cpumask
>> regardless of whether they're lazy.  The interesting case is that you
>> go lazy, you miss an invalidation IPI because you were lazy, then you
>> go unlazy, notice the tlb_gen change, and flush.  If this happens, you
>> know that you only missed a page table update and not an LDT update or
>> a CR4 update, because the latter would have sent the IPI even though
>> you were lazy.  So you should skip the CR4 and LDT updates.
>>=20
>> I suppose a different approach would be to fix the issue below and to
>> try to track when the LDT actually needs reloading.  But that latter
>> part seems a bit complicated for minimal gain.
>>=20
>> (Do you believe me?  If not, please argue back!)
>>=20
> I believe you :)
>=20
>>>> Hmm.  load_mm_cr4() should bypass itself when mm =3D=3D &init_mm.  Want=
 to
>>>> fix that part or should I?
>>>=20
>>> I would be happy to send in a patch for this, and one for
>>> the above optimization you pointed out.
>>>=20
>>=20
>> Yes please!
>>=20
> There is a third optimization left to do. Currently every time
> we switch into lazy tlb mode, we take a refcount on the mm,
> even when switching from one kernel thread to another, or
> when repeatedly switching between the same mm and kernel
> threads.
>=20
> We could keep that refcount (on a per cpu basis) from the time
> we first switch to that mm in lazy tlb mode, to when we switch
> the CPU to a different mm.
>=20
> That would allow us to not bounce the cache line with the
> mm_struct reference count on every lazy TLB context switch.
>=20
> Does that seem like a reasonable optimization?

Are you referring to the core sched code that deals with mm_count and active=
_mm?  If so, last time I looked at it, I convinced myself that it was totall=
y useless, at least on x86. I think the my reasoning was that, when mm_users=
 went to zero, we already waited for RCU before tearing down page tables.

Things may have changed, but I strongly suspect that it should be possibly f=
or at least x86 to opt out of mm_count and maybe even active_mm entirely.  I=
f nothing else, you=E2=80=99re shooting the mm out of CR3 on all CPUs whenev=
er the pagetables get freed, and more or less the same logic should be suffi=
cient so that, whenever mm_users hits zero, we can synchronously or via RCU c=
allback kill the mm entirely.

Want to take a look at that?

>=20
> Am I overlooking anything?
>=20
> I'll try to get all three optimizations working, and will run them
> through some testing here before posting upstream.
>=20
