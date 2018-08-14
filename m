Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AC2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222AF2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222AF2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeHNGcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:32:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeHNGb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:31:59 -0400
Received: from localhost (unknown [172.58.41.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 558E31217A103;
        Mon, 13 Aug 2018 20:46:46 -0700 (PDT)
Date:   Mon, 13 Aug 2018 20:46:45 -0700 (PDT)
Message-Id: <20180813.204645.1525930340958396833.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: mark PM functions as __maybe_unused
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813215046.3663828-1-arnd@arndb.de>
References: <20180813215046.3663828-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 20:46:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Aug 2018 23:50:41 +0200

> The newly added suspend/resume functions cause a build warning
> when CONFIG_PM is disabled:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:324:12: error: 'stmmac_pci_resume' defined but not used [-Werror=unused-function]
> drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:306:12: error: 'stmmac_pci_suspend' defined but not used [-Werror=unused-function]
> 
> Mark them as __maybe_unused so gcc can drop them silently.
> 
> Fixes: b7d0f08e9129 ("net: stmmac: Fix WoL for PCI-based setups")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
