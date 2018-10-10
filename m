Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C209C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635382150B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dbrMdp0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635382150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeJJWih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:38:37 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45127 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:38:30 -0400
Received: by mail-yw1-f65.google.com with SMTP id v198-v6so2301283ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fE4xEy53WtuGc23PB6OocrWOqKsA1Ap5tx7Zq7YRJJU=;
        b=dbrMdp0OT0r7iqxHERFNmoN5KTFysoZSqg3uVsufo0QCVzq9wbVE4BUeV/9tlliYDn
         QH6mOzdHFPGSy8b6JpQh9dFcIqz7tOgKOWe8qV9jVFxpHHm78dglz9n4K3jima5Pk4lo
         AVzelP8EVPGhz5jgzz1xifzCeEt3sbtiPxfnuKIvOQ09qzDZncS68RxLkTPHmGgJJ+5U
         ASX7tvt06nwNOiQrtZMx1kzRzR0OD02R3JlLtxaj5fsiBT294p66a8xU/7GEidVrICmL
         3b7VfFPqZHfgEH8ECWY6MbiX+iakEVx6aT6OQXVdchW7xlAxXTKbtprnLVY/JiPRHs6d
         Kbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fE4xEy53WtuGc23PB6OocrWOqKsA1Ap5tx7Zq7YRJJU=;
        b=VD7rY6vHcL8dl1ryv2XDZ6xuMLY1PH4Jf2vPjk0+OW+cwKUBgnlDoMFOAGxYbyhUB+
         9y6CFnzx/yEIvSMBv8FMCc4O3CXx9KIeK27R5CnvlXTEDcCXkP+WfRWj9XaS2oYAqGLU
         O3m42il2poIKhbWYWYd4HoiqM5U/gBLdo5JdjcxdsI9aeXap94tzPk1boUMfGsq+JuCq
         HwTu6CBkKHFs4sk4ppJKlOb6BMN28wLA9JlrjCFF7z99MQvsTqRsrtFEfYhFpjWs+iES
         48YPlFrKDb+imsXXRUAa9QedFV+1L2h6qT41QwNvt7QexWQWtE6UBIKZswEseEeU5cj8
         XwPg==
X-Gm-Message-State: ABuFfog2U22yvaMV6utasqktI0fSwpASf+s1GjilJzaOSusbHWhPV06U
        T6FffNvEjEWd4Vcycwf6ExexR0hqKeo=
X-Google-Smtp-Source: ACcGV62r6fiPBfckuqJo4BGJhZhHVwnX47nPV3jKkzBIwRU7qg7otvD/ojlEJR49hfLGJJwRCrFttA==
X-Received: by 2002:a81:7307:: with SMTP id o7-v6mr18698574ywc.183.1539184552080;
        Wed, 10 Oct 2018 08:15:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:4a04])
        by smtp.gmail.com with ESMTPSA id c5-v6sm6070471ywf.73.2018.10.10.08.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 08:15:50 -0700 (PDT)
Date:   Wed, 10 Oct 2018 11:15:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Rik van Riel <riel@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 4/4] mm: zero-seek shrinkers
Message-ID: <20181010151549.GC2527@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
 <20181009184732.762-5-hannes@cmpxchg.org>
 <e01c4f441e24bb31816a3080389dcae7b49cc1ff.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01c4f441e24bb31816a3080389dcae7b49cc1ff.camel@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:03:50AM +0000, Rik van Riel wrote:
> On Tue, 2018-10-09 at 14:47 -0400, Johannes Weiner wrote:
> 
> > These workloads also deal with tens of thousands of open files and
> > use
> > /proc for introspection, which ends up growing the proc_inode_cache
> > to
> > absurdly large sizes - again at the cost of valuable cache space,
> > which isn't a reasonable trade-off, given that proc inodes can be
> > re-created without involving the disk.
> > 
> > This patch implements a "zero-seek" setting for shrinkers that
> > results
> > in a target ratio of 0:1 between their objects and IO-backed
> > caches. This allows such virtual caches to grow when memory is
> > available (they do cache/avoid CPU work after all), but effectively
> > disables them as soon as IO-backed objects are under pressure.
> > 
> > It then switches the shrinkers for procfs and sysfs metadata, as well
> > as excess page cache shadow nodes, to the new zero-seek setting.
> 
> This patch looks like a great step in the right
> direction, though I do not know whether it is
> aggressive enough.
> 
> Given that internal slab fragmentation will
> prevent the slab cache from returning a slab to
> the VM if just one object in that slab is still
> in use, there may well be workloads where we
> should just put a hard cap on the number of
> freeable items these slabs, and reclaim them
> preemptively.
> 
> However, I do not know for sure, and this patch
> seems like a big improvement over what we had
> before, so ...

Fully agreed, fragmentation is still a concern. I'm still working on
that part, but artificial caps and pro-active reclaim are trickier to
get right than prioritization, and since these patches here are useful
on their own I didn't want to hold them back.

> > Reported-by: Domas Mituzas <dmituzas@fb.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Rik van Riel <riel@surriel.com>

Thanks!
