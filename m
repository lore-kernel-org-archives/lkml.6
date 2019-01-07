Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C63C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EB42054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546886593;
	bh=OEZKQrdIikhzqWGw9TMqIoFKwJR7OpxIClZspjyR8BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jo1S+vbG9p1DW8hQxdp/eQw1aSQHusJ4XTqk83wU/WvXDr7XJt5Q8k90CbliMJxfX
	 5vaGVqPBrFD4bE0ldnVt6uNlrvqfEl0dtNc06/jkTnSOXdqPxhmOBVJGv6GNwP/OOD
	 BG82Tvo8p5vmIoSc7rphQiHWR2ohL7iagmGF/1Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfAGSnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:43:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:51974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfAGSnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:43:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED05FAEB2;
        Mon,  7 Jan 2019 18:43:10 +0000 (UTC)
Date:   Mon, 7 Jan 2019 19:43:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
Message-ID: <20190107184309.GM31793@dhcp22.suse.cz>
References: <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
 <20190103202235.GE31793@dhcp22.suse.cz>
 <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
 <20190104130906.GO31793@dhcp22.suse.cz>
 <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
 <20190104151737.GT31793@dhcp22.suse.cz>
 <c8faf7eb-d23f-4ef7-3432-0acc7165f883@lca.pw>
 <20190104153245.GV31793@dhcp22.suse.cz>
 <fa135cd8-32e5-86f7-14ee-30685bca91b5@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa135cd8-32e5-86f7-14ee-30685bca91b5@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-01-19 15:18:08, Qian Cai wrote:
[...]
> Though, I can't see any really benefit of this approach apart from "beautify"

This is not about beautifying! This is about making the code long term
maintainable. As you can see it is just too easy to break it with the
current scheme. And that is bad especially when the code is broken
because of an optimization.

-- 
Michal Hocko
SUSE Labs
