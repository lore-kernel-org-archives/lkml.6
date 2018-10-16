Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79AAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4232147E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4232147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJPNUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:20:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43846 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeJPNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:20:52 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 00525120A8DE6;
        Mon, 15 Oct 2018 22:32:10 -0700 (PDT)
Date:   Mon, 15 Oct 2018 22:32:10 -0700 (PDT)
Message-Id: <20181015.223210.800610059472159197.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, yuehaibing@huawei.com, nmani@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-af: remove unused
 cgx_fwi_link_change
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181012195232.4024123-1-arnd@arndb.de>
References: <20181012195232.4024123-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 22:32:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Oct 2018 21:52:22 +0200

> The newly added driver causes a warning about a function that is
> not used anywhere:
> 
> drivers/net/ethernet/marvell/octeontx2/af/cgx.c:320:12: error: 'cgx_fwi_link_change' defined but not used [-Werror=unused-function]
> 
> Remove it for now, until a user gets added. If we want to use this
> function from another module, we also need a declaration in a header
> file, which is currently missing, so it would have to change anyway.
> 
> Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
