Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66554C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECE1217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMH/oJN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfAYX6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:58:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37024 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYX6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:58:48 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so12158430iti.2;
        Fri, 25 Jan 2019 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImNYreKqjVLM4GCqjmMQdpMN5LcD/RYcu5KlQGlCsKw=;
        b=GMH/oJN5OSITLf4PlYxXLJm6aoWFPBcfSIQkvWYVmxOs/oOxxmvCVvcxNh7ob8eJlr
         OtW07in7lwsiCL9NG2cnj5muse9Uwp2qKO1a5A/yEelgOTjrqe9JeRXcWQvq5rXEm3p8
         Z7NFCVNEOjOieI6HQZyCblm6+/LmNUxFXpr/K58DrGxm+qv6+32nHjmiqgo1hXgRCdSM
         ab5zRJ0AjYfwoJDUTBBqKUd06QFM88VpwNWK33DvAcu40lqAIW91S5TbbHKFCfZtULQa
         LKoQQHWKpFZtPW/oG2KI8BA7QVmJJWyOKU3OG7Md13jZRmTEsjips2eMwoaE/6iwDqeN
         sEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImNYreKqjVLM4GCqjmMQdpMN5LcD/RYcu5KlQGlCsKw=;
        b=LmXN0EMXca/zj5kbW9MnkA/rAgAvPb/HOLMShbUAtcVBU8ktt7ZtRVXcerUh7HbDck
         vBqdGTJm9NXKSgoYyLv85B3p4M9jYJRz2Ou4otymoJjnkbqm/jQnVp63iqYJk5qLUXNx
         5p8FtfvDwObLJZ5uFwMjbYMEGsjsBxBLGfNgmCoj/8LLg4AuiLy+p0sLlo53fwRi4Y2w
         tRDMFs/LD6UYq/8cn5hW6o2OdpkyzWqyYOaAIkmbfEY6QFoEcjlIdpHuJNdDXkiUr73u
         e9HIlyhc+Z9mc5Oy8+uWvH4DZqF7g2z+LqvqoRXyRjqM6GUynK1phhNm+PSHeGyYYyvg
         8Yxg==
X-Gm-Message-State: AJcUukeHoqbvY2s8tqrQ9ciH/1ejr3ZVPxgXJChnonXlWpepekpkCuQ1
        jO4Erl/mejMi0a9p30o8+xepT1BIcJHo6loEwgo=
X-Google-Smtp-Source: ALg8bN7LUDWuEjyHRtLB3YAJnFIV7UWorTvilrX9o/yjSPzwj721ecaCgTj0qSCWr5K09MDRIKmFL7RJUjg5QcssSDo=
X-Received: by 2002:a24:d1c4:: with SMTP id w187mr5382960itg.141.1548460727592;
 Fri, 25 Jan 2019 15:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20190124220954.2147f1da@canb.auug.org.au> <CAKdAkRRBVDd80e4zjmwqqMH-dt4-1paVdrriu2Fn=-Zv+7qgrg@mail.gmail.com>
In-Reply-To: <CAKdAkRRBVDd80e4zjmwqqMH-dt4-1paVdrriu2Fn=-Zv+7qgrg@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 25 Jan 2019 15:58:36 -0800
Message-ID: <CAKdAkRTzN+Zg-9LSdx2uSAV6_u8ytQZCVxJyRaKhKSNf+3teRA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the input-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 3:56 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Stephen,
>
> On Thu, Jan 24, 2019 at 3:09 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Dmitry,
> >
> > In commit
> >
> >   ec87da107d11 ("Input: olpc_apsp - assign priv->dev earlier")
> >
> > Fixes tag
> >
> >   Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open(), not probe()")
> >
> > has these problem(s):
> >
> >   - No SHA1 recognised
> >
> > The "commit" at the start of the tag value was unexpected.
>
> Hmm, this is really weird:
>
> dtor@dtor-ws:~/kernel/master (for-linus)$ git log --oneline --
> drivers/input/serio/olpc_apsp.c
> ec87da107d11 Input: olpc_apsp - assign priv->dev earlier
> 2a58dd767bf9 Input: olpc_apsp - remove set but not used variable 'np'
> ed22cee91a88 Input: olpc_apsp - enable the SP clock
> af518342effd Input: olpc_apsp - check FIFO status on open(), not probe()
>
> As you can see there is that SHA1 in question present in my for-linus branch.

Argh, I see what you mean, the word "commit" should be omitted. Oh
well, it's in the branch that I loath to rebase, so it will have to
stay as is.

-- 
Dmitry
