Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE4C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BE320827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BE320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeKHRAJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:00:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33722 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKHRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:00:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id x204-v6so668758oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m5QoePyAj2YI6QUty4NP8hZpIkgaGBT9QFNFVrkmBkU=;
        b=dQo/lES9N+Q4X1LLx9CyXyTWjuxdNfe2oA8quDcpJ8S0DoK8fawMXHW/GEZZQZZg41
         8Cwp+nG5QnIgoSVGZ96DLPK3DkVGrAt/+qDZXG9r/y5g48OS+idKKzILemwu1sNHrh7U
         ARFXsYOUWsPEL0QaL2zE1nTu948BM1M1IhUFV6WFKbuTm/uoyulS2dUtkQ+X4cojN42A
         hVdpCfa8TpSbBjpS8kTT1rF56jE5/Bs6wqS46En1zP417/ZfQ65nu+8K4VjSu1LDpx2e
         U5mOZmhLlr7RHCXJICVd74uXnajArnrOvRikIKWchCMRhtOKw0YtoBIst2zBvTUDoECI
         Y/Qg==
X-Gm-Message-State: AGRZ1gLq2jGvcAVHVD0KT53hk4c/PZs5FcnX2BXHWB1J4GWblRc8RbTT
        as40KUPXEu9DFiH7wOAr7l2Hg8j71QqINzwBRiM=
X-Google-Smtp-Source: AJdET5elf07R5uCUGxPaTC6fZMJRiDCclIPfeQLpTxCho2NHE9L4Vrej7h5BV8U+F5FhpEGStoUj+m06y1uzbbUIBrQ=
X-Received: by 2002:aca:aa84:: with SMTP id t126-v6mr2093746oie.218.1541661960379;
 Wed, 07 Nov 2018 23:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20181107202641.7865-1-malat@debian.org> <d3ba180c-9ab1-d204-7a62-0563ecabad70@c-s.fr>
In-Reply-To: <d3ba180c-9ab1-d204-7a62-0563ecabad70@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 8 Nov 2018 08:25:47 +0100
Message-ID: <CA+7wUsz8TVtOuSvmWVGeZmPKGvxFhHy2mVSKex4REFs9uGb_xQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Mark variable `cpumsr` as unused
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Breno Leitao <leitao@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 7:09 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
>
>
> On 11/07/2018 08:26 PM, Mathieu Malaterre wrote:
> > Add gcc attribute unused for `cpumsr` variable.
> >
> > Fix warnings treated as errors with W=1:
> >
> >    arch/powerpc/kernel/process.c:231:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
> >    arch/powerpc/kernel/process.c:296:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> I don't think this is the good way to fix that. This problem was
> introduced by commit 5c784c8414fb ("powerpc/tm: Remove
> msr_tm_active()"). That commit should be reverted and fixed.

I see, it makes sense.

> That commit should have removed the macro and kept the inline function.

Breno, what do you think ?

> Christophe
>
> > ---
> >   arch/powerpc/kernel/process.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 96f34730010f..b9f1a2408738 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(flush_fp_to_thread);
> >
> >   void enable_kernel_fp(void)
> >   {
> > -     unsigned long cpumsr;
> > +     unsigned long cpumsr __maybe_unused;
> >
> >       WARN_ON(preemptible());
> >
> > @@ -293,7 +293,7 @@ EXPORT_SYMBOL(giveup_altivec);
> >
> >   void enable_kernel_altivec(void)
> >   {
> > -     unsigned long cpumsr;
> > +     unsigned long cpumsr __maybe_unused;
> >
> >       WARN_ON(preemptible());
> >
> >
