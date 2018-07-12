Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B319FECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696402087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696402087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeGLV72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:59:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeGLV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:59:27 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 35AEA1420D3B8;
        Thu, 12 Jul 2018 14:47:59 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:47:58 -0700 (PDT)
Message-Id: <20180712.144758.1033301223663799674.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: systemport: Fix CRC forwarding check for
 SYSTEMPORT Lite
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180711094758.1670-1-f.fainelli@gmail.com>
References: <20180711094758.1670-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Jul 2018 14:47:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 11 Jul 2018 02:47:58 -0700

> SYSTEMPORT Lite reversed the logic compared to SYSTEMPORT, the
> GIB_FCS_STRIP bit is set when the Ethernet FCS is stripped, and that bit
> is not set by default. Fix the logic such that we properly check whether
> that bit is set or not and we don't forward an extra 4 bytes to the
> network stack.
> 
> Fixes: 44a4524c54af ("net: systemport: Add support for SYSTEMPORT Lite")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
