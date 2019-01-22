Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95CAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE90A2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bQKk0wSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfAVKaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:30:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35485 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfAVKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:30:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so18898566edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 02:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hpHDDlaPZa12Ry+qZQ/bWKSbFyddHFY3H6F1iJllFuc=;
        b=bQKk0wSSXaOmGFGqqHK7faXxMHrh8Yg23homVyaPt55z0TfVBQh9tSs7wu6fhO0KJE
         kaORsX9oaCZX1Xqxvlt8KVbPCr1S8Ib+s17CWEE1Egr3BEB4PGN3j0Q6DjSIMm7Nc+JW
         K7Xf4QQgg6ShfMCQ3VEgYi9fo+HsZq26dfhZbUfnV0W1TtKS62VKpN+2nwuixbPRUlqT
         /BayLURWrG/v8xmHHSbu5EV5TSJ+oKsZ319aP9VvWJgtH2mzKmlxPzIL8C+WcGtBaCgD
         srzuMF0UN/NZvk0LIWqUoz5VJ1zjp5MwEpV2GV+zkSX0Q4W0BitGU/l0HbBguOtoUOuf
         lV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hpHDDlaPZa12Ry+qZQ/bWKSbFyddHFY3H6F1iJllFuc=;
        b=etQv5gtxBo+kubj8DK/Wnm9VG41IHTFx9QFTL9P0EXPDuBGW0ZNmlvMiuJrr16Xc1R
         HyC4PKrdh4oeRm3oaogGfged7sGfmdNYRv+fW/5fG0/KaNIr4yWvnwPaAg0lnU5cXzML
         xr+vMxH93HBeLGAZbTefRUZ4ADpKLMMLNEcJ7/gl7A3xq5fvM7MHxzO7ei9EuVsJ9hrl
         rUUhkTaTKZ9c8rd0Ya5NFTlgiM/BrTqS/TYKEVWVk2xUVlJL4qM+CtMNAGfs59xm671S
         GvcRX3PTJq96WfqzmwWG71Yy4JMsh5oYiIuGLKquhYsg/wNvViaWu32m6/Y1m4v3a7zM
         Bvrg==
X-Gm-Message-State: AJcUukeneuHiEXRaRSSUhqURWi5UBDUFMzR3q98/JT4l2QyMkd6yrF0P
        YEy3+fv1EdEtL2w7CN1x9B0YUA==
X-Google-Smtp-Source: ALg8bN4iciLGHt9SBSd43kb3Y6czUKthzmdBgRX743QkgvLuxHHlHt4f47snG1CH/mbhceRHfnmk7A==
X-Received: by 2002:a17:906:228d:: with SMTP id p13-v6mr27479935eja.159.1548153011464;
        Tue, 22 Jan 2019 02:30:11 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id t10-v6sm5077664ejg.41.2019.01.22.02.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 02:30:10 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:30:10 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190122103009.vu2a67kviqhcb3cn@brauner.io>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
 <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
 <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122093146.kmckcgdbvo2e7v3c@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:31:46AM +0100, Christian Brauner wrote:
> On Tue, Jan 22, 2019 at 10:26:56AM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 21, 2019 at 11:48 PM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Mon, Jan 21, 2019 at 03:44:17PM -0700, Jens Axboe wrote:
> > > > On 1/21/19 1:23 PM, Christian Brauner wrote:
> > > > > On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
> > > > >> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> > > > >>> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > > > >>>> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > >>>
> > > > >>> I plan on sending the pidfd branch with the new pidfd_send_signal()
> > > > >>> syscall for the 5.1 window. Should we somehow coordinate so that our
> > > > >>> branches don't conflict? Any suggestions?
> > > > >>
> > > > >> A conflict can't be avoided, but if you pick system call number 427
> > > > >> for pidfd_send_signal, and Jens picks numbers 424 through 426 for
> > > > >
> > > > > That sounds good to me. Since it's only one syscall for the pidfd branch
> > > > > is there anything that speaks against me using 424? Given that the other
> > > > > patchset has 4 new syscalls. :)
> > > > > Jens, any objections?
> > > >
> > > > I'm fine with either one, I'll have to renumber in any case. But it's 3
> > > > new syscalls (424, 425, 426), not 4.
> > > >
> > > > Arnd, what's the best way to make this switch now, in my tree? Would be
> > >
> > > Yeah, I'd like to know that as well.
> > >
> > > > great if I didn't have to change it again once I make the change.
> > 
> > I'd suggest that you each just take the numbers we talked about and
> > add them in your respective git trees, at the end of the current tables.

What should we do about unistd.h? We can't just bump that to 42*, right?

Christian
