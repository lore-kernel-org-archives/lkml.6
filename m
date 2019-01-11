Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E747C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8C2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfAKKkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:40:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43156 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbfAKKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:40:23 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 8e17ad8caeb986e5; Fri, 11 Jan 2019 11:40:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tony Lindgren <tony@atomide.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        ulf.hansson@linaro.org, ladis@linux-mips.org
Subject: Re: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Date:   Fri, 11 Jan 2019 11:39:34 +0100
Message-ID: <6922521.G0BVNVQKqm@aspire.rjw.lan>
In-Reply-To: <20190110164431.GA5544@atomide.com>
References: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org> <20190110164431.GA5544@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 10, 2019 5:44:31 PM CET Tony Lindgren wrote:
> * Vincent Guittot <vincent.guittot@linaro.org> [190110 09:00]:
> > Cast autosuspend_delay in u64 to make sure that the full computation of
> > expires or slack will be done in u64, even on 32bits arch.
> > Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
> > is used when moving delay from msec to nsec
> > 
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > 
> > Change since v1:
> > - add u64 cast for slack computation
> 
> Still works for me.

Applied, thanks!

