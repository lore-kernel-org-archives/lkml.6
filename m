Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29CAC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E04E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="oJLbBQDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E04E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeLIVxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:53:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50958 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:53:13 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so14657923iti.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 13:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iEA46s7oSLc4tOf/MrScR6zpCyF/9+8toSFPueMksig=;
        b=oJLbBQDRCyZnTrBuif2PeIEWKqwWkvrXZdwDQBpf5omYVkbFMXz1fD7K+U15LwSJpM
         X+94T2EQWp2eUp84pviMZ+1q2VJKcvnozOTxBQZJansoajQkidMJB/WKWYLmECm/Bcfh
         ePoRdR/L6ZfG9hRfOCVhKQEITCai51KsHSuNKf9iBZsFq9XrHMGhdUHcPWvnjINx2j6p
         zIsYu2VjMq4skBxK9fYxZRlW3M6gCcu5/BSkQ55u1HYIlf90s5GDPgYVO/pxZY1UVSp2
         xyKvEXn0Dx/Obbi2Qd+prwQmBdc9FJk7qNHFW8wkp+mnZ1J8XINE/fYlxvI8T4Ota19s
         SFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iEA46s7oSLc4tOf/MrScR6zpCyF/9+8toSFPueMksig=;
        b=snmIpf5OA5OxXiPjX1FuJA2LKYYHwIan0whoDJapvLFA47Umrz638E51c5F1j7Gy4+
         uv1L5OzH3I6mB6xYtI8qcGajmR4/7dpi1sorxvXMw6bu1yfNUEi6+PrJdwS5e19q5UQT
         EVaz9/5Fk0ev+j/spHE93hsfmdiKzClBgQGEP737Og3J+SFLiT8fLCJWfq/2LmvLLvdt
         l8H14//mUjKkWNcGuk+kOVL47nZkn4j2TlxT+cFvW0CPdGn9gbbNQdxRqsw21LyK89iP
         pFU+kBaZac53SfnBsvbe/fm8npp4fH0FOrPhGSZ7mosURH+guoNA2NJFREW20f4fZhLg
         TolQ==
X-Gm-Message-State: AA+aEWZFPKngRb5d2As/c179LpaDIaMFVz68Nr2juhwGZZf+E4K38cgK
        JqVlGwjqwKLtVrwPT8uF6V5jQA==
X-Google-Smtp-Source: AFSGD/X4pbgYJiE4ZuZ1AOVShoOEHOv+2mhYYNfRAeTDScuA0MYlzfFeYVXdjtt9L/OjO6ziFqhSUw==
X-Received: by 2002:a02:9c53:: with SMTP id h19mr9603036jal.31.1544392391344;
        Sun, 09 Dec 2018 13:53:11 -0800 (PST)
Received: from cisco (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id t2sm4440247iob.7.2018.12.09.13.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 13:53:10 -0800 (PST)
Date:   Sun, 9 Dec 2018 14:53:09 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209215309.GF30796@cisco>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
 <20181209212523.GE30796@cisco>
 <20181209213951.kumz33u6prb2seqz@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209213951.kumz33u6prb2seqz@ltop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 10:39:52PM +0100, Luc Van Oostenryck wrote:
> On Sun, Dec 09, 2018 at 02:25:23PM -0700, Tycho Andersen wrote:
> > Hi Al,
> > 
> > On Sun, Dec 09, 2018 at 09:02:21PM +0000, Al Viro wrote:
> > > On Sun, Dec 09, 2018 at 01:44:49PM -0700, Tycho Andersen wrote:
> > > > While working on some additional copy_to_user() checks for sparse, I
> > > > noticed that sparse's current copy_to_user() checks are not triggered. This
> > > > is because copy_to_user() is declared as __always_inline, and sparse
> > > > specifically looks for a call instruction to copy_to_user() when it tries
> > > > to apply the checks.
> > > > 
> > > > A quick fix is to explicitly not inline when __CHECKER__ is defined, so
> > > > that sparse will be able to analyze all the copy_{to,from}_user calls.
> > > > There may be some refactoring in sparse that we can do to fix this,
> > > > although it's not immediately obvious to me how, hence the RFC-ness of this
> > > > patch.
> > > 
> > > Which sparse checks do not trigger?  Explain, please - as it is, I had been
> > > unable to guess what could "specifically looks for a call instruction" refer
> > > to.
> > 
> > In sparse.c there's check_call_instruction(), which is triggered when
> > there's an instruction of OP_CALL type in the basic block. This simply
> > compares against the name of the call target to determine whether or
> > not to call check_ctu().
> > 
> > I think what's happening here is that the call is getting inlined, and
> > so the OP_CALL goes away, and check_call_instruction() never gets
> > called.
> 
> Yes, it's what's happening.
> 
> There are several more or less bad/good solutions, like:
> * add raw_copy_{to,from}_user() in the list of checked function
>   (not inlined in most archs).

But they are inlined on x86 :\

> * add a new annotation to force sparse to check the byte count
>   (I'm thinking about __range__/OP_RANGE or something similar).

Yes, I was playing around with inventing some check like this without
the need for an annotation. It's not clear to me if it's going to work
or not yet, though :). Top two patches here are what I was playing
with:

https://github.com/tych0/sparse/commits/check-as-infoleaks

> * do these checks before functions are inlined (but then some
>   constant count could not yet be seen as constant).

Yeah, I guess I was wondering if there was some more clever location
in sparse itself we could move these to.

Tycho
