Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88243C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473CA20854
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Plls5MIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473CA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeKOUUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:20:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EVzolkB/aVmQqrXrlje8GzLUCo7zvF79zB76LKs+7rA=; b=Plls5MIKWoUooBJHyaaqQcn4Z
        IwSyVmSTeDPCYswipel5Btxt/mXgpvMicIO5PxVMivzhhkny9Y7JnPv9QLBj8DtdQmr5JxiLYJEM8
        8dP+yul6K5IIEVWUJ01wrlgJoTEvOPQZVz5k/zfnSwJSl7hIqyduiPgr0U6mdTItwIZrM6HmOokeE
        K4Qz06HdJnx7ebgFE6gyz4k1LiLAIzpuIWsnsmkODJrD8+OTKiyEZqVfJDNdIhg0ZjUzRnRPOwdPe
        X+A9mbP3kh101Iu2nG6dMoDMGD1dguAcjvhQC5RkPuxrUKGxaeYxeFD3YU8DNc9UToNqWM8A6Q2cE
        3BQaxdzOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNEdh-00074j-GB; Thu, 15 Nov 2018 10:12:45 +0000
Date:   Thu, 15 Nov 2018 02:12:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Joe Perches <joe@perches.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: Remove noinline from #define STATIC
Message-ID: <20181115101245.GA13913@infradead.org>
References: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
 <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
 <20181112214515.GN19305@dastard>
 <bd3806ccc911989c7ef1fed9e8d26a4a5ad347a9.camel@perches.com>
 <20181113011804.GP19305@dastard>
 <20181113015410.GB30750@thunk.org>
 <20181113030926.GQ19305@dastard>
 <b03fda08ee4ca4b488c6f67e64bfc94f49be4e83.camel@perches.com>
 <20181113052651.GR19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113052651.GR19305@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 04:26:51PM +1100, Dave Chinner wrote:
> That's just as bad as removing them all, if not worse.
> 
> If you are writing new code or reworking existing code, then we'll
> consider the usage of STATIC/static in the context of that work.
> Otherwise, we leave it alone.
> 
> It if ain't broke, don't fix it. And it sure as hell isn't broken
> right now. We've got more than enough bugs to fix without having to
> deal with drive-by bikeshed painting...

Agreed.  That being said I think we should aim to add manual
noline annotations to those functions where we really care while we
go through the code instead of the weird STATIC that just seems to
cause this kind of confusion.

And if Joe or somone else can come up with a few patches where removing
the noinline (aka STATIC) makes a huge difference for a small number
of functions we should consider it as well.
