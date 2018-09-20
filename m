Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C020C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA0F21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA0F21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbeIUDve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:51:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55828 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbeIUDvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:51:33 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 22EE080749; Fri, 21 Sep 2018 00:05:54 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:05:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>
Subject: Re: [PATCH 10/12][RFC v3] x86-32, hibernate: Switch to relocated
 restore code during resume on 32bit system
Message-ID: <20180920220553.GL27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <7a562ef6f77ff83c1fbdc6a2ecc7af387ce1fd71.1537275915.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a562ef6f77ff83c1fbdc6a2ecc7af387ce1fd71.1537275915.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-19 15:43:12, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> Code should be executed in a safe page during page
> restoring, as the page where instruction is running
> during resume might be scribbled and causes issues.
> 
> Backport the code from 64 bit system to fix this bug.

On 32 bit, we only suspend resuming by same kernel that did the suspend.

64 bit does not have that restriction. So 32 bit code should not be actually
bugy.

> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

But we'd like to remove that restriction in future, so:

Acked-by: Pavel Machek <pavel@ucw.cz>

