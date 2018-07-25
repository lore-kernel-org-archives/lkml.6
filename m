Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C10C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F0E20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sUQX6/xC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F0E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeGYJqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:46:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41614 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeGYJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fYsu40eIhuD9dQmywF9XPRG0hMZiemlyizkikClGMzw=; b=sUQX6/xC6madhHnPjCZrebhl8
        GHf//tnQFdsItQSloO9tTV6kf/OlU5gUufT0QhWQfw9KqVF6m/Avwg9kLm1Gl9n1XU8jduDfhQYRN
        DOmUWD0F8j/2kjAbJnS8vGtL5KD4CrvI9znLZaEf7DNHiu0LjVXeWJIknuWK70LT7G0b7etVGcrb7
        ngot0IFeEmwAJ6g/Ww/vXhtKvUdLHzy3qnlClY+PpYTdsZ3ReAtRRNYMc/CeSJl3XdJ3d/53kWBO7
        CCYM3vQSjx2VR5T/UVhOlK79b2S+RLJ1mwh79rGYOLbz6P5JfJykj6zkrJgkEwm6c9m8j0g1B7z7z
        ZNm7B1Imw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiFGf-0008MH-8M; Wed, 25 Jul 2018 08:35:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEB4720268339; Wed, 25 Jul 2018 10:35:30 +0200 (CEST)
Date:   Wed, 25 Jul 2018 10:35:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jiang.biao2@zte.com.cn
Cc:     chen.lin130@zte.com.cn, mingo@redhat.com,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        tan.hu@zte.com.cn.cn, cheng.lin130@zte.com.cn, tan.hu@zte.com.cn
Subject: Re: [PATCH] sched/numa: do not balance tasks onto isolated cpus
Message-ID: <20180725083530.GT2494@hirez.programming.kicks-ass.net>
References: <20180724090651.GK2494@hirez.programming.kicks-ass.net>
 <201807250830037580322@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807250830037580322@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:30:03AM +0800, jiang.biao2@zte.com.cn wrote:
> I do find some(very few) Co-Authored-by in git logs, and we'll try to avoid
> using that. Sometimes little patches may include much background work of
> different people.:) 

I sometimes use Debugged-by: to attribute the sometimes significant work
of actually finding what's wrong.

