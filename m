Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEF4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F8C23FD1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F8C23FD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966802AbeF1Odo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:33:44 -0400
Received: from nautica.notk.org ([91.121.71.147]:46689 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966737AbeF1Odj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:39 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5D1B5C009; Thu, 28 Jun 2018 16:33:38 +0200 (CEST)
Date:   Thu, 28 Jun 2018 16:33:23 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 4/6] 9p: Remove an unnecessary memory
 barrier
Message-ID: <20180628143323.GA32547@nautica>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-5-willy@infradead.org>
 <20180628134029.GA24673@nautica>
 <20180628140358.GG7646@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628140358.GG7646@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Thu, Jun 28, 2018:
> How about this?
> 
> 	/*
> 	 * This barrier is needed to make sure any change made to req before
> -	 * the other thread wakes up will indeed be seen by the waiting side.
> +	 * the status change is visible to another thread
> 	 */

Yes, that sounds better.

This code is fairly old and I was wondering if the new WRITE_ONCE and
READ_ONCE macros would help but it looks like compile-time barriers only
so I do not think they would be enough...
Documentation/memory-barriers.txt still suggests something similar in
the "SLEEP AND WAKE-UP FUNCTIONS" section so I guess this is fine.


Thanks,
-- 
Dominique Martinet | Asmadeus
