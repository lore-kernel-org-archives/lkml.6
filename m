Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877AAC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A44213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A44213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeJCPsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:48:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51575 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJCPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:48:47 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id b640457e59a45be6; Wed, 3 Oct 2018 11:01:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-pm@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the performance multiplier
Date:   Wed, 03 Oct 2018 10:58:16 +0200
Message-ID: <4200780.ZjVhNjpZ67@aspire.rjw.lan>
In-Reply-To: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 25, 2018 11:38:44 AM CEST Daniel Lezcano wrote:
> The function get_loadavg() returns almost always zero. To be more
> precise, statistically speaking for a total of 1023379 times passing
> to the function, the load is equal to zero 1020728 times, greater than
> 100, 610 times, the remaining is between 0 and 5.
> 
> I'm putting in question this metric. Is it worth to keep it?

The honest answer is that I'm not sure.

Using the CPU load for driving idle state selection is questionable in general
(there need not be any connection between the two in principle) and this
particular function is questionable either.  If it really makes no difference
in addition to that, then yes it would be good to get rid of it.

That said it looks like that may be quite workload-dependent, so maybe there
are workloads where it does make a difference?  Like networking or similar?

Thanks,
Rafael

