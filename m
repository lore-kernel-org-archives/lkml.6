Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F18C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412B321A05
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBLqJA+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412B321A05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeHQUJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:09:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53271 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeHQUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:09:22 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so12202054itw.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYLH/vLlJ1z8Y6BtsiU0X/uc8ONaAHXRoM06QeKTSCo=;
        b=fBLqJA+J1gsVm6TERXMRwllKNy5Q8UfLtcSzN67l2j277kJ0cpGnRJ1h5rA9djUo3O
         2QWgwSUQDnO8igtTT6WlI0RnweVQWRutJcRZvE0kssu9e72pHWYB7baTw8lg0qywPLJL
         MMyIBR/95Hp7vJlhrCKp7tadi2ikmyH9AkJBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYLH/vLlJ1z8Y6BtsiU0X/uc8ONaAHXRoM06QeKTSCo=;
        b=Qd4aYJdSJdFxDF2OXOBNoo2lQvD/38pYGWlQxtT81kddB6HaGpXaNp2e+MEm3UgMhq
         2QrF07J9M8NEU8oCZBLKPMPZWPr2fktbSk7PpgUxosmLEB3SAmHL7Idc+VcP3gVrPJbI
         EQ/P9lFVFe2kOntldMjUVB1T7tC1eJNor2UjD+hz4k87RPwASkqNPrCsAczyB+x5k+2W
         okEz0WclOY/GY5bXNLVWLXThEz43tSC5OjZ1NqutOUx9zbmDyyyrHg+S5/cTHTPueOKR
         Xesruv/SzRHJrZzwkemo+0e6ElaLPfOBaF9f7cgrUIgFkBsWQANCgDZTT4T95EcSCfyc
         Kesg==
X-Gm-Message-State: AOUpUlFZpGdDrIQuk1yHauSVI8nT8Lohc1ls+9zIyFd5OYUaJeB333/R
        BGmp18UL9VL8I0Qm2lXK50EQf3jIyvkCpySNig0=
X-Google-Smtp-Source: AA+uWPwP/0aaV9cIDnV/RHoXe7tWXIziJ3CXdHITAnomPpavQQlt/h2n0zwqdlWECZ4azPaRD3Z1lLs2ivvaUwzN8O8=
X-Received: by 2002:a24:d0cd:: with SMTP id m196-v6mr27705689itg.9.1534525513484;
 Fri, 17 Aug 2018 10:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180816204638.4046-1-sean.j.christopherson@intel.com>
 <CA+55aFweC_ja8pLOHv2dbokChaJej2bhhDyeO5ZxiQ+64C-Xog@mail.gmail.com> <20180817170148.GA29466@linux.intel.com>
In-Reply-To: <20180817170148.GA29466@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 10:05:02 -0700
Message-ID: <CA+55aFzQf3VRKtvaQCbZAt3aSkd_tSTTPNYpvRbF0XdaCaNb0g@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation/l1tf: Exempt zeroed PTEs from XOR conversion
To:     sean.j.christopherson@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 10:01 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Checking for a non-zero val in __pte_needs_invert() also resolves the
> issue.  I shied away from that change because prot_none_walk() doesn't
> pass the full PTE to __pte_needs_invert(), it only passes the pgprot_t
> bits.  This works because PAGE_NONE sets the global and accessed bits,
> but it made me nervous nonetheless.

Good point, and I do think that might merit a comment in the code.
Will add, and credit you. But I'd still prefer to just fix up just
__pte_needs_invert.

Thanks,

              Linus
