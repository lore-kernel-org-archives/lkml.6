Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10CEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D7C21A16
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R78IMBnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D7C21A16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbeHFUtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:49:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeHFUte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yLRIAaa5dTK2aqDcKxhjXtk2Cd2wkgwlCL01NjOZU9Y=; b=R78IMBnP46ez2nKMHc72UVKhA
        OtPokvf76f1OQbt5NnI68FLx6JvmJTpcPWc3+2PufqlgMWapjv309T3zKme2MMorcnmgd4HMThfFm
        oSNacQ2lwVDAKoAD26Ye0ElXcVWNotAORKhDHShvW+wLjSV7+5UE5dbG5QXlltAS6qkXrW+TXubtj
        4i9CTPx+11G1mvx99Eh4t3KRaGnWVCUkKr9rr9YcBx/Obh4Y4lvRxosQx+O4vzRfF4wHwAEgfFM6O
        Lxkm5JhvsV6WC6Ir/UjAyktsvrkPfxefIkLck4MWEXLbYEzb5mJceNYL9UQxLqOW90C+A54p0WnTI
        MT5EG6DVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmkPN-0007Pu-4o; Mon, 06 Aug 2018 18:39:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 811992016469D; Mon,  6 Aug 2018 20:39:07 +0200 (CEST)
Date:   Mon, 6 Aug 2018 20:39:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 3/3] perf/x86/intel: Add quirk for Goldmont Plus
Message-ID: <20180806183907.GS2494@hirez.programming.kicks-ass.net>
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
 <1533576223-11588-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533576223-11588-3-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:23:43AM -0700, kan.liang@linux.intel.com wrote:

> +static bool intel_glk_counter_freezing_broken(int cpu)

>  	case INTEL_FAM6_ATOM_GEMINI_LAKE:
> +		x86_add_quirk(intel_counter_freezing_quirk);

We really should fix that ATOM naming instead of making it worse :/
