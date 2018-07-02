Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48323C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E422480C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VsLDbo6r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcGRxuOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E422480C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeGBS1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:27:04 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33420 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeGBS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:27:02 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so5449164ybb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gbEC9ndd5VZZCAqZ+EXgUCjm6sRvtGqwh4YpyGEquao=;
        b=VsLDbo6rN3gNyUs6zCUoFbhhhnQHfL0d28lWGrX6ViVVnhbSfT5qMRJYf7oWT11Nik
         ifPA0kehuZ/+JOwvvFDHeGt7GVpf6ET/y8SoTfVLqSssR2VGh/xt97o/LC/yo1mg/3MJ
         HipRBNTYHPoj+Ys2dE1t71FdnZJCi+VD1qnnYkZJv9xeE3M4xYj6wtA1vCOGDYUf/MQD
         elP8Z3ch1qmvPPuWhHhKjcaIrAetE2B26sXaNpvozHfjPNELfSpDGOhncbV89gyhMBFz
         Lb+pzkAsVqGcA3RmFSN0C3U8UiQuVrrxJlHg0RJ8y+pYxsniRtKctSRrqVneNrYQj5br
         6TUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gbEC9ndd5VZZCAqZ+EXgUCjm6sRvtGqwh4YpyGEquao=;
        b=gcGRxuOWRH06IzFPGoF06Sc1bzxH5g3AltQj1Zgl647xy9suXsG+tMRxxYFzXJpzUH
         30bzeIgKHnhOREyPZ0EbK66z8WGxvvJK1rqHjILCF/enQKfqsPRiIWCq6LdxX/oRsrHg
         KTj2AtdBORhTnRcBdy3U/3VF9UffsiXZQi1eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gbEC9ndd5VZZCAqZ+EXgUCjm6sRvtGqwh4YpyGEquao=;
        b=bljQTgBTne+KgLhNXrL+aJSq4KLrb3E7KgIA2JCAlFwu7KCuiYAfcczHezorL2uwBb
         xEi6MYpLWBdnl2s3Pt0o6zIdsW1WGtNXLcUBg0BFh8+xefAPZN6oSdYFLFLTaiGl5HQ0
         HNbozW42rJYcjBYMb/MseTwv2OutvudbQZkC23AGR/s8dlE5oz4TDWSMLk5QrWNltA1O
         2WwaQ5VF6VBvSkQdq5NBqidwnrDtSoqeiNPJzx5YlxRufp+Ken+QBE3QZwpABMJaABms
         H4mHexvalawcHLb/sOY+i4/HsCNl9EpbQQGD5v1GaHUTqWDBbD3kr+Ra4cIRtDCUdp+I
         AVfQ==
X-Gm-Message-State: APt69E2s55ghIj32N9RgJH4v1ovbCvVbV40PltUwI+xrAlnkiNlOzznq
        p58/S5RC8XdVhgw1yXYFfiVGTM+1eLo3b+vnchjjlZSJ
X-Google-Smtp-Source: AAOMgpdYAtD/LAhLcjqgl3v6JGzsuyBBsdr88a+itZH41nl6QySippPepXeyFYghuzEqNqehGpZc3ZavDWRxg2Rc00U=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr3139415ybe.118.1530556021515;
 Mon, 02 Jul 2018 11:27:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 11:27:00 -0700 (PDT)
In-Reply-To: <2073665.T6vW7v0NJO@blindfold>
References: <20180701212051.29486-1-richard@nod.at> <CAGXu5jJyeoKdqo86+tWoq1n34sELSAXQu8LSBpEbiu2oFg2JPQ@mail.gmail.com>
 <2073665.T6vW7v0NJO@blindfold>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 11:27:00 -0700
X-Google-Sender-Auth: QpK-yJnsuxKv8NzBptFykQwLr6E
Message-ID: <CAGXu5jJabYkC06ZGa1X2HweY8idyDR8a2y805btY5jKMHKbSuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "UBIFS: Fix potential integer overflow in allocation"
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:50 AM, Richard Weinberger <richard@nod.at> wrote:
> Am Montag, 2. Juli 2018, 18:00:05 CEST schrieb Kees Cook:
>> On Sun, Jul 1, 2018 at 2:20 PM, Richard Weinberger <richard@nod.at> wrote:
>> > This reverts commit 353748a359f1821ee934afc579cf04572406b420.
>> > It bypassed the linux-mtd review process and fixes the issue not as it
>> > should.
>>
>> Ah, sorry, I thought you were CCed on the original report.
>
> No big deal. I was just "surprised".

Yeah, totally my mistake. There were other overflow patches that went
out pubically and I thought this one had too.

>> > Cc: Kees Cook <keescook@chromium.org>
>> > Cc: Silvio Cesare <silvio.cesare@gmail.com>
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Richard Weinberger <richard@nod.at>
>> > ---
>> >  fs/ubifs/journal.c | 5 ++---
>> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
>> > index 07b4956e0425..da8afdfccaa6 100644
>> > --- a/fs/ubifs/journal.c
>> > +++ b/fs/ubifs/journal.c
>> > @@ -1282,11 +1282,10 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
>> >                               int *new_len)
>> >  {
>> >         void *buf;
>> > -       int err, compr_type;
>> > -       u32 dlen, out_len, old_dlen;
>> > +       int err, dlen, compr_type, out_len, old_dlen;
>>
>> What's wrong with making these unsigned?
>
> Well, what is the benefit?
> In ubifs a data node carries at most 4k of bytes.
> WORST_COMPR_FACTOR is 2.
> So the computed lengths are always in a range where a natural int does work just fine.

Just a robustness preference: it keeps it from going negative. But I
don't feel strongly. :)

>> >         out_len = le32_to_cpu(dn->size);
>> > -       buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
>> > +       buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
>> >         if (!buf)
>> >                 return -ENOMEM;
>>
>> Please leave the kmalloc() -> kmalloc_array() change, as that has
>> happened treewide already. We don't want to have any multiplications
>> in the size argument for the allocators (i.e. they should use 2-factor
>> arg version like here, or use array_size() for things like vmalloc()).
>
> Let's queue another patch for the next merge window which converts
> kmalloc() -> kmalloc_array().

I'd prefer to leave it as-is for 4.18 because it would be the only
unconverted kmalloc()-with-multiplication in the entire tree. We did
treewide conversions and a revert would be undoing that here. (The
scripts that check for this case would run "clean" for 4.18.)

So, this gets back to the question of the int vs u32: if you just
didn't revert this patch, then the kmalloc_array() would stand too.
Easy! :)

-Kees

-- 
Kees Cook
Pixel Security
