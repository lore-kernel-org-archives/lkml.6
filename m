Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0C9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18D321473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syDWoCZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18D321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJDMdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:33:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43989 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJDMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:33:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id e21-v6so7972211otk.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QHogu/EGQzE2KzonWmloSuaT3Q50Dv5gL9JnXU4z+M=;
        b=syDWoCZzdK0g3ZOGOb6dEygTsB/AOwdvL2wpjq/cwy54Q1fUXgUKejmyRs0Pmff5e6
         uLklQFPr9+dretG+S+rajSVY10srVejUNsjwqrEN3uxncc4ZfRww62cOUZckqxcyho+O
         XqeTjzTjwW6yCMWRazZ7oMMZJBWf5ia/yk+8O86F+LlMiOiBcWXCITIuKaGQ3aED9fDk
         K8DBh06V4o9djswAufeo507XYbVlK2Pgd/6e/2eKeaIap6QL78alb6ohideJFEzOw6yQ
         Rcr9EBTfEalSOOCigVrvBMy7Z8crL3x7ost/mEgLdcbdjgYWhjOB+xwOQdsWlOTNphwC
         owpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QHogu/EGQzE2KzonWmloSuaT3Q50Dv5gL9JnXU4z+M=;
        b=gXu9r8YXdmOIvN7/+ovyWgaKn8Uky01fmi5u31NyB9dVV0NcW7eBX7sJGGqTA9kfMR
         N4HhabmVaJyvnmqwBs+XNbTPlSSDjxOgop/LnVtth5zTAd9Bek0W4bxroyXAHO6fV9f7
         xk5sPl9rxAlsdzzGZeMJzib1KrkE9sGBk8H9q2t+c7u0ynt9r9AqSfSR2HB7yXuWKHDW
         gb8/xspTmhfP2W96MODQd4I+s+POX2mnkeaJVupQuXE8kIseM2WJbEodmBWKwBmHLKvD
         B5c5ndDpxOkMRLKSeDFPOW9Kk5FvXd+j6Kv1lIZG9iHCGErxrYep+jpD9jtjI5VgZeSI
         FlqA==
X-Gm-Message-State: ABuFfoh5TewsVXAxZrBH2s8YPjg9ZhuU4wzPAG7uXAr+sJGbJEvjvV7E
        QjUCKueL2tUZNMiZaMqS4eke6pXJ6Qip0e2Fcik=
X-Google-Smtp-Source: ACcGV63HbecXvemzVskh8I85Djmu/X27eMH55n8uzBzPj33+ws9T/35BWOiNUWQOoCbLFlRefDBjSAc6G0FPwWt20SI=
X-Received: by 2002:a9d:2fe6:: with SMTP id b35mr1860378otd.18.1538631741234;
 Wed, 03 Oct 2018 22:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com> <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
In-Reply-To: <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 4 Oct 2018 11:12:09 +0530
Message-ID: <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

can you please pull this patch?

On Mon, Oct 1, 2018 at 10:09 PM Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>
> Hi Will,
>
> On Mon, Oct 1, 2018 at 7:58 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Hi Ganapat,
> >
> > On Mon, Oct 01, 2018 at 10:07:43AM +0000, Kulkarni, Ganapatrao wrote:
> > > Perf events L1-dcache-load-misses, L1-dcache-store-misses are mapped to
> > > armv8_pmuv3 (both DT and ACPI) event L1D_CACHE_REFILL. This is incorrect,
> > > since L1D_CACHE_REFILL counts both load and store misses.
> > > Similarly the events L1-dcache-loads, L1-dcache-stores, dTLB-load-misses
> > > and dTLB-loads are wrongly mapped. Hence Deleting all these cache events
> > > from armv8_pmuv3 cache mapping.
> > >
> > > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > > ---
> > >  arch/arm64/kernel/perf_event.c | 8 --------
> > >  1 file changed, 8 deletions(-)
> >
> > The "generic" events are really implemented on a best-effort basis, as
> > they rarely tend to map exactly to what the hardware supports. I think
> > they originally stemmed from the x86 CPU PMU, but that doesn't really
> > help us.
>
> This works fairly well for DT based boots, since almost all SoCs have
> added remapping using custom dt object binding.
> However we have concluded in the past to drop SoC specific from the
> ACPI mapping and use json to add SoC/micro architecture specific
> events support.
> At present ,  When we boot with ACPI,  it is misleading for these events.
>
> In fact, this has been pointed internally from benchmark team and
> reported it as hardware bug!
> IMHO, it would be much simpler to delete these misleading events
> mapping rather explaining to perf tool users.
>
> We already have proper mapping for these events,
> armv8_pmuv3_0/l1d_cache_refill/
> armv8_pmuv3_0/l1d_cache/
> [core imp def:]
> l1d_cache_rd
> l1d_cache_wr
> l1d_cache_refill_rd
> l1d_cache_refill_wr
>
> >
> > I had a discussion with Ingo back when we originally implemented perf
> > because I actually preferred not to implement the generic events at all.
> > However, he was strongly of the opinion that a best-effort approach was
> > sufficient to get casual users going with the tool, so that's what we went
> > with.
>
> thanks for the background info, these generic mapping fairly works
> except these events.
>
> >
> > Will
>
> thanks,
> Ganapat

thanks,
Ganapat
