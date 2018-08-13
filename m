Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E8BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB99D2189A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB99D2189A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeHMTbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:31:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:31:07 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BD94A145A9B36;
        Mon, 13 Aug 2018 09:48:06 -0700 (PDT)
Date:   Mon, 13 Aug 2018 09:48:06 -0700 (PDT)
Message-Id: <20180813.094806.2117966073798365808.davem@davemloft.net>
To:     joyce.ooi@intel.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hean.loong.ong@intel.com,
        yves.vandervennet@intel.com
Subject: Re: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534142494-11541-1-git-send-email-joyce.ooi@intel.com>
References: <1534142494-11541-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 09:48:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ooi, Joyce" <joyce.ooi@intel.com>
Date: Sun, 12 Aug 2018 23:41:34 -0700

> As there is restriction to access to EMAC System Manager registers in
> the kernel for Intel Stratix10, the use of SMC calls are required and
> added in dwmac-socfpga driver.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
> This patch is dependent on https://lkml.org/lkml/2018/7/26/624

I guess I cannot apply this to my networking tree then.

I would suggest that you make a helper in a header file which dos the
special SMC EMAC accesses, or alternatively the regular regmap access,
based upon the CPP ifdef.

That way you won't have to put all of those CPP tests in the foo.c
code.

Thanks.
