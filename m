Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F19FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A5C26451
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A5C26451
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935182AbeFZCiE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:38:04 -0400
Received: from sauhun.de ([88.99.104.3]:48876 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934740AbeFZCiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:38:02 -0400
Received: from localhost (unknown [91.73.131.157])
        by pokefinder.org (Postfix) with ESMTPSA id DCFAC56A489;
        Tue, 26 Jun 2018 04:37:59 +0200 (CEST)
Date:   Tue, 26 Jun 2018 11:37:58 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Message-ID: <20180626023757.l54suaryim2fieq3@ninjato>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620085157.30121-2-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This is not perfectly equivalent, since i2c_smbus_xfer was callable from
> atomic/irq context if you happened to end up emulating SMBus with an I2C
> transfer, and that is no longer the case with this patch. It is unknown
> (to me) if anything depends on that quirk, but it seems fragile enough to
> simply break those cases and require them to call i2c_transfer directly
> instead.

Couldn't we just add the same trylock-code path here as well? I always
wondered why I2C and SMBus were not in sync when it came to that. Yet, I
didn't want to change the code for no reason, but it seems we now have
one?

Rest of the series looks good to me, very nice diffstat!

