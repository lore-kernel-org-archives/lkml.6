Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF2DC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5273A207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5273A207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJWKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:49:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39786 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:49:02 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 57E2C146BF274;
        Mon, 22 Oct 2018 19:27:48 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:27:47 -0700 (PDT)
Message-Id: <20181022.192747.1517598401629589272.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, kishon@ti.com,
        quentin.schulz@bootlin.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] phy: ocelot-serdes: fix out-of-bounds read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1539940387.git.gustavo@embeddedor.com>
References: <cover.1539940387.git.gustavo@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 19:27:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 19 Oct 2018 11:18:43 +0200

> This patchset aims to fix an out-of-bounds bug in
> the phy-ocelot-serdes driver.
> 
> Currently, there is an out-of-bounds read on array ctrl->phys,
> once variable i reaches the maximum array size of SERDES_MAX
> in the for loop.
> 
> Quentin Schulz pointed out that SERDES_MAX is a valid value to
> index ctrl->phys. So, I updated SERDES_MAX to be SERDES6G_MAX + 1
> in include/dt-bindings/phy/phy-ocelot-serdes.h.
> 
> Then I changed the condition in the for loop from
> i <= SERDES_MAX to i < SERDES_MAX in order to
> complete the fix.
> 
> The reason I'm sending this fix as series is because
> checkpatch reported an error when I first tried to
> integrate the whole solution into a singe patch. So,
> changes to dt-bindings should be sent as a separate
> patch.
> 
> Thanks!
> 
> Changes in v3:
>  - Post the series to netdev, so Dave can take it.
> 
> Changes in v2:
>  - Send the whole series to Kishon Vijay Abraham I, so it
>    can be taken into the PHY tree.
>  - Add Quentin's Reviewed-by to commit log in both patches.

Series applied.
