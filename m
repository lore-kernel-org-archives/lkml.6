Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FFDC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD1F20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EheUCSTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD1F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeIIBnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:43:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeIIBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KTlAfQ/QsuReubslWxYBxr2H/Ow0bdy1HnzchPGYLwY=; b=EheUCSTwrK+Ic0erHFVy8QG4Lu
        pSZlndCp53LMMZxxUKO1GnC+/PZvwcdxND6PaNUi6nth9THk2n9MVb2H1jY8gFYo8fikMkiTmGvEk
        mRXBQ8l4qdHUT5o58uK2D9hNykHE5qd8aKoeBNttPvr3Sl/rhIskwC0l8l8lr2GhiKJWwFJQ2Y1oC
        ovU5WuglBIy3gdIfmvF9YoZF2gf8s3Cp14rd1AdEv89KHBSvUXU/gjWxBoVTuw8dD+tpWc9o16tnX
        qqO7lkNNDWyMOa9AYQ5y5wIqCc0MBrkvqbxMLtKUOLm9hae4TJm0FSIL9vuvo05wZtwFwmeieXHxx
        hF+Orx6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fykH8-0006S5-0r; Sat, 08 Sep 2018 20:56:14 +0000
Date:   Sat, 8 Sep 2018 13:56:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, vjitta@codeaurora.org,
        sumit.semwal@linaro.org, rientjes@google.com, mhocko@kernel.org,
        mgorman@techsingularity.net, labbott@redhat.com,
        iamjoonsoo.kim@lge.com, guro@fb.com, cl@linux.com, vbabka@suse.cz
Subject: Re: + mm-slab-shorten-kmalloc-cache-names-for-large-sizes.patch
 added to -mm tree
Message-ID: <20180908205613.GA6043@bombadil.infradead.org>
References: <20180906224849.1JOWr%akpm@linux-foundation.org>
 <20180907195816.GA28375@avx2>
 <20180908140306.GB17637@cmpxchg.org>
 <20180908155422.GA26807@bombadil.infradead.org>
 <bd363bd7-9e28-5499-235f-6e6c3c66c829@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd363bd7-9e28-5499-235f-6e6c3c66c829@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 09:10:46AM -0700, Randy Dunlap wrote:
> On 09/08/2018 08:54 AM, Matthew Wilcox wrote:
> > On Sat, Sep 08, 2018 at 10:03:06AM -0400, Johannes Weiner wrote:
> >> On Fri, Sep 07, 2018 at 10:58:16PM +0300, Alexey Dobriyan wrote:
> >>> I'd rather use KB and MB suffixes or at least capital 'K'.
> >> I like k and M better.
> > k and M work for me too.  It we were going to be anal then we should
> > go with the IEC standard of KiB and MiB, but we're trying to make
> 
> But                           ^K and  ^M.
> 
> Small 'k' .. I don't know what that is.

SI uses 'k' for kilo and 'K' for Kelvin.  It's an anomaly because all
the other magnifying prefixes use capital letters, but it's km, not Km;
kg, kV, kJ, kN, kW and kΩ.
