Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45286C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F9E2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K851uWF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F9E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeH3Oki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:40:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33348 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeH3Okh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7vglJ+NZ4ZmZvWkw+w6q7eF3N8xslbTy/DARKonGKgo=; b=K851uWF5RgWAbj/vPmWA8yYRS
        MLqzj+iDYTxLYKegi6vyUn74FiNbsLvUp1V58+icaBCCokHTf3jq33o4o22/ubezCPksTu9CLJE/h
        zFeb+PEpM0DJd25TLKqc+mc82+1zOoPy3ZnyVlrwenR4GSTH4A0cNdwe0lkR6U8m9lOMaiUWPrQux
        ws9jQuj9lEgABcrxQx7/Lad4pDoHqtbifqZWI3xbbUMTHqY0+XIRs7aVGkZkLJlD0iicMm1tcic8w
        siCZWE0A3vIPBNS9nltbLKz1BQQVkUjzRrRTtZbzM1crqYP30BVzBGv9TTEtZfjIZMkN7wdB0EUh2
        WT2yyAv5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvKLx-00085r-RK; Thu, 30 Aug 2018 10:39:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 877042024EB08; Thu, 30 Aug 2018 12:39:04 +0200 (CEST)
Date:   Thu, 30 Aug 2018 12:39:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: futex_cmpxchg_enabled breakage
Message-ID: <20180830103904.GA24160@hirez.programming.kicks-ass.net>
References: <20180829222221.GA22017@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829222221.GA22017@brightrain.aerifal.cx>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 06:22:21PM -0400, Rich Felker wrote:
> If there are archs that support SMP but don't provide their own

Then throw it out the window and drive over it with a tank.

Seriously, an SMP architecture that doesn't have native cmpxchg (or
equivalent) is not worth anybodies time.


