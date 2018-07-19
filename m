Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC549ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9647120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vq6+0RIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9647120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeGSRaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:30:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55664 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeGSRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:30:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so6886280wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UqH2mx9zECHZcoLTWUxO23zzKNIwduMXdg89ScoUhDE=;
        b=vq6+0RIMvXhmO1JRvf2RH/v50e23TaMavZt8BhFaGpA3QQF50NCHngtHlnoSgVEgGX
         fLv470OTuZRJAOqnasPTHEwilP+34ps0xtH4crVqxtIACPvO0L9sBg6CPvcTEs77PvBy
         ijWGfsuCNiSX6K9FAfSxAHUBeLhZ4hc1aawD/FN9zEYVICy92W1maMcOpRNhv6FezR9p
         pEJiIJNgy6o1tywEaLv+myaP+NiyZiKBWUxmriQ/bwe4DNjF0cjgtoMdDpTegEPbAMlC
         IaP5jHCVE9F7K3bf8hxhH2KfATURYHy0xZBWZeBCtj2DdZPeTOxtJKiB6fT3/R5TF1cV
         MvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UqH2mx9zECHZcoLTWUxO23zzKNIwduMXdg89ScoUhDE=;
        b=EOWCMvtlNsAUiaWqH3PP0llQ20CmkrUqybEZH5iTZAGIn85U503ol/5rZlf+re+1c7
         H2xugYKRYXTAW6sbH9IAof0g2j6muDGZTOhvh+12XjMlHXv32vsKh60O8kzlSxden0zF
         cse646tEiodz1lRlNEAen+UEAYiebgDqaxpihh5iACjbWc3LSrg6Ghw+NIMv4q2eivss
         eD5yRkHDcAI9mcItjE3/p5HESLr9XLPu7yYmN0V+fQlCEMrcemWvsxTeSFq1/9oIzlmI
         WTTZLS4252Z/ZxX5DCP6HdY7u6oJOl6D54ANqfPXqavWY+All4b66RLVBC7IQZz9pQWH
         PjwA==
X-Gm-Message-State: AOUpUlEzitaga4BWcgvR2MrfA8K90nVzdDg9sybYNcEJ/kz+jOCJcKmt
        P7t2FYRmmQ4cuD0XU+Xb0CJEz+TvaE+h7TQ/zMcBTw==
X-Google-Smtp-Source: AAOMgpdbV2Uxbjrd+20XzLP06sQnIauFE/HGgosdlWjRPXg1M2ybFTEE5s7JFh+pcfN8k5eAFaHjla9pV5U2ZOgAmfY=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr4504932wmd.144.1532018768394;
 Thu, 19 Jul 2018 09:46:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 09:45:47
 -0700 (PDT)
In-Reply-To: <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
References: <20180716190337.26133-1-riel@surriel.com> <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com> <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 19 Jul 2018 09:45:47 -0700
Message-ID: <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
To:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I added PeterZ and Vitaly -- can you see any way in which this would
break something obscure?  I don't.]

On Thu, Jul 19, 2018 at 7:14 AM, Rik van Riel <riel@surriel.com> wrote:
> I guess we can skip both switch_ldt and load_mm_cr4 if real_prev equals
> next?

Yes, AFAICS.

>
> On to the lazy TLB mm_struct refcounting stuff :)
>
>>
>> Which refcount?  mm_users shouldn=E2=80=99t be hot, so I assume you=E2=
=80=99re talking about
>> mm_count. My suggestion is to get rid of mm_count instead of trying to
>> optimize it.
>
>
> Do you have any suggestions on how? :)
>
> The TLB shootdown sent at __exit_mm time does not get rid of the
> kernelthread->active_mm
> pointer pointing at the mm that is exiting.
>

Ah, but that's conceptually very easy to fix.  Add a #define like
ARCH_NO_TASK_ACTIVE_MM.  Then just get rid of active_mm if that
#define is set.  After some grepping, there are very few users.  The
only nontrivial ones are the ones in kernel/ and mm/mmu_context.c that
are involved in the rather complicated dance of refcounting active_mm.
If that field goes away, it doesn't need to be refcounted.  Instead, I
think the refcounting can get replaced with something like:

/*
 * Release any arch-internal references to mm.  Only called when
mm_users is zero
 * and all tasks using mm have either been switch_mm()'d away or have had
 * enter_lazy_tlb() called.
 */
extern void arch_shoot_down_dead_mm(struct mm_struct *mm);

which the kernel calls in __mmput() after tearing down all the page
tables.  The body can be something like:

if (WARN_ON(cpumask_any_but(mm_cpumask(...), ...)) {
  /* send an IPI.  Maybe just call tlb_flush_remove_tables() */
}

(You'll also have to fix up the highly questionable users in
arch/x86/platform/efi/efi_64.c, but that's easy.)

Does all that make sense?  Basically, as I understand it, the
expensive atomic ops you're seeing are all pointless because they're
enabling an optimization that hasn't actually worked for a long time,
if ever.
