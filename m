Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2FCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9C720989
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ZQCkKqOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9C720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeKJA4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:56:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37044 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeKJA4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:56:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so974227pge.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kogkxzw+fq2Is8CHmsTDlaVGnODviCCJxOZoap3Dfu0=;
        b=ZQCkKqOzZ37sa/fGbd3LD59VBRylVU6rkQyD4Itt0NgJ1IGEKlwuKocEV5xFbGnHnd
         +MVE6CE6e4CYQAJfqU/nXpyXxjyhLPpNBuswgEk1GJw5MTczKr64Z/sv630Rv5BExQ1K
         kUron6vDAqBwbBb3AGlPbRlRKLwj28dHUmTahmjrF3loSCD5UxbA0aW11bP+cRiuMWE7
         8Q9WB/U4J0czz3FZMNQa9Np6SDCWCUA98KTnijb/0Bl0hzUpNOS7N8vV8L0OAEgipypa
         xCA8fcFoHxTc9ypnZGoJqtz6gesxKSM19BzgxmLqR01fJo+YbDQgTUk/QPTwHGL67DDn
         KLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kogkxzw+fq2Is8CHmsTDlaVGnODviCCJxOZoap3Dfu0=;
        b=UrrThHNrKUYLCE19oQBGN/8FQZdJfbKKIH/ggQNsuRAcmlEsfs8nYtoZkkGIcCz+6E
         oy9TkqLIvtjeT4L1TeMiPMDZY4gB42Qvw5gROg+6lEvEx6ow11dkF6alzh7jmM8DxjFq
         KmD9rEIWwvKfwgKg1aMd0pbL8qspkwG7jj7+FTlKlnb2PGhcaVIWLVlr52Mka0jgb0gd
         s2dIzGHN+HgQ1o84adg18TlqKW5cSxv0m3Sys492/v/ftuS16HBih++T1yXcEVHMa1Ib
         xs9hD7ck3vLsNmC8K2qqtFgAf9YVgH4YhhVHmOocnYRBlkyPwI71FVNojvU3SL8AOfXo
         dR+Q==
X-Gm-Message-State: AGRZ1gLCCct+fKgOTkp+EvQGuGODQoYrr/XWYcyLi7dNN1o9HT+gZsgk
        11UV4DNajnkBgW7wkwhpheDSCxaF324=
X-Google-Smtp-Source: AJdET5cUdLe2pU4k/VUxmG6U+LdYbLnxWAqUrSUK7FllMeneeh7sy4Db5gHF0tvpVAJMpRum/WJ+Rw==
X-Received: by 2002:a63:c10f:: with SMTP id w15mr7744859pgf.199.1541776523619;
        Fri, 09 Nov 2018 07:15:23 -0800 (PST)
Received: from cisco ([128.107.241.164])
        by smtp.gmail.com with ESMTPSA id p14-v6sm6856538pgn.45.2018.11.09.07.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 07:15:22 -0800 (PST)
Date:   Fri, 9 Nov 2018 08:15:20 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     David Teigland <teigland@redhat.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dlm: fix various incorrect behaviors
Message-ID: <20181109151520.GD3645@cisco>
References: <20181102201822.12518-1-tycho@tycho.ws>
 <20181107222042.GA24927@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107222042.GA24927@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:20:42PM -0600, David Teigland wrote:
> On Fri, Nov 02, 2018 at 02:18:19PM -0600, Tycho Andersen wrote:
> > Hi,
> > 
> > here's a series to fix some bugs I noticed in the DLM. The third patch
> > in the series and maybe the first should probably go to stable, assuming
> > everyone agrees they're indeed bugs.
> > 
> > Thanks,
> > 
> > Tycho
> > 
> > Tycho Andersen (3):
> >   dlm: fix invalid free
> >   dlm: don't allow zero length names
> >   dlm: don't leak kernel pointer to userspace
> > 
> >  fs/dlm/lockspace.c | 2 +-
> >  fs/dlm/member.c    | 5 +++--
> >  fs/dlm/user.c      | 2 +-
> >  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> I've pushed these to linux-dlm next.

Great, thanks! Should we send 1 and 3 to stable?

Tycho
