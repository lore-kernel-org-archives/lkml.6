Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91811C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAAB20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BobaWjrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAAB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeKIUZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:25:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36923 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKIUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:25:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so771234pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H5jOHBWLP9V4yMpJUdT5opRiCEzhy4pJ+9dwy88Qjv0=;
        b=BobaWjrklokqt01lje4/gfHXGrRCqxrTqIJwyvW7aURjkDzbX5x9lOkeztGY/KYyBh
         bEZerRu1AOOMA+V0XGfTP2peenAlCMnz/vgu6diovn8vPVxjEu6xJJ733006Qw6zZl6D
         a584bnrBel7jQ1/lHQumHWwj5f1WN5mQLlojZakL/Qex+/AgHeZOYzqSiY221eALhspi
         TDP35H3Lg4mcd9eAyz4Us0tcPtT2JzoZkLfjM5NNAizms4fS3fMSLJDuORhvKj0UjXvb
         z8eoV3/s88wLN9QXToT7d1g4z/xP3biwDhuzysBblLH9doOV9PE2gCbV5p6W2EkviJRb
         EM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H5jOHBWLP9V4yMpJUdT5opRiCEzhy4pJ+9dwy88Qjv0=;
        b=dyUIQgQ63uV5QpGeZuL9NNm67gALzJbNHnesf7a2wrdSQ3/zNOubdD4fi3oroUfV9Q
         oNAo5nhBaUIdocjv3CNVqy1KkNkEiNY1df+30c0tFmQ8jUivbeYtIWu2es2aeUgpcqEL
         Ey+hXYp2ZXZZWDTNdrkT32JVBhmn4Yw8Rmk8vXuKfkh/AdW4vGlsS9B/KAuZMxFsCdax
         HG+NaaroKTcjTIht/qmYP+jbQcUjDYsWoUo3W8y41YhguO6Ctj0k3l9vxc/94futWCDU
         x2nLhknuMPhnJq2Xpjazc2YcFFAo9hrY892f67FXhPvVEEqixEldT1PJWwB20hx89YrG
         74/Q==
X-Gm-Message-State: AGRZ1gK20B/7zYF6mKdfGKPFlVJFS2gHwrW9B0Bu4O+X8uSv0UI6apDE
        s1sKtA2pUPPIxMuaaosIc6kpCyGu
X-Google-Smtp-Source: AJdET5fr689ZohvLg44dWKJ0DiLGWngjfM9FUuHuF8co1NxXvfuFwEjHSvMzkGRo4ljIWP1hjlEgnQ==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr6948053pga.202.1541760346419;
        Fri, 09 Nov 2018 02:45:46 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id n17-v6sm14611656pfj.148.2018.11.09.02.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 02:45:44 -0800 (PST)
Date:   Fri, 9 Nov 2018 21:45:41 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: check zone_movable in
 has_unmovable_pages
Message-ID: <20181109104541.GE9042@350D>
References: <20181106095524.14629-1-mhocko@kernel.org>
 <20181106203518.GC9042@350D>
 <20181107073548.GU27423@dhcp22.suse.cz>
 <20181107125324.GD9042@350D>
 <20181107130655.GE27423@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107130655.GE27423@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 02:06:55PM +0100, Michal Hocko wrote:
> On Wed 07-11-18 23:53:24, Balbir Singh wrote:
> > On Wed, Nov 07, 2018 at 08:35:48AM +0100, Michal Hocko wrote:
> > > On Wed 07-11-18 07:35:18, Balbir Singh wrote:
> [...]
> > > > The check seems to be quite aggressive and in a loop that iterates
> > > > pages, but has nothing to do with the page, did you mean to make
> > > > the check
> > > > 
> > > > zone_idx(page_zone(page)) == ZONE_MOVABLE
> > > 
> > > Does it make any difference? Can we actually encounter a page from a
> > > different zone here?
> > > 
> > 
> > Just to avoid page state related issues, do we want to go ahead
> > with the migration if zone_idx(page_zone(page)) != ZONE_MOVABLE.
> 
> Could you be more specific what kind of state related issues you have in
> mind?
> 

I was wondering if page_zone() is setup correctly, but it's setup
upfront, so I don't think that is ever an issue.

> > > > it also skips all checks for pinned pages and other checks
> > > 
> > > Yes, this is intentional and the comment tries to explain why. I wish we
> > > could be add a more specific checks for movable pages - e.g. detect long
> > > term pins that would prevent migration - but we do not have any facility
> > > for that. Please note that the worst case of a false positive is a
> > > repeated migration failure and user has a way to break out of migration
> > > by a signal.
> > >
> > 
> > Basically isolate_pages() will fail as opposed to hotplug failing upfront.
> > The basic assertion this patch makes is that all ZONE_MOVABLE pages that
> > are not reserved are hotpluggable.
> 
> Yes, that is correct.
>

I wonder if it is easier to catch a __SetPageReserved() on ZONE_MOVABLE memory
at set time, the downside is that we never know if that memory will ever be
hot(un)plugged. The patch itself, I think is OK

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.
