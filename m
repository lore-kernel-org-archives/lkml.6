Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2799120C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2799120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeGLC7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:59:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51930 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeGLC7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:59:33 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B1C731008D9A2;
        Wed, 11 Jul 2018 19:52:14 -0700 (PDT)
Date:   Wed, 11 Jul 2018 19:52:14 -0700 (PDT)
Message-Id: <20180711.195214.373420143941741317.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     boris.brezillon@bootlin.com, linux-ia64@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sparc64: add reads{b,w,l}/writes{b,w,l}
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180711120824.3882108-2-arnd@arndb.de>
References: <20180711120824.3882108-1-arnd@arndb.de>
        <20180711120824.3882108-2-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Jul 2018 19:52:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Jul 2018 14:08:06 +0200

> Some drivers need these for compile-testing. On most architectures
> they come from asm-generic/io.h, but not on sparc64, which has its
> own definitions.
> 
> Since we already have ioread*_rep()/iowrite*_rep() that have the
> same behavior on sparc64 (i.e. all PCI I/O space is memory mapped),
> we can rename the existing helpers and add macros to define them
> to the same implementation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
