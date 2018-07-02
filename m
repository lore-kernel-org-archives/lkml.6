Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D240C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9CE25447
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ihtr+l1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9CE25447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeGBNU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:20:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeGBNU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KW2xw3jWDDgPcYimdcvFdC7/gvYFAqLn+depIs2hxTw=; b=Ihtr+l1hily/ldgK10lecD2xP
        X+x1YZBRiht4XI3k4lxDXjbOXQZm7xgXivGExvgAQGsbwwA7tTxyivR4Iu183iAkehPmyXr61gw7Y
        edEO12ViAbolMQVeiMvzgoX0/cSNVFzoCnsHexPzCME8ftZwKvrwIzPCjr5o5g11H38/RtfFPDdZ/
        Eu1uDECXV9rK6KQAN7qYtN9/skzqyNYzxT7PSd5GNKU+nF3SaBzbSDKA0uuWVq1SbJ8V25FGp/LGQ
        vtvH9UnDrHhp36yIVTL8UIYa0MzM1aSXRqrO3UkOaUO4ecQre1rqVjTACnZflgPrT1p6wogx9nOJW
        73cI15XWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZylE-0000wJ-Sh; Mon, 02 Jul 2018 13:20:56 +0000
Date:   Mon, 2 Jul 2018 06:20:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arc/Kconfig: include mm/Kconfig inside "ARC system
 configuration"
Message-ID: <20180702132056.GA30627@infradead.org>
References: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 04:42:27PM +0300, Mike Rapoport wrote:
> Otherwise mm configuration options show up in the top level menu.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Is this urgent?  If not I'm about to post a series that moves the
includes of all common kernel Kconfigs into the top-level Kconfig..
