Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D893ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9357720647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IB0gu2Xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9357720647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbeGTPww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:52:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbeGTPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X/YQ9WADySG6qPPI1jIYNSTgs8iZ/cBt/yn6nRQq+AM=; b=IB0gu2XaTzHzWbutwLBKk6kNt
        98Yt7kuj2/qTu3YpyuyfIIhyWaMFpvDPLklPfvlFGMqOpyfzuZ5fOQi2LKrLX7K7Im5g1PQHGpeUR
        QcvPEsAB57to5fjJlhV6Xx8QyEjOQ0oCh0jTdwF2ZlpEtvQ7KSFlmhNNYoGS4BzvktQsPP0NVuB4F
        hqKDAWoNEMLlPUWaXaiceJpda1//PQZ+f596W6hbeHPJ4NvbN+GBx0eOjOt1xqKthkNls+27PxfF4
        Vl56E/6BaiyTKZvW9N5CUspVcuFMylgE20hN9YvG8rEu4F6xJP2KakogC9wd/gOr8xUBNsKTj+HYI
        mlBjepI0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgWwt-0000Io-0D; Fri, 20 Jul 2018 15:04:03 +0000
Date:   Fri, 20 Jul 2018 08:04:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sphinx version dependencies?
Message-ID: <20180720150402.GA32320@infradead.org>
References: <20180719181556.GA21435@thunk.org>
 <20180719190400.GB4800@magnolia>
 <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 09:30:33AM +0200, Markus Heiser wrote:
> We have this discussion over and over again an I believe we will have it again
> and again, as long as we do not change our POV .. building viewing formats is
> an application not a part of the Kernel.

Sorry, but this is complete and utter bullshit.

If that was the case we could skip all that RST stuff and just stick
to text files.  If we want fancy docs it better behave like the rest
of the kernel and just works.  python virtual environments are just
not going to cut it as they lead to a long-term maintainance nightmare.
