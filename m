Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA4EFC617A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3C121557
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qmOGRRKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3C121557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeIMVVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:21:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeIMVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y0OnmPmrNSW7gnWaO4y3qUgmkq/l5b5zzWBdQXoZotk=; b=qmOGRRKq7j7yhb1fIQmtIOKcR
        TwRq3n5yjVCYwGIRdL6t2/gd7uS/6FLzfkb4EIm49GKeWj33Adb/4LNpBMO4nM09nNh0gbrJjTu3R
        3eG5oXTL2DdDF1jqC9shZsOZt8MSLEqhC+RYJ0OL6jNyWRZnDH3AKdGaWV3L4qLNMzajvUwD6CF0d
        KcCcVrovOKw3q00Lk+tVaPOkNvVqYSn/nHPpuDkHftlNiTVwagLTzD/8kJjiH82DzI+RdRMUw/R2R
        ZqcxlCjlM26t2fDq2vV811PP8q5uX9pVR/rX3rVQkCQCP+8KN1TJBW4k4GgA5cbyCdIDfFgLk+BER
        E+AjBJlQQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0UCk-0004jK-Mw; Thu, 13 Sep 2018 16:10:54 +0000
Date:   Thu, 13 Sep 2018 09:10:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] iov_iter: Add new iters and use with AFS
Message-ID: <20180913161054.GB11574@bombadil.infradead.org>
References: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 04:51:35PM +0100, David Howells wrote:
>  (5) Add an ITER_DISCARD iterator type.  This provides an iterator that
>      simply discards anything written to it.  It cannot be used as a data
>      source.

May I suggest an ITER_ZERO iterator type instead?  It acts like /dev/zero;
writes are discarded (as you have here) and reads return zeroes.
I've wanted such a thing in the past, but got distracted away from
that project.
