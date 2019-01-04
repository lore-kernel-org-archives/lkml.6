Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7876C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6931721872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="dnGPyM+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfADW1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:27:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46435 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfADW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:27:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so33618687ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 14:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQ6UjuNopEwKcnsvjRzRd/46ByMprL2t1YUeCJB4np8=;
        b=dnGPyM+sp6t1FDjNBiwhviFzeDXe7u/VjXujfc50M6fyZeOSJW6qUQUAfsBS+A2aeA
         9AHyQxO+EKGebt2YtFz4bMxHVPIjrw230Wo2FHTcEDCQTilrtCoZHJzXTLUQBmweDT3B
         cGjR/v0kuaqLbtHso9OvmEemyGUx/C8wKOoRvhyUwFGOu4x8ysgoqHI6kuyLggIMoSRW
         WjgWLb8rFc1blH51tuUQNYCS23Akg8WqFIPMoSFU2B+W9iCRPB7VDf63lE0SDy3GzsqS
         MSKMFVEsgYa5mDu8nV7pZrmicBiVdr578iomaluKnnJDfOTJs+x3MG5ZtnjF+w31bbVy
         Vqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQ6UjuNopEwKcnsvjRzRd/46ByMprL2t1YUeCJB4np8=;
        b=X4diC17fZ3pmJlOlf0YRxsJBcUwkHzxIPnRxxj1+xCQ+9faegImQ2rDPrReQteODyb
         ftERjIuaLtYkbiJr0Fq+5AagbswmuP2vPKJLKd9DvSQi1yjYIEI4VYYtAC9kr0FY9d5p
         6hHhXCvsg10tu5bosiYjGnlgoJtGCvogBdPXJnPLlghvGVq7G9N313uzchipjEdJmJrp
         M+uTQ23k+U+dH8QCL0byF1kIagm2f4zbRNhTDQ2K+N8IdkCjs0pZC2QpJCkE+OLHCxbJ
         RfDS8VCY1Pdmf5C1elU03n5dCIWVKl+y6CQyc16l8/vvRwz/7oqpaGdkmVXsOpPBV2hd
         rifg==
X-Gm-Message-State: AJcUukcXJbtzXh7nM/qzDD1IyiyNwZJs9oM/hzWOu9EUTQYw4ejcGiQK
        R9TLp3Wxp9qjcC/eqFVcgkMAxg==
X-Google-Smtp-Source: ALg8bN7MBaYcsurbii1VK9E8kdi4UaQ7ZDvkzE1ymFHgxYjzrjhCYlYaSG//AxmagQzBAYAMWcL7Jg==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr28865059ljk.76.1546640841367;
        Fri, 04 Jan 2019 14:27:21 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id h21sm11572091lfk.41.2019.01.04.14.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 14:27:20 -0800 (PST)
Date:   Fri, 4 Jan 2019 14:26:36 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ARM: multi_v7_defconfig: enable
 CONFIG_UNIPHIER_MDMAC
Message-ID: <20190104222636.cjobi7ztjyci22uk@localhost>
References: <1545382284-7290-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545382284-7290-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 05:51:24PM +0900, Masahiro Yamada wrote:
> Enable the UniPhier MIO DMAC driver. This is used as the DMA engine
> for accelerating the SD/eMMC controller drivers.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> When I sent this last time, Olof asked me to resend it later
> to avoid accidental drop.
> 
> I think the patches for v5.0 have been almost queued up.
> So, I am resending it on top of that.
> 
> The insert context was decided by savedefconfig
> based on next-20181221.

Applied now that the driver has landed in mainline.


-Olof
