Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEDCC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB77C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ourg54zZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB77C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeJECe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:34:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36357 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJECe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:34:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125-v6so8499928oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4kQ8VJxC3cT+BnlsYuBYZJ7ENAvD+eaH4vZhPmOGWs=;
        b=Ourg54zZ9jTMCGImlUYvrln9xXvblGsyrJYSCFDVfTWfmigYQFyBSGz5zu6GB0/Rid
         ADMtOcs0WLqfVIUaBaXpIhw+Db9hTR990kzZp+bnj0Cwd82WEa4YtU8fKEVNuc4RLWmM
         9TM4VH89hffOLIMbXoCN0UzX0qdIH0HJpgXGemts766GXx864pqbd6ka+UfFKDwRzBR5
         A3buJkrw9zQX2+ECbmFrHyvdSs4O+hAsGNx5QwqkgqzlD9kBMkfHyTtQNuLNKU7N827s
         ACW1d4pv8M0kFsY5T9bEwG5InWYm0Lb/UeeDcXOGROBRQMcgsicPNmkQozyuAmTto3iJ
         +CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4kQ8VJxC3cT+BnlsYuBYZJ7ENAvD+eaH4vZhPmOGWs=;
        b=oq4sC0IL3f6RWawaRPIA5ImpD02I8iUuAm8XgdUYVZbhjTuewcQ/8VzWWPkt7YmLha
         xrkcVhbbjLEuF95XGbQ09wHtr/rv12LgPT8zWYZl1Zp/oSkzpo0dLn5xYEoBinZMLXOe
         ZGbxM7Aq3s6dEgrFA4QI3ekwV+AhucxwQsQ+NJvXW4BoWWHAc2cxZlrQKP5o+jSDM8Ze
         p4kzeWrwBtGWFFLVQ4X+50XSciTxlskMgvDgZlgy5JXi9RYEn06mFyLlWeoKRspdlPMT
         1ESZUfhTQ+PjJ1peCF00F0JxaCOXnV1v3IQMbNZt9C+k2JvcQmNMgeopVyrDmwrE6jB0
         994Q==
X-Gm-Message-State: ABuFfoggPUJLTtVNZt58YzrP4RuJ2Vx4awKR6lferBwdvIUuaTDizpxL
        7fFyBgvQW5e/w786Jmz8tLcdidtDF9qT6OMAHQM=
X-Google-Smtp-Source: ACcGV62Xh1rU8ckujdPttVl8lwljzjVlIW3lnQfKUgbGAB5g7b3TdiU0cE1CE2dW3pob7JnUkQ+zxvkYiTi0ZBMI52I=
X-Received: by 2002:aca:c54f:: with SMTP id v76-v6mr3527410oif.276.1538681984887;
 Thu, 04 Oct 2018 12:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com> <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
 <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com> <20181004122207.GE4065@arm.com>
In-Reply-To: <20181004122207.GE4065@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 5 Oct 2018 01:09:33 +0530
Message-ID: <CAKTKpr4a12FHkMtFNueWqQbAhT4TLw_4DLDrOD6Tjsbno28U3A@mail.gmail.com>
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

On Thu, Oct 4, 2018 at 5:51 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ganapat,
>
> On Thu, Oct 04, 2018 at 11:12:09AM +0530, Ganapatrao Kulkarni wrote:
> > can you please pull this patch?
>
> I still don't like the idea of just removing events like this, especially
> when other architectures (including some x86 and Power CPUs afaict) playa
> similar games for generic events, and these events do actually appear in
> user code.
>
> I also don't understand why you remove the TLB events. I think that logic
> would imply we should remove all of the events, because we can't distinguish
> prefetches from reads either. If we want to be consistent, then I think
> we should just remove the OP_WRITE events for L1D and BPU -- would you be
> ok with that instead?

IIUC, dTLB-load-misses is mapped to
ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL(event 0x05) and dTLB-loads is
mapped to ARMV8_PMUV3_PERFCTR_L1D_TLB(0x25). Which are as per spec,
counts TLB access/misses for both memory-read operation and
memory-write operation.

IMO, It won't help in keeping these events, knowingly that their
mapping is not accurate, only thing i can say to users is , dont use
events that are marked as "Hardware cache event"

>
> Also, looking at the code, I think our PMCEID parsing is broken for 8.1
> parts, where the upper 32 bits of the register are offset by 0x4000 in the
> event numbering space.

yes, i did not find any mapping in PMCEIDx registers for
implementation defined events, otherwise we would have remapped at
runtime.

>
> Will

thanks
Ganapat
