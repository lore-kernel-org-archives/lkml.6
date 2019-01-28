Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484CDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182DC21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ZEOZkIB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfA1VbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:31:21 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35273 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1VbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:31:21 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so7374211ywk.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YAmmgKNRrQc5gbyA9vCwhi1X0/D3dSvcMoWevldO61g=;
        b=ZEOZkIB1dewlaD5Y88LebQn5HMgZEDeuALlgAC8pDnS/sfQZ8K6q8lkY836iFp/Kdw
         1It/VXY71UBzl1Bq7uh1IQfoJmSOqpgULvqmJE3ZspNPl8BPV5sjb83Xb/fC2Mzd/yhA
         Eu6LIMbmYraCkmEsuq7xjdLo/MM+VJPVxA/A9rZgYLOlqGTs+CVaHhBvXqOFUBWs2gES
         +xKhaDOu2ZiqRD85iIYTWm8h0IpSudZoXEA+qxmeXddUu0fljZFnNNJvAJjk2cFervnN
         dFRepVyf/R1qL4CFhy5JHnciEQw4kJrZvH+kb5VjmytlAglZ+q8KE0yqeQQh/uZ4s8Tv
         og1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YAmmgKNRrQc5gbyA9vCwhi1X0/D3dSvcMoWevldO61g=;
        b=JPeQzUCzVqyMg6hh2LFF2iBdC8zWZn1uPFzs2Ujp+aNfoEP3byRpnHmG/pJHhHt7DM
         a2zW+HUNoQWFUDQwpZ8Hat1D9hDmdmrK++iu3FPTGdnp5n1vfNq8D13tZZp8dbJmlVUB
         /C37Olx3D6f+LoaDaaXsIof3iUWB4GdkXAyP0QIeylc3c8YM4KKLr+67AoGNiHzGhSkQ
         ThoH1a/ce030phAWGTPmB7JG//7pEWIO4EULB2bu0ExsDjk5BhVkfJvZorYFoyTe7q8Q
         yGltaL4uVLab4hejKrKp5ILVQORFQvkvohSsnksYdZ1GzJ/OZccVPbn/UptuBykN/8vC
         oj2Q==
X-Gm-Message-State: AJcUukeFbwOD/D1GPI8pekxlmjqIM8Fx6foyejnEdxmWaoR1wzFOlBb/
        DM2+mY71JVndLUllW7g8PK8OBw==
X-Google-Smtp-Source: ALg8bN7r2Al7asGW6bKrsfih1TF2sfeDStiKF6KOaXlnpYSIXwhcAGaYJxIlng3sTi0ucBCqmjkmxQ==
X-Received: by 2002:a81:11d5:: with SMTP id 204mr22836937ywr.287.1548711079931;
        Mon, 28 Jan 2019 13:31:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:42c8])
        by smtp.gmail.com with ESMTPSA id p3sm12266647ywc.14.2019.01.28.13.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:31:19 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:31:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, Chris Mason <clm@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm,slab,vmscan: accumulate gradual pressure on small
 slabs
Message-ID: <20190128213118.GE1416@cmpxchg.org>
References: <20190128143535.7767c397@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128143535.7767c397@imladris.surriel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:35:35PM -0500, Rik van Riel wrote:
> There are a few issues with the way the number of slab objects to
> scan is calculated in do_shrink_slab.  First, for zero-seek slabs,
> we could leave the last object around forever. That could result
> in pinning a dying cgroup into memory, instead of reclaiming it.
> The fix for that is trivial.
> 
> Secondly, small slabs receive much more pressure, relative to their
> size, than larger slabs, due to "rounding up" the minimum number of
> scanned objects to batch_size.
> 
> We can keep the pressure on all slabs equal relative to their size
> by accumulating the scan pressure on small slabs over time, resulting
> in sometimes scanning an object, instead of always scanning several.
> 
> This results in lower system CPU use, and a lower major fault rate,
> as actively used entries from smaller caches get reclaimed less
> aggressively, and need to be reloaded/recreated less often.
> 
> Fixes: 4b85afbdacd2 ("mm: zero-seek shrinkers")
> Fixes: 172b06c32b94 ("mm: slowly shrink slabs with a relatively small number of objects")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Chris Mason <clm@fb.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: kernel-team@fb.com
> Tested-by: Chris Mason <clm@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
