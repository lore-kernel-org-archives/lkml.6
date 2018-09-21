Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC76ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA142150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SK1UjTNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA142150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbeIUUDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:03:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIUUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HizfqUw0My1sIgp4v39gaOuILV99jCHPT4j951LpQ/Q=; b=SK1UjTNTiCiTumOEi1/xDd4nP
        IhjnFrCpIt0bCeeWn1jMD96OvJriXLTDQBGJxxicx8n9bCUoHevmkqAJGOlIj8Aoe4ngxsrTReMd+
        oykYqpsLrogVNfaom/dstAaJg6e4phQycRr++4P8KKmawsrqBmSAW2jYVRdHJTsQ4F5fInzr4pMU/
        mZyDH2whhXBLnm9NJPta69fNWscswWH9B/lO8TdwC0Up7TAV90l5w1k8OL6wblz4yDuda/fiGlLxn
        Pzcyl1YQl576eSmT5JY3WEHj8EY5fBcob+qgBoC8xmRvbu0GOllFUVab1HFBU+HIlDWtt7oPyCCiJ
        O8wAaiL0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3MCd-0007ET-R6; Fri, 21 Sep 2018 14:14:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CF022024E445; Fri, 21 Sep 2018 16:14:37 +0200 (CEST)
Date:   Fri, 21 Sep 2018 16:14:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on
 SKX
Message-ID: <20180921141437.GE24124@hirez.programming.kicks-ass.net>
References: <1537538826-55489-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537538826-55489-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 07:07:06AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The counters on M3UPI Link 0 and Link 3 don't count. Writing 0 to
> these counters may causes system crash on some machines.
> 
> The PCI BDF addresses of M3UPI in current code are incorrect.
> The correct addresses should be
> D18:F1 	0x204D
> D18:F2 	0x204E
> D18:F5 	0x204D

Should this have a Fixes: tag?

