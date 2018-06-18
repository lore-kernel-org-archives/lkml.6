Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B1DC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F23C20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="i1zgfhjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F23C20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935468AbeFRRXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:23:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35866 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeFRRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:23:17 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so13122036itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JxMigBDv9lQO5irQb/9jaXHS+W57w3021PS7U1jAHfk=;
        b=i1zgfhjOG7Pq/KMRZTwsd/XCZBZk7koTAM66a9rItnidKCA8COe06zKve4XznmWTNR
         FnitkAunxF/DKIHWW5Wtt23xz92zDQvcTHD6JT3f/IVB2FwPkDYl1vNBja82Q+cE/Nu6
         ALvteaeHJEfHMuUcmt0gb+o8wZbKt5Y6kzDR8r5Yp+h3BelTIPPFnWmRg7TNiJfjA0p0
         HjSRUxolyc4mOsMsyUFFdK52K7mf/IRYMAqJF4sLH6DyNbmjge6bjYzCpi+/t9UTOn5Q
         21uFZrkr3siZegesBkeEuQdNB7XaNQVac1pUAwiB3mpGHRvUCWhn8jXs/9IjZfd+2ywL
         HO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JxMigBDv9lQO5irQb/9jaXHS+W57w3021PS7U1jAHfk=;
        b=SrfY0F9xvzJfmnXPN3A5Zn3cUAJr6/GylXRNNdNDIWxKgfqTetQvL1eTi0uknqHXJi
         PXz7tPympYJ4sA0OStiR2h+BDRLi/PtAKo3WQldqjdz5sqeDliSxZgTGJasTmweI5/G1
         cE50KNgZVwJgWXkDqkyi2dSQ8S4ZJa/RhMAcncifz1wSBL1V4p1VG4Aq7jr9WvQyUWOB
         5DS6rUjUZr1OUAQg2sDB0Av8iZGwvCoF9BiZK7wOpjvOKXhDWRczLN08Tyvbv9TFrYh3
         TqG6b1NbuAexIccZCxf4xj970SmKanSWAedoyxNXyWPzHO64WafdKyZCAEl0snH0Mx/j
         naag==
X-Gm-Message-State: APt69E1PoxL3ORRVbaNEaud0tL2bwkHsZOD4bTq35Bz66yJkViUWV7PW
        wSakeeZo6bC3b5EBiGu9Q/FDcygP1P4KPlUp11MGLg==
X-Google-Smtp-Source: ADUXVKJN5Ewaioyblv2lc7WQn7TAaejXjrcu40EMlMdPvbTPxF6jnw8KMGJYNUxKM/M3xWbENP0CmWBAkQw3D2qILCg=
X-Received: by 2002:a24:5ccb:: with SMTP id q194-v6mr9566337itb.133.1529342596500;
 Mon, 18 Jun 2018 10:23:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:494a:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 10:22:36
 -0700 (PDT)
In-Reply-To: <eaf86ae1-75f3-b49c-781c-33ebac532eb2@linux.intel.com>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
 <d8503ac3-b6a4-d6cc-3db7-4e092724b79d@linux.intel.com> <CABV8kRwhrQ75g9y7v4Mq05CfZ9khhVQCwkp052jcNOvKs6-2Fg@mail.gmail.com>
 <11347d3a-8491-1545-d47d-a1cb2fb9b410@linux.intel.com> <CABV8kRyWFJN1r8HtNrDGMCEDUEiCS=p0n8xucO9T5B1AvCDZVA@mail.gmail.com>
 <eaf86ae1-75f3-b49c-781c-33ebac532eb2@linux.intel.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 18 Jun 2018 13:22:36 -0400
Message-ID: <CABV8kRzqaxNwS-eyLCUr13eQVYjUvr=Nf=G3gch_tB9Aqo2A2A@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0 per-thread
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <andi@firstfloor.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:16 PM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> On 06/18/2018 08:13 AM, Keno Fischer wrote:
>>>> 4) Catch the fault thrown by xsaves/xrestors in this situation, update
>>>>     XCR0, redo the xsaves/restores, put XCR0 back and continue
>>>>     execution after the faulting instruction.
>>>
>>> I'm worried about the kernel pieces that go digging in the XSAVE data
>>> getting confused more than the hardware getting confused.
>>
>> So you prefer this option? If so, I can try to have a go at implementing it
>> this way and seeing if I run into any trouble.
>
> No, I'm saying that depending on faults is not a viable solution.  We
> are not guaranteed to get faults in all the cases you would need to fix up.
>
> XSAVE*/XRSTOR* are not even *called* in some of those cases.

Ah, my apologies, I was under the mistaken impression that xsaves also
read xcomp_bv to inform the layout, rather than using the RFBM and then
updating the xcomp_bv field. Let me think about this some more and see
what I can come up with.
