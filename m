Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9835820823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0Ow7IRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfARIi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:38:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56878 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfARIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ty2rw2XR6+xHUz5qlzXdBSmbHEXkiCUzCis1eZQGRlM=; b=l0Ow7IRTABPaHGGxr3G2KBdH0
        x9MiV+er85mMgICbNJb2nHBRDeET06H167jAlPYkKhq6Vk5XX2Y+X6sZk/YEfsxsUMW0SZ9wzaIb+
        GrkkoFe81UgQyectU50QuQvgxhZDvjOUgNgCpVl44MK5JNoZ8HQvdt3NAYtJZMwZ6gd/oHWJpe3jR
        Tkfj2TfFEWYCA0+oSVwuTD0hZD804TNt9Zxakizqww/oyMkpiVkKTqHyJLrmZXhdtSwrCB7wXRLS7
        uHymJwVubtz3V+zcU9E6I2IjXq/SgjcKbEsTnRAhvIiI8gUSR+knnxweRTokN2bF8+JJEL2uCUdzE
        S2k6/wXHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkPf8-00017r-ST; Fri, 18 Jan 2019 08:38:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1574A202A6AFB; Fri, 18 Jan 2019 09:38:00 +0100 (CET)
Date:   Fri, 18 Jan 2019 09:38:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        David Ahern <dsahern@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190118083800.GJ10803@hirez.programming.kicks-ass.net>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-2-songliubraving@fb.com>
 <20190117125653.GF10486@hirez.programming.kicks-ass.net>
 <A411D89E-0B62-4DE7-9D70-CD57672FD20A@fb.com>
 <20190117145854.GD5823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117145854.GD5823@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:58:54AM -0300, Arnaldo Carvalho de Melo wrote:
> So, can you post one last set, this time with PeterZ's Acked-by,
> assuming you're sorting out the get_names() thing, and I can try merging
> this into my perf/core branch, then pushing it out to Ingo, my perf/core
> starts from tip/perf/urgent, so should be new enough.

Works for me; thanks Arnaldo!
