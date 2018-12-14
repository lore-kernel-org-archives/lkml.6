Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF3AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19CA206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P/rN+T/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbeLNR6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:58:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeLNR6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vd7q6Y/7HvIvMjXnHmosjCED9/0KsC/J21bU6sFmxhs=; b=P/rN+T/mjdCrqOwwTPUbHV1NC
        PG9cgHQEBCTsFxP+EbhNKfpnHKZL2fMKQSx8FbTQPDqq2//IK5HjbUdGAFJNPWVT6PZ1yg7BDmckl
        oIhEkAXMtb9pSwPny4iyjg+95OyA6aT45w3RNDDQzLB9CH/Hak3yAdPKVPr1p755c1RFRjfC5awQl
        3heYEunR06bjtRBD9bFUsEpqhUFp25wbOHArNwTRWrZvAeTJulJt+CN6NJmGWaLZm/9U2XBKyXN39
        VtbQPN5bM5PypzS/Pc05cHGE/OlNkwQBb3QJXTQ8YpU9i7JiBjH8MB94GA/jl43ofKwD31klaC499
        9OwbdreiQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXrjV-0003L7-0i; Fri, 14 Dec 2018 17:58:41 +0000
Date:   Fri, 14 Dec 2018 09:58:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     linux-kernel@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] radix tree: Don't return internal entries on lookup
Message-ID: <20181214175840.GB10600@bombadil.infradead.org>
References: <154408284374.405977.5950625525821388567.stgit@bahia.lan>
 <20181206133620.GC24603@bombadil.infradead.org>
 <20181206172102.0538b2a9@bahia.lab.toulouse-stg.fr.ibm.com>
 <20181213104314.71fd74eb@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213104314.71fd74eb@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:43:14AM +0100, Greg Kurz wrote:
> I see this fix is in linux-next. I just want to make sure it will
> land in 4.20 in order to avoid kernel panics in the OCXL driver.

It's in now.  Looks like Linus actually pulled it last night but didn't
push out the tree until this morning.  Thanks for the reminder (although
I hadn't forgotten; I was chasing down another bug).
