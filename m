Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3E42077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ucbH6op2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3E42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeIGWBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:01:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIGWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TmN2bvm/6GiBDRNJxpy2fLx6qDRHkW2Bzox3U+Rnqi4=; b=ucbH6op2Q54f40Kx7ht6wp93L
        An+/KFdI80BSjnF7RWViejCUFXssJTu5RRfNtePoXA+e1BW+Xg2JXHc2c8qvLJKagZyjfoDHKD1Be
        Q5fcC4wGy/PU7h2F2sYwj/s8QPHoqnvO3so+R4NeIE8HhuAbyvcG16UzBaOB3SCsQzLs7400Q0U4D
        JMTvqO+Gh8Eq13zRqzeDVtw9saXaWZyQmGvT3HjMNNUgIoXJKTC2+NItNpFPmOUrAjqR0QnxA2yUM
        KysWGgX02cpv6iAZhIglivfgRvlrx2ayEEbV/w7j1zJu1aE99NnMU4kudd0NFpiPobIImp1qDHA6K
        gadY+Kaug==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyKPu-00045M-Px; Fri, 07 Sep 2018 17:19:34 +0000
Date:   Fri, 7 Sep 2018 10:19:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org
Subject: Re: [PATCH 1/6] openvswitch: convert to kvmalloc
Message-ID: <20180907171934.GA3425@bombadil.infradead.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907165635.8469-2-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:56:30PM -0400, Kent Overstreet wrote:
> There was no real need for this code to be using flexarrays, it's just
> implementing a hash table - ideally it would be using rhashtables, but
> that conversion would be significantly more complicated.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Pravin B Shelar <pshelar@ovn.org>
> Cc: dev@openvswitch.org

Reviewed-by: Matthew Wilcox <willy@infradead.org>
