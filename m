Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3FB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3FB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbeGKNnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:43:14 -0400
Received: from nautica.notk.org ([91.121.71.147]:49362 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387811AbeGKNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:43:14 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 78624C009; Wed, 11 Jul 2018 15:38:49 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:38:34 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 0/6] 9p: Use IDRs more effectively
Message-ID: <20180711133834.GA27521@nautica>
References: <20180628132629.3148-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628132629.3148-1-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Thu, Jun 28, 2018:
> The 9p code doesn't take advantage of the IDR's ability to store
> a pointer.  We can actually get rid of the p9_idpool abstraction
> and the multi-dimensional array of requests.
> 
> I haven't tested these patches, so caveat maintainer.

Overall pretty good for something that hadn't even been tested!

I'm done with the comments here, the three other patches I didn't
comment look good to me.

For [PATCH 4/6] 9p: Remove an unnecessary memory barrier, your suggested
wording in the comment is good; I've offered to do it if you aren't
going to but since you're submitting a second version of the other
patchs I suggest you do this one as well.


Thanks for the well-needed cleanup,
-- 
Dominique Martinet
