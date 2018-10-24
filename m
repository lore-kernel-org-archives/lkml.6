Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA9BC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625AE2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC7WR3UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625AE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeJXSM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:12:26 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39766 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeJXSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:12:26 -0400
Received: by mail-yw1-f67.google.com with SMTP id v1-v6so1797187ywv.6;
        Wed, 24 Oct 2018 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2imPrQBCleSfuoYb57UDpMgu4SBmSZqDInqIhK1wD8=;
        b=DC7WR3UUhYcwtC2hflCwUMcGVakio78s15rq22jDRcSuQiTWwMquQwTGS/iFzas+7+
         TU943tO2UzMK8UYGfhWtVAMO/owhGptoj2Q1bfYOOKykFB7c8Y/2updCKZjynJUokXZh
         pZWTrmd8KIyx4vzI73tkhE7sdfBg8Qe7nay+QEeDeX4tygdPh525+XXEjrMEuCxDDXuN
         3JUlA7HQ703tsFYAQFYzZZeTbAxTZMfnj+a0achkOPbIWasAiOZuVLHt8eBtM/857cyn
         VpLxfn/9YcaoQHqFfeedFFXettEsZHT9O14/uh3JC5eJU5fFPKnZ6a0wgMO+cuzW7KwW
         EWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2imPrQBCleSfuoYb57UDpMgu4SBmSZqDInqIhK1wD8=;
        b=IiXFOKYBbGNYncBo2NoQcWNtNboxjD6dpA1N3roFuEE942HnqG5kJfORBQPE8eVJ7P
         +PAlgjv2ibD7OW6MjAJizKRsVWZrurSwKM1LKZhwaOrWAoROt4elFI25+po8heyHh3ZM
         e/tPJEfWulQkE3/2Xzd58x9cB0eLTzIiyFK9mA0D6e2RLFinosI2a/lUWOGu+p30tCH3
         Mp7quo+CgXepBRdNpl593cnkc/1SU7AJM7Y1HEYjTbm90TjglnNW0BZWWwUQzLyafCRc
         hT1AgDnXmnsgPwPBXuh/tMZfDC4YzBs4jLcKksSY4phn6DuR+m/GtDZP1RvfaS9uGlBy
         o6ug==
X-Gm-Message-State: AGRZ1gL2RWWA1m7HumrXgkRzCFsz176F3P3GQvshrCry/2tdWd77yYiR
        cFb5B+jj3jhOrvURowemrrPnrYb2weqWD5Pc4Ow=
X-Google-Smtp-Source: AJdET5fe8UyEC7PnlBa86AcY/nTwc9A1I1xDPidiEpyJoM4L3GV8YUOKlbUlP29aZEFvOF5NQWu9NgqaAa1P6X+qbHs=
X-Received: by 2002:a0d:d181:: with SMTP id t123-v6mr1408902ywd.241.1540374301186;
 Wed, 24 Oct 2018 02:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181023201953.GA15687@pathfinder> <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
 <20181024082134.GA14565@pathfinder> <CAOQ4uxjQwE2nhS7KccL_P+jUnz4vGwTpxjQquvbaZ0zZpJqGtA@mail.gmail.com>
 <20181024093103.GA19623@pathfinder>
In-Reply-To: <20181024093103.GA19623@pathfinder>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Oct 2018 12:44:50 +0300
Message-ID: <CAOQ4uxjyTtjPk1OaWCSKs3Larqog+vmqLSth1kKWdOA5oRTtAA@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:31 PM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> On Wed, Oct 24, 2018 at 12:20:14PM +0300, Amir Goldstein wrote:
> > On Wed, Oct 24, 2018 at 11:21 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> > > Dear Amir,
> > >
> > > Yes, I applied each patch manually to my tree, fixed it up where needed,
> > > then after rebuilding and testing each one I committed it and regenerated
> > > each patch. Thank you very much for your advice, I will take it into
> > > account and make the necessary changes. In the meantime, do I add other
> > > tags in the order they are received also (such as Reviewed-by:) and am
> > > I safe to add these in when I re-send the patches with the changes you
> > > and others have suggested (or would that offend people that have
> > > offered the tags)?
> > >
> >
> > Reviewed-by before of after Signed-off-by.
> > I prefer Signed-off-by last which conceptually covers the entire patch,
> > the commit message including all the review tags that you may have added.
> >
> > Some developers add Reviewed-by after Signed-off-by signifying the
> > order that things happened, so choose your own preference.
> >
> > As a reviewer, and I speak only for myself, if I offered my Reviewed-by
> > I expect it to be removed if a future revision of the patch has changed
> > so I have an indication of patches that I need to re-review.
> > But if the patch changed very lightly, like small edits to commit message
> > and code nits in general, that would not invalidate my review.
> > When in doubt, you can always explicitly ask the reviewer.
> >
> > Thanks,
> > Amir.
>
> Dear Amir,
>
> Thanks - I am just going to fix up the commit messages as you suggested
> using git am etc. The content of the patches themselves will not change
> (until further feedback is received).
>

Well, I did request to change some content (the location and the comment
above BUILD_BUG_ON section) which is relevant for several patches.
However, so far affected patched did not get any Reviewed-by.

Thanks,
Amir.
