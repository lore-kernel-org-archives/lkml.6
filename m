Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196B8C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AE7215E6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K56uiW41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AE7215E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJUDZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:25:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36296 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJUDZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:25:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so17214775pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzYsPVqR/FzkWN8wrk/qTG41Ljwq/P8kj+FYipmYAyo=;
        b=K56uiW41VVCp2ttkcnGpaqX376nUJuNbJPrGA9c5PAflmdeS+TiAQsU8V6yNPt2qPq
         9w/ZYsK1njHriUaqwlDNxPOVgbReBbONfLqAcZvswl9atEUnNSHQ6krJPMAi6K0qUGnz
         6aNTz32NDEWkTMtz+6AlIuPlZxvXfPEJ50OKk1Axm37DCuufS0ahOAgsHQg2jFOQhrrB
         Sgqapvkq/8qmY/7ztQJRK6Vdp/Z9OU2gz/bLI/h/hR097R6uAOktgsKzxxg9MRSAlN6W
         hqu4nIlO4AWrYRdFBNg2Q/Q94jaUFvBQ/ScbTLVhSBvjiPDH3AlBlc8OjsqQl/L1ngsx
         6cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzYsPVqR/FzkWN8wrk/qTG41Ljwq/P8kj+FYipmYAyo=;
        b=e+nblaBeb8ol9+upV/eWyChvAhhKGxii0dGy2nl+QWG+FM9l1AzoedRIIbVTkhV8PC
         Jv5+UNeO8MDPFsx4wijNKNIfTqjJDhQggQHiMVeaqdr7asl01q8hEz4uLJhWHjXten8n
         wW4u2rDkVnIDMInG5SsjZjRh+w8TgPTnZyNhL3kHwYFj4TjNpMJhFoTkSC55u1OGcqx8
         /Jk0NlmuxJUu1FJmAVjZ1uzFCj5MJLwtT5Kgn1roSpXdiuAtNuHDG3oAH16WJvgXZxRm
         EfUcxMV/ht6cDigmL0GwepcZIGI6ZiXD1cqHqzHf02HihaYcmAc2V4xKnGf+5vdXKado
         KcJg==
X-Gm-Message-State: ABuFfojyDlyk2D4P8OEf4TCtFFjciK3g6SRAsC4oGq5+GTki8VQMIeAj
        y4VbKNJujkupRG9vgDlXGZ6Ne8gNc2ReO4olwfhn+Q==
X-Google-Smtp-Source: ACcGV62wlbjTDlgQkA4wnHv7IoiCziKlMtZpemtYIKc2fig0+IoA5jYze72gTZUmjJBvMpAK1IaRnCRC2J2demyhtkk=
X-Received: by 2002:a62:62c3:: with SMTP id w186-v6mr39755372pfb.5.1540062872277;
 Sat, 20 Oct 2018 12:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181020134908.GA32218@kroah.com> <20181020135118.GG32218@kroah.com>
 <20181020192845.48b8b860@alans-desktop> <dfabf8b10d3e825c9a7f6c110e042dc72e50217d.camel@hammerspace.com>
In-Reply-To: <dfabf8b10d3e825c9a7f6c110e042dc72e50217d.camel@hammerspace.com>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Sat, 20 Oct 2018 15:14:20 -0400
Message-ID: <CAKON4OxLLhUkPGGbSF_ZtBC18fzZo44t1gUSsbYA0d2vCPfosg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the contact
 email address
To:     trondmy@hammerspace.com
Cc:     gnomes@lxorguk.ukuu.org.uk, Greg KH <gregkh@linuxfoundation.org>,
        mishi@linux.com, ksummit-discuss@lists.linuxfoundation.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 2:47 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Sat, 2018-10-20 at 19:28 +0100, Alan Cox wrote:
> > > +to the circumstances. The Code of Conduct Committee is obligated
> > > to
> > > +maintain confidentiality with regard to the reporter of an
> > > incident.
> > > +Further details of specific enforcement policies may be posted
> > > +separately.
> >
> > Unfortunately by ignoring the other suggestions on this you've left
> > this
> > bit broken.
> >
> > The committee can't keep most stuff confidential so it's misleading
> > and
> > wrong to imply they can. Data protection law, reporting laws in some
> > countries and the like mean that anyone expecting an incident to
> > remain
> > confidential from the person it was reported against is living in
> > dreamland and are going to get a nasty shock.
> >
> > At the very least it should say '(except where required by law)'.
> >
> > There is a separate issue that serious things should always go to law
> > enforcement - you are setting up a policy akin to the one that got
> > the
> > catholic church and many others in trouble.
> >
> > You should also reserving the right to report serious incidents
> > directly
> > to law enforcement. Unless of course you want to be forced to sit on
> > multiple reports of physical abuse from different people about
> > someone - unable to tell them about each others report, unable to
> > prove
> > anything, and in twenty years time having to explain to the media why
> > nothing was done.
> >
>
> ...and then you get into questions about how this committee will
> respond to queries from said law enforcement, and indeed to which legal
> systems the committee will or will not report incidents.
>
> Why would we want to be going down the path of trying to handle reports
> about "serious incidents" in the first place? That seems way out of
> scope for a code of conduct arbitration scheme. Even attempting to
> counsel people as to whether or not they should report incidents can
> get you in trouble in many parts of the world.
>

Which is why the lawyers need to go over this document and I haven't
seen anything posted from them. In the same vein Mauro is concerned
that the way this is code is written it is a binding contract in
Brazil.


> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


--
Jon Smirl
jonsmirl@gmail.com
