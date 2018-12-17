Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DB2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC81120874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7VyWFkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbeLQMuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:50:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40742 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeLQMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:50:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so12447644wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 04:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9EErUeduN9XIXunOQRmguU7wxFCZoXVfNjeGsfJc7tc=;
        b=j7VyWFkvZ2KBSYBWaOVlKmjFvBFyaJ8N1y2vSc9y7wC2LW7zJXCCyadRuFT+LGBklk
         tejr9zetvvqf0or4Af0PolQARKfx6PToyHQ2rL4dMubEwA7fgPLrhX15KRV36M2NHkBA
         1TnBMNg4mQ0xpjiQy4BI46PdPP07cg9MmtIgzIoHY1IIjU4GFOolMb4pgnTEa0L3Udk6
         Fc1EU+W6v3Ni8gAsXL5tJ8O8sOw1z5YZvjCsKIUlp49LcLlRtLWJW/b/QyPTUcdh8jJG
         bvLU4i9HzJE3VQy3cT0mW93yq0nMkdTv9wmHrG/eBtt+db7vJxMrZ0bwYZb6cXWxqhti
         b/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9EErUeduN9XIXunOQRmguU7wxFCZoXVfNjeGsfJc7tc=;
        b=FKoQEFuiEezGy/zbJnMgMOPlp5QPQItCcfuQCN/dbOR375qWACZ/jstndS7/HrSZdS
         ah7HackZziYTqIbQLgWqSjD4Lq13II7Q1ZqyB/jCRQRVuCV2jND6A21Fr6dEs9v2Hn6n
         zP6aXNQep8J1rqxzZlelMGCSpagucpj0CXKRNCkrqcWxrHNDrDvc4CgkIW4NNWIc46hl
         lOWeRq+1lnB2SAu+lZZjKmBVAwVyjA0ttZftPgm8nVW2L23F2cQ1tFIjVC5O2WlBc8cY
         Visn+lRgnNi8GemIWaNMVSg5GNoZPWP23o5S0juUUapFTnKM8g8iVjnHOZcg7ICPVERW
         E3tA==
X-Gm-Message-State: AA+aEWZSJ6HHyOw5zYTIhccSF/kTGtvGOqxFuN7Ivly1Ald3QyeNdYHt
        t/vBw7CIFq31uXPKAZB/8nAERkNkcA==
X-Google-Smtp-Source: AFSGD/WBCoywXfsVqSMNErA6Ls2RVTynNSH7gFRthd210BS9Y1+p4QtPH86BJq0+0GS+asBkcvd7aw==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr11476972wmk.149.1545051015188;
        Mon, 17 Dec 2018 04:50:15 -0800 (PST)
Received: from kmo-pixel ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id e12sm33334705wmf.22.2018.12.17.04.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 04:50:13 -0800 (PST)
Date:   Mon, 17 Dec 2018 07:50:11 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xin Long <lucien.xin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, dave.hansen@intel.com,
        davem <davem@davemloft.net>, Oleg Babin <obabin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 6/6] Drop flex_arrays
Message-ID: <20181217125011.GA28294@kmo-pixel>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-7-kent.overstreet@gmail.com>
 <CADvbK_ccPYY5jGRV+cLNc5Nzcfv0mq0eNMeU-ALvepax0ZSizQ@mail.gmail.com>
 <20181213144111.GO6830@bombadil.infradead.org>
 <20181213155149.GA4127@hmswarspite.think-freely.org>
 <20181213164533.GQ6830@bombadil.infradead.org>
 <20181213180917.GB4127@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213180917.GB4127@hmswarspite.think-freely.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 01:09:17PM -0500, Neil Horman wrote:
> On Thu, Dec 13, 2018 at 08:45:33AM -0800, Matthew Wilcox wrote:
> > On Thu, Dec 13, 2018 at 10:51:49AM -0500, Neil Horman wrote:
> > > On Thu, Dec 13, 2018 at 06:41:11AM -0800, Matthew Wilcox wrote:
> > > > On Thu, Dec 13, 2018 at 09:30:47PM +0900, Xin Long wrote:
> > > > > On Sat, Sep 8, 2018 at 1:57 AM Kent Overstreet
> > > > > <kent.overstreet@gmail.com> wrote:
> > > > > >
> > > > > > All existing users have been converted to generic radix trees
> > > > > NAK, SCTP is still using flex_arrays,
> > > > > # grep flex_array net/sctp/*
> > > > > 
> > > > > This patch will break the build.
> > > > 
> > > > sctp added that user after this patch was sent.  Please stop adding
> > > > flexarray users!
> > > > 
> > > > This particular user should probably have just used kvmalloc.
> > > > 
> > > 
> > > No, I don't think thats right.
> > > 
> > > This appears to have been sent on September 7th.  Commit
> > > 0d493b4d0be352b5e361e4fa0bc3efe952d8b10e, which added the use of flex_arrays to
> > > sctp, seems to have been merged on August 10th, a month prior.
> > 
> > Are you seriously suggesting anybody sending cleanups needs to be
> > monitoring every single email list to see if anybody has added a new user?
> > Removing the flexarray has been advertised since May.
> > https://lkml.org/lkml/2018/5/22/1142
> > 
> I don't see how thats any more egregious than everyone else having to monitor
> for removals of code thats in the tree at some indeterminate future.  The long and the short of it
> is that a new flex_array user was added in the intervening 7 months that this
> patch has been waiting to go in, and it will now break if merged.  I'm sorry we
> started using it during that time, but it got missed by everyone in the chain
> that merged it, and hasn't been noticed in the 4 months since.  It is what it
> is, and now it needs to be undone. 
> 
> > > regardless, however, sctp has a current in-tree use of flex_arrays, and merging
> > > this patch will break the build without a respin.
> > 
> > Great.  I await your patch to replace the flexarray usage.
> Sure, we'll get to it as soon as we can, or, if you are in a hurry, you can
> replace the same usage, like you've done for all the other users in this series.

This is really my fault for slacking on getting generic-radix-trees in, and
given that the sctp code has been merged I'll do the conversion.

However.

Looking at the sctp code, honestly, wtf is going on here.

sctp_send_add_streams() calls sctp_stream_alloc_out() when it wants to make the
out flex_array bigger - ok, this makes sense, you're using a flex_array because
you want something resizable.

But wait, look what it actually does - it unconditionally frees the old flex
array and preallocates a new one and copies the contents of the old one over.

Without, as far as I can tell, any locking whatsoever.

Was this code tested? Reviewed?
