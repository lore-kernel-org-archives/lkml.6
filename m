Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B62CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4174A20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bkl8mM6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4174A20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeFTFvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:51:37 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35643 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTFvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:51:35 -0400
Received: by mail-io0-f195.google.com with SMTP id u4-v6so2413916iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2q31LQ0dXw1oDNrgsM377yNHfxu+Y8A/PAxY5nTVAc=;
        b=bkl8mM6MqV7uUlsMG8qRh0PTQM4wqEi0fcV4Hg7NgNWIAX2t/tHyyee+Ao7APisUiE
         MhCbJTPx5M0eM7SmJ0R1lJDmG0jAsfwnmqCwEQDmXGHsTEIc0UrB4yUko4p+/ZSdeR3R
         yzCw2DXG7aLFvVsf4sjnUnjBjuVk0DVtLEEgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2q31LQ0dXw1oDNrgsM377yNHfxu+Y8A/PAxY5nTVAc=;
        b=dIBkgGAOWkwANRnl5SM7jHcGf3elIPEiAanEFSFP2rLPEoznFWWOle3En4omKGdVZU
         NnQaC4acTxSwWOehiKB7WJvwnUnJDYCUQDq7kkpkdkdGxL7E841E+0T5M5qCMb5bx0G7
         GrDdhN1wEMCi2dJFAxEEtFBfiEQ39KzTtoOc66DyGvQw9rzG1hYo/4Env4t/hz56/7AH
         byOu2TVKkPjPzEvjFeIX2BV8/6xfuig6XCPxNQjSOPUTUfIg6GzHUK62odujcNPgePHa
         7AB13MhMUPdSkeyxCDYBqmp+tBeAFStJQBg4p/5n1FkoCt9d/IbinpWyyg120V/Oc1Gl
         ZStA==
X-Gm-Message-State: APt69E2DsxwmWHuX9rR0o9C04/HgicF+O6fKwUKfhI2rqf2U0AuIaMwv
        EcjJqAxnS385D9nFvSV1JV0hHDYAyFF0EkV0HFM=
X-Google-Smtp-Source: ADUXVKJonjl6k9yGJYzz02IpZM2diWpiqdUE7S/LqLjqXux12G9ZpVGHUnqe2LDhIKK0EKdkzdf945baSbuyzisa4WM=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr16903745iov.203.1529473894259;
 Tue, 19 Jun 2018 22:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180619092254.kmww3fpqjqcsjrna@unicorn.suse.cz>
 <20180619162411.B2B7AA1081@unicorn.suse.cz> <CA+55aFwa-mxOFKGiLmbxyJ+LyEjOG07fuYOmcWaYf-SJntneuw@mail.gmail.com>
 <20180620050824.hwijqfhzuu3ip4wo@unicorn.suse.cz>
In-Reply-To: <20180620050824.hwijqfhzuu3ip4wo@unicorn.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 14:51:23 +0900
Message-ID: <CA+55aFwnXSmB_Xn+-wC1fhnAVSa5KQABah-d2_zt3iNL0Cpwvw@mail.gmail.com>
Subject: Re: [PATCH] proc: add missing '\0' back to /proc/$pid/cmdline
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 2:08 PM Michal Kubecek <mkubecek@suse.cz> wrote:
>
>
> > @@ -254,10 +258,19 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
> >       while (count) {
> >               int got;
> >               size_t size = min_t(size_t, PAGE_SIZE, count);
>
> We limit size to be at most PAGE_SIZE here.
>
> > +             long offset;
> >
> > -             got = access_remote_vm(mm, pos, page, size, FOLL_ANON);
> > -             if (got <= 0)
> > +             /*
> > +              * Are we already starting past the official end?
> > +              * We always include the last byte that is *supposed*
> > +              * to be NUL
> > +              */
> > +             offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;
> > +
> > +             got = access_remote_vm(mm, pos - offset, page, size + offset, FOLL_ANON);
>
> But here we read (size + offset) bytes which may be more than PAGE_SIZE.

Actually, no. We limit size not just to PAGE_SIZE, but to count as well.

And there's *another* limit on 'count' that you missed, namely this part:

        /* .. and limit it to a maximum of one page of slop */
        if (env_end >= arg_end + PAGE_SIZE)
                env_end = arg_end + PAGE_SIZE - 1;

coupled with

        /* .. and we never go past env_end */
        if (env_end - pos < count)
                count = env_end - pos;

so we know that "pos + size" can never be larger than "arg_end + PAGE_SIZE - 1"

And then:

                offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;

means that "offset" will be bigger than zero only if "pos > arg_end-1".

So let's ignore all other cases, and just say that we care about that
case where 'offset' can be non-zero.

So we have

   offset = pos - arg_end +1

(from the above initialization of offset), but we also know that

   pos + count <= end_end

and since we've limited end_end to "arg_end + PAGE_SIZE -1" we have

   pos + count <= arg_end + PAGE_SIZE -1

agreed?

Now, we can do some math on the above. Re-write that "offset = .." equation as

   pos = arg_end + offset - 1

And the same time we can  take that "pos + count" inequality, and
replacing "pos", we get

   arg_end + offset - 1 + count <= arg_end + PAGE_SIZE -1

and then we can remove "arg_end - 1" from both sides, and get

   offset+count <= PAGE_SIZE

agreed?

              Linus
