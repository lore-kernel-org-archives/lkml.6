Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11305C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DDB219CD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xg1Eh17F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DDB219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeHRBkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:40:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37060 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeHRBkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:40:39 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so13677502itf.2;
        Fri, 17 Aug 2018 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qPzMIeAgzEFT+T1M7SMlgwVZ/3OdfNj30fh2ygut8w=;
        b=Xg1Eh17FYS3LrtWw7pU38c25f+/JcBx5w/7TzE32lMZs/+0w4/GTxNrtvnLvURI7HS
         gK5nUxmvSIXfD94bbuxHgCkimG78c2Xrn72SRLKurBqpQyeS48miaLbKKn2BpWmuwJFf
         A0PwrVfKGobF/4Tu+XxH4/nsAIJtuT3cdPrKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qPzMIeAgzEFT+T1M7SMlgwVZ/3OdfNj30fh2ygut8w=;
        b=G2hjoDynbK8TIfNIXZ4j7zhH3dg7/JJUtkmVI41S868PXIASXDAcEgnZFmMN8huNKh
         nd8+ogDF2C6Pg9fLlPJibEKxSPzvlDuIq4p/ftAIjOBU4AADeXymTQRyl5Xbuwz4+UYe
         6urWxhbnCRNxhvy/mP02jceFqX6tDVekzN0ZPSQieXRXgCHwQGzHipEI06ow3dvIfZv5
         3wdOptmdoaPbYau5AljHNJf9xZI/RqacCaMh1FPAfCCt2LDufCOCLWtg6vGQKLxKxn02
         DDD7s7Q6kMCny4j6JMliGof4L6jd/8O6iHyIikZusbDbTl5hWy0aIYblsEwnVtEeANHP
         oxTw==
X-Gm-Message-State: AOUpUlF6q9wGGRZgBSzyLJrHve711BS8GXsG9oMatMdgPPDEVWWTPLRZ
        fwy/8HtYi9OKE829I0tY2eP2DY74wMkLmKE63fjdrhcY
X-Google-Smtp-Source: AA+uWPye8nxc/zBNQHSAk5vdB05uGlW8HIlzdukdFUSOfYlOic9AetGdSqROKqVIJSuDTt18PJlduZ0fJeSbQusw2Kk=
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr26194029itb.123.1534545327036;
 Fri, 17 Aug 2018 15:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180813012347.GA32555@nautica> <20180817023307.GA32726@nautica>
 <CA+55aFzLe7C03-53=0WrXXfZcfsJfTsvRqrrBNqnLvOxUiCJqQ@mail.gmail.com> <20180817213648.GA31406@nautica>
In-Reply-To: <20180817213648.GA31406@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 15:35:15 -0700
Message-ID: <CA+55aFx58-vbKca_KGdhOA3cJ_M7HP=wOsJ483os=CCobi2zOA@mail.gmail.com>
Subject: Re: [GIT PULL] 9p updates for 4.19
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 2:37 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> I thought the the same thing (that you never saw the first version) when
> I wrote the request-pull email and adjusted the text -- I wasn't aware
> the tag should have the same text as the mail but will pay attention to
> that in the future, it does make sense.

The tag doesn't have to have the same text, it's just that when you
send it to me, and I get a message saying "this is the second
version", and I haven't seen a first one, that makes me go "Hmm."

> > And it comes from a github address, with a pgp key that I've not seen
> > before, and without me having been told about said maintainership
> > updates. And while the  key has a lot of signatures, none of them are
> > any that I have recognized previously from kernel development.
>
> I agree on this point, and will have a different key with at least some
> kernel developers signatures for 4.20

I don't reall yneed to absolutely have some signature chain for the
keys - but I do want to know that it's not some maintainership fight
brewing, and I'd *really* like to see explicit acknowledgement from
people about this all.

The pgp signature is useful even without the chain of other people
signing it, since it's still going to mean (going forward) that the
same person who controls the key is sending me pull requests. So it's
worth it even without the absolute chain.

But the first time I pull is special. For me, the MAINTAINERS file
currently still says

  [torvalds@i7 linux]$ ./scripts/get_maintainer.pl fs/9p/
  Eric Van Hensbergen <ericvh@gmail.com> (maintainer:9P FILE SYSTEM)
  Ron Minnich <rminnich@sandia.gov> (maintainer:9P FILE SYSTEM)
  Latchesar Ionkov <lucho@ionkov.net> (maintainer:9P FILE SYSTEM)
  v9fs-developer@lists.sourceforge.net (open list:9P FILE SYSTEM)
  linux-kernel@vger.kernel.org (open list)

and I realize that in practice it's been not very maintained and most
of the patches have just been going through Andrew (actually, _most_
patches haven't really been about 9p at all, but have been about
updating 9p for non-9p work).

So I would basically want to see Andrew and/or others be on record of
saying "yup, this looks good, go ahead and pull from Dominique".

Then, next time you send me a pull request, it will be "all systems
normal", and I won't care about who has signed your key, I'll care a
lot more about "it's the same key as the last time, or at least the
new key is signed by the old key I already recognize for 9p".

That's the main issue for me.

           Linus
