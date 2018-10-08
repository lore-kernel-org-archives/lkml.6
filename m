Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D31C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F121D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASfF7Dva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F121D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJHRKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:10:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44731 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:10:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so7346658otf.11;
        Mon, 08 Oct 2018 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pPl+ooxeuaHheuMEW1uilUNg7fgvFgLTQ5AiW5OUWI=;
        b=ASfF7DvaFE+sS7/Qr+mj2BWqdEmZUx6Vt75cTZCD5+aIVjW/g25ejQ7gNj7lNqcyfX
         xtwyvO259ecUYT5J09nkD8Idm5zXIO7gTgMxR7DXr2bpiJh028CNoczbkGhI1HCjRApm
         hj61u+GMhK4rV7tAb2Lw3QFg7PS40sJII52rNaLms+eiKuSk4oUKB+N99WtR497uNXT8
         1/6RfvT4dLLivJuLu5x17ezOifh3VZoMsko3PEmKkesg+3beIxZy13NqGntee9A8+9Zb
         NxPRMhjdUv9G4cGXtU6FglDjGZ+zCfjSNLQUF1AtRq3wlkLQuamWY7SerMhnOQlIfklW
         Lkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pPl+ooxeuaHheuMEW1uilUNg7fgvFgLTQ5AiW5OUWI=;
        b=tB5Qy7aWluPCh2xHUWo2CBoBaC/o+p8/u8b5YblYmNG36EJey0w8sszukaitWHG2B4
         QKokRWS6T2IPfWMxQiswDg6yVZetgVBB0jJLLoN+YzEtKRjFmk6XZQb70MDvU+bTNpsD
         q4PQpUX8fmILIvvnaL5QN0VBfOsqijt7G55PE1JNOW7u76z28QKw1uLCVEUP92sdBxIZ
         6EHvz5U369GcXai+2CZfM/9uBxUKrtihKYQRxwxi7m+VZVfZpnSyF8Kefbn9YNdgALR5
         66g/HzejGeAstlPkXME0DVPeyHDWHaVdpp4+c1anpkF6aV1XKOy95fLwz0elSsQ1tj5H
         eJIQ==
X-Gm-Message-State: ABuFfogKqVMrEr6roE6txfS0SVe8jE3Q17Jogh9H/IEEsTUPrm8qAmvk
        Z+RXpKojzUUph4gOCnrucGJr/Yr4MazIraT3iIo=
X-Google-Smtp-Source: ACcGV60FHkthoD1/xyJJDzGkX+kAf83QmfuwLMGujVi2OKG+jlgt8/Cm+gzzqe/ayNHWjE+KLauqJC90gyY7m7ZcYFg=
X-Received: by 2002:a9d:614a:: with SMTP id c10mr7919361otk.278.1538992757379;
 Mon, 08 Oct 2018 02:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com> <CADYwmhHdTuK-z4GcGCYypYo2dvvPj7udihPcMmTkHTSU2fOWWw@mail.gmail.com>
In-Reply-To: <CADYwmhHdTuK-z4GcGCYypYo2dvvPj7udihPcMmTkHTSU2fOWWw@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Mon, 8 Oct 2018 15:29:05 +0530
Message-ID: <CAKTKpr7nq7jfXzHmTd-EX6b3MDefa6B5i--Zn=yUZV7MqS2ywA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
To:     pranith.foss@gmail.com
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pranith,

On Sat, Jul 7, 2018 at 11:22 AM Pranith Kumar <pranith.foss@gmail.com> wrote:
>
> Hi Ganapatrao,
>
>
> On Wed, Jun 20, 2018 at 11:33 PM, Ganapatrao Kulkarni
> <ganapatrao.kulkarni@cavium.com> wrote:
>
> > +
> > +enum thunderx2_uncore_l3_events {
> > +       L3_EVENT_NONE,
> > +       L3_EVENT_NBU_CANCEL,
> > +       L3_EVENT_DIB_RETRY,
> > +       L3_EVENT_DOB_RETRY,
> > +       L3_EVENT_DIB_CREDIT_RETRY,
> > +       L3_EVENT_DOB_CREDIT_RETRY,
> > +       L3_EVENT_FORCE_RETRY,
> > +       L3_EVENT_IDX_CONFLICT_RETRY,
> > +       L3_EVENT_EVICT_CONFLICT_RETRY,
> > +       L3_EVENT_BANK_CONFLICT_RETRY,
> > +       L3_EVENT_FILL_ENTRY_RETRY,
> > +       L3_EVENT_EVICT_NOT_READY_RETRY,
> > +       L3_EVENT_L3_RETRY,
> > +       L3_EVENT_READ_REQ,
> > +       L3_EVENT_WRITE_BACK_REQ,
> > +       L3_EVENT_INVALIDATE_NWRITE_REQ,
> > +       L3_EVENT_INV_REQ,
> > +       L3_EVENT_SELF_REQ,
> > +       L3_EVENT_REQ,
> > +       L3_EVENT_EVICT_REQ,
> > +       L3_EVENT_INVALIDATE_NWRITE_HIT,
> > +       L3_EVENT_INVALIDATE_HIT,
> > +       L3_EVENT_SELF_HIT,
> > +       L3_EVENT_READ_HIT,
> > +       L3_EVENT_MAX,
> > +};
> > +
> > +enum thunderx2_uncore_dmc_events {
> > +       DMC_EVENT_NONE,
> > +       DMC_EVENT_COUNT_CYCLES,
> > +       DMC_EVENT_RES2,
> > +       DMC_EVENT_RES3,
> > +       DMC_EVENT_RES4,
> > +       DMC_EVENT_RES5,
> > +       DMC_EVENT_RES6,
> > +       DMC_EVENT_RES7,
> > +       DMC_EVENT_RES8,
> > +       DMC_EVENT_READ_64B_TXNS,
> > +       DMC_EVENT_READ_BELOW_64B_TXNS,
> > +       DMC_EVENT_WRITE_TXNS,
> > +       DMC_EVENT_TXN_CYCLES,
> > +       DMC_EVENT_DATA_TRANSFERS,
> > +       DMC_EVENT_CANCELLED_READ_TXNS,
> > +       DMC_EVENT_CONSUMED_READ_TXNS,
> > +       DMC_EVENT_MAX,
> > +};
>
> Can you please provide a link to where these counters are documented?
> It is not clear what each counter does especially for the L3C events.

I will add brief description of each event in Documentation.
>
> Also, what counter do you need to use to get L3 hit/miss ratio? I
> think this is the most useful counter related to L3.

L3C cache Hit Ratio = (L3_READ_HIT + L3_INV_N_WRITE_HIT +
L3_INVALIDATE_HIT) / (L3_READ_REQ + L3_INV_N_WRITE_REQ +
L3_INVALIDATE_REQ)

>
> Thanks,
> --
> Pranith

thanks
Ganapat
