Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BECC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC21820846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC21820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbeFUGBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:01:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49908 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeFUGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:01:44 -0400
Received: from localhost (unknown [112.167.33.120])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 402531469D448;
        Wed, 20 Jun 2018 23:01:43 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:01:40 +0900 (KST)
Message-Id: <20180621.150140.1170551679722502944.davem@davemloft.net>
To:     harini.katakam@xilinx.com
Cc:     nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com
Subject: Re: [PATCH] net: macb: Fix ptp time adjustment for large negative
 delta
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1529494460-4689-1-git-send-email-harini.katakam@xilinx.com>
References: <1529494460-4689-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Jun 2018 23:01:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>
Date: Wed, 20 Jun 2018 17:04:20 +0530

> When delta passed to gem_ptp_adjtime is negative, the sign is
> maintained in the ns_to_timespec64 conversion. Hence timespec_add
> should be used directly. timespec_sub will just subtract the negative
> value thus increasing the time difference.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>

Applied and queued up for -stable.
