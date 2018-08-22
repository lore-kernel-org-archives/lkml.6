Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091EC2148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R6KWZH0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091EC2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeHVTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:11:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeHVTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K61e23rDPdYeAluFZncd/sjTQ7bcj6H5sIUK4bClOoY=; b=R6KWZH0vSV6t8/lj1JCiR4/m1
        5PIyK7rX9gK5Y9EzirpuwcUNlEXwU8kIuDYtmAs8z2ckcnniCptKk9DTsNhmsPNi+2J2aw14bBR7s
        ZE+Lb047mrx4lVCX3NQswZ4svQgSz2EB3Drudpmvhew64d6uNY4/llpTBQbEy0RTOoPM/0cmGYK62
        Mu+j1qbl7cE+bBGfzs7QeNV+6XRUz2112bo1xD8HPxg304PDQHrXSlE072IW74hFAdj5GshxQZ/oq
        ajiTe6K5c0d1kWdhmFsAl17SD/qGp+5Wcnjw7uy1LRhrxhaIJao50RXmAEC0LNo0Hgg2DuQHMP1QB
        oAgP4FUTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsVKM-0004RA-EH; Wed, 22 Aug 2018 15:45:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B6E902024D722; Wed, 22 Aug 2018 17:45:44 +0200 (CEST)
Message-ID: <20180822153012.173508681@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Aug 2018 17:30:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/4] x86: TLB invalidate fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of patches that fix a x86 TLB invalidation issue reported by
Jann and some related things that came up while sorting this out.

Please consider.

