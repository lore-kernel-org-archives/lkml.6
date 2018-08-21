Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FFC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BCF217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BCF217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeHUSQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:16:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41520 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:16:20 -0400
Received: from [172.20.13.211] (unknown [94.75.125.194])
        by mail.holtmann.org (Postfix) with ESMTPSA id EDCD1CF355;
        Tue, 21 Aug 2018 17:02:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] bluetooth/{bnep,cmtp,hidp}: Remove unnecessary
 smp_mb__{before,after}_atomic
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
Date:   Tue, 21 Aug 2018 16:55:47 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>
Content-Transfer-Encoding: 7bit
Message-Id: <FA7B52C1-96F5-47E5-83EB-E2A2147490ED@holtmann.org>
References: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

> The barriers are unneeded; wait_woken() and woken_wake_function()
> already provide us with the required synchronization: remove them
> and document that we're relying on the (implicit) synchronization
> provided by wait_woken() and woken_wake_function().
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
> net/bluetooth/bnep/core.c |  7 ++++---
> net/bluetooth/cmtp/core.c | 14 ++++++++------
> net/bluetooth/hidp/core.c | 13 ++++++++-----
> 3 files changed, 20 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

