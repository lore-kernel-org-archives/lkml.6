Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C01C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDD72145D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpmbRI90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDD72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeLBQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:10:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeLBQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 11:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BejUWo7u7HptnBAJpssF7b1r5HGnRImN3RWKdyNwg0M=; b=gpmbRI90IBzqVzf9oKMJ6LZyg
        W3sbJ7eV+TnCuOlXDvW9VbVPAb7xjIMm6euoIUOHacQDnwVN8e+pQMhRjAAtoPeB+bbL8X6jJtW0p
        ta3O6TgQL/GETbDoyOzcWSsiMmfs8hMlmyLgDZPjq9DL1eDtmXbilZ9evPiGpITAhqtjdMORO9bWC
        FQHt2+DMIA6X5VbOYJtbqfvwN1lCQIyQ9cjbIByJdQEZCqjGfjDp2ygm2ioY9/AsVgJx2MKRgRIOk
        tTALBnrlKcBZenKOAe9mmp6vmFhxjB/uNnYu/t+9q6G0rLzgrHAWmiBcU8L96dQbD3trGJ+c9JDCA
        3HUCVwFLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTUK0-00086G-B7; Sun, 02 Dec 2018 16:10:16 +0000
Date:   Sun, 2 Dec 2018 08:10:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Luis R. Chamberlain" <mcgrof@kernel.org>
Subject: Re: XFS patches for stable
Message-ID: <20181202161016.GA27696@infradead.org>
References: <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
 <CAOQ4uxhCH3oxVWDMVRcXMZO3JSTCA1Pp5AYnHP5pDxyNktqONw@mail.gmail.com>
 <20181202152547.GI221015@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202152547.GI221015@sasha-vm>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As someone who has done xfs stable backports for a while I really don't
think the autoselection is helpful at all.  Someone who is vaguely
familiar with the code needs to manually select the commits and QA them,
which takes a fair amount of time, but just needs some manual help if it
should work ok.

I think we are about ready to have a new xfs stable maintainer lined up
if everything works well fortunately.
