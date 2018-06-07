Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 45IEL5BsGVuNTAAAmS7hNA
	; Thu, 07 Jun 2018 17:34:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 42C4A6089E; Thu,  7 Jun 2018 17:34:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vayt2k48"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B838C6063F;
	Thu,  7 Jun 2018 17:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B838C6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934328AbeFGRe5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:34:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43348 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933021AbeFGRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:34:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so10673632wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRDXR3/xr8ArrjhF9/uiOCf2az0ATHcm6kczPGcdUGA=;
        b=Vayt2k48hBHGL48NfP/AOlllX1B1FyfML/m2ova7WaSjBFgOzhPdOUJPLMZMXGPKJs
         g7Cvb3toDdJhoJIbgmnshqNt+SAtr9SMLudTv0h7C0J8z3ENfON/4PRanSPaCxlhQ0+i
         5lyORb8Lobp7YFUgvlCV8DkjM7L0/RFoP7yHP5PMCSTIMChtDGe949wKAqE0rlJ5XHO3
         LuvHB+8F7tR2kwwXh79LBqUBNLQFbpOOGzFDQuZ9/FcyW36hxaSOOGSQz84whUDEZCPe
         EV0HBl2x/nzwVjykdmQKS+lIJyrvQ9c7asHvwuUR0va3odqpDRV3fAYcAvqqFtY15A8q
         XArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRDXR3/xr8ArrjhF9/uiOCf2az0ATHcm6kczPGcdUGA=;
        b=U5++NoiLHh5RYX2BgI7FUYV+vspsaiKeQacZg6XEvqkZepAOiBetEioMIWroiSqYXj
         waP3UhvK7Hrtxn6OQyxyep6XbzP1Z5spWEwAmpAep0JVxRlNv9ud2y9jpvI5AEUGXfeP
         mCCcpN1reIv2+JzOjFeLAjOJEgNW4i+luGP8diiZ833oJWFHuiaL3/cz7rdYzL1a7XW9
         LFz9qWor8nT80l9d6BmxnRaItC0eVwlN00w7VF4DAqq3FtQpdn+m2HXyfUQ7xRsec0bU
         zENqJ3eD8k66L5g0pG4RkGFswgWTylJfDZuoVWiSSVSj0KoBYGBtucXlfyiv7TX7Y7oC
         LAcQ==
X-Gm-Message-State: APt69E3KK6xT7QtIm6ELfkaJ6EZT7DlVC1cJJHf0JsSwdxXPVtMTaA/+
        KIVDW2sZBDwOa+Vtl2UvnhVlQ59QiD1/4W2BwmXh2w==
X-Google-Smtp-Source: ADUXVKKjLoOcC3OjudfxP+7qzjXrfMbomSk7SPtf0zX5aorxgOBp0RZ8DyCZ/0g6uM8o8m1z8hYyQGMHGhxfn33Onak=
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr2626000wrm.2.1528392893664;
 Thu, 07 Jun 2018 10:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180607145720.22590-1-willy@infradead.org> <20180607145720.22590-7-willy@infradead.org>
 <03d9addb-9c68-c6e5-d7db-57468fc3950c@nvidia.com>
In-Reply-To: <03d9addb-9c68-c6e5-d7db-57468fc3950c@nvidia.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 7 Jun 2018 10:34:41 -0700
Message-ID: <CALvZod6SCZ8mqW4RDkBA0xYqBkF=qbzMDtUaP7q0SBHTbGxmOg@mail.gmail.com>
Subject: Re: [PATCH 6/6] Convert intel uncore to struct_size
To: rcampbell@nvidia.com
Cc: Matthew Wilcox <willy@infradead.org>, keescook@chromium.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 10:30 AM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
>
>
> On 06/07/2018 07:57 AM, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> >
> > Need to do a bit of rearranging to make this work.
> >
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > ---
> >   arch/x86/events/intel/uncore.c | 19 ++++++++++---------
> >   1 file changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> > index 15b07379e72d..e15cfad4f89b 100644
> > --- a/arch/x86/events/intel/uncore.c
> > +++ b/arch/x86/events/intel/uncore.c
> > @@ -865,8 +865,6 @@ static void uncore_types_exit(struct intel_uncore_type **types)
> >   static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
> >   {
> >       struct intel_uncore_pmu *pmus;
> > -     struct attribute_group *attr_group;
> > -     struct attribute **attrs;
> >       size_t size;
> >       int i, j;
> >
> > @@ -891,21 +889,24 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
> >                               0, type->num_counters, 0, 0);
> >
> >       if (type->event_descs) {
> > +             struct {
> > +                     struct attribute_group group;
> > +                     struct attribute *attrs[];
> > +             } *attr_group;
> >               for (i = 0; type->event_descs[i].attr.attr.name; i++);
>
> What does this for loop do?
> Looks like nothing given the semicolon at the end.
>

Finding the first index 'i' where type->event_descs[i].attr.attr.name
is NULL with the assumption that one such entry definitely exists.
