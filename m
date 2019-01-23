Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5622A21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPSmr92C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfAWVJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:09:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAWVJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PzEEtvq+ZFIfdohoCxqGSejXKNUndYefJYH09iMapkQ=; b=WPSmr92Ck9WtUCUTlRaOi2o8p
        fvF6N6VxA7TIQSdC7bssukEMNAvkCby4Uusq4sy3rKZYOhx06M1PI6YXpegoXv3rXPvYoJqja1nLc
        qX1xCnEAxiQp6fvbwxjgogBqTP0DBsUFlndLHgxHPYaaXW+ytZ+Cym+iNqKDhVGPQP0m8UAGvzk33
        QZoYkl4l4F3kjud+X2zmJDejvXOinV436PemqURZ+rN0X/hKvvZ2TzCMc4R5i3zIF341fdakfXp57
        gH1MTB86xBNhKMzJCRbdJdg4UVzSm+5RkjO+U2zAj/wq1FigN1hbyJyP3s13epVeyrhNdvaLyPQ4P
        KNje0EWrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmPlW-0000bJ-TY; Wed, 23 Jan 2019 21:08:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59C8520F51B1C; Wed, 23 Jan 2019 22:08:52 +0100 (CET)
Date:   Wed, 23 Jan 2019 22:08:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com
Subject: Re: [PATCH v2 0/7] perf: Communicate sink via event::attr:config2
Message-ID: <20190123210852.GA27931@hirez.programming.kicks-ass.net>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:11:37AM -0700, Mathieu Poirier wrote:

> Mathieu Poirier (7):
>   perf/aux: Make perf_event accessible to setup_aux()
>   coresight: perf: Add "sinks" group to PMU directory
>   coresight: Use event attributes for sink selection

Them looks good to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acme, since the majority is (4 of 7) is userspace patches, will you pick
them up once you deem that part good?

