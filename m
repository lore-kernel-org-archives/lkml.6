Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D0DC6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696824037
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0696824037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeGFCwV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:52:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45082 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753757AbeGFCwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:52:19 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 40412108C968F;
        Thu,  5 Jul 2018 19:52:17 -0700 (PDT)
Date:   Fri, 06 Jul 2018 11:52:13 +0900 (KST)
Message-Id: <20180706.115213.1244805309957477961.davem@davemloft.net>
To:     tyhicks@canonical.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        ebiederm@xmission.com, segoon@openwall.com, netdev@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: Return EINVAL when ping_group_range sysctl
 doesn't map to user ns
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530816563-4478-1-git-send-email-tyhicks@canonical.com>
References: <1530816563-4478-1-git-send-email-tyhicks@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Jul 2018 19:52:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@canonical.com>
Date: Thu,  5 Jul 2018 18:49:23 +0000

> The low and high values of the net.ipv4.ping_group_range sysctl were
> being silently forced to the default disabled state when a write to the
> sysctl contained GIDs that didn't map to the associated user namespace.
> Confusingly, the sysctl's write operation would return success and then
> a subsequent read of the sysctl would indicate that the low and high
> values are the overflowgid.
> 
> This patch changes the behavior by clearly returning an error when the
> sysctl write operation receives a GID range that doesn't map to the
> associated user namespace. In such a situation, the previous value of
> the sysctl is preserved and that range will be returned in a subsequent
> read of the sysctl.
> 
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>

Looks good to me, applied and queued up for -stable.

Thanks.
