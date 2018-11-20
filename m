Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4D5C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677E9206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cgRWnMAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677E9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeKUBDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:03:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41339 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeKUBDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:03:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so176559qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fm/scVdMCI1pxhmJin1gGXV9ZqPxMuwEQf6GzjP5rYs=;
        b=cgRWnMAwuY9qcszTGnrQOv8NVGPPOgDeLk0eM/f49JEHjcRpAPD+oJe8OFYIa2+7Qt
         k7EGnh6vMzZ00eM0oTgrP3/GFZYnSCAHGtiq+1WS8NYd+ELSBRFF60fOBQwQLh//MFeX
         pyxc7/KNkA8GddzP6jzLMBI35Bfx49gGcl8EngjtGdJYZGkd5AqmuJGVa5WSrksbVET/
         gB9PD3nu3F1guMuRiSbgGVsLUyec/9xcLzys/uVrRYtecckdEX+UOgZzHrJL63HQWxI2
         U0WT4Cl3DV1HZhf7alOlDf9x/s9BG0MGG9a7FEP5jovviGIBBBTJidSLA/zUvgpJYcl8
         XIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fm/scVdMCI1pxhmJin1gGXV9ZqPxMuwEQf6GzjP5rYs=;
        b=oeKJnNNjSCdVOZqZAiAd0425EQwkefi3LFVWQ3oxDpO8ETgR8k66N8fYyCDHxTrkRM
         Z2Vll61A+wnplKgWLOQ0rPxw2cM+htdFfCp1MGo9aLat7kK6IrmGoiICV/fScvyMRm03
         tQSwD8Zj1A+SOLrXdBP+hTWoFma+Kgmeg98IMTOum2ZNUsgWwtltkeIcgHRNQg9h2kMT
         X2w8TH2C+E0op/Mn1zC7uktggU2Enw7WAiC+AodJP/KyiIzgYrJspz1s67DwqqgMCiMO
         Uhw/4iJ2BmeUIZjEUc/+ZwHGs6nqNWx3hSFZMO3z/L8RfC9yvQiY9P7eZ68AAvR0LC2d
         KrGg==
X-Gm-Message-State: AGRZ1gKOu9FN0L8tPMMfxUabJAD+ILs9zSH1w6QJh6CMbfZuybOmBPcq
        MDUzHfGzgqtE9xdos9t9if3E3UcLE0Y=
X-Google-Smtp-Source: AJdET5cb7sqXtfi6QV1AuOs5q04ZGg7Td3ZOH8R3/U0AlQU3+7dZcifZVYW66PnB+i9wSoTQM6GG0A==
X-Received: by 2002:aed:3968:: with SMTP id l95mr2097833qte.344.1542724435605;
        Tue, 20 Nov 2018 06:33:55 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id g52sm3139107qte.58.2018.11.20.06.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 06:33:54 -0800 (PST)
Date:   Tue, 20 Nov 2018 14:33:53 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC PATCH 1/3] mm, memory_hotplug: try to migrate full section
 worth of pages
Message-ID: <20181120143353.4s7vl7wzgyunh46j@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120134323.13007-2-mhocko@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-20 14:43:21, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> do_migrate_range has been limiting the number of pages to migrate to 256
> for some reason which is not documented. Even if the limit made some
> sense back then when it was introduced it doesn't really serve a good
> purpose these days. If the range contains huge pages then
> we break out of the loop too early and go through LRU and pcp
> caches draining and scan_movable_pages is quite suboptimal.
> 
> The only reason to limit the number of pages I can think of is to reduce
> the potential time to react on the fatal signal. But even then the
> number of pages is a questionable metric because even a single page
> might migration block in a non-killable state (e.g. __unmap_and_move).
> 
> Remove the limit and offline the full requested range (this is one
> membblock worth of pages with the current code). Should we ever get a
> report that offlining takes too long to react on fatal signal then we
> should rather fix the core migration to use killable waits and bailout
> on a signal.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks good to me, I also do not see a reason for 256 pages limit.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Added Kame to CC, who introduced page offlining, and this limit, but as
far as I can tell the last time he was active on LKML was in 2016.

Pasha
