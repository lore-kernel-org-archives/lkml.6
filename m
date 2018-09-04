Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F2EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3092A2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cj/AW+Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3092A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIDSSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:18:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIDSSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KrHUmTB/yXx0iZHl8q6SClKS8mbd2bGHFzlpm03KXic=; b=Cj/AW+RuCyndv/wVJy7/YEytE
        CL/61URYPbfHkTOzlublghs9hWZErr3eB87Or9RRjhrX7+K9FGZSBiM02MC+S/fYjv+GUZQFXXJH9
        hhaIR64z9uj3dvGVIZSFXG2a7h6KySuhdtL5dNuwwpP1JariTaLKeahH893b5J+7jsB84TYAf0e9T
        eyOXUU+BzVuGNgRm7vhQeZwbhxqcDcNtcppzwVrVJVttdf3Xg69uwe34ghCqnsp+qFHDatsrUE8+p
        LoOef0mn5vINq00UG8Emqd4NKSN8iUnxzTRkkIvVs8+7t+TP0vP7fL782Yu3VfCiAQMbUIX6XTL+7
        Rkc7OO0qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxBlm-00080x-OP; Tue, 04 Sep 2018 13:53:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AAF72027B767; Tue,  4 Sep 2018 15:53:25 +0200 (CEST)
Date:   Tue, 4 Sep 2018 15:53:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf tool improvement requests
Message-ID: <20180904135325.GI24124@hirez.programming.kicks-ass.net>
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
 <20180904071049.GY24124@hirez.programming.kicks-ass.net>
 <20180904134218.GA5364@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904134218.GA5364@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 10:42:18AM -0300, Arnaldo Carvalho de Melo wrote:
> So, use 'c2c record' to get the samples:

IIRC that uses numa events and is completely useless.
