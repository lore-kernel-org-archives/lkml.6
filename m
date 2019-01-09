Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4793C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD420859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxyHwknU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfAIQXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:23:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfAIQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5/6fz2iVijZBLH9qoGDdtlYZB+7nLsXf0jW6XfihxZM=; b=HxyHwknUKddEykZ+nqMjhA8Vp
        jnwyDuTbwFw/avrvoFn3L/zedBkYJMd0d1Z8DxQ7NWEsD7m8p3ZzG12k3zRYtgG9y9tGqnP4s8B8/
        b5GWFzEQJ95qJevApF5YZp8+taUrhmE9/2sXsk/gsncFp8IZ/Bxp682cGvE8ITywJqcz9UcWYGbFQ
        pRhecL9Tsg0QRtP+nhRKobe70RPkr/kMvoyjQXbM5QfaZjCm+WbUutY0exHF5NlfsDHIJm8RHY8D7
        Nqy7tol84DZ3Nz5mRh1gcmeGL+DJibmjkUXb7VjSjQ0riIfDuIjUf6vzbKi0LpbnUzcCjBBI88KuC
        y+K59MqEQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghGdg-0000JW-Qq; Wed, 09 Jan 2019 16:23:32 +0000
Date:   Wed, 9 Jan 2019 08:23:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, jglisse@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] include/linux/hmm.h: Convert to use vm_fault_t
Message-ID: <20190109162332.GL6310@bombadil.infradead.org>
References: <20190109161916.GA23410@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109161916.GA23410@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 09:49:17PM +0530, Souptick Joarder wrote:
> convert to use vm_fault_t type as return type for
> fault handler.

I think you'll also need to convert hmm_devmem_fault().  And that's
going to lead to some more spots.

(It's important to note that this is the patch working as designed.  It's
throwing up warnings where code *hasn't* been converted to vm_fault_t yet
but should have been).
