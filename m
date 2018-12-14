Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90533206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbeLNVfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:35:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbeLNVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:35:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E03414E088D1;
        Fri, 14 Dec 2018 13:35:47 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:35:46 -0800 (PST)
Message-Id: <20181214.133546.2181294450034085842.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     isubramanian@apm.com, kchudgar@apm.com, qnguyen@apm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: xgene: Remove unnecessary forward
 declarations
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181211042030.13712-1-natechancellor@gmail.com>
References: <20181211042030.13712-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 13:35:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 10 Dec 2018 21:20:30 -0700

> Clang warns:
> 
> drivers/net/ethernet/apm/xgene/xgene_enet_main.c:33:36: warning:
> tentative array definition assumed to have one element
> static const struct acpi_device_id xgene_enet_acpi_match[];
>                                    ^
> 1 warning generated.
> 
> Both xgene_enet_acpi_match and xgene_enet_of_match are defined before
> their uses at the bottom of the file so this is unnecessary. When
> CONFIG_ACPI is disabled, ACPI_PTR becomes NULL so xgene_enet_acpi_match
> doesn't need to be defined.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
