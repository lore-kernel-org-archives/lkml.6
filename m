Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE91C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492762152F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axlJUdmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492762152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389381AbeHGULu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:11:50 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39287 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGULu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:11:50 -0400
Received: by mail-io0-f196.google.com with SMTP id o22-v6so14737498ioh.6;
        Tue, 07 Aug 2018 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/dDB7ahvUP/j0SzFLNqoNVYWMMJTlZlo7fsH5DdliHY=;
        b=axlJUdmcgeQsPFI51bFgb8uGMSQogD40xa/JYGWoE+5/L6eY10tRNc6aiaZsKFa6bq
         hg9aohrxo/1EBws7FQxpc3ZZz5hB/8EKFvI2XU0qrn94gsGDwUl5d7o+eNtjwVX84F/J
         Wq4tAhCJxNXNB1EzBts4hKw7BPDoTipoRYOfX5AymwFP0hSCbuoUHhIfQEdk/4medVBf
         WDYKXANDOIy6MRc5nEaPaGt2mh2mkj4edULM18ke94rmRcXD/Ebc6bXG7fnLuEYCm9oQ
         KvsAEkwYaDJd6v+wxZrT+A5e/5xvHTCvK0k6neITyzBKm08Kq+O7r8jQJuyZhjw8S/OL
         D5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/dDB7ahvUP/j0SzFLNqoNVYWMMJTlZlo7fsH5DdliHY=;
        b=KTPrVtxwiIKhptlNj/MZuJiYinPMOug6GcTlVxdmCGll5ey/hikAJH7MpEs9d8ZXYP
         rQSr2mbglX7ROOTbsIcYJYVsXPNLUHvy92jN3IIiWU9V0akjYYvXcTbP4XA+h50QBwAt
         wD900CT6sX1NSgSQu32a00vugBxKQIu4HErifi1g0xRCYejPz+iSwUrq6bQLT5uxw2B2
         AVmQHsCLIATeRA5GpCEwgQ+Q3EkbtlmFq0Q+LKVV23dn+5UNFurke2gmx5qMSForOnje
         8+JRQ82JSRR2SAPF3s286gfsHCL8sY+bXYfR+ls0dmU6xP36M2a6wFkXkETyJLv3i5/n
         Tyrw==
X-Gm-Message-State: AOUpUlECsJok0/EwxAYtX9N9Cgl+NyHlQM8nGbGCBjR6xqfqopsaqqBm
        eWvmO1Aq8hLaPWK1FfpDxcoq5kivjUzdT00drE2UtQ==
X-Google-Smtp-Source: AAOMgpfer+lLGlxoORofiPIemVkqL/+AaeYFZ+Rxf1hgxbltkZKRPt85eUM5nHShYh8rIYp9Cbt7A0UuBOxizj7pBR0=
X-Received: by 2002:a6b:fc0c:: with SMTP id r12-v6mr20579931ioh.203.1533664581168;
 Tue, 07 Aug 2018 10:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:bc4a:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 10:56:00 -0700 (PDT)
In-Reply-To: <CA+55aFx1vbQWnQUVoieFgKrNECLKJs-RQi8z8cpe29g0aAiq3A@mail.gmail.com>
References: <20180805.004744.1043412275329854518.davem@davemloft.net> <CA+55aFx1vbQWnQUVoieFgKrNECLKJs-RQi8z8cpe29g0aAiq3A@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Tue, 7 Aug 2018 18:56:00 +0100
Message-ID: <CAJwJo6a7-p_WO4oUTC3bGMB_APZR2dEYV+TvgAcXeFjYgfLhqQ@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

2018-08-05 16:52 GMT+01:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Sun, Aug 5, 2018 at 12:47 AM David Miller <davem@davemloft.net> wrote:
>>
>> 4) Fix regression in netlink bind handling of multicast
>>    gruops, from Dmitry Safonov.
>
> This one is written kind of stupidly.
>
> The code went from the original
>
>         groups &= (1UL << nlk->ngroups) - 1;
>
> (which is incorrect for large values of nlk->ngroups) to the fixed
>
>         if (nlk->ngroups == 0)
>                 groups = 0;
>         else if (nlk->ngroups < 8*sizeof(groups))
>                 groups &= (1UL << nlk->ngroups) - 1;
>
> which isn't technically incorrect...
>
> But it is stupid.
>
> Why stupid? Because the test for 0 is pointless.

Heh, I've been stupid enough at that moment to think that
(1 << 0 == 1) and forgetting that I'm subtracting 1 for mask.

> Just doing
>
>         if (nlk->ngroups < 8*sizeof(groups))
>                 groups &= (1UL << nlk->ngroups) - 1;
>
> would have been fine and more understandable, since the "mask by shift
> count" already does the right thing for a ngroups value of 0. Now that
> test for zero makes me go "what's special about zero?". It turns out
> that the answer to that is "nothing".
>
> I certainly didn't care enough to fix it up, and maybe the compiler is
> even smart enough to remove the unnecessary test for zero, but it's
> kind of sad to see this kind of "people didn't think the code through"
> patch this late in the rc.

Yes, sorry.

> I'll be making an rc8 today anyway, but I did want to just point to it
> and say "hey guys, the code is unnecessarily stupid and overly
> complicated".
>
> The type of "groups" is kind of silly too.
>
> Yeah, "long unsigned int" isn't _technically_ wrong. But we normally
> call that type "unsigned long".
>
> And comparing against "8*sizeof(groups)" is misleading too, when the
> actual masking expression works and is correct in "unsigned long"
> because that's the type of the actual mask we're computing (due to the
> "1UL").
>
> So _regardless_ of the type of "groups" itself, the mask is actually
> correct in unsigned long. I personally think it would have been more
> legible as just
>
>         unsigned long groups;
>         ...
>         if (nlk->ngroups < BITS_PER_LONG)
>                 groups &= (1UL << nlk->ngroups) - 1;
>
> but by now I'm just nitpicking.

I'll prepare the cleanup for linux-next.

Sorry about the stupid code,
             Dmitry
