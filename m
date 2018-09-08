Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C47C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CA020844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CA020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeIHKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 06:40:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57286 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 06:40:53 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7F9D010082598;
        Fri,  7 Sep 2018 22:56:22 -0700 (PDT)
Date:   Fri, 07 Sep 2018 22:56:18 -0700 (PDT)
Message-Id: <20180907.225618.1479462649726004474.davem@davemloft.net>
To:     hangdianqj@163.com
Cc:     jakub.kicinski@netronome.com, dirk.vandermerwe@netronome.com,
        daniel@iogearbox.net, quentin.monnet@netronome.com,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: replace spin_lock_bh with spin_lock in tasklet
 callback
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180907170109.48150-1-hangdianqj@163.com>
References: <20180907170109.48150-1-hangdianqj@163.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Sep 2018 22:56:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <hangdianqj@163.com>
Date: Fri,  7 Sep 2018 10:01:09 -0700

> As you are already in a tasklet, it is unnecessary to call spin_lock_bh.
> 
> Signed-off-by: jun qian <hangdianqj@163.com>

Applied to net-next, thanks.
