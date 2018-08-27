Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303BBC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2095208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TsgX4KbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2095208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeH0LiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:38:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH0LiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=scKW0pvD6ySwQo06heKJnd8A3zFX67evTMYdbm/uWds=; b=TsgX4KbEckS2CKAt+VLmVOvap
        aULIG5TGcsBzSgbdGHV7Lib565AgUGr2RaLy6itkQDouxQqwO62zp5fN5aJGYiKG6fI2Uu8sJxnJ9
        fP64HmoVdJGZrroDwMVe7khlNAyoPm0ErbxU8cDFvukY3VZNjxzZnEP1KRkN6ElMQzKUi/9bIA7Oa
        Jlx5ug14fLZnjZp6Gs/yCOvgoAYTdkb4F9sJLSeNOki3DDkFNMScjjTJFLfCXt8im3Pn1/DJ/UQ+p
        8LuXb9U1EuSDvvEFFhRcQWWZkV3Hjf2QZ4FiLh0wLb/ZJn0yaN+EBBSp45FCvkFO6Vx51BFZ6S3ri
        a/8IWjjzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuCKO-0005Wt-7z; Mon, 27 Aug 2018 07:52:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C54F2024EFCD; Mon, 27 Aug 2018 09:52:46 +0200 (CEST)
Date:   Mon, 27 Aug 2018 09:52:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [perf] perf_event.h ABI visibility question
Message-ID: <20180827075246.GX24124@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1808231401440.28868@macbook-air>
 <20180824085042.GL24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1808241706120.12717@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808241706120.12717@macbook-air>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 05:09:27PM -0400, Vince Weaver wrote:
> On Fri, 24 Aug 2018, Peter Zijlstra wrote:
> 
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> > >         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
> > >  
> > >         PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> > > +
> > > +       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63,
> > >  };
> > > 
> > 
> > Hurphm.. visible yes, but as you say, also quite useless. Does it really
> > make sense to document that?
> 
> Well, it should probably be documented either in the manpage or else in 
> perf_event.h  (even if it's just "internal use, don't use") as we can't 
> really expect people to download a git tree and do a git-blame to try to 
> figure out what this mysterious field is all about.


Something like so then?

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index eeb787b1c53c..f35eb72739c0 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -144,7 +144,7 @@ enum perf_event_sample_format {
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
 
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 /*

> Also, this change increased the size of the enum from 32 to 64 bits on 
> 32-bit machines, though that only really matters if the user is doing 
> something really weird with enum variables.

Yeah, since the target variable is a u64 I really can't be bothered with
that.
