Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DA5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61068217BF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qy1pvzwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61068217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeHUUhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:01 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38476 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeHUUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:59 -0400
Received: by mail-yb0-f196.google.com with SMTP id c1-v6so4579150ybq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f2ra5hNONeOO5tlyLnTi9ILGED9CQbxz6jS8y2pJFqM=;
        b=qy1pvzwa987d9O3vBH9UY0JQ5MgHhUSUpuvxqdPK88Ged/IgwXSDTb0ZOJtHVLqfTp
         ymqHP1TZ50fyx/KN2s5EsKykSlgVsI8f3dvk0mIde2CTj4c9EMHqD02UsD4DDD/oLXMa
         PwiALRMMP8b/ra9Mg/6/54I2Gn1ckoUsCIs1xkzSUNNQqYpOoSffvtXlElqB77iJ3qZ/
         8UKUkvpn8/Q2bna+1H249G3LnsChvGWIFDZih59dIgFCa7cPQ7xvYgkERuDwPHaz9Usc
         rcwS+9c80s6plyeRkItdeNo8qeXAyyYi65wLNwEM3EBHG4papER+EnsxfmWc08RGW0Bd
         9ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f2ra5hNONeOO5tlyLnTi9ILGED9CQbxz6jS8y2pJFqM=;
        b=Yp5iCTMCSwTsRZGVCEq2xjncasV4amwNOF58ROh8OGtBZZU1OeG9QpVH5e+73Y/Q8C
         A0M0bTKdyojYWt2pdz6pV6mQCw4JN05uL186U47NOJizkmYCU5IL3Ev+AxT3xpGgfDj3
         gVzmKzc9G3q8mpfaaToU/Gv/iW797C1ig2cFDTB7dWZmu+mUSnDZLQ+PNUW4vWSEsoG/
         jemWXS5YrTV/Vyqe4DDCb4eLkpEIIATcfV7UPcCDCo6xh7fesuf1bFWSiMvLMVxGQfwg
         vY0BexaxhaPTvE8EBdgwIdhtdJNWeRdjw5mTsbKlL1mX1lAXt80tj2bepWsjmNxTQoqb
         /97A==
X-Gm-Message-State: AOUpUlE0bnT8fwIptogRAPOuf7QBZO5bJTybCoublPvdy4uxlzVdkAbL
        b7+k+D7S+6h7UXGdewO+V5FwFg==
X-Google-Smtp-Source: AA+uWPw52tgWXizR+PA3fdBEdHcWht46aZ7Q7JkP1VvSKS8VH8QBIEuytCTOvtTAnn+c0nUEYA9csg==
X-Received: by 2002:a5b:287:: with SMTP id x7-v6mr27845337ybl.476.1534871758395;
        Tue, 21 Aug 2018 10:15:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:17a0])
        by smtp.gmail.com with ESMTPSA id c126-v6sm1543227ywa.104.2018.08.21.10.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 10:15:57 -0700 (PDT)
Date:   Tue, 21 Aug 2018 13:15:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC] mm: don't miss the last page because of round-off
 error
Message-ID: <20180821171555.GA16545@cmpxchg.org>
References: <20180817231834.15959-1-guro@fb.com>
 <20180818012213.GA14115@bombadil.infradead.org>
 <CALYGNiOf_0fR4R747J11JNROO7_FW_9u16Bg09f+CdWPiFwGvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiOf_0fR4R747J11JNROO7_FW_9u16Bg09f+CdWPiFwGvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:11:44AM +0300, Konstantin Khlebnikov wrote:
> On Sat, Aug 18, 2018 at 4:22 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Fri, Aug 17, 2018 at 04:18:34PM -0700, Roman Gushchin wrote:
> >> -                     scan = div64_u64(scan * fraction[file],
> >> -                                      denominator);
> >> +                     if (scan > 1)
> >> +                             scan = div64_u64(scan * fraction[file],
> >> +                                              denominator);
> >
> > Wouldn't we be better off doing a div_round_up?  ie:
> >
> >         scan = div64_u64(scan * fraction[file] + denominator - 1, denominator);
> >
> > although i'd rather hide that in a new macro in math64.h than opencode it
> > here.
> 
> All numbers here should be up to nr_pages * 200 and fit into unsigned long.
> I see no reason for u64. If they overflow then u64 wouldn't help either.

It is nr_pages * 200 * recent_scanned, where recent_scanned can be up
to four times of what's on the LRUs. That can overflow a u32 with even
small amounts of memory.
