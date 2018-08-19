Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F337C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4232E20C0E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4232E20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeHSVKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:10:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33472 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeHSVKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:10:21 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9AEF61473A80D;
        Sun, 19 Aug 2018 10:58:03 -0700 (PDT)
Date:   Sun, 19 Aug 2018 10:58:02 -0700 (PDT)
Message-Id: <20180819.105802.703437731810737269.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180815175040.3736548-1-arnd@arndb.de>
References: <20180815175040.3736548-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Aug 2018 10:58:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Aug 2018 19:49:49 +0200

> timekeeping_clocktai64() has been renamed to ktime_get_clocktai_ts64()
> for consistency with the other ktime_get_* access functions.
> 
> Rename the new caller that has come up as well.
> 
> Question: this is the only ptp driver that sets the hardware time
> to the current system time in TAI. Why does it do that?
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Deciding whether PTP drivers should set the hardware time at boot
to the current system time is a separate discussion from using
the new name for the timekeeping_clocktai64() interface, I'm applying
this.

Thanks Arnd.
