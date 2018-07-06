Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9FA21526
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmVWUA0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9FA21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934695AbeGFRzK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933947AbeGFRzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:55:08 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C969D2147E;
        Fri,  6 Jul 2018 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530899707;
        bh=43LPQ6VyymlzGAZjBycVpU1dLQhkwdKHyAKjdaixTNY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bmVWUA0MiaYwZqmAWz88KQLsib+CgAX4dFF/fPZHnujEFwmwVBRXRs2kemChRWjr0
         960NkSlIIZQxOxdWRnjT2tkVCdcnlnQDZWbheSDqPQhzWWykGs96hKWd1qx1/iFtD3
         Qdh9KZIPSqjsptaVxoaGfQNe0uf/6fWuIjLeZJdA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180628231540.26633-1-joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180628231540.26633-1-joel@jms.id.au>
Message-ID: <153089970720.143105.7005759760140367907@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: aspeed: Support HPLL strapping on ast2400
Date:   Fri, 06 Jul 2018 10:55:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2018-06-28 16:15:40)
> The HPLL can be configured through a register (SCU24), however some
> platforms chose to configure it through the strapping settings and do
> not use the register. This was not noticed as the logic for bit 18 in
> SCU24 was confused: set means programmed, but the driver read it as set
> means strapped.
> =

> This gives us the correct HPLL value on Palmetto systems, from which
> most of the peripheral clocks are generated.
> =

> Fixes: 5eda5d79e4be ("clk: Add clock driver for ASPEED BMC SoCs")
> Cc: stable@vger.kernel.org # v4.15
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Do you want this merged for -rc5? It sounds like on some systems this is
a problem, but I don't know if these systems are supposed to work yet or
not, so priority of this fix is not easy for me to understand.

