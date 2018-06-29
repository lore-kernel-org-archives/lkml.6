Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB451C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F36C24529
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F36C24529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936845AbeF2QLg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:11:36 -0400
Received: from foss.arm.com ([217.140.101.70]:36644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934535AbeF2QLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:11:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB0718A;
        Fri, 29 Jun 2018 09:11:35 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CBB23F266;
        Fri, 29 Jun 2018 09:11:33 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:11:30 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Hendrik =?ISO-8859-1?Q?Br=FCckner?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
Message-Id: <20180629111130.fa4cc7d2bcd55e07a5298c1c@arm.com>
In-Reply-To: <20180629152155.GB3593@kernel.org>
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
        <20180620134622.GM20477@kernel.org>
        <20180620194546.364cc109430ac51c5a288739@arm.com>
        <20180621141915.GS20477@kernel.org>
        <20180621151800.GU20477@kernel.org>
        <20180621153250.e29e7fbfbfe14b98341b68f0@arm.com>
        <20180629152155.GB3593@kernel.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 12:21:55 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Jun 21, 2018 at 03:32:50PM -0500, Kim Phillips escreveu:
> > On Thu, 21 Jun 2018 12:18:00 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Would be good if we had some utility that given a two files, one with
> > > regexps, could tell if, line by line, those expressions matched, better,
> > > one that is present in all these OSes...
> > 
> > I didn't find any, but given the two-file notion might be acceptable,
> > hopefully you might find the following more readable/acceptable?:
> 
> Looks better, you build the expected lines in a separate file, then read
> both it and the output, then do the matching, cleaner. And I assume it
> works with dash, right?

Yes, of course :)

I'll re-send via a new v2 series as 1/2 wasn't git-am friendly, and
I've uncovered another minor bashism.

Kim
