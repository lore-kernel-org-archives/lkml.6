Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77066C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D162145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D162145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeK3JdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:33:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36254 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeK3JdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:33:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C453C14F4528F;
        Thu, 29 Nov 2018 14:26:09 -0800 (PST)
Date:   Thu, 29 Nov 2018 14:26:09 -0800 (PST)
Message-Id: <20181129.142609.820562472340154653.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     andrew.hendry@gmail.com, stephen@networkplumber.org,
        joe@perches.com, anto.cardace@gmail.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net/x25: fix null_x25_address handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181127085029.9589-2-ms@dev.tdt.de>
References: <20181127085029.9589-1-ms@dev.tdt.de>
        <20181127085029.9589-2-ms@dev.tdt.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Nov 2018 14:26:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 27 Nov 2018 09:50:28 +0100

>  o x25_find_listener(): the compare for the null_x25_address was wrong.
>    We have to check the x25_addr of the listener socket instead of the
>    x25_addr of the incomming call.
> 
>  o x25_bind(): it was not possible to bind a socket to null_x25_address
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied.
