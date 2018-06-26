Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE62C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F9326545
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F9326545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeFZGZ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:25:58 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42557 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeFZGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:25:57 -0400
Received: by mail-ot0-f193.google.com with SMTP id 92-v6so17811682otw.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e/ZLmL+XN36JwntG3/TpDae/Gfa2zE+Ti5w8DOqaZTM=;
        b=EioEuCMTqCtlBrwrSkgrQuWrg9bU/Nl3ehYnkErrh36vhhWsxxVHl6hVBwFJyhbvHc
         uLwYDVQc+vtz3h3LvSq4/PS7wsaiIUnrDEinAa0jPZPDqKivuDuuGzU+NffGl4OS+jYf
         KoAysyyIPlMB0SDPyUdqsCIYid+1gNjjeQmKP+6g7unG1vop2gvQkSWPb5nXlRm8Ik6C
         KfT6OKvdQcPGkXeNscub5aRCvWR86znMRdA4HX1NGK+XNRlx9Erp2EPc+r5S/Bl3seZ6
         vjiU1JJQ4MMUOGDm1ExAqkgRc5zaQGfSLvXDTj3yeef6F8WKdV/xvu3XarC59bNOiXMu
         BNHg==
X-Gm-Message-State: APt69E35YYSxlCbSacD0k+LaLayN3dMwVXeQwuNcXX9OHEIwtzXmP61Q
        dTbTEUaUl7zueplacn4AGT7sf5r2Z5/bbqwpjoo=
X-Google-Smtp-Source: AAOMgpcJLrFrqDBd2UwKBQvS8hvNkpxTN4PUkHpCQM+K8Ko1Utb+hT+xDFhut75XHl09up9WTa+pdt8QFPHKvTsfRk0=
X-Received: by 2002:a9d:3666:: with SMTP id w93-v6mr100026otb.394.1529994356378;
 Mon, 25 Jun 2018 23:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180622192749.24954-1-malat@debian.org> <c182ca65-f41e-4a1c-95ee-6cb979a6e76b@c-s.fr>
In-Reply-To: <c182ca65-f41e-4a1c-95ee-6cb979a6e76b@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 26 Jun 2018 08:25:44 +0200
Message-ID: <CA+7wUsy9j8Zfxs1dB-bR-dYrzWjpNRm=BZYqkvEH5c1UzHrZMA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_powerpc=2Fmm=3A_remove_warning_about_=E2=80=98type?=
        =?UTF-8?Q?=E2=80=99_being_set?=
To:     a.p.zijlstra@chello.nl
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 7:12 PM christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> > ‘type’ is only used when CONFIG_DEBUG_HIGHMEM is set. So add a possibly
> > unused tag to variable. Remove warning treated as error with W=1:
> >
> >    arch/powerpc/mm/highmem.c:59:6: error: variable ‘type’ set but not used [-Werror=unused-but-set-variable]
>
> Is type neeeded at all when CONFIG_DEBUG_HIGHMEM is not set ?
>
> The call        type = kmap_atomic_idx();          seems useless when
> CONFIG_DEBUG_HIGHMEM isn't set. Couldn't we just most type definition
> and setting inside the CONFIG_DEBUG_HIGHMEM {} below ?
>
> Alternatively, maybe you could replace the #ifdef CONFIG_DEBUG_HIGHMEM
> by an    if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) ?

I am not familiar with this code. But starring at other arch
implementations (eg. `arch/x86/mm/highmem_32.c`), it feels like
powerpc is skipping `pte_clear(&init_mm, vaddr, kmap_pte-idx);` unless
`CONFIG_DEBUG_HIGHMEM=y`. Could someone please confirm this is the
correct behavior ?

Or else I can rewrite the code a bit like `arch/arm/mm/highmem.c`
which skips `set_fixmap_pte(idx, __pte(0));` unless
`CONFIG_DEBUG_HIGHMEM=y`.

> Christophe
>
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/mm/highmem.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
> > index 668e87d03f9e..82a0e37557a5 100644
> > --- a/arch/powerpc/mm/highmem.c
> > +++ b/arch/powerpc/mm/highmem.c
> > @@ -56,7 +56,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
> >   void __kunmap_atomic(void *kvaddr)
> >   {
> >       unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
> > -     int type;
> > +     int type __maybe_unused;
> >
> >       if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
> >               pagefault_enable();
> >
>
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
