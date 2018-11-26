Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74FAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76599208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Rnbq6FCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76599208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeK0Ii7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:38:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40142 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeK0Ii7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:38:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so14751064lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaF/FGgMILYt8P2hF3zP1oce9BsgpJa0a1NFDKAvmJ8=;
        b=Rnbq6FCRgdG8cBVl7L6zKw/AYLdOkYvOXx//s60ciBRRRwbs+nRXSpnmJcJUH0XHI4
         Ey1g0ubpjS6yIwfVNXaOO7veFmJEL4JK4GsmOOq3LyoyjXc7DJ6ZsUI7evMrQ0vDe5DC
         Tjxgabxml53VoCe9T5SOWalWPBg9dVwcFwjMbhQ7oTrR7KQDIXnwNCXR8sRDIUJJxfiI
         4Nj7d69cVQLV7a13gijm5/KtddxiPPdTJVkn83gVo8KIIQlpOq7cTcdAV0lABhm0EnkD
         eEXcNni2C3ezXtdNsJggIi0KwYDWWnVGp00JrpQwvw/6hfYau7yjNWWyrdcQ3xR/Ex1m
         pOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaF/FGgMILYt8P2hF3zP1oce9BsgpJa0a1NFDKAvmJ8=;
        b=GRUqM5hvQ8OVnxyZQP7opyyk08Bq7nSZDyC0Cw12DJbfAPYFfGjntzba57RKSKjRj8
         SwxAQwdlrb/AVV9O4O2dMVyCBrSeOP2ee4pEA4lelfvimqgjNo3feb8d6p7IImmu+TOh
         sFPubVm6sBmqF8i4TwVHfAAFmLl4rtQ6TYtGFv4TnNcr7tZQWYPXqCg+4A+6+4OOqqm+
         HtASVP4G3zuR09klLWeEwzSS3xYOVjBEA7MSWf8eRSGkjpBRQGdMxkufGodp3nPnumhI
         9W/i2PagjZP9gc6/sDOMZYDFLAHnGE/6iOaSi2C9tmi21sz28nPRxiD0iIj5xQQIc+hL
         Rhrg==
X-Gm-Message-State: AGRZ1gISEsb1Sdbh4sxSKhRcdntIMAu1Y6JwzgA7lHPH+BeM+Z0Fctgh
        J2dp45Cky9v27Ao4B8YSao9R9SYALGPw0jgbFI6D
X-Google-Smtp-Source: AJdET5fzHcxQvHc4ChpSKpxcnZz6vmWodsVEzKcD1lTtVpeCz1/5gsJZUqSGGOGkZIvHr5UvOmeAHlcFIMJvfv2v7jE=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr16174266lfe.4.1543268607204;
 Mon, 26 Nov 2018 13:43:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1518435853.git.rgb@redhat.com> <7289e57d94a0a13965e3dbd279cc8cd12dfb29a6.1518435853.git.rgb@redhat.com>
 <CAHC9VhRv_F=Gqs7EyTR2ZmLtJobyH9B8Cg-iiHE5hacTC-d=Pw@mail.gmail.com>
 <20181125171115.su4kuu44lazqw56n@madcap2.tricolour.ca> <CAHC9VhRpYpkVN5fan91g96YuR9GjT=6TbV7vngtS1Crm72+Knw@mail.gmail.com>
 <20181126192138.n6r7buxy4dpra4pt@madcap2.tricolour.ca>
In-Reply-To: <20181126192138.n6r7buxy4dpra4pt@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 16:43:15 -0500
Message-ID: <CAHC9VhS4YO4XN51QZDJMiJ7AqGLjc5zZ_b7h=_h1v5mhTCt2BA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] audit: remove arch_f pointer from struct audit_krule
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 2:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-11-26 11:37, Paul Moore wrote:
> > On Sun, Nov 25, 2018 at 12:11 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2018-02-15 15:42, Paul Moore wrote:
> > > > On Mon, Feb 12, 2018 at 7:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > The arch_f pointer was added to the struct audit_krule in commit:
> > > > > e54dc2431d740a79a6bd013babade99d71b1714f ("audit signal recipients")
> > > > >
> > > > > This is only used on addition and deletion of rules which isn't time
> > > > > critical and the arch field is likely to be one of the first fields,
> > > > > easily found iterating over the field type.  This isn't worth the
> > > > > additional complexity and storage.  Delete the field.
> > > > >
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > ---
> > > > >  include/linux/audit.h |  1 -
> > > > >  kernel/auditfilter.c  | 12 ++++++++----
> > > > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > > >
> > > > I haven't decided if I like the removal of arch_f or not, but I think
> > > > I might know where your oops/panic is coming from, thoughts below ...
> > >
> > > Have you decided yet if you like the removal of the arch_f pointer or
> > > not?  An updated v2 was provided the following day:
> > >         https://www.redhat.com/archives/linux-audit/2018-February/msg00059.html
> >
> > I still think I'd like to keep it as-is for now.
>
> Can you explain why you'd prefer to keep it as-is for now?  Is there a
> factor I'm not aware of that might make it acceptable later?  arch_f
> appears to make the code noisier than needed and use extra memory that
> is a convenience at best only when adding or deleting rules.

Personal preference for the existing approach, status quo, gut
feeling, etc.  Some things are simply judgement calls.

Please stop trying to find a four page, black-and-white explanation
reason for every single patch that is rejected; it is getting very
tiring.  I typically provide reasons when I don't merge a patch, and
often on these smaller, trade-off patches it falls into the "judgement
call" category and there simply isn't a detailed response to be given.

-- 
paul moore
www.paul-moore.com
