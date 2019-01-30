Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489CCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E0821473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfA3Xvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:51:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54837 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA3Xvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:51:52 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id b487e0d7d9f64c44; Thu, 31 Jan 2019 00:51:49 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        thara.gopinath@linaro.org, linux@roeck-us.net,
        ulf.hansson@linaro.org
Subject: Re: [PATCH v7 0/3] Move pm_runtime accounted time to raw nsec
Date:   Thu, 31 Jan 2019 00:50:44 +0100
Message-ID: <2577730.BvIW2u5g9k@aspire.rjw.lan>
In-Reply-To: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
References: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 23, 2019 8:50:12 AM CET Vincent Guittot wrote:
> Move pm_runtime accounted time to raw nsec. The subject of the patchset
> has changed as 1st patch o the previous versions has been queued by
> Rafael.
> 
> Patch 1 set accounting_timestamp to 0 in pm_runtime_init and update it when enable.
> So we remove ordering constraint between timekeeping_init and pm_runtime_init
> 
> Patch 2 moves time accounting on raw ns. This patch initially used
> ktime instead of raw ns but it was easier to move i915 driver on raw ns
> than on ktime.
> 
> Change since v6:
> - move code that set accounting_timestamp in pm_runtime_enable
> 
> Changes since v5:
> - removed patches already queued.
> - set accounting_timestamp to 0 in pm_runtime_init and update it when enable
> 
> Changes since v4:
> -Update commit message
> 
> Changes since v3:
> - Rebase on v4.20-rc7 without patch that has been queued by Rafael
> - Simplify the new interface pm_runtime_suspended_time()
> 
> Changes since v2:
> - remove patch1 that has been queued by rafael
> - add new interface in pm_runtime to get accounted time
> - reorder patchset to prevent compilation error
> 
> Changes since v1:
> - updated commit message of patch 1
> - Added patches 2 & 3 to move runtime_pm accounting on raw ns
>   
> Thara Gopinath (1):
>   PM-runtime: Replace jiffies based accounting with ktime-based
>     accounting
> 
> Vincent Guittot (1):
>   PM-runtime: update accounting_timestamp only when enable
> 
>  drivers/base/power/runtime.c | 26 ++++++++++++++++----------
>  drivers/base/power/sysfs.c   | 11 ++++++++---
>  include/linux/pm.h           |  6 +++---
>  3 files changed, 27 insertions(+), 16 deletions(-)

Both patches applied, thanks!

