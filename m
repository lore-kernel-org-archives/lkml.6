Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C061C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A958F20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A958F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeIHKsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 06:48:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeIHKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 06:48:21 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7F2821007FBED;
        Fri,  7 Sep 2018 23:03:49 -0700 (PDT)
Date:   Fri, 07 Sep 2018 23:03:48 -0700 (PDT)
Message-Id: <20180907.230348.33221589667753465.davem@davemloft.net>
To:     jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org, boris.ostrovsky@oracle.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] xen/netfront: fix waiting for xenbus state change
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180907122130.30810-1-jgross@suse.com>
References: <20180907122130.30810-1-jgross@suse.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Sep 2018 23:03:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>
Date: Fri,  7 Sep 2018 14:21:30 +0200

> Commit 822fb18a82aba ("xen-netfront: wait xenbus state change when load
> module manually") added a new wait queue to wait on for a state change
> when the module is loaded manually. Unfortunately there is no wakeup
> anywhere to stop that waiting.
> 
> Instead of introducing a new wait queue rename the existing
> module_unload_q to module_wq and use it for both purposes (loading and
> unloading).
> 
> As any state change of the backend might be intended to stop waiting
> do the wake_up_all() in any case when netback_changed() is called.
> 
> Fixes: 822fb18a82aba ("xen-netfront: wait xenbus state change when load module manually")
> Cc: <stable@vger.kernel.org> #4.18
> Signed-off-by: Juergen Gross <jgross@suse.com>

Applied.
