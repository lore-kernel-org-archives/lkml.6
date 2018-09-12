Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C4C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfcP4di0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0C62146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeIMBqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:46:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42219 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeIMBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:46:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so1629712pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IBNNNg4MizNDFcrdAYwzK4XLVozLQ+0zgqPf9zoim8I=;
        b=vfcP4di0YmpH6QP5Gw7WPqtLqJtejtQsmzkTKvdV6gxBN/XZOFL+5+feikBhN9GTW7
         +lL54OdTtWIdB4lcEWrD2TKv1TGxhwvILx0mY5yXChAMw1ySJqp7oyJ91T/H5p84KwbS
         XlICTuTvgxE3jNx/MEWUQoHP7Vqm/KDzh2DT2CT1v6Db3NufWuBF+I5KFR5ChiEqlVdP
         uyVJowjFJQSAykRTLGyGD26iEjtQiAZ1LE0QPfQgf/XwGsoazJ7RyY6B+nJzxFgdfm7w
         wQX2/s1+Wg9Rb0GOge9DPZaUsD4o1O/U6t2BtgZ4CDZXmr715bQlA6n1FK6Cx0PSi1GC
         yExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IBNNNg4MizNDFcrdAYwzK4XLVozLQ+0zgqPf9zoim8I=;
        b=CD7IUm9dCZr1r6WkJjR9sd2G0VVvbWC4pXZZR9doc3YvrwalT+6TEyPclDABvoIJ0/
         iOTQ3E3plmR23Yo1AnNGsdaJkSlihDFeO4MuFK4Rc7zAh0SFwA+YuqwRc105FyhDsFKm
         lK2GQ7Vx6X3QtTz6bPCN3pYRF6iX4fDtF550sngtHunRjhiP//lnGCRvbU76WbOtddFi
         NvtUEEffu6/PtF7NesgC0qG1nmVxt3Sod/T0k9bN7bGqbqBUa3JKMAyHdfTnA3GvGo0P
         rBQ/z+CfawPmvY2BbKWipRTGoZSZ+m1qKPWUkE4HQpd7wIb9ujcGaXNLyB5swR3DuLIK
         au6Q==
X-Gm-Message-State: APzg51B2T1PKNF/R1iD+dc7e82jCdyaPa4KUYdplec64doHkWaPrfN3j
        ZwJpLQqRjM0j5vI8uCCPD+ZsQg==
X-Google-Smtp-Source: ANB0VdbeYLFO8sKE8l0XPMflx27xbtA0iBcmFoZitjuTrQQxYcJtWZcFid0I8R6YjXBeUaE0MlQOsg==
X-Received: by 2002:a63:f309:: with SMTP id l9-v6mr3923726pgh.369.1536784831786;
        Wed, 12 Sep 2018 13:40:31 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g7-v6sm2740930pfi.175.2018.09.12.13.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 13:40:30 -0700 (PDT)
Date:   Wed, 12 Sep 2018 13:40:27 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20180912120504.GE10951@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1809121336310.47609@chino.kir.corp.google.com>
References: <20180907130550.11885-1-mhocko@kernel.org> <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com> <20180911115613.GR10951@dhcp22.suse.cz> <alpine.DEB.2.21.1809111319060.189563@chino.kir.corp.google.com>
 <20180912120504.GE10951@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Michal Hocko wrote:

> > Saying that we really want THP isn't an all-or-nothing decision.  We 
> > certainly want to try hard to fault hugepages locally especially at task 
> > startup when remapping our .text segment to thp, and MADV_HUGEPAGE works 
> > very well for that.  Remote hugepages would be a regression that we now 
> > have no way to avoid because the kernel doesn't provide for it, if we were 
> > to remove __GFP_THISNODE that this patch introduces.
> 
> Why cannot you use mempolicy to bind to local nodes if you really care
> about the locality?
> 

Because we do not want to oom kill, we want to fallback first to local 
native pages and then to remote native pages.  That's the order of least 
to greatest latency, we do not want to work hard to allocate a remote 
hugepage when a local native page is faster.  This seems pretty straight 
forward.

> From what you have said so far it sounds like you would like to have
> something like the zone/node reclaim mode fine grained for a specific
> mapping. If we really want to support something like that then it should
> be a generic policy rather than THP specific thing IMHO.
> 
> As I've said it is hard to come up with a solution that would satisfy
> everybody but considering that the existing reports are seeing this a
> regression and cosindering their NUMA requirements are not so strict as
> yours I would tend to think that stronger NUMA requirements should be
> expressed explicitly rather than implicit effect of a madvise flag. We
> do have APIs for that.

Every process on every platform we have would need to define this explicit 
mempolicy for users of libraries that remap text segments because changing 
the allocation behavior of thp out from under them would cause very 
noticeable performance regressions.  I don't know of any platform where 
remote hugepages is preferred over local native pages.  If they exist, it 
sounds resaonable to introduce a stronger variant of MADV_HUGEPAGE that 
defines exactly what you want rather than causing it to become a dumping 
ground and userspace regressions.
