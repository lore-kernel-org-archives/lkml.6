Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F72C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE48218A6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAGXih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:38:37 -0500
Received: from muru.com ([72.249.23.125]:60400 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGXih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:38:37 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DED4E813A;
        Mon,  7 Jan 2019 23:38:42 +0000 (UTC)
Date:   Mon, 7 Jan 2019 15:38:33 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190107233833.GI5544@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
over to using hrtimers") caused a regression on at least
omap5-uevm where 8250 UART rx wake no longer works. I have not
noticed this happening on others so far.

The devices I've tested all are using 8250 with dedicated
wakeirqs configured for the rx pin. I can see the interrupt
increase on omap5-uevm after some one or more keypresses,
but then nothing. It seems that the uart just falls back
asleep right away or something.

Any ideas what might be going wrong?

Regards,

Tony

