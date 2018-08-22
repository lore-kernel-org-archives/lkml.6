Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40561C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E782147A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E782147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeHVHZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:25:34 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44964 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHVHZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:25:33 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fsKLl-000146-Hg; Wed, 22 Aug 2018 06:02:29 +0200
Message-ID: <1534910543.25523.50.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        kernel-team@lge.com
Date:   Wed, 22 Aug 2018 06:02:23 +0200
In-Reply-To: <20180822024535.GA2414@X58A-UD3R>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
         <20180821120317.4115-2-johannes@sipsolutions.net>
         <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
         <1534871894.25523.34.camel@sipsolutions.net>
         <20180821172711.GR3978217@devbig004.ftw2.facebook.com>
         <1534872621.25523.39.camel@sipsolutions.net>
         <20180821175550.GS3978217@devbig004.ftw2.facebook.com>
         <1534879241.25523.44.camel@sipsolutions.net>
         <20180822024535.GA2414@X58A-UD3R>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 11:45 +0900, Byungchul Park wrote:

> That should've been adjusted as well when Ingo reverted Cross-release.

I can't really say.

> It would be much easier to add each pair, acquire/release, before
> wait_for_completion() in both flush_workqueue() and flush_work() than
> reverting the whole commit.

The commit doesn't do much more than this though.

> What's lacking is only lockdep annotations for wait_for_completion().

No, I disagree. Like I said before, we need the lockdep annotations on
the WQ even when we don't actually create/use the completion, so we can
catch issues even when they don't actually happen.

johannes
