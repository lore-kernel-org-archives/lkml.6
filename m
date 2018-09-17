Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF12AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85035214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85035214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeIQUZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:25:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45678 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeIQUZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:25:56 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C878E144A2347;
        Mon, 17 Sep 2018 07:58:13 -0700 (PDT)
Date:   Mon, 17 Sep 2018 07:58:13 -0700 (PDT)
Message-Id: <20180917.075813.1145409055019392182.davem@davemloft.net>
To:     nicolas.ferre@microchip.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, claudiu.beznea@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] net: macb: disable scatter-gather for macb on sama5d3
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180914154811.12090-1-nicolas.ferre@microchip.com>
References: <20180914154811.12090-1-nicolas.ferre@microchip.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 07:58:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Fri, 14 Sep 2018 17:48:10 +0200

> Create a new configuration for the sama5d3-macb new compatibility string.
> This configuration disables scatter-gather because we experienced lock down
> of the macb interface of this particular SoC under very high load.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied, but are you really sure it isn't just some bug in the driver
or somesuch?
