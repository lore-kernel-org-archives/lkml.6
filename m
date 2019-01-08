Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09684C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC06F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WNbbiha+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbfAHTn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:43:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfAHTnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kAcpKixWtHGEPESaLO1jfQIkKD8g3uluyYQMkCQxYT4=; b=WNbbiha+WCx7XuYFvQE2Fllvi
        Kzjd9oeL8X5tW8rp99y2IebzMzDBEOUuO8MqSWMMB5HH+0Skn1AW1Gvtke+y5igEFO/nx5m/A1nZx
        6N7k5G34MqMrOZH3/en6Wl2mGRWZj0c4whPgLtGjdMo/kkUVQpZ0oXFO3enTgdtV6OhyKbIQIMP1K
        LA8ILDWYV7SkrrgTvR9z5kSnQfYQ4rpYWg8Iizm+hFNNDqsbFmnghWaOSR7XB5PJG8b2s4yv7scT6
        VCswykby70e1+zmLsIOrkDH+/4OGqTM8XYpDRrbc6LrbJKmx8Rcnv3TuWMFbFLQLUx9k0EkRTKypX
        NK0W1jyNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggxHu-0005w5-1o; Tue, 08 Jan 2019 19:43:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22EA520280199; Tue,  8 Jan 2019 20:43:43 +0100 (CET)
Date:   Tue, 8 Jan 2019 20:43:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190108194343.GE1900@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-2-songliubraving@fb.com>
 <20190108183127.GB30894@hirez.programming.kicks-ass.net>
 <A7A11A44-FDF0-4FB5-98B6-3E47A35E7120@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7A11A44-FDF0-4FB5-98B6-3E47A35E7120@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:56:19PM +0000, Song Liu wrote:
> I don't think we need u64 length. 32 bit should be more than enough. 
> 
> How about we revise it as:

Yep, works. Although I would not introduce types we're not yet
generating. We can add those easily enough when needed.
