Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BF32075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BF32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeGRXEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:04:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44840 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRXEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:04:22 -0400
Received: from localhost (50-234-71-226-static.hfc.comcastbusiness.net [50.234.71.226])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7602B147A413D;
        Wed, 18 Jul 2018 15:24:23 -0700 (PDT)
Date:   Thu, 19 Jul 2018 07:24:23 +0900 (KST)
Message-Id: <20180719.072423.733195459839902101.davem@davemloft.net>
To:     haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc:     netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, stephen@networkplumber.org
Subject: Re: [PATCH net,v2] hv_netvsc: Fix napi reschedule while receive
 completion is busy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180717171113.6390-1-haiyangz@linuxonhyperv.com>
References: <20180717171113.6390-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 15:24:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Tue, 17 Jul 2018 17:11:13 +0000

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> If out ring is full temporarily and receive completion cannot go out,
> we may still need to reschedule napi if certain conditions are met.
> Otherwise the napi poll might be stopped forever, and cause network
> disconnect.
> 
> Fixes: 7426b1a51803 ("netvsc: optimize receive completions")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied and queued up for -stable.
