Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D08DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2FE20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dtcGTzsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2FE20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeLFIJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:09:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbeLFIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JNEAmdDrNcWc/uAt+U0m6dMHO9FyfybsEeJj+/UVvsw=; b=dtcGTzsgDfoFfsS3A8faPr/7K
        c88rHbxnSS6PBql1fhqXo4iAXcQdFnnXHp+aFW+jAHom5uRcS6jJbU0bh3oN/prR29TlyrdbcSRf9
        ba2CYdut8vwA+pvqYCM/X5CriE8PgfvkXwXU6P6i7fd0Tcd6ugvg3UHHmuQ0dSkH9ddzACxhdJmxS
        pQu60feKY8QuSbsJjuRutKYuAG1PNZ3TwKvJHFOgNRUS78MxRoqF+qfYGAc7KJt4n/c2NX3gckGPd
        u8OH597pS6HlWjV0u8nM6khzxN4bA1iceizJ/Y6Qmuc9B3IOMs1EID0f/xK2Nwfy0+52RdIrXg80k
        Qw5DcvJbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUoie-0004f4-Pa; Thu, 06 Dec 2018 08:09:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87D852029F883; Thu,  6 Dec 2018 09:09:10 +0100 (CET)
Date:   Thu, 6 Dec 2018 09:09:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206080910.GD4234@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205160509.1168-2-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:05:02PM +0100, Jiri Olsa wrote:
> Adding support to specify 'block' bool in struct perf_event_attr

NAK for having _Bool in structures.
