Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D62C8C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8241E208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp2JFh3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8241E208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755524AbeFNVAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:00:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40783 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755383AbeFNU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:59:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so3810282pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHnk7GM0F2eCaEEv0KDJ1WkQoiGj31adxlnxbM/mkEk=;
        b=Zp2JFh3Q8f/TKygk5IiiPlApIWM0k3vcwhnNN4g4dBnLaWj17Qp/P2KsrOzh9CrSgE
         4PxzlzxPim6+cTxX42F8eXBsQ+URMTR2725lA6+pmnj2gXXhp0ebBhL4vAnFvu4ftZUQ
         hmu8nUSN6/jiwXGYNAgi1RebUH4sx2CcJaFi7YSMS/7GDmKUxRl63qnt6Y0yDt1vIkDD
         wJPmXYkk+/GIz8PzMU8JTaqa+BF884b9vnVXXYgnjaslfA1VkIGadQ4g2Oyd6Q0fMrb4
         /jYwZT414jXTSrJLpgsxxDf/WE5d+DgJ6/e44knbKl1FELoC9QFpSv/3RqR+kpemBeIQ
         e1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHnk7GM0F2eCaEEv0KDJ1WkQoiGj31adxlnxbM/mkEk=;
        b=PrPKL5y/8580wrOHWapuoGp/C0Pab1ievQnGGG78ZGT2U76Q3D2oUOSSJSmsfFcnZl
         iTjD8fQ1w6eOdUGJ8qkQ1VPUFuU5xfRAo1/mD8HmZ8rv2aZjQIAu0NbbPdta+rmqQYg+
         FROgnPQxPw/mxWrL5Xmt75Ijoh38gpPuLwVpa5HdqvVuzO5qcd1r08Cmvf7RFMS81IFU
         Vai9PuXzBDRR39yw0/6mX50e0SSy6zLmxxdOyxEPmQRQGSM25ZjmokBERkDnZnHFL9T5
         IpC0u6L4ZybDSEpssVwXzoU5A9CiRo7Y2/Wysv0VHe7Cr6Czn5cnLn2Rd3K+pYxf0HqJ
         sF3A==
X-Gm-Message-State: APt69E2aEcbN1IsqNOBizNF5t4cx03V775Vds0o9dcQ/Jp4kA1S5bWHw
        35xk0tRrpd16TRsHOOaKA1pIkngsaemlJllWMJEsPA==
X-Google-Smtp-Source: ADUXVKLEFVx1jl7wNNW6SpbMOTrxSEAs5oBejCzZRZ8nCilenk1RA7ia3cmG0P4oUT401Q3zVHb6qo/rsCElNtRWBzI=
X-Received: by 2002:a63:ad46:: with SMTP id y6-v6mr3668405pgo.10.1529009997004;
 Thu, 14 Jun 2018 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180613210518.113983-1-ndesaulniers@google.com>
 <20180613210518.113983-3-ndesaulniers@google.com> <b027a324-ffae-fd5e-d8a3-03934be91a2d@zytor.com>
In-Reply-To: <b027a324-ffae-fd5e-d8a3-03934be91a2d@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jun 2018 13:59:45 -0700
Message-ID: <CAKwvOdngs8k_T=nDKh8JYdAwwFoJRcCU0bZu0tJHQ+keZ5+RFQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
To:     hpa@zytor.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com,
        "H. Peter Anvin" <hpa@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 1:48 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 06/13/18 14:05, Nick Desaulniers wrote:
> > From: "H. Peter Anvin" <hpa@linux.intel.com>
> >
> > i386 and x86-64 uses different registers for arguments; make them
> > available so we don't have to #ifdef in the actual code.
> >
> > Native size and specified size (q, l, w, b) versions are provided.
> >
> > Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I still object to Suggested-by: here.  Sedat did a correction, which is
> a Reviewed-by:, but unless I'm completely out to sea, there was no
> suggestion on Sedat's part of this; and I had certainly not seen it when
> I wrote the code.

I'm fine with changing it from a Suggested-by to a Reviewed-by.  Can
you do that when you apply the set, or should I send a v6?
-- 
Thanks,
~Nick Desaulniers
