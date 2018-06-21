Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B62C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52620874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeFUAy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:54:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeFUAyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:54:24 -0400
Received: from localhost (unknown [61.102.160.122])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 23A35147040AA;
        Wed, 20 Jun 2018 17:54:21 -0700 (PDT)
Date:   Thu, 21 Jun 2018 09:54:18 +0900 (KST)
Message-Id: <20180621.095418.39855891010040022.davem@davemloft.net>
To:     vakul.garg@nxp.com
Cc:     doronrk@fb.com, tom@quantonium.net, john.fastabend@gmail.com,
        davejwatson@fb.com, netdev@vger.kernel.org, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net][RESEND] strparser: Don't schedule in workqueue in
 paused state
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180620215949.32334-1-vakul.garg@nxp.com>
References: <20180620215949.32334-1-vakul.garg@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Jun 2018 17:54:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vakul Garg <vakul.garg@nxp.com>
Date: Thu, 21 Jun 2018 03:29:49 +0530

> In function strp_data_ready(), it is useless to call queue_work if
> the state of strparser is already paused. The state checking should
> be done before calling queue_work. The change reduces the context
> switches and improves the ktls-rx throughput by approx 20% (measured
> on cortex-a53 based platform).
> 
> Signed-off-by: Vakul Garg <vakul.garg@nxp.com>

Applied, thank you.
