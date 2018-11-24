Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5CEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963A720868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963A720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeKXRLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 12:11:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42682 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeKXRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 12:11:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 257F214E03FEC;
        Fri, 23 Nov 2018 22:23:56 -0800 (PST)
Date:   Fri, 23 Nov 2018 22:23:51 -0800 (PST)
Message-Id: <20181123.222351.996887956213237908.davem@davemloft.net>
To:     Alexander.Onnasch@landisgyr.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] phy: Micrel KSZ8061: link failure after cable
 connect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542965762-26822-1-git-send-email-alexander.onnasch@landisgyr.com>
References: <1542965762-26822-1-git-send-email-alexander.onnasch@landisgyr.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 22:23:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
Date: Fri, 23 Nov 2018 09:36:11 +0000

> With Micrel KSZ8061 PHY, the link may occasionally not come up after
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
> sheet 80000688A.pdf describes the problem and possible workarounds in
> detail, see below.
> The patch implements workaround 1, which permanently fixes the issue.
 ...
> Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Something is off with your character encodings or something like that.

When I download your patch from patchwork, I see every line end with
a ^M control character.  See for yourself:

	https://patchwork.ozlabs.org/patch/1002221/mbox/

You'll need to fix this before I can apply your patch.
