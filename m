Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB828C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7C020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ohy/EcSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7C020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389923AbeHARXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:23:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389740AbeHARXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tNvby4XvqzZyAT+ihwUpd0SQE5FUUE6BRch0tASGIBs=; b=Ohy/EcSRBm24I60Hmlbja9KjJ
        +mWTUrgyXBeUr020tHyb1b9zhFSF3YyiQEiXJo2OQFvAhR4KlTtoU1AJCcuIWsteKqXO2pqbkFJMZ
        NgZxPy71zTSGSbASBPVo8j+cSdn1kDM0k3344qvbZ4Kr0RQ0dn8dl19Jpo5w9crqQ7PrGIdAbVo6b
        xdfeF+ML0yWa48tSYpPzr7XXUG6yFUS4CPkOjauowEQY6yMwfqtq+NIElEG2KfdLTJEZXBh827/90
        cT4K3rjyFjvddKxnfNOWlKiNpA7zzpBI2ZdOyOU8yJi8J6d6VitybVLACYp2j3ejz5kERPLILpqnh
        /eesvLN1g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fktBZ-0007tl-PU; Wed, 01 Aug 2018 15:37:13 +0000
Date:   Wed, 1 Aug 2018 08:37:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Laura Abbott <labbott@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] A novel case happened when using mempool allocate
 memory.
Message-ID: <20180801153713.GA4039@bombadil.infradead.org>
References: <5B61D243.9050608@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B61D243.9050608@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:31:15PM +0800, zhong jiang wrote:
> Hi,  Everyone
> 
>  I ran across the following novel case similar to memory leak in linux-4.1 stable when allocating
>  memory object by kmem_cache_alloc.   it rarely can be reproduced.
> 
> I create a specific  mempool with 24k size based on the slab.  it can not be merged with
> other kmem cache.  I  record the allocation and free usage by atomic_add/sub.    After a while,
> I watch the specific slab consume most of total memory.   After halting the code execution.
> The counter of allocation and free is equal.  Therefore,  I am sure that module have released
> all meory resource.  but the statistic of specific slab is very high but stable by checking /proc/slabinfo.

Please post the code.
