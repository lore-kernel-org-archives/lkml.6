Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0E45C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9127F208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9127F208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934075AbeFKREU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:04:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933584AbeFKREQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:04:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99AB31435;
        Mon, 11 Jun 2018 10:04:16 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50CB33F59D;
        Mon, 11 Jun 2018 10:04:15 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:04:14 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        <linux-perf-users@vger.kernel.org>, <brueckner@linux.vnet.ibm.com>,
        <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] perf tests: Add event parsing error handling to
 parse events test
Message-Id: <20180611120414.c128fc280e0fa827aff743a8@arm.com>
In-Reply-To: <20180611093422.1005-1-jolsa@kernel.org>
References: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
        <20180611093422.1005-1-jolsa@kernel.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 11:34:21 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Add missing error handling for parse_events calls in test_event
> function that led to following segfault on s390:

like I said, this happens on any $ARCH machine without intel_pt
hardware.

Other than that, for both 1 & 2 in this series:

[Reported-and-]Tested-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
