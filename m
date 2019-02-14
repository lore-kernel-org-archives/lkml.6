Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABA21B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503383AbfBNV4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:56:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60534 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440308AbfBNV4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:56:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EA76A14D92FE6;
        Thu, 14 Feb 2019 13:56:17 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:56:14 -0800 (PST)
Message-Id: <20190214.135614.1795866372655163721.davem@davemloft.net>
To:     thor.thayer@linux.intel.com
Cc:     lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com, olof@lixom.net,
        mcoquelin.stm32@gmail.com, mchehab+samsung@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCHv4 5/6] net: stmmac: socfpga: Use shared System Manager
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1550177058-1860-6-git-send-email-thor.thayer@linux.intel.com>
References: <1550177058-1860-1-git-send-email-thor.thayer@linux.intel.com>
        <1550177058-1860-6-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 13:56:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: thor.thayer@linux.intel.com
Date: Thu, 14 Feb 2019 14:44:17 -0600

> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The ARM64 System Manager requires a different method of reading
> the System Manager than ARM32. A new System Manager driver was
> created to steer ARM32 System Manager calls to regmap_mmio and
> ARM64 System Manager calls to the new access method.
> 
> Convert from syscon to the shared System Manager driver so that
> both ARM64 and ARM32 are supported.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
