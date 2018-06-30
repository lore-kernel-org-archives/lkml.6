Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99300C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5281825871
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5281825871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030454AbeF3M3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 08:29:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38300 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030246AbeF3M3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 08:29:34 -0400
Received: from localhost (unknown [183.108.164.149])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3A56414240485;
        Sat, 30 Jun 2018 05:29:32 -0700 (PDT)
Date:   Sat, 30 Jun 2018 21:29:30 +0900 (KST)
Message-Id: <20180630.212930.58049848439397621.davem@davemloft.net>
To:     haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc:     netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: split sub-channel setup into async and
 sync
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180629210716.6798-1-haiyangz@linuxonhyperv.com>
References: <20180629210716.6798-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 30 Jun 2018 05:29:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Fri, 29 Jun 2018 14:07:16 -0700

> From: Stephen Hemminger <sthemmin@microsoft.com>
> 
> When doing device hotplug the sub channel must be async to avoid
> deadlock issues because device is discovered in softirq context.
> 
> When doing changes to MTU and number of channels, the setup
> must be synchronous to avoid races such as when MTU and device
> settings are done in a single ip command.
> 
> Reported-by: Thomas Walker <Thomas.Walker@twosigma.com>
> Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
> Fixes: 732e49850c5e ("netvsc: fix race on sub channel creation")
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied and queued up for -stable.
