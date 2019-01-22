Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99866C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CB620870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fBuNIGQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfAVLrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:47:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38953 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfAVLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:47:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so19032436edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 03:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QuO/XozkMMZklay5tLOHBo8nE2s3ZBEpJul+RMCtktE=;
        b=fBuNIGQ6b78tFxfzFdSEuYKlBA2Cx4jHkILv4tqBWKKYRieeXq4FTVgHAzU9W7+CNn
         sMk5hL6Nz2zjF6lVBUKzpLAbdpPp0hkZX6RGpAlOvKv+TYH0GkTxueRYJWsd/vHjGqvO
         EqbQdPGuKran5OxRpN1/yLSrJwHdt7pca3tvvgiawiyCpR/ASPjuqoLkpI3pEnWACVPz
         6rA5h6kQLRsjStQloqrhPhuY16M9L+ALrBehDlW8RAc289WoaXvPoh+cq3Phr27p2lFe
         RnfYV/x+DyO6IfnWDpKxwrDZ3nkfqstjRrKDM9oUCKatk4Iuipi14BvzMKzHKUvvqLBU
         n0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QuO/XozkMMZklay5tLOHBo8nE2s3ZBEpJul+RMCtktE=;
        b=neckWjGHbPyItRmN8JgwW/Yvk5LRynZYQFDzGN9izepJnKSwhU242VEb1PScjKzWoV
         GdqHk5IcEbFicME3Yt4l1ed0ubyq8yO4/Lx80brPQ0Thonr5NaWtaoGwg7IY1Ci3SXfW
         q9DfHeKq3ZEHunEXsnDGo/a67ucd3qw7uUcFWxN7n0jF7j1vMhGE4xqpNyDXNyjZrF2n
         aDv+aePAs2GJtCzDGlSTXyrSnCjoYPoHHu1OFXJ3VOtknAPR2071xTouyFdFU9ucolnO
         CoMCE2FVGt2ks5Ek2xDJeSUeIlDbCpwX+FSF/vbMQ5Jnv/NB0sj3w02j0IM3tNlGkIJX
         U5kA==
X-Gm-Message-State: AJcUukcB+mTlUi1XivzAdS0s58feQ0j3JBUJpLNm9R4hi/LUhMEVpjAs
        0iLu9D08aCT5oj3F+l+QxmGTDA==
X-Google-Smtp-Source: ALg8bN5yRHm4UNwnyBGuIJGpB2pCcHgn4gHKxqntgPVXW8WnyyrSRdyd2SX8/AySbzBIwZ45zQjQ8g==
X-Received: by 2002:a17:906:e9b:: with SMTP id p27-v6mr27518229ejf.29.1548157618839;
        Tue, 22 Jan 2019 03:46:58 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id w56sm9838112edb.72.2019.01.22.03.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 03:46:58 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:46:57 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190122114656.joasjhlpwo3vy7hg@brauner.io>
References: <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
 <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
 <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io>
 <20190122103009.vu2a67kviqhcb3cn@brauner.io>
 <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com>
 <20190122105747.6gxvghn7n5dxa65w@brauner.io>
 <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:42:44PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 22, 2019 at 11:57 AM Christian Brauner <christian@brauner.io> wrote:
> > On Tue, Jan 22, 2019 at 11:48:12AM +0100, Arnd Bergmann wrote:
> 
> > > Do you mean the asm-generic uapi header? In my current series, I do that:
> >
> > Yes. My idea was to only change pidfd_send_signal's entry to 424 and
> > leave the other ones untouched:
> >
> >  #
> >  # x32-specific system call numbers start at 512 to avoid cache impact
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index b77538af7aca..4d86d0787d99 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -740,7 +740,7 @@ __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> >  __SYSCALL(__NR_rseq, sys_rseq)
> >  #define __NR_kexec_file_load 294
> >  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> > -#define __NR_pidfd_send_signal 295
> > +#define __NR_pidfd_send_signal 424
> >  __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
> >
> > and also leave
> 
> Yes, that looks good.
> 
> > #undef __NR_syscalls
> > #define __NR_syscalls 296
> >
> > Does that work to avoid the merge conflict or do you need something
> > more?
> 
> You need to change __NR_syscalls to 425 as well. This will
> clearly create a conflict, but then the resolution will be to pick
> the correct (a.k.a. highest) number, rather than remembering
> to update it manually.

Hm, ok. Wasn't sure if that would confuse people.

Ok, when I sent my PR I will make a note in the PR that this branch is
aligned to create only minimal conflicts with your y2038 branch. The
patch carries your ack already so this should be good.

Thanks Arnd!
Christian
