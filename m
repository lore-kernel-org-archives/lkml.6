Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F11C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1E22BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMqpE8Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF1E22BD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934501AbeGFUsT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934035AbeGFUsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:48:15 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8A822BD2;
        Fri,  6 Jul 2018 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530910094;
        bh=2tksW7inlV/WQhrBUoHTNiUWg0SGpQE52+IclFWC5xU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=sMqpE8PxiBPtKLQun0XEKB6gsgwwmkiTclTI5YAgLd2sY129cQPIVliHFxGYa1mNz
         9KAlgbH2tIFKsHmsLrWrdyJ6E+/QVfn0nCTp4n0DmMDRsbdrJy4rezIgdJhPcMNlcw
         jtFwY/dkUyzOKSYijKFhMQXujm2rVJWQ1V9IAZGw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180607070959.31995-1-joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180607070959.31995-1-joel@jms.id.au>
Message-ID: <153091009365.143105.4953968802856253539@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical
Date:   Fri, 06 Jul 2018 13:48:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2018-06-07 00:09:59)
> This is used by the host to talk to the BMC's PCIe slave device. The BMC
> is not involved, but the clock needs to be enabled so the host can use
> the device.
> =

> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
> Cc: stable@vger.kernel.org # 4.15
> Acked-by: Andrew Jeffery <andrew@aj.id.au>
> Tested-by: Lei YU <mine260309@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-fixes

