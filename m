Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F80C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D04220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D04220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeG3VLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:11:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36074 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeG3VLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:11:24 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CE3A713FBDE97;
        Mon, 30 Jul 2018 12:34:54 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:34:53 -0700 (PDT)
Message-Id: <20180730.123453.209203416033226519.davem@davemloft.net>
To:     yidren@microsoft.com, yidren@linuxonhyperv.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhans@microsoft.com
Subject: Re: [PATCH v4 net-next] hv_netvsc: Add per-cpu ethtool stats for
 netvsc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180730170945.20517-1-yidren@linuxonhyperv.com>
References: <20180724012622.26873-1-yidren@linuxonhyperv.com>
        <20180730170945.20517-1-yidren@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 12:34:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yidong Ren <yidren@linuxonhyperv.com>
Date: Mon, 30 Jul 2018 17:09:45 +0000

> From: Yidong Ren <yidren@microsoft.com>
> 
> This patch implements following ethtool stats fields for netvsc:
> cpu<n>_tx/rx_packets/bytes
> cpu<n>_vf_tx/rx_packets/bytes
> 
> Corresponding per-cpu counters already exist in current code. Exposing
> these counters will help troubleshooting performance issues.
> 
> for_each_present_cpu() was used instead of for_each_possible_cpu().
> for_each_possible_cpu() would create very long and useless output.
> It is still being used for internal buffer, but not for ethtool
> output.
> 
> There could be an overflow if cpu was added between ethtool
> call netvsc_get_sset_count() and netvsc_get_ethtool_stats() and
> netvsc_get_strings(). (still safe if cpu was removed)
> ethtool makes these three function calls separately.
> As long as we use ethtool, I can't see any clean solution.
> 
> Currently and in foreseeable short term, Hyper-V doesn't support
> cpu hot-plug. Plus, ethtool is for admin use. Unlikely the admin
> would perform such combo operations.
> 
> Signed-off-by: Yidong Ren <yidren@microsoft.com>

Applied, thank you.
