Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DAAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5CF208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CcRwaZxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5CF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeKHUln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:41:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeKHUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yQN16AXpg2b9lL0N1lNJmpMMdXV/0a0CIBZK3dVsC6A=; b=CcRwaZxFym7E3FjbedCQFHgHAd
        oqli4lD2dbKHlPob4aESEs4Hbemg24orKQMYZjnSRjctF1fUALm5CkqfChIxEPKA0iytn6VXXkscD
        rVP9WGEAYrZ7NnZeYk3TPSZw51gWjyo0W8688qEHoZt1WZ1OChJCUuD7IILVe7Jf3nMjhZuQ2iJBd
        Xe288UWxi/hpsjmXTt7WmcbW1BC5uD0/lwnpSxrzoJIQSFcetmoBbLgB+4MvNFNVGTmfu054RTOkH
        6G3UZdME/0jA1EwO/7ZmD9/Qr93uTBNeuWQPYgNHYuatqwjVWtbXITOQn4lsS+Eo144RzZregh8hA
        wpUdkb/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKhh3-0005ZT-MJ; Thu, 08 Nov 2018 10:37:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2B832029F881; Thu,  8 Nov 2018 11:37:43 +0100 (CET)
Date:   Thu, 8 Nov 2018 11:37:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] sched/fair: make some function static
Message-ID: <20181108103743.GQ9761@hirez.programming.kicks-ass.net>
References: <1541656452-3326-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1541656452-3326-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:54:12PM +0800, Yi Wang wrote:
> Make some function static as they are not used outside of fair.c.
> 
> This fixes the following warning when building with 'W=1':
> 
> kernel/sched/fair.c:2439:6: warning: no previous prototype for ‘task_numa_work’ [-Wmissing-prototypes]
> kernel/sched/fair.c:2584:6: warning: no previous prototype for ‘task_tick_numa’ [-Wmissing-prototypes]
> kernel/sched/fair.c:3548:6: warning: no previous prototype for ‘sync_entity_load_avg’ [-Wmissing-prototypes]
> kernel/sched/fair.c:3561:6: warning: no previous prototype for ‘remove_entity_load_avg’ [-Wmissing-prototypes]
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

I'm not sure why; but when I apply I get:

$ quilt push
Applying patch patches/yi_wang-sched_fair-make_some_function_static.patch
patching file kernel/sched/fair.c
Hunk #1 FAILED at 2436.
Hunk #2 FAILED at 2581.
Hunk #3 FAILED at 3545.
Hunk #4 FAILED at 3558.
4 out of 4 hunks FAILED -- rejects in file kernel/sched/fair.c
Patch patches/yi_wang-sched_fair-make_some_function_static.patch does not apply (enforce with -f)D
