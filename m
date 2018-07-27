Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB72320857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTaFFw8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB72320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbeG0WyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:54:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38378 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389767AbeG0WyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:54:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so11515734oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J68r1YCrRKF3sYvW9iXMAAZTDiWnMsqdX6yVjhUA48M=;
        b=VTaFFw8m0OZL7bg2gXoUfLAEMsortwijUg00xWU7FSVpRMIy4Auxh1E8SFcakpaXEg
         MCsBuhQm8hZrleaybaoPqrIAs7QfHVvn/RLTCYF+jw1mTYC2VsDTKl61wSYdna7WCoQt
         4YhnFKS9o5dYp/OLb7K9vtX33Uby2+V7X2Zyo+sJur6rVhx1eNw2zjyGHfI+g6SdpeIF
         3L5PuAcWATpMiC28+q3Re2xhPwghDku79TuyFS1fLcYmbQM1shih6Amx+pODNIWwZvzq
         WBaJhLMuGtQCtdLsIkiRb1UoEfpicNFHTkZX7hOA/KvPWIlB4oEL7bApgxfGi4wAwXqS
         N06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J68r1YCrRKF3sYvW9iXMAAZTDiWnMsqdX6yVjhUA48M=;
        b=qjBab4nD5dT8HCv69y7QjV5igqg096AvJ2FAdnDa/ub0XBGGwdfAuuZ1DYd7JqVVcN
         ZKVl8KbCbcSZH19hpqFwg90Nm/SNcFi3R7MspjpGHMJB4KQI74BCUOankmQGVwGdNaYC
         3iPqST9dsx3gfwogMPdxjs0+CktRhxKJc177LB2B9ZJ2IUYU0FEEAx6sLQ7l4TcynAKq
         vW6zB6iR8qcexShzZ2t18KkOAY84ImU3lg92YbX8+2OD8NXpV9LBlkwKo9sZujFpXMCt
         AgryT5LVJYubhXSw3pzh34M3l9V6u7F6Mk9CWd93/v4lzNjATQJr3gqTTjzGEvtl2yM1
         0kxg==
X-Gm-Message-State: AOUpUlETu7FO1CdpSSjxv1VGn8qxy7LH1K9rlujl6xuCPdeLCcvT7qeb
        Z/n7r93O+3uA7Vvf7ILXK72m5IVMnCPzc+lcJKL0+g==
X-Google-Smtp-Source: AAOMgpcwS/YceNbe+dNbpI3g40cjUoxt0QThl2Wqjt6hVxVEoBRWWTUSpmPP838b1y+nEzsdKsahmgC0cz457lAjmcU=
X-Received: by 2002:aca:544e:: with SMTP id i75-v6mr3241184oib.73.1532727025452;
 Fri, 27 Jul 2018 14:30:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 14:30:24
 -0700 (PDT)
In-Reply-To: <CALCETrVzH+9cJtxTHj300jDWx7S1bLxYCGX==7zHish9J5aFAQ@mail.gmail.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
 <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
 <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net> <CALMp9eQDWWAgmwnzZ0iTa2w+7-d_MjyOByOdfN0MjiHzaQWyEw@mail.gmail.com>
 <CALCETrVzH+9cJtxTHj300jDWx7S1bLxYCGX==7zHish9J5aFAQ@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 27 Jul 2018 14:30:24 -0700
Message-ID: <CALMp9eQ3VOOdQpZ2=rqB1W3=RnyZXDxrqXgADsDZ0eSH_8r9tQ@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        David Matlack <dmatlack@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andi Kleen <andi@firstfloor.org>,
        LKML <linux-kernel@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        "open list:USER-MODE LINUX (UML)" 
        <user-mode-linux-user@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 2:05 PM, Andy Lutomirski <luto@kernel.org> wrote:
> Does KVM *have* a concept of "maximum non-turbo frequency" of the
> guest that it would make sense to expose here?  If so, presumably the
> right solution is to expose it.

KVM has the concept of a guest's invariant TSC frequency. The Maximum
Non-Turbo Ratio is just some fraction of that. Sadly, the fraction is
100 MHz, 133.33MHz, or the "scalable bus frequency" from some other
MSR, depending on microarchitecture.
