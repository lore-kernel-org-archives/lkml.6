Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC12C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E5A20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHaipyjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E5A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeGYD00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:26:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38699 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeGYD0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:26:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so4179193pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 19:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n0JU50XI8YoaF9r6YPGEP9uX5H4ZbTJVBWlIMQmd1Gs=;
        b=GHaipyjctEknRpwRMcA95bOzugMxGGd+j7rCgdDcz9QPBOcXkwSXN8v/NPw09fuB4D
         K7XntQG87hNWRduMAQMdGjDLCAp8qzjhGWdaJ9j5/UU3bpRH6aCig1XtpDf8jNPGbmL8
         tQ2rB2+Vj+Ba1F2oicx8558F5ByiHsEpMAEa+uDmHmvGvJM3G5ggLZn8/un697JVs4en
         I/Gls5MfIn6gc5j635eFjjgNHjLbQ9w2BKp5ZftOTgzBMCP5DsZdaDYFrbLwfL2N7sWs
         3aTs4/F/88Zri+2L2VyPMPGFiiyUmRoIY7Jj4xKj68pm9bqXQhusEIcOaz3g7yeAh7aA
         aQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n0JU50XI8YoaF9r6YPGEP9uX5H4ZbTJVBWlIMQmd1Gs=;
        b=F4q1bJXPdTFDoywB8oHncAtrQi+v+N6VOAvKC8JsKbwR9x+lLr/BRNIT29LzkkTal2
         EQcDbD3F1XiEPItIcEzD+taNuy/myy5DXoJ+myA2iJRufp3L+Bo/tD5IukIbrwvJqUiG
         RQ1pQUPcPgnsTlvbw1w8mVDzvZYkJyyWRK/Gk0h05Fvnt5rhejRMRpReJskonT0bE7/a
         n0ynn/5ZAnBBBB4RA+KV9QxGZQ+GYPAKtAn1pIjHULBhGIX80CQZ2S47gqQJaslV6c5E
         sWTUrOhzuGQ8TBiS2phOkH+WU7cZ/2OroJ3cu17pl7NxswEp5BmwDU/Y9X8GoHc9ws+f
         ZsXg==
X-Gm-Message-State: AOUpUlGZtv8oF8S/h2s3X0bkOxlO2PRXjHjRK3PeGkjMWDhqBYf0P+AF
        ceuX4Ji/nsScTm4faWyZ6Q+u9UCo
X-Google-Smtp-Source: AAOMgpeKyM9jYtR2hs9fOgYKUBIBjKQjbGQdYo300OHoHmRVTAJS67EhfM975iRPNa0bQfvNo4tBug==
X-Received: by 2002:a63:4763:: with SMTP id w35-v6mr18356214pgk.140.1532485023475;
        Tue, 24 Jul 2018 19:17:03 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id t88-v6sm38526996pfg.10.2018.07.24.19.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 19:17:01 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:16:57 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725021657.GA87819@rodete-desktop-imager.corp.google.com>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
 <20180725015502.GA16271@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725015502.GA16271@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 06:55:02PM -0700, Matthew Wilcox wrote:
> On Wed, Jul 25, 2018 at 10:32:50AM +0900, Minchan Kim wrote:
> > Hi Tino,
> > 
> > On Tue, Jul 24, 2018 at 09:30:34AM +0200, Tino Lehnig wrote:
> > > Hi,
> > > 
> > > The first build I used was from the master branch of the mainline kernel,
> > > somewhere between rc5 and rc6. I have just reproduced the bug with 4.17.9
> > > and 4.18-rc6. Kernel messages below.
> > > 
> > > The bug does not appear on 4.14.57. I can test more versions if it helps.
> > 
> > Could you try 4.15?
> > 
> > I think it's a regression of struct page field reordring and it started from
> > v4.16. 
> > 
> > page->units for zsmalloc is used as offset of first object on the zspage,
> > However, below patch unified it with page->_refcount.
> 
> No it didn't.  It's in a union with _mapcount, which is where it was before
> my patches.
> 
> It's entiely possible that my patches caused this, but the explanation
> you're offering is wrong.

Before your patch, _mapcount and _refcount is separated space so we can use
_mapcount for page->units for non-mapped pages because units is unified with
_mapcount. However, with your patch, now units is unified with _refcount.
