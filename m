Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46E821479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfBSWP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:15:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfBSWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:15:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D77ED1086DDEC;
        Tue, 19 Feb 2019 14:15:57 -0800 (PST)
Date:   Tue, 19 Feb 2019 14:15:57 -0800 (PST)
Message-Id: <20190219.141557.284906726764572414.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     yangbo.lu@nxp.com, claudiu.manoil@nxp.com,
        richardcochran@gmail.com, leoyang.li@nxp.com,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ptp_qoriq: don't pass a large struct by value
 but instead pass it by reference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190219142120.11347-1-colin.king@canonical.com>
References: <20190219142120.11347-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Feb 2019 14:15:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 19 Feb 2019 14:21:20 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Passing the struct ptp_clock_info caps by parameter is passing over 130 bytes
> of data by value on the stack. Optimize this by passing it by reference instead.
> Also shinks the object code size:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   12596	   2160	     64	  14820	   39e4	drivers/ptp/ptp_qoriq.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   12567	   2160	     64	  14791	   39c7	drivers/ptp/ptp_qoriq.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good, applied, thanks.
