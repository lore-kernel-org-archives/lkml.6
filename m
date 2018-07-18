Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4174EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27C920652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bf+TEUsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27C920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeGROJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:09:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbeGROJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kCgmAgHFAWhPVUCrKwNY/yECUVSsYcM01j4D9rh6L7M=; b=Bf+TEUsHWAxVepGuLvvAncPcd
        zRJuRzfJe1HC3OYohQaLzvUV+0GQwVEXE/vJ1eYMDOLw6tMxUbeYWPRredHseQ87E3bAjn5XWRaf5
        Ii6RPvgyPW8Tz2HQt+l6UlHITt2UztLOvP9Ne2Mrq335dNjvPA0qj5c5PEY/LzJ7i+Wgopg+iaNXT
        SOdsloEd2RsSoyJzBNkxbaa51o6IyRO20EBPBFKVmqH7f4nB81F/krwTtia1rsP72LDUDvhkNYD3K
        hZa0qByi+aM3ZkvMypOdDCraTMt3ChP2eR4ZBb6Qy7tnXhRrw2zRDmIURM1ihGBJh8izY2SMTkmyS
        u1xbsl+IA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffmYA-0001ki-DI; Wed, 18 Jul 2018 13:31:26 +0000
Date:   Wed, 18 Jul 2018 06:31:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Varsha Rao <rvarsha016@gmail.com>
Subject: Re: linux-next: build failure after merge of the ida tree
Message-ID: <20180718133126.GD4949@bombadil.infradead.org>
References: <20180718165406.6f262266@canb.auug.org.au>
 <20180718092426.mxdti3jes5jsssta@salvia>
 <20180718131446.GC4949@bombadil.infradead.org>
 <20180718132746.txspsjvw3xxlqtey@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718132746.txspsjvw3xxlqtey@salvia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:27:46PM +0200, Pablo Neira Ayuso wrote:
> On Wed, Jul 18, 2018 at 06:14:46AM -0700, Matthew Wilcox wrote:
> > So Varsha, if you would like to take a look at transforming table->sets
> > from a LIST_HEAD to an IDR, I think that would be a great use of your
> > time.
> 
> Please, don't do so, we don't need a radix tree datastructure, it's
> just more complexity.

It's no more complex to use than the list_* macros.

> We just wanted to have a simple way to allocate IDs using a bitmap
> structure in the background without reinventing the wheel.
