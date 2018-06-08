Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 42zqBWWYGltJLAAAmS7hNA
	; Fri, 08 Jun 2018 14:53:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 02486608B8; Fri,  8 Jun 2018 14:53:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 657EC601D2;
	Fri,  8 Jun 2018 14:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 657EC601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeFHOxX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:53:23 -0400
Received: from foss.arm.com ([217.140.101.70]:34734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeFHOxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:53:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE6241435;
        Fri,  8 Jun 2018 07:53:19 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64A823F5A0;
        Fri,  8 Jun 2018 07:53:19 -0700 (PDT)
Date: Fri, 8 Jun 2018 09:53:18 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <brueckner@linux.vnet.ibm.com>,
        <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] perf test: Test 6 dumps core on s390
Message-Id: <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
In-Reply-To: <20180608131728.75084-1-tmricht@linux.ibm.com>
References: <20180608131728.75084-1-tmricht@linux.ibm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018 15:17:28 +0200
Thomas Richter <tmricht@linux.ibm.com> wrote:

> Perf test case 6 "Parse event definition strings"
> dumps core when executed on s390.

I reported it actually fails on any $ARCH system without
Intel Processor Trace (PT) h/w:

https://www.spinics.net/lists/linux-perf-users/msg06020.html

There was a follow-up patch sent here:

https://www.spinics.net/lists/linux-perf-users/msg06029.html

which worked for me, but I don't know what has/has-not transpired
since, other than it is still broken, as you found.

Kim
