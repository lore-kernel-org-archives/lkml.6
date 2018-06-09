Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KXPTCwBIHFvdfgAAmS7hNA
	; Sat, 09 Jun 2018 21:42:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E43D8608BA; Sat,  9 Jun 2018 21:42:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c/ZjBVPC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5BCE5602FC;
	Sat,  9 Jun 2018 21:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BCE5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeFIVme (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 17:42:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55177 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbeFIVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 17:42:32 -0400
Received: by mail-it0-f68.google.com with SMTP id 76-v6so6330465itx.4;
        Sat, 09 Jun 2018 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meWKAMAzfLS0QojYyDb1xx5HghvosL7M3W0Q6NSgnvY=;
        b=c/ZjBVPC5uT956wxUOVPeov69lrE4ika53RC9sOf1Jxw1Tvq+Oo7MmqrSlWXrvTgBY
         b6dd8+ewXMM6z7Cw+8idpZakOXe1BinH6MNANAd7pB/wRBoGrDwSKxAcxqazpny9qIPl
         JSXtgEqXmsh8j6MrZxj4cOjnBBKlFmW5c/Fe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meWKAMAzfLS0QojYyDb1xx5HghvosL7M3W0Q6NSgnvY=;
        b=n7Pje8fk49S1GJqy4Ix4+KXsqcuWM8TnbljVtBNSMZ2sLegIvrcIfUkSOop1idua3L
         rgL4EnKn4q5B2l7pyZ+YwHOC/TAJBWzi/M61ry6OKXeqf2Dv4t0kUpZkdLR9j2vCoxVQ
         0T4+vHyWRI225uY8W4n+p1Kl07K5NyB6a+2uaA8xVgtEDyZAELelOmlyB9yaqabfoyY7
         M2l7x7yQu4OF7aVgJEjk3KAc5fxxPlzXcyj7BAJcKjDPhfYFI/d/Im9SVUw0pa09b/b8
         zKnIq0m+80a+pyXhppsVcdWQOTAZAPnkhN1LU4PSl62ASmwr8XKyEmP7k6agghabOMjh
         2ROg==
X-Gm-Message-State: APt69E2MaXSk/+FGj60Di2odLboqZa2Sen7nLusrQhyraxsHNq0kHWeG
        t+fQFYd98fNQ37m7YpNCWnwckQ6tGhE8D0Dt8HFpVw==
X-Google-Smtp-Source: ADUXVKIYJjyJPUpW0KFJ4GTASQHdx0W0J8954MTyQGiv0f5zTmtSd0xrMra79lg66rgp98nC2SlaZ+YLaOMBsdDiURU=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr5897909ita.113.1528580551189;
 Sat, 09 Jun 2018 14:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com> <20180609065208.GA31572@infradead.org>
In-Reply-To: <20180609065208.GA31572@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Jun 2018 14:42:20 -0700
Message-ID: <CA+55aFxkUYXHNT+GtUFMSSdnNgYBoQu1tvxiWYNrwTJCLbi_rw@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

So I had held off on pulling this in the hope that it would get more comments.

I like most of the vfs-level stuff - it gets rid of some of the
hackery we had for overlayfs.

It does add some new hackery to replace it (like the file accounting), though.

And Christoph's copmmentary isn't really helping the situation.
Christoph, I haven't seen the NAK history, can you elaborate?

And Al, can you please take a look?

               Linus

On Fri, Jun 8, 2018 at 11:52 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > This contains two new features:
> >
> >  1) Stack file operations: this allows removal of several hacks from the
> >     VFS, proper interaction of read-only open files with copy-up,
> >     possibility to implement fs modifying ioctls properly, and others.
>
> Which includews all kinds of NAKed or at least non-acked VFS changes.
>
> Please get these through Als tree after proper review first.
