Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DFFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A725620833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A725620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeIKRqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726950AbeIKRqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:46:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4451DAF02;
        Tue, 11 Sep 2018 12:47:38 +0000 (UTC)
Date:   Tue, 11 Sep 2018 14:47:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180911124737.GV10951@dhcp22.suse.cz>
References: <20180910215622.4428-1-guro@fb.com>
 <20180911121141.GS10951@dhcp22.suse.cz>
 <0ea4cdbd-dc3f-1b66-8a5f-8d67ab0e2bc9@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea4cdbd-dc3f-1b66-8a5f-8d67ab0e2bc9@sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-09-18 14:41:04, peter enderborg wrote:
> On 09/11/2018 02:11 PM, Michal Hocko wrote:
> > Why is this a problem though? IIRC this event was deliberately placed
> > outside of the oom path because we wanted to count allocation failures
> > and this is also documented that way
> >
> >           oom
> >                 The number of time the cgroup's memory usage was
> >                 reached the limit and allocation was about to fail.
> >
> >                 Depending on context result could be invocation of OOM
> >                 killer and retrying allocation or failing a
> >
> > One could argue that we do not apply the same logic to GFP_NOWAIT
> > requests but in general I would like to see a good reason to change
> > the behavior and if it is really the right thing to do then we need to
> > update the documentation as well.
> >
> 
> Why not introduce a MEMCG_ALLOC_FAIL in to memcg_memory_event?

My understanding is that this is what the oom event is about.

-- 
Michal Hocko
SUSE Labs
