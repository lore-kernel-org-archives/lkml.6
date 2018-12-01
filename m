Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA5C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3044920867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3044920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLAMht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:37:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLAMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:37:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EADAE14F24070;
        Fri, 30 Nov 2018 17:26:32 -0800 (PST)
Date:   Fri, 30 Nov 2018 17:26:32 -0800 (PST)
Message-Id: <20181130.172632.2265989456941854215.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     dmitry.bezrukov@aquantia.com, igor.russkikh@aquantia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: aqc111: Initialize wol_cfg with memset in
 aqc111_suspend
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181129060104.13966-1-natechancellor@gmail.com>
References: <20181129051808.30015-1-natechancellor@gmail.com>
        <20181129060104.13966-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Nov 2018 17:26:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 28 Nov 2018 23:01:05 -0700

> Clang warns:
> 
> drivers/net/usb/aqc111.c:1326:37: warning: suggest braces around
> initialization of subobject [-Wmissing-braces]
>                 struct aqc111_wol_cfg wol_cfg = { 0 };
>                                                   ^
>                                                   {}
> 1 warning generated.
> 
> Use memset to initialize the object to take compiler instrumentation out
> of the equation.
> 
> Fixes: e58ba4544c77 ("net: usb: aqc111: Add support for wake on LAN by MAGIC packet")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
