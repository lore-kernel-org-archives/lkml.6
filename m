Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AA6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC9720685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AVdS3hqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBTK6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:58:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfBTK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gXnRYuoJulDdeBEx2ziHc8wXHc9Z26vXW+vn5c3kxYA=; b=AVdS3hqI8PPLQCTVLVrmTsNiN
        IN2c9mQ6Z666U4HeKuVHAUrZ3rVGQH1D8BnYHqu2RkuAIukJ0cbStP6bzE0q9DxNpfVqhEGlpgvIL
        fjYZWR61ME2In7DJksqHOanvRHm6ZTF/YMQ272zZFEDaVe4BTys7WVyXrIc7YceNmH+cNSr2Kg5z2
        4iVo8ETxPR3famAVNaXjol72amRL/7F6+DVshVfHIM43H3NO9ljwOWPPlEPqoXuvjWJw/Cw0djTgH
        oYItB36GmAwkZ0qa0KZX6hzQ77UyE2VREBo24WRLhb9Y03mtq3aof02HKFLLqJZDonzNqrgJM8WcC
        N3LMdkyAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwPaV-0006Jk-NS; Wed, 20 Feb 2019 10:58:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8111F202BC402; Wed, 20 Feb 2019 11:58:50 +0100 (CET)
Date:   Wed, 20 Feb 2019 11:58:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 05/11] x86 topology: export die_siblings
Message-ID: <20190220105850.GC17969@hirez.programming.kicks-ass.net>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <0d54a56186fb9be7a8f622a4625a41dc600dd7a4.1550545163.git.len.brown@intel.com>
 <59e07a24-dc44-c21b-91d4-ea04e8d0653e@linux.intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C9485C5B75B9@FMSMSX126.amr.corp.intel.com>
 <70ea25e2-6538-77ec-8686-40567e8d362b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ea25e2-6538-77ec-8686-40567e8d362b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:33:59PM -0500, Liang, Kan wrote:
> Besides the generic document, I think we should update x86 document as well,
> which is in Documentation/x86/topology.txt.
> 
> The definition of topology_core_cpumask has to be changed to per die, right?

That's what the change to match_die() did. It limits the core mask.
