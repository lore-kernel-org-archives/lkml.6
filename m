Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBEDC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F9520863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ch9sIIJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F9520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755313AbeFRP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:58:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFRP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V9nJv2C7fzmsFzFMQD8auD4jS0DpXlVcvJt6LjofLmA=; b=Ch9sIIJVbfU5QPrfXpMr+GJU5
        m995pZuhZfgpVgcWgopxB497AuqDTQFv9oHfOSMFePqWT9vNTxIpNbKKMCIAT4CfN6K2phtJ7fQpD
        /cX3wZM24t5e6Qqgi+lx5mXhYDaGCjfTEI7BmVXd6UO9qzCeHLlxUPvIZ3VXHrXo21bPQKceMXIXt
        45HoV3sg5XLc1ephVTeXrt51+RPYVZuozkLqn3NvefX4U2/WXMxRBeLwjQIs1A2aZ/mIWJQoGwdCs
        y7NfZ77rZykSlMvflRuKSO9pjYsoexG9oKxooG6RRQcuPJrI8tgjiSxCj/arv7FqrUK03qe8RSw39
        SS7T3DJ5A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUwYR-0006HI-L0; Mon, 18 Jun 2018 15:58:55 +0000
Date:   Mon, 18 Jun 2018 08:58:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the xarray tree
Message-ID: <20180618155855.GB28748@bombadil.infradead.org>
References: <20180618132854.4fcf8d5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618132854.4fcf8d5d@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 01:28:54PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the xarray tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in lib/test_xarray.o
> 
> Introduced by commit
> 
>   d968f529e39f ("xarray: Add XArray load operation")

Thanks; fix pushed.  I hadn't actually built it as a module ;-)

