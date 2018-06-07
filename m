Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id x9G8HwmUGVtUVwAAmS7hNA
	; Thu, 07 Jun 2018 20:26:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E700C6074D; Thu,  7 Jun 2018 20:26:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7AC2B605A2;
	Thu,  7 Jun 2018 20:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AC2B605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932655AbeFGU0O (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:26:14 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33962 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbeFGU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:26:13 -0400
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87C8B1087046C;
        Thu,  7 Jun 2018 13:26:11 -0700 (PDT)
Date: Thu, 07 Jun 2018 16:26:09 -0400 (EDT)
Message-Id: <20180607.162609.1307648495406963798.davem@davemloft.net>
To: yidren@microsoft.com, yidren@linuxonhyperv.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc: Add per-cpu ethtool stats for netvsc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180606222700.24732-1-yidren@linuxonhyperv.com>
References: <20180606222700.24732-1-yidren@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Jun 2018 13:26:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yidong Ren <yidren@linuxonhyperv.com>
Date: Wed,  6 Jun 2018 15:27:00 -0700

> From: Yidong Ren <yidren@microsoft.com>
> 
> This patch implements following ethtool stats fields for netvsc:
> cpu<n>_tx/rx_packets/bytes
> cpu<n>_vf_tx/rx_packets/bytes
> 
> Corresponding per-cpu counters exist in current code. Exposing these
> counters will help troubleshooting performance issues.
> 
> Signed-off-by: Yidong Ren <yidren@microsoft.com>

net-next is closed, please resubmit this new feature when it opens again,
also:

> +	// fetch percpu stats of vf

Please do not use c++ comments.
