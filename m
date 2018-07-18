Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C19ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F3920854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LdJLlB5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F3920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeGRS6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:58:35 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:39318 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGRS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:58:35 -0400
Received: by mail-io0-f182.google.com with SMTP id o22-v6so3812687ioh.6;
        Wed, 18 Jul 2018 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EoiKQ7XGSxmYw+Ig8t7223KHD1tJG1+RFYUjMmJU6g=;
        b=LdJLlB5dyd12W0uIQQ75GHDE9ZyGSWxqbQtzaS+eEFj18AONku6CZ5zNGK3O/bZZg6
         Tuz4wYl5IeLLx9muSsFEGUF5bxGTPfXJxBKTw2zv2g0xI5rUn8ChPTbHCN93xFbSv/zH
         zZaKi9tbHCltPO177rz23iSMo3NU972aulLvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EoiKQ7XGSxmYw+Ig8t7223KHD1tJG1+RFYUjMmJU6g=;
        b=kN4S1mjGB0iE3RLrRHwaUCsXuDkTJUk9QfKRtQy1QZDSv8N3C2n4E8zEHIasbefdKU
         14tYkqj7Im0OeUEy0xAABZe6oTCLf4w6dnFitOoCMUYY2D6wjoB+V3EcXdlLhfcJ1ZeI
         Mj5RXu2TjsfmEgFJaz7vibBm0Q6X7/WvHHv/RzRyVVgHbXOekeoI7fIHdIDqsXjO5D81
         u+/NwLuqEShrhpypNIf/N+7Y712nh0VDGBr+ni2V+BIbz2WUjL6uVBPlAHILidUkyp3L
         uM6Eh4NAhFGTt3xIj6Pb2bv/bFQX3wmX2NYDnPOpVpMB15YxcMe0I6wXcjFVd7i7ZR9a
         4P7A==
X-Gm-Message-State: AOUpUlHZFgGQy0qg8pMHbDakUuXgU/Mb0/QQ40yBkeC9ffY01g+vGbDf
        tsxCuT2LJPCoBPvbU9iXI6ht6WLykG/73PBU9hc=
X-Google-Smtp-Source: AAOMgpc5oQDe3KXsWZQfqb3rS22AGc1bP8HuCyj1E39B4ynzWtr+jw2El0I7c4C4dblZPTnjaMdmHbKMsGJtktTHpSs=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr6213550ion.259.1531937969160;
 Wed, 18 Jul 2018 11:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180711161540.GS30522@ZenIV.linux.org.uk> <20180712124326.GA19272@ZenIV.linux.org.uk>
 <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk> <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au> <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk> <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk>
In-Reply-To: <20180718181252.GU30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jul 2018 11:19:18 -0700
Message-ID: <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
Subject: Re: [RFC] call_with_creds()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Linus, David - do you have any objections to the above?

I damn well do.

I explained earlier why it's wrong and fragile, and why it can just
cause the *reverse* security problem if you do it wrong. So now you
take a subtle bug, and make it even more subtle, and encourage people
to do this known-broken model of using creds at IO time.

No.

Some debugging option to just clear current->creds entirely and catch
mis-uses, sure. But saying "we have shit buggy garbage in random write
functions, so we'll just paper over it"? No.

                 Linus
