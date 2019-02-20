Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2242086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxp46Zhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfBTNYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:24:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTNYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4ocQSy5oqQzner+zXlaSW1R3YCqwknCWGq4qyHzoTQY=; b=uxp46Zhiz+FDkdnp21ZrObAvp
        XB0GkS1QxT9AatC9D8o0SoF8dy41QHV8uz1/xnoMSCVnC2ti8L5F+vJ78pheCwslpkUG1L4RQ6Qli
        Cf2raQthQ6Bq3AnDUregsi1OB8ExrcENZp5pTh0Yi9/9FOqoh9p5sCnAqOEPIVx5xvequ9KtAh6Ge
        ri7UKg1TzPv6F7DoUb81L/xYqmRSalEGAXE78QkjVHfddd/ObKs74cj/ejsROL/J4Jc+ScIux7JYA
        MoVO0I5RIakgIRwqTUxctvB7WTF371XWxAGJP112kP/cQHefI0f5mPL/9uND+U2UgQTRFY3Xfva86
        i24kh2/zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwRrE-0004Ft-Fo; Wed, 20 Feb 2019 13:24:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B84DC20094FD6; Wed, 20 Feb 2019 14:24:13 +0100 (CET)
Date:   Wed, 20 Feb 2019 14:24:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kan.liang@linux.intel.com, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH 00/10] perf: Multi-die/package support
Message-ID: <20190220132413.GH32494@hirez.programming.kicks-ass.net>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
 <20190220124619.GB25423@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220124619.GB25423@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 01:46:19PM +0100, Jiri Olsa wrote:
> On Tue, Feb 19, 2019 at 12:00:01PM -0800, kan.liang@linux.intel.com wrote:

> > The code bases on the top of Len's multi-die/package support.
> > https://lkml.org/lkml/2019/2/18/1534

> what is based on? I'm getting conflicts when applying
> on tip or Arnaldo's perf/core


