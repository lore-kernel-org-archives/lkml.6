Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7284EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC22206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfAJQoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:44:37 -0500
Received: from muru.com ([72.249.23.125]:33100 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfAJQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:44:35 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 23A7680E7;
        Thu, 10 Jan 2019 16:44:41 +0000 (UTC)
Date:   Thu, 10 Jan 2019 08:44:31 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, ladis@linux-mips.org
Subject: Re: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Message-ID: <20190110164431.GA5544@atomide.com>
References: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [190110 09:00]:
> Cast autosuspend_delay in u64 to make sure that the full computation of
> expires or slack will be done in u64, even on 32bits arch.
> Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
> is used when moving delay from msec to nsec
> 
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Change since v1:
> - add u64 cast for slack computation

Still works for me.

Thanks,

Tony
