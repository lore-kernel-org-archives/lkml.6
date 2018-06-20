Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE24AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E9C208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E9C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbeFTFe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:34:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55414 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFTFez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:34:55 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C9BD414621558;
        Tue, 19 Jun 2018 22:34:53 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:34:52 +0900 (KST)
Message-Id: <20180620.143452.95470527735556806.davem@davemloft.net>
To:     dinguyen@kernel.org
Cc:     netdev@vger.kernel.org, joabreu@synopsys.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: socfpga: add additional ocp reset line
 for Stratix10
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1529422538-8447-1-git-send-email-dinguyen@kernel.org>
References: <1529422538-8447-1-git-send-email-dinguyen@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 22:34:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>
Date: Tue, 19 Jun 2018 10:35:38 -0500

> The Stratix10 platform has an additional reset line, OCP(Open Core Protocol),
> that also needs to get deasserted for the stmmac ethernet controller to work.
> Thus we need to update the Kconfig to include ARCH_STRATIX10 in order to build
> dwmac-socfpga.
> 
> Also, remove the redundant check for the reset controller pointer. The
> reset driver already checks for the pointer and returns 0 if the pointer
> is NULL.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Applied.
