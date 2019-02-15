Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25007C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E952192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYv2egmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405710AbfBOOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:10:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41085 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405514AbfBOOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:10:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so290612otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLclIBA0RkBX+hGfBPm/UE/fXMOsoU2vzH+YE7DcR2I=;
        b=vYv2egmLZEhZb+6YAarGiVeLXFJ+snmapF6T6/BGHi/gtBAFHtEx5h7mwNJvdVvSFe
         R3HALhQCHr4Vwnqlb92dyNUhzm1L4QpfVqDEilzZCPlq0W9itaYSSFxq6t+Qw8ivmU82
         fSmJ+V4itJd+exHzB1dxovKxxoew1Q8Q6zq7erNx+ZsheFBYohITFwIl9dA0NJyII3xA
         sjKsMYSReZHZA/TL09oHbc2DRzC83mz6CNA70GBVVs4/23zKEFQ2ZZibzwIG7xOZ+5V1
         WU0J85ocXOHwKRaIQe6N2ktIStFP1JS8fp2CqFDF2Ob8GRzOBwa4G1NgglxRhmBeLFWV
         H/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLclIBA0RkBX+hGfBPm/UE/fXMOsoU2vzH+YE7DcR2I=;
        b=Mu38jKP2tepvguLxAIAfubhu1eTHFGShKPA9mMWghBGuD/v6xudqx7A78+Pzhgmz13
         PsVvofx93DJ2IP+ZqLG/mrLHugQS0UsHN6jdMBN014H1sLJ/sVukfa9/WlHE/dM5kiFH
         UR3KBGfMwOfE1MIVdvkBTlwmRgb4JfzzFFuThWK5qc11Q9qfdOA8ic/qB6pVz3xfmTmh
         g21qJnEKG4863aSHcl9Y/cAqx/InqXRRuVF5EUj9gL/QFwYkVox4lgpHv4aRZhphtHRa
         thvcPl8+wqM/ErgBr3WemTUoA7p7pJKulHb4WmFLFqdC2DlybOIBbkUBXANNxf4be9h3
         yzDA==
X-Gm-Message-State: AHQUAuYh40VIrhfmJh4mv178FI1pobto20Tmlr41loGWuGFfEN4DUOou
        hwstPbZ2c+yMcpeBhhiAOpOEWg4zynYfMhE+pjdsHg==
X-Google-Smtp-Source: AHgI3IZI5i8+95zakDTxm8TzBkeD2gXSCxni03rr9qOn6Vdy1LTesPvYG3Sp8UcP64ZAhl2i330YdY1yUK2OW61wBTU=
X-Received: by 2002:aca:a847:: with SMTP id r68mr6001138oie.175.1550239844739;
 Fri, 15 Feb 2019 06:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20190213214559.125666-1-jannh@google.com> <20190214.091328.1687361207100252890.davem@davemloft.net>
 <CAG48ez3p9kyyON4qDybveNhCNdTPfsvi3hUp7rDQUk-f43xMsQ@mail.gmail.com> <20190214.142100.1155290437338631379.davem@davemloft.net>
In-Reply-To: <20190214.142100.1155290437338631379.davem@davemloft.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Feb 2019 15:10:18 +0100
Message-ID: <CAG48ez0bFsKPBubARtjs+NQmRiUAbPEGbNjXPJaceuDa9Dd7OA@mail.gmail.com>
Subject: Re: [RESEND PATCH net] mm: page_alloc: fix ref bias in
 page_frag_alloc() for 1-byte allocs
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:21 PM David Miller <davem@davemloft.net> wrote:
>
> From: Jann Horn <jannh@google.com>
> Date: Thu, 14 Feb 2019 22:26:22 +0100
>
> > On Thu, Feb 14, 2019 at 6:13 PM David Miller <davem@davemloft.net> wrote:
> >>
> >> From: Jann Horn <jannh@google.com>
> >> Date: Wed, 13 Feb 2019 22:45:59 +0100
> >>
> >> > The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> >> > number of references that we might need to create in the fastpath later,
> >> > the bump-allocation fastpath only has to modify the non-atomic bias value
> >> > that tracks the number of extra references we hold instead of the atomic
> >> > refcount. The maximum number of allocations we can serve (under the
> >> > assumption that no allocation is made with size 0) is nc->size, so that's
> >> > the bias used.
> >> >
> >> > However, even when all memory in the allocation has been given away, a
> >> > reference to the page is still held; and in the `offset < 0` slowpath, the
> >> > page may be reused if everyone else has dropped their references.
> >> > This means that the necessary number of references is actually
> >> > `nc->size+1`.
> >> >
> >> > Luckily, from a quick grep, it looks like the only path that can call
> >> > page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> >> > requires CAP_NET_ADMIN in the init namespace and is only intended to be
> >> > used for kernel testing and fuzzing.
> >> >
> >> > To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> >> > `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> >> > writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> >> > with a vector consisting of 15 elements containing 1 byte each.
> >> >
> >> > Signed-off-by: Jann Horn <jannh@google.com>
> >>
> >> Applied and queued up for -stable.
> >
> > I had sent a v2 at Alexander Duyck's request an hour before you
> > applied the patch (with a minor difference that, in Alexander's
> > opinion, might be slightly more efficient). I guess the net tree
> > doesn't work like the mm tree, where patches can get removed and
> > replaced with newer versions? So if Alexander wants that change
> > (s/size/PAGE_FRAG_CACHE_MAX_SIZE/ in the refcount), someone has to
> > send that as a separate patch?
>
> Yes, please send a follow-up.  Sorry about that.

@Alexander Do you want to do that? It was your idea and I don't think
I can reasonably judge the usefulness of the change.
