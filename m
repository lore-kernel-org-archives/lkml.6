Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089ABC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68F120661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qmzrQ9DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68F120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeHWSvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:51:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeHWSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=po6DZaumXmV4HF6eHdYyylaiYRSYAwrP75eUrUE+/rY=; b=qmzrQ9DRL1eMGqxSA9Z97Iu4f
        0A0miOdZjMTFL5eYemgYaWA3iL70ggkpnr7c/PJ+Q1IYEgg1D7dtW91qenD8rylQdUxOrGQIQb3Ep
        RX9VzK0GOIAkNyzibNwt5ewC7r3oOs3neFkMpCm1lH/pztzRrPJW5WMkVUwzjT21HVrYwmhTmauaT
        IEpyU4J24CvLjUBY4J3HgWssm5inpRFbQt/zlEm+/We5Jj5P4jd4cwpkpmCs+K1LjcjDAQs8YnGrv
        sd+ugDtUl2sKi0RLyDZ1520gx+bCx7a8W+idHjsQWe2ZI4IHeXDk51U9dAuGRSh2ytDMfWcF0aDxc
        0kSJenQyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsrQd-0002Cy-Iw; Thu, 23 Aug 2018 15:21:43 +0000
Date:   Thu, 23 Aug 2018 08:21:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>
Subject: Re: [PULL 00/14] Xtensa updates for 4.19
Message-ID: <20180823152143.GA3049@infradead.org>
References: <20180822185034.30167-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822185034.30167-1-jcmvbkbc@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>       xtensa: platform-specific handling of coherent memory

How is this supposed to be used?  For the nommu version there only
are __weak stubs, but no actual implementation.
