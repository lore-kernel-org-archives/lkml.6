Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730C520671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730C520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeJXC1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:27:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50930 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXC1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:27:32 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D88021472357E;
        Tue, 23 Oct 2018 11:03:05 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:03:05 -0700 (PDT)
Message-Id: <20181023.110305.461689764889182451.davem@davemloft.net>
To:     ivecera@redhat.com
Cc:     netdev@vger.kernel.org, sathya.perla@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "be2net: remove desc field from be_eq_obj"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181023144026.26180-1-ivecera@redhat.com>
References: <20181023144026.26180-1-ivecera@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Oct 2018 11:03:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Vecera <ivecera@redhat.com>
Date: Tue, 23 Oct 2018 16:40:26 +0200

> The mentioned commit needs to be reverted because we cannot pass
> string allocated on stack to request_irq(). This function stores
> uses this pointer for later use (e.g. /proc/interrupts) so we need
> to keep this string persistently.
> 
> Fixes: d6d9704af8f4 ("be2net: remove desc field from be_eq_obj")
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Please do not put empty lines between Fixes and the other tags,
all tags should appear together as one contiguous group.

Fixed and applied and queued up for -stable.
