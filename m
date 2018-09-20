Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB11021522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB11021522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbeIUDuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:50:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55787 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeIUDut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:50:49 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 137C98075A; Fri, 21 Sep 2018 00:05:11 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:05:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>
Subject: Re: [PATCH 02/12][RFC v3] PM / hibernate: Check the success of
 generating md5 digest before hibernation
Message-ID: <20180920220510.GE27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <f50baa939e550d4c6e09fd15ed2c0ddb0b23b023.1537275915.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f50baa939e550d4c6e09fd15ed2c0ddb0b23b023.1537275915.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-19 15:38:17, Chen Yu wrote:
> Currently if get_e820_md5() fails, then it will hibernate nevertheless.
> Actually the error code should be propagated to upper caller so that
> the hibernation could be aware of the result and terminates the process
> if md5 digest fails.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/x86/power/hibernate_64.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
