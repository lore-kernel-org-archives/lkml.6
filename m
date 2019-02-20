Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1E22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jf+M9uBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfBTKPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:15:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBTKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=glNt4U43zYwB6bY6425KBthPaPDzCuIz6JZN42uQBtM=; b=Jf+M9uBfx5T3fZIqYSU1kNyKO
        pbAGdUbmnv0ezTutUQI868RehUyPAkJwW3kNUWr53pvQpIOKKfoSmttQjxPIqkJUnaMxjAAY6BWcv
        u3BTgugotJ46W3QYgBQVVzWRVtspI/bvRGVebEUAaIJlYZM4IqITo7iaSxOuafVD4fjob0KxWu3k3
        BVy5XfW4QaWsXGLRekMVpxy3HmNPQCQbVcdAoeCrKGSQvLWOAvALcNAFhuuPRsn+gqGZrwEFmdEvE
        fDwq80pAEXlhcE3wpw+rhrknZhA7NqWHokEzQc5xjwak0ivv//lhcBBRmYo4MD32G9V1DWwwWmZQl
        GiwYioEMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwOuS-0007KK-6q; Wed, 20 Feb 2019 10:15:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1210523E8DABC; Wed, 20 Feb 2019 11:15:21 +0100 (CET)
Date:   Wed, 20 Feb 2019 11:15:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
        jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH 00/10] perf: Multi-die/package support
Message-ID: <20190220101521.GF32494@hirez.programming.kicks-ass.net>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:00:01PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add Linux perf support for multi-die/package. The first product with
> multi-die is Xeon Cascade Lake-AP (CLX-AP).
> The code bases on the top of Len's multi-die/package support.
> https://lkml.org/lkml/2019/2/18/1534

*sigh*, don't use lkml.org links.

We have a perfectly good canonical form:

  https://lkml.kernel.org/r/20190219034013.4147-1-lenb@kernel.org

which has the added benefit of including the Message-Id such that I can
easily find the email in my local archive.

And since Len forgot to Cc me on those, I suppose I'll have to go dig
them out to make sense of these here patches.

