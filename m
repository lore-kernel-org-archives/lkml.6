Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EBE2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVRRkfeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EBE2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeGaCGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:06:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54681 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeGaCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:06:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so1144780wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 17:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZCTNO7l1zXWs/lTPNJh3hnDtpHCOLiA517x/IgDS2o=;
        b=nVRRkfeXPb8nc3WyZDCd5n8sT1Jvji440Ws5c22rMNRaY4XpdC9vO6SeqwWCUkzWRG
         fA9S9r69vL6IIX0XIv0NI+ro85EYeseYGke7Aya4zVz6hWZ2Z/cDPtfz8DZTSM6gYTsH
         sbHRW/JTOZauTWbd3YkK2Bn7U5DS7ZZvUF63C0hXYBwyk1JVMFNINblrTVB71wzG8gr1
         7Pg8J5w7fUTX+DBnBeNj1l5UUgP82Aa0TQL+MnpjTHzSXxWuIW2hjJFdK08yNp4Zz2rX
         p+1LENuPDeH3QypYxi5Ry8SYLhwGOzwyIFEjgJ9cu+bFwPcxMg4gZ8RJtpVAaMnz4abp
         sljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZCTNO7l1zXWs/lTPNJh3hnDtpHCOLiA517x/IgDS2o=;
        b=ozvonDjjrlFQxLquCU2VWPysjrwqZiYaKUQpjOoMbgoPp9moAwaWikNzqeRa65j+P4
         k+5t6Vf+/R1V/VcoXr2VSmSs44zASZI7BFmkW7kAG+9yRgpLhtZIKx4OMucjsEgTPxz/
         D76YPvdW0Xv8Xdakah3RIGhcyKJES5+hTLxgbAjADET/ER45jbJAfpUGJd2pDKo7m0Pt
         3WK98hn0uWUPXaehHMR1sahqsGdIx3dG1c0YZl79Pk94zm7JSnpTkeJFSNqV3iTPqEta
         uFCaNmrg1IFiwqMip3XlLQxojjgwaeAoFRO0naBLWbv3vI+9XPm56ZsEdFfDH9xnfVwc
         uSnA==
X-Gm-Message-State: AOUpUlEXTTRcPoWATmrCk7JCsAQlFmOvD+jf53vra25BdAYTWQU50vYM
        hWr8kWA/P/MX9Jdb5gaQwA3OLoOGg3DSqHkVvDIRvw==
X-Google-Smtp-Source: AAOMgpfQ37r8cvVgTI9HQbfcf0FzWF1dwVer05CG/jgBXYnxzwrFQteqrETh2uv5mtXAN3RdNHduVpaaIoApz/bCmGw=
X-Received: by 2002:a1c:f306:: with SMTP id q6-v6mr763965wmq.111.1532996928875;
 Mon, 30 Jul 2018 17:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com> <20180730162926.GD11890@nazgul.tnic>
In-Reply-To: <20180730162926.GD11890@nazgul.tnic>
From:   Cannon Matthews <cannonmatthews@google.com>
Date:   Mon, 30 Jul 2018 17:28:37 -0700
Message-ID: <CAJfu=UcafhF4EEXxFAT+1v8F4i7GJ99z2wKc2Z5PJ8THst2VKw@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
To:     bp@alien8.de
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the feedback from everyone.

I am going to try to fix this up, and do some more robust benchmarking,
including the 2MB case, and try to have an updated/non-RFC patch(es) in
a few days.

Thanks!
Cannon
On Mon, Jul 30, 2018 at 9:29 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 24, 2018 at 07:37:28PM -0700, Cannon Matthews wrote:
> > diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> > index 88acd349911b..81a39804ac72 100644
> > --- a/arch/x86/lib/clear_page_64.S
> > +++ b/arch/x86/lib/clear_page_64.S
> > @@ -49,3 +49,23 @@ ENTRY(clear_page_erms)
> >       ret
> >  ENDPROC(clear_page_erms)
> >  EXPORT_SYMBOL_GPL(clear_page_erms)
> > +
> > +/*
> > + * Zero memory using non temporal stores, bypassing the cache.
> > + * Requires an `sfence` (wmb()) afterwards.
> > + * %rdi - destination.
> > + * %rsi - page size. Must be 64 bit aligned.
> > +*/
> > +ENTRY(__clear_page_nt)
> > +     leaq    (%rdi,%rsi), %rdx
> > +     xorl    %eax, %eax
> > +     .p2align 4,,10
> > +     .p2align 3
> > +.L2:
> > +     movnti  %rax, (%rdi)
> > +     addq    $8, %rdi
> > +     cmpq    %rdx, %rdi
> > +     jne     .L2
> > +     ret
> > +ENDPROC(__clear_page_nt)
> > +EXPORT_SYMBOL(__clear_page_nt)
>
> EXPORT_SYMBOL_GPL like the other functions in that file.
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
> --
