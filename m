Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2F1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8F5218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548349282;
	bh=IdaIj0dltWsxNzjiO9YjwH5bB4s5zU9bg3u2IoXgZ/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJk3kLZjf8LG1j4LvlXsf0CtoxpNk+Vr1ZYsOYnN1DifixJvbFAKJ2MIf+JZq8Fc6
	 jsCOTOLO1mp5ox77M389uzJ+3HzLqXl6RkXM1OqWCRCWP3HsA5Cg1IuDk6LUwsuL55
	 CSr7xwolhLy+uetKC1NPS/qv+ZndQrxyLlAyFj3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfAXRBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:01:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:43436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfAXRBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:01:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12A1EAFCC;
        Thu, 24 Jan 2019 17:01:19 +0000 (UTC)
Date:   Thu, 24 Jan 2019 18:01:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190124170117.GS4087@dhcp22.suse.cz>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124160009.GA12436@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-01-19 11:00:10, Johannes Weiner wrote:
[...]
> We cannot fully eliminate a risk for regression, but it strikes me as
> highly unlikely, given the extremely young age of cgroup2-based system
> management and surrounding tooling.

I am not really sure what you consider young but this interface is 4.0+
IIRC and the cgroup v2 is considered stable since 4.5 unless I
missrememeber and that is not a short time period in my book. Changing
interfaces now represents a non-trivial risk and so far I haven't heard
any actual usecase where the current semantic is actually wrong.
Inconsistency on its own is not a sufficient justification IMO.
-- 
Michal Hocko
SUSE Labs
