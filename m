Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E892920684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDC+cUj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E892920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390689AbeKWD07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:26:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389322AbeKWD07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lkep2NOJyNjU48mnRezbUf0lRxqHNB7oST7ClY/Kht4=; b=qDC+cUj6wfMbdOM47eBwJkp5N
        hyZS2cN8VwhBwQZc0A7MqB6Wq/RkI61kR56J4Ox5hREJJ5/ihe57JDDa6OvcgvtegUenL98rMrp4u
        KVbrVvY0aHxXXXqCWkRh/06NUZxG8+kUCQifG1seflqmhqmfLSoZWUagObqGTJv+9BjwhS1k6CRR+
        I3X8N10qD8dV9VSdxEgCKF5R+gIjBP2Q1/asdcLg7iaUosl/e0dHv8AmSvc5L/Q5jjfIKlAjcu+4f
        WTTsc++DgjqToK3Pmjsrxyrm0XtfOEYTekVxmj6uj31U24LY/UKPKve553ddmAixWMldMIe7WyvKz
        Wcp5ElFZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPs7q-00013W-Uu; Thu, 22 Nov 2018 16:46:46 +0000
Date:   Thu, 22 Nov 2018 08:46:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Remove obsolete bust_spinlock() implementation
Message-ID: <20181122164646.GA30230@infradead.org>
References: <20181122141529.14933-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122141529.14933-1-pmladek@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please remove the weak attribute from the generic implementation as
well now that the last override is gone.

