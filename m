Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF17DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D13C24A88
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D13C24A88
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934275AbeFWBed (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:34:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33970 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754134AbeFWBeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:34:31 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 11005119C195B;
        Fri, 22 Jun 2018 18:34:29 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:34:28 +0900 (KST)
Message-Id: <20180623.103428.364996260926164569.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Allow compile test of GPIO consumers if
 !GPIOLIB
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180621185800.17371-1-geert@linux-m68k.org>
References: <20180621185800.17371-1-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Jun 2018 18:34:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Jun 2018 20:58:00 +0200

> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
> 
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Applied to net-next, thank you.
