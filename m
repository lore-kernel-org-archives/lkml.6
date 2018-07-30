Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A0216256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB6C205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB6C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeG3SQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:16:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32900 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeG3SQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:16:56 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DCAA121068D4;
        Mon, 30 Jul 2018 09:41:06 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:41:05 -0700 (PDT)
Message-Id: <20180730.094105.276965999059841658.davem@davemloft.net>
To:     xiliang@redhat.com
Cc:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-netfront: wait xenbus state change when load
 module manually
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727095608.25210-1-xiliang@redhat.com>
References: <20180727095608.25210-1-xiliang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 09:41:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiao Liang <xiliang@redhat.com>
Date: Fri, 27 Jul 2018 17:56:08 +0800

> When loading module manually, after call xenbus_switch_state to initializes
> the state of the netfront device, the driver state did not change so fast
> that may lead no dev created in latest kernel. This patch adds wait to make
> sure xenbus knows the driver is not in closed/unknown state.
 ...
> Signed-off-by: Xiao Liang <xiliang@redhat.com>

Applied and queued up for -stable, thanks.
