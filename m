Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348D3C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0558A20848
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0558A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeKDLto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:49:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59960 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbeKDLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:49:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 252AB1438FFCC;
        Sat,  3 Nov 2018 19:27:57 -0700 (PDT)
Date:   Sat, 03 Nov 2018 19:27:53 -0700 (PDT)
Message-Id: <20181103.192753.1631072685342336213.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        sudarsana.kalluru@cavium.com, Tomer.Tayar@cavium.com,
        denis.bolotin@cavium.com, Rahul.Verma@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: fix link config error handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181102153632.1646632-1-arnd@arndb.de>
References: <20181102153632.1646632-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 03 Nov 2018 19:27:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri,  2 Nov 2018 16:36:24 +0100

> gcc-8 notices that qed_mcp_get_transceiver_data() may fail to
> return a result to the caller:
> 
> drivers/net/ethernet/qlogic/qed/qed_mcp.c: In function 'qed_mcp_trans_speed_mask':
> drivers/net/ethernet/qlogic/qed/qed_mcp.c:1955:2: error: 'transceiver_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> When an error is returned by qed_mcp_get_transceiver_data(), we
> should propagate that to the caller of qed_mcp_trans_speed_mask()
> rather than continuing with uninitialized data.
> 
> Fixes: c56a8be7e7aa ("qed: Add supported link and advertise link to display in ethtool.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
