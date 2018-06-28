Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0366CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6387273BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NW6/yfbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6387273BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935016AbeF1NDD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:03:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933090AbeF1NDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q7okRLbnM87Hz+NWLiCimxVRQSCMaYUKuGsQ522+NbA=; b=NW6/yfbjrwQ0OkkuWwM5GXseQ
        K1/VL83Abumfgt9sh+OvrgHUqD4OmrHLkAIF1PM1QCZCi2xlRH24zdPhODAADY60rp8jp8RR/mM6l
        jvFYuNfd1503woC0waet5gIfWk2QsApWy7sS3Gc3C78J4kDGnNoYrwJ0ERx/2xCVGGuafjKBITLZO
        CqNMhicDZc9cWThzhD5eLaBZCS2i2E9z8oYoUad3QlnyWrOsDlAn0t+bNf9O6s/61tJny30LTDr1U
        9DZgCaBF7Mn9p9D5rcBtTugeefN0Tkou692W1d/co7zrfJKYB7bhoA90kv9kW4TFJ8lRii/Ixt2KZ
        joXlTadjQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYWZe-00061B-QA; Thu, 28 Jun 2018 13:02:58 +0000
Date:   Thu, 28 Jun 2018 06:02:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180628130258.GF7646@bombadil.infradead.org>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:41:19PM +0200, Andrea Parri wrote:
> + * smp_mb__after_spinlock() provides a full memory barrier between po-earlier
> + * lock acquisitions and po-later memory accesses.

What does po-earlier mean?  Partial order?

