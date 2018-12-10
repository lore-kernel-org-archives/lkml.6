Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659CEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B5320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS6jJnWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B5320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeLJUEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:04:04 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40004 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeLJUED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:04:03 -0500
Received: by mail-ua1-f68.google.com with SMTP id n7so4282838uao.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AkPN93qMOA0IRtRg7BfWRUTvc7TYJd7/F0i7q7hurpE=;
        b=vS6jJnWEsTQW7E9sylRBX9sMMhnlc/oVluy0mVZG2Vr7PcsqeY+ug3F/fc2aIji4/S
         CAgVeX9SJQm8bXdentZ7Ky0exmiaiBF6SKVcRb5jYxsiVOo1TvoBmHkZzSkC6ip0pOe9
         1BqM1QoTp7OEhkcRiVdkoz16B4e+Y/NWkDKqzW+ZUiw+62how8fpIEjH9CHsZi2/bkZR
         MpJ3hMJXywKaV+mDig7fUaZJ8+vaZ43CkkWzqBJNiJE6tNbCA0TKUOOA/N2UwqfysiD7
         DTxToPS7Wo3ScROLht/BacN//iQyHZbL0MGLDF2uD8ygbad3eIz9KaAeA0LUUsppTqId
         n1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AkPN93qMOA0IRtRg7BfWRUTvc7TYJd7/F0i7q7hurpE=;
        b=kJlODEYRaU89qTLzzIPZnMlIL4gheo4MdQ5jtAkd0vNstBIjEg/YZyW1QZ4Nu6vp+v
         23NqG1bTXPJcDhHIrslUGJLw10a3x4mOBiSjZkgQPpMZ0cUvDC8X4IHYApnAHslIQff6
         NHQop22JCwCjIA4GSv7+jlGPHrl4127bsXToswupJgeJp7+yxjUChmaZpmFDqH69J5og
         zCrh34ZirRU8Ls/c+ub10DI3rOtrcsxBh4wjvWa1fIncFfwsufSPBFq7yh/1d0sHwTSi
         L4pIk2eOQA85A77MKb65fkV0co6/NnVZjwBBvEqf5ekJ0wErPrpgjqeJaaUpH5RYCZFO
         3vAA==
X-Gm-Message-State: AA+aEWZxeWFf/KmLRrQmH0llbNDlUEWqxkL3VKvZqvG5vYuPHjlXWxIV
        lvOWHlbPAhSjcCfjPaArr9iCQEfgV5liWoZgknwo2hg9GFQM
X-Google-Smtp-Source: AFSGD/U9u7glBZtMC6sfUxRd0OWKLxnWZoYUPocjb0Oj2yhmUNCHrOq4rhWzf8iKsy84Rhld/ohdKT6wvQURksAmxgI=
X-Received: by 2002:ab0:1058:: with SMTP id g24mr5931973uab.58.1544472241744;
 Mon, 10 Dec 2018 12:04:01 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de> <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
 <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
 <20181208171746.GB15228@lst.de> <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
 <20181210193317.GA31514@lst.de>
In-Reply-To: <20181210193317.GA31514@lst.de>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 10 Dec 2018 20:03:49 +0000
Message-ID: <CALjTZvZNNj7L6MWg=xdA31xbfwW_8gej5iUPXqz4Xg55EQUYSA@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To:     hch@lst.de
Cc:     benh@kernel.crashing.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 19:33, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Dec 10, 2018 at 05:04:46PM +0000, Rui Salvaterra wrote:
> > Hi, Christoph and Ben,
> >
> > It just came to my mind (and this is most likely a stupid question,
> > but still)=E2=80=A6 Is there any possibility of these changes having an
> > (positive) effect on the long-standing problem of Power Mac machines
> > with AGP graphics cards (which have to be limited to PCI transfers,
> > otherwise they'll hang, due to coherence issues)? If so, I have a G4
> > machine where I'd gladly test them.
>
> These patches themselves are not going to affect that directly.
> But IFF the problem really is that the AGP needs to be treated as not
> cache coherent (I have no idea if that is true) the generic direct
> mapping code has full support for a per-device coherent flag, so
> support for a non-coherent AGP slot could be implemented relatively
> simply.

Thanks for the insight, Christoph. Well, the problem[1] is real, and
it's been known for a long time, though I can't be sure if it's *only*
a coherence issue. If someone who knows the hardware manages to cook
up a patch (as hacky is it may be), I'll definitely fire up old my G4
laptop to test it! :)

[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D95017
