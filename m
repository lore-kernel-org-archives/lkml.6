Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B3416256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22942083E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYiGwIfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22942083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbeG3SYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:24:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeG3SYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KHQDuWksIWgi08qoi1c4oLpN4rL/KTE0sDZyrBqXjVQ=; b=MYiGwIfx2AUF50TnZ/XVwgoDo
        yfG7WIoHAG908WJofnaIpAmZt1L761Rfwmwwi4A9gPsTh0lMzqbaz0DW8yp4f0D6gra9ei4EaArEj
        4LYBLsR/rKzRAgyxNWV1GuGo1p/coFcItWjbpISA950HYyCmQYlBJV8PR0zLzwJ8zwCFPU8I7+jYx
        h9byj+PfdQNVghz/Dk9ZzgiFJDfmGMdFNIb0sbf8puV9EWA9PmMUuvl0tC/Dse1eXFGxmhIdQ7Loe
        7jY/9U9JBvhWNykC10UP/VjXZn0SQ5onMNSzL2IjcWvV0ETOKzlbsW0cHotGzSaCVW0Wd0kObymZr
        eSk9GcHAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkBLd-0000oM-IW; Mon, 30 Jul 2018 16:48:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 129AE202883BF; Mon, 30 Jul 2018 18:48:40 +0200 (CEST)
Date:   Mon, 30 Jul 2018 18:48:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jacek Tomaka <jacekt@dug.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: Re: [PATCH v2] perf/x86/intel: Add support for MISPREDICT bit on
 Knights Landing cpus
Message-ID: <20180730164839.GP2494@hirez.programming.kicks-ass.net>
References: <20180730142813.13451-1-jacekt@dugeo.com>
 <20180730161738.GL2494@hirez.programming.kicks-ass.net>
 <CAKVxXCVjBaW1kFA48r-bKwrnzR9+SaFXtgaBTb-tr6QHeu1srg@mail.gmail.com>
 <CAKVxXCVoRb8Hf18AmUF7RcyNy7JACKByj2FsVOSiO31=ZHFHYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKVxXCVoRb8Hf18AmUF7RcyNy7JACKByj2FsVOSiO31=ZHFHYQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?On Tue, Jul 31, 2018 at 12:34:02AM +0800, Jacek Tomaka wrote:

> Ah, right:
> /*
>  * Due to lack of segmentation in Linux the effective address (offset)
>  * is the same as the linear address, allowing us to merge the LIP and EIP
>  * LBR formats.
>  */
>
> Yeah, LBR_FORMAT_EIP_FLAGS is ok as well. Would it be preffered?

Yeah, think so, that keeps the lookup table const.
