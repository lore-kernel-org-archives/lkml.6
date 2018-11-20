Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F8BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF682080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF682080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbeKTNKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:10:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57084 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeKTNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:10:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B3B2014D706A9;
        Mon, 19 Nov 2018 18:43:43 -0800 (PST)
Date:   Mon, 19 Nov 2018 18:43:43 -0800 (PST)
Message-Id: <20181119.184343.1334940445389777881.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuehaibing@huawei.com
Subject: Re: [PATCH net-next v2 0/2] net: bcmgenet: fix aborted suspend
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542650162-9229-1-git-send-email-opendmb@gmail.com>
References: <1542650162-9229-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Nov 2018 18:43:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Mon, 19 Nov 2018 09:56:00 -0800

> It is not enough to return an error code from the driver suspend
> routine. The driver must also restore the device functionality.
> 
> This commit corrects the issue introduced by commit 0db55093b566 
> ("net: bcmgenet: return correct value 'ret' from bcmgenet_power_down")
> by calling the driver resume function if the suspend function returns
> an error.
> 
> Changes in v2:
> - Removed accidentally included write to HFB register

Doug, this doesn't apply cleanly to net-next.
