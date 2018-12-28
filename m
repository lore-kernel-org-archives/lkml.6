Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E474DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE2C20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeL1A1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:27:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeL1A1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:27:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9FA7514E09831;
        Thu, 27 Dec 2018 16:27:12 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:27:12 -0800 (PST)
Message-Id: <20181227.162712.705546628469200285.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, ymarkman@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: marvell: fix a missing check of acpi_match_device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181226063117.75646-1-kjlu@umn.edu>
References: <20181226063117.75646-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:27:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Wed, 26 Dec 2018 00:31:08 -0600

> When acpi_match_device fails, its return value is NULL. Directly using
> the return value without a check may result in a NULL-pointer
> dereference. The fix checks if acpi_match_device fails, and if so,
> returns -EINVAL.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.
