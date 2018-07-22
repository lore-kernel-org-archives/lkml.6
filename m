Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C386C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C910120850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C910120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbeGVWiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:38:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60276 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbeGVWiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:38:06 -0400
Received: from localhost (unknown [172.58.43.132])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3C9410949650;
        Sun, 22 Jul 2018 14:40:00 -0700 (PDT)
Date:   Sun, 22 Jul 2018 14:39:56 -0700 (PDT)
Message-Id: <20180722.143956.903331235259719609.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers3@gmail.com
Subject: Re: [PATCH v2] net: ethernet: freescale: Use generic CRC32
 implementation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180722142636.31525-1-krzk@kernel.org>
References: <20180722142636.31525-1-krzk@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 22 Jul 2018 14:40:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 22 Jul 2018 16:26:36 +0200

> +		crc = crc32_le(~0, ha->addr, ndev->addr_len);

This is "ether_crc_le(ha->addr, ndev->addr_len)" :-)

Please use it, thanks!

