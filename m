Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B86C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D760F217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D760F217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeHUUhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:03 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35480 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeHUUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:01 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fsAG7-0007ER-9R; Tue, 21 Aug 2018 19:15:59 +0200
Message-ID: <1534871755.25523.32.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] workqueue lockdep limitations/bugs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Tue, 21 Aug 2018 19:15:55 +0200
In-Reply-To: <20180821160039.GO3978217@devbig004.ftw2.facebook.com> (sfid-20180821_180043_407003_1DE29E4C)
References: <20180821120317.4115-1-johannes@sipsolutions.net>
         <20180821160039.GO3978217@devbig004.ftw2.facebook.com>
         (sfid-20180821_180043_407003_1DE29E4C)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

> > Let's say we again have an ordered workqueue, and the following:
> > 
> > work1_function
> > {
> > 	mutex_lock(&mutex);
> > }
> 
> Regular mutexes complain when the locker isn't the unlocker already.
> Do we really care about this case?

Oh, sorry for the confusion. I was just eliding the - not very
interesting for this case - unlock. Really I should've typed up a
lock/unlock pair in all of the examples.

johannes
