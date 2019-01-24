Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41A4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C57218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dKMD2Nmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAXVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:04:54 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37962 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfAXVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:04:53 -0500
Received: by mail-yb1-f193.google.com with SMTP id x9so2965108ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=On+Ju2/jG/TvajQP/wDisjpcbshjNNlG5MNkLQVn1Nk=;
        b=dKMD2NmbO5prZaNx2YHoPu2Hmaa+Hi+8SXHBi9aLBU6rJpU4N1Y0Gr3NycZAJALkAY
         zS2f3R6QFXE36JxGApdfRH4tIGW8VwFRUZLJe8pvmAU8u2WaIzJHOf5pKefG9cLHd+A9
         Z+KjGJqf3zbaYFr4dpsoRnXaf8oFWzbJ+RNVa7D+4AF/aIve8sYIVe81/5RigHbiA8IU
         xbsA9Okfw3if8dRvVvUfSgbTiANPa1nCm4qks1lv9ghBohqHmTB+wT2ZQSCZTFjsVyJx
         cC6PuQ68Y+cNr4syjsJ2OoqZ2KTH9X+lNGmiXIOEDjHQpUs09L3tISJCkalB+rZ751Pc
         Z+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=On+Ju2/jG/TvajQP/wDisjpcbshjNNlG5MNkLQVn1Nk=;
        b=rHR5p2RNcSJB27N/rX4pGxba9uDlSY7B++q70P8qMjeXNf8E3Wv5SSp3zzKqNuIlN0
         navBpCFjz5UOhH4KPKSjHb+8GLQdsVJzz8KsTcGWM7mS3G2XK63xahak3/OKqXjdtPKJ
         Fb9szpDF+kb0/3L6tWEfE+E0qMGU9OUWH05csWl/PUy5yKRcB3OidNwaXOodygS4p+fI
         YvZO+oWA1PsIhAPpCpSw1Ylbus85Gx2p1DxHfNhTBP7LPJ2GoOrIBgjH72d6U4eHA3Zm
         uV0hPXOZiW0C/KCmvZaPes+0GrM8EmksmM0VCpmF+/BQGq5CLGHHtu2Zxkp6R2eLOQgk
         tHUA==
X-Gm-Message-State: AJcUukcTF6T8zUksvb4audQ8LTSqyWdTIjApKpPMsvn0iHw2G8lGVeOo
        2mtGg8kJQpzYPI+nUT6KzgjTGA==
X-Google-Smtp-Source: ALg8bN6HOytAWDlAmyx0fJc7wYpSD5RbQ6hBOgGTEWfZ7KrzrC14q9V5wy1p91SwiCEg8clzRaAlsg==
X-Received: by 2002:a25:6642:: with SMTP id z2mr7716983ybm.131.1548363892149;
        Thu, 24 Jan 2019 13:04:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:9b5d])
        by smtp.gmail.com with ESMTPSA id x133sm12541815ywg.57.2019.01.24.13.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 13:04:51 -0800 (PST)
Date:   Thu, 24 Jan 2019 16:04:49 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm: Create mem_cgroup_from_seq
Message-ID: <20190124210449.GA14136@cmpxchg.org>
References: <20190124194050.GA31341@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124194050.GA31341@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:40:50PM -0500, Chris Down wrote:
> This is the start of a series of patches similar to my earlier
> DEFINE_MEMCG_MAX_OR_VAL work, but with less Macro Magic(tm).
> 
> There are a bunch of places we go from seq_file to mem_cgroup, which
> currently requires manually getting the css, then getting the mem_cgroup
> from the css. It's in enough places now that having mem_cgroup_from_seq
> makes sense (and also makes the next patch a bit nicer).
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
