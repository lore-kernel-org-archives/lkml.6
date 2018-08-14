Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A8FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3872E21747
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3872E21747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeHNGcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:32:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38206 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeHNGcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:32:06 -0400
Received: from localhost (unknown [172.58.41.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6A7DD12175DC9;
        Mon, 13 Aug 2018 20:46:52 -0700 (PDT)
Date:   Mon, 13 Aug 2018 20:46:51 -0700 (PDT)
Message-Id: <20180813.204651.82890800816549610.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     f.fainelli@gmail.com, talgi@mellanox.com,
        alexander.h.duyck@intel.com, jeffrey.t.kirsher@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: systemport: fix unused function warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813221041.219857-1-arnd@arndb.de>
References: <20180813221041.219857-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 20:46:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Aug 2018 00:10:34 +0200

> The only remaining caller of this function is inside of an #ifdef
> after another caller got removed. This causes a harmless warning
> in some configurations:
> 
> drivers/net/ethernet/broadcom/bcmsysport.c:1068:13: error: 'bcm_sysport_resume_from_wol' defined but not used [-Werror=unused-function]
> 
> Removing the #ifdef around the PM functions simplifies the code
> and avoids the problem but letting the compiler drop the unused
> functions silently.
> 
> Fixes: 9e85e22713d6 ("net: systemport: Do not re-configure upon WoL interrupt")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
