Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828E2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F6B20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfA2RlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:41:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33126 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2RlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:41:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1DAC414F14B77;
        Tue, 29 Jan 2019 09:41:24 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:41:23 -0800 (PST)
Message-Id: <20190129.094123.395728867400146205.davem@davemloft.net>
To:     harini.katakam@xilinx.com
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        brandon.streiff@ni.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com
Subject: Re: [PATCH v2] net: macb: Apply RXUBR workaround only to versions
 with errata
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1548755403-361-1-git-send-email-harini.katakam@xilinx.com>
References: <1548755403-361-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Jan 2019 09:41:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>
Date: Tue, 29 Jan 2019 15:20:03 +0530

> The interrupt handler contains a workaround for RX hang applicable
> to Zynq and AT91RM9200 only. Subsequent versions do not need this
> workaround. This workaround unnecessarily resets RX whenever RX used
> bit read is observed, which can be often under heavy traffic. There
> is no other action performed on RX UBR interrupt. Hence introduce a
> CAPS mask; enable this interrupt and workaround only on affected
> versions.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>

Applied, thank you.
