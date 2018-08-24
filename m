Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111D3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F852064A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F852064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHYBVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:21:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeHYBVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 313E880D;
        Fri, 24 Aug 2018 14:45:08 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4514D3F2EA;
        Fri, 24 Aug 2018 14:45:07 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:45:06 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        perf group <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf annotate: fix parsing aarch64 branch instructions
 after objdump update
Message-Id: <20180824164506.aa6e54bceb1ffb7b3dc70733@arm.com>
In-Reply-To: <18abf031-f803-b8e6-129e-ed50c63e73d0@linux.ibm.com>
References: <20180823191047.9260992844205984b75e6721@arm.com>
        <18abf031-f803-b8e6-129e-ed50c63e73d0@linux.ibm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 09:59:22 +0200
Thomas-Mich Richter <tmricht@linux.ibm.com> wrote:

> On 08/24/2018 02:10 AM, Kim Phillips wrote:
> > Tested no difference in output for sample x86_64, power arch perf.data files.
> 
> Tested,  no difference in output on s390. Just to let you know.

Thanks!  An official Tested-by: tag would help keep acme from guessing
whether he should convert these less-officially sounding types of
emails in the future.  I doubt your official Tested-by implies you
necessarily have had to claim you fully tested it on e.g., x86-64, esp.
if your Tested-by is in such context as provided above.

BTW, if you want to send me an s390 perf.data file and the file
resulting from 'perf archive', and a matching vmlinux in an off-list
email, I can add it to my perf-archives arsenal for future testing.

Again, thanks for testing!

Kim
