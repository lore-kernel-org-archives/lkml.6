Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6888E205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INX4cf/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfBDQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:10:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfBDQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IxZFU4FZRXZFVTeuRKgQ0Q3a+JEkXXrXcHtY3w9gHNM=; b=INX4cf/8S03C3PcRImwIduh+9
        CQbOv9lchqwTZ+0lbr06DGjMf604lxTJXeASjuZNkZuF/QSOO5HsOgBHLY5RIm7d4bW3H3ccRL2xD
        h+Z9cek9VQOvZRHvDiUFSMh43WT5n1oSX3I+CdepsOZufzkD6jIHbLn+PjEQeYAD05lqfRlPztfys
        UT8O3urX+UQr8gqu7LiGfUy3uIsYMT0hEAoxSKJn0+VngJna4xpwPrB5q4dTut63RLDVl6gfVPPGq
        /92XfY2C11Kbf9mqmQTOnRdoSnaEmBKhrcdow96gXpRXupjRdjqFBBflOxsL9QCnlLjR/GxUbukpC
        VlS09pJgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqgp1-0002w5-Fd; Mon, 04 Feb 2019 16:10:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF6922029F1D6; Mon,  4 Feb 2019 17:10:08 +0100 (CET)
Date:   Mon, 4 Feb 2019 17:10:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204161008.GH17528@hirez.programming.kicks-ass.net>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:42:28PM -0800, kan.liang@linux.intel.com wrote:
> +	INTEL_CPU_DESC(INTEL_FAM6_CANNONLAKE_MOBILE,	 3, 0x00000000),

Funny that, CNL doesn't have any perf support at all yet.. Maybe do that
patch first or delay this line to that patch?
