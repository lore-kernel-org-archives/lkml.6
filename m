Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D96EC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2F22083C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2F22083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbeHNGcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:32:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38218 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeHNGcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:32:12 -0400
Received: from localhost (unknown [172.58.41.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 748DB12175DC9;
        Mon, 13 Aug 2018 20:46:58 -0700 (PDT)
Date:   Mon, 13 Aug 2018 20:46:57 -0700 (PDT)
Message-Id: <20180813.204657.372870473276503588.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     michael.chan@broadcom.com, vasundhara-v.volam@broadcom.com,
        gospo@broadcom.com, scott.branden@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnxt_en: take coredump_record structure off stack
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813221256.299221-1-arnd@arndb.de>
References: <20180813221256.299221-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 20:46:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Aug 2018 00:12:45 +0200

> The bnxt_coredump_record structure is very long, causing a warning
> about possible stack overflow on 32-bit architectures:
> 
> drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c: In function 'bnxt_get_coredump':
> drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:2989:1: error: the frame size of 1188 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> I could not see any reason to operate on an on-stack copy of the
> structure before copying it back into the caller-provided buffer, which
> also simplifies the code here.
> 
> Fixes: 6c5657d085ae ("bnxt_en: Add support for ethtool get dump.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
