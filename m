Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB6C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC552217BB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+at7OG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC552217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeHEKlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 06:41:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHEKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 06:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UBKeKqFIKqzLixZUgiFcOU0BBIaKClQP8ffAFLrkRnY=; b=F+at7OG/7OSKqVNVKsIXxt2G0
        tu+qiWUQM+UAVTzwUl5jFcjQKJ6hFY1i7HNTawkWlfyKA2byeN07Me+Y4XYV0nt8lY3aOjUAM8jKd
        J6kQH/kwDQonNM2+psYpBTq8vA4B+FkILsUvCCEMZ7wH9Fs6Jpt0krAFBRrPiWk40m1YIWqYK2Rkq
        5kFUh89YwVQXggqiWM6HXLelZ4HoOAc+OyXeqz6jwMr4Awq1fQyGYr5m1SZHo0vMaFiZpEpqW3ccw
        Jl964ZmwYiVND9gAoRPj5LMUey59MlgDtIFPyNOorNps5ZvY6z54QndQmsmQ8pZxrRDItfKDoN9zg
        PgkygLNLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmEXS-0003yb-7D; Sun, 05 Aug 2018 08:37:22 +0000
Date:   Sun, 5 Aug 2018 01:37:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2 15/18] serial: intel: Support more platform
Message-ID: <20180805083722.GA30000@infradead.org>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-16-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-16-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject line also seems odd, your are changing deps on the lantiq
driver, not some (nonexistent) intel serial driver.
