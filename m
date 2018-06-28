Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73814C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F11727102
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDfsnI7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F11727102
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeF1IqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:46:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeF1IqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lwj9IbXuAhLfTf81RdioTvEygEy2s0xl9ERoeajSeFY=; b=NDfsnI7jLNMAtMc9SF8bvIRKN
        BBcXH7TQLRZh9i/SUF3lHuZWHxylQDYZij+vOnpHCyR86bmI2kXSdDRZov8HyPjaPyNDQE7jkknTa
        JFv+Zj7qynNpLYoOhmytAw3YfFGIlCNrYOtOXTbilxjXw/tvlruuStHsdF6GrjanLwEBkyScsMn8D
        lMun0LLOe4f/IYi3JxTRXr8xArmpE+8NDV14pkDkhagip3KUg4/vWPotOurbg1YoXHoyFxJGVZqlw
        rA+rf/djsG7RQi3hB71MZXZuX9kg4dE9tArjmKjcAogGZTvit8EqZeLLIe3/phiQrgaxE595oW9w8
        +BP/3EMBA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYSZB-0004wi-56; Thu, 28 Jun 2018 08:46:13 +0000
Date:   Thu, 28 Jun 2018 01:46:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the xarray tree with the
 wireless-drivers-next tree
Message-ID: <20180628084612.GB7646@bombadil.infradead.org>
References: <20180628145900.4ca1e648@canb.auug.org.au>
 <1530172269.4988.1.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530172269.4988.1.camel@sipsolutions.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:51:09AM +0200, Johannes Berg wrote:
> On Thu, 2018-06-28 at 14:59 +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the xarray tree got a conflict in:
> > 
> >   lib/Kconfig.debug
> > 
> > between commit:
> > 
> >   0e2dc70e3d0d ("bitfield: add tests")
> > 
> > from the wireless-drivers-next tree and commit:
> > 
> >   d968f529e39f ("xarray: Add XArray load operation")
> > 
> > from the xarray tree.
> 
> Thanks for the heads-up! Not really sure where/how we'll be able to get
> that resolved before it hits Linus, but as the conflict seems rather
> easy (overlapping additions), I guess it's not such a big deal.

I don't care which order the tests are presented in.  I'll happily move the
XArray addition to a different location in the file.
