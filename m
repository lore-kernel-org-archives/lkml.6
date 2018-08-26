Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B9C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653AC208B9
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb0rmLb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653AC208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeH0Anf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:43:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45702 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeH0Ane (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:43:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so11733923wrb.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ob3t/jBzWODHBo2hlJ2B658om6+Tfa41Qcu36l+MtuY=;
        b=mb0rmLb3GlVjlXiQqax1tukgWkrlTFknOSxo76/U9xbwDi4M0PQrBv/+VAEQwTOg3H
         4LWZ1bJhZVHGMV8BfJ0XWXEL1A4a07WD33EulAtIJByc2wfNzuL0VqkiZBkx1mt3MiMB
         bDd2WtCB+HLg7BIxxutapfuDxbuq6iKNjYZvSnq72b8pobq7ru2TUxM8e/sDgQGlE14y
         ZASqSbv8R02DiuDooIn3aDp4qyWIP8BXveZcDhgF6qD2SU+Q/fUWmMlghcnI5Ect+5hl
         orBwA2FkmSfAIX8xWevU0Lbz/i0lqdUgZ9gyW/EKWLMkKsZLUPAsCFQ7ubKBYlaqh9rO
         3c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ob3t/jBzWODHBo2hlJ2B658om6+Tfa41Qcu36l+MtuY=;
        b=H8fdxR7IQnO+xswFeyCA9yIpTHJk4RBgs7D8IUfAXp5vQijx8eFv1V8H4l7cspYkXH
         ewIkIVGcG/8h8sbmcm8ZLQ7TipWBbefo62uJim4a1aiIDwz6L7EPpKD5lzYhShd67Rgj
         62/1jMYZ+2ZkgKLXVi3wuokgUTMTpQ6+LNkyLYU+T6AxFAyzs22L51ATLrtm7J3MBZNC
         +Vapy4j4PDqMNRpUgnRQfOUlN8LkGxneZUDUNBZovlYO9NGoSib7TKqkuTOLHbBgzO3U
         C4k6g9sHtQaXKHhO/PnYsmWeovdaTZljP9flV37YqTz46XxRVJ0TuaQvLkCKCUZv62N5
         ZlLw==
X-Gm-Message-State: APzg51COCTm4IPtJ00X88TpsH77RdA5BeaQagUgOr7kFjSa4w3u3U2FY
        dRHqK+IOXaLz8FqkzweZRvDICiM7r1qOHR0SQpA=
X-Google-Smtp-Source: ANB0VdbcdVYjMi5lPSjmR6sNoUyyymLWxBsPVqS1Xo2juZwaK88oeyphNnuvzwiB2Zwo5Vmj4QgnemgmxSnbKq/6RlE=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr7067511wrh.148.1535317192548;
 Sun, 26 Aug 2018 13:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
 <20180704124137.13396-6-s.hauer@pengutronix.de> <20180813063127.kpxw6d5amna5wpas@pengutronix.de>
In-Reply-To: <20180813063127.kpxw6d5amna5wpas@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 26 Aug 2018 22:59:40 +0200
Message-ID: <CAFLxGvw8Zd8WE9xZxebp+mPEDDQXizFrjY973+uTjz4VvS=2Kw@mail.gmail.com>
Subject: Re: [PATCH 05/25] ubifs: implement ubifs_lpt_lookup using ubifs_pnode_lookup
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 8:31 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Wed, Jul 04, 2018 at 02:41:17PM +0200, Sascha Hauer wrote:
> > ubifs_lpt_lookup() starts by looking up the nth pnode in the LPT. We
> > already have this functionality in ubifs_pnode_lookup(). Use this
> > function rather than open coding its functionality.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  fs/ubifs/lpt.c | 20 ++------------------
> >  1 file changed, 2 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
> > index 6cd6f23d4512..cde7b9484157 100644
> > --- a/fs/ubifs/lpt.c
> > +++ b/fs/ubifs/lpt.c
> > @@ -1478,27 +1478,11 @@ struct ubifs_pnode *ubifs_pnode_lookup(struct ubifs_info *c, int i)
> >   */
> >  struct ubifs_lprops *ubifs_lpt_lookup(struct ubifs_info *c, int lnum)
> >  {
> > -     int err, i, h, iip, shft;
> > -     struct ubifs_nnode *nnode;
> > +     int i, iip;
> >       struct ubifs_pnode *pnode;
> >
> > -     if (!c->nroot) {
> > -             err = ubifs_read_nnode(c, NULL, 0);
> > -             if (err)
> > -                     return ERR_PTR(err);
> > -     }
> > -     nnode = c->nroot;
> >       i = lnum - c->main_first;
> > -     shft = c->lpt_hght * UBIFS_LPT_FANOUT_SHIFT;
> > -     for (h = 1; h < c->lpt_hght; h++) {
> > -             iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
> > -             shft -= UBIFS_LPT_FANOUT_SHIFT;
> > -             nnode = ubifs_get_nnode(c, nnode, iip);
> > -             if (IS_ERR(nnode))
> > -                     return ERR_CAST(nnode);
> > -     }
> > -     iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
> > -     pnode = ubifs_get_pnode(c, nnode, iip);
> > +     pnode = ubifs_pnode_lookup(c, i);
>
> This should be
>
>         ubifs_pnode_lookup(c, i >> UBIFS_LPT_FANOUT_SHIFT);

FWIW, I've rebased the whole series to Linus as of today, the merge
window introduced some minor conflicts.
http://git.infradead.org/users/rw/linux.git/shortlog/refs/heads/ubifs_auth_wip

The above fix is included.

Thanks,
//richard
