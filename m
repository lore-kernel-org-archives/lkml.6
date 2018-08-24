Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E4E21523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CtetxMzg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LIx1B2aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E4E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeHXPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:25:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:25:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 185996032D; Fri, 24 Aug 2018 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535111445;
        bh=suwnnnhNy9/js4Ggwue2NIECenMNsSEeHuSQ42zPRxU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CtetxMzgUpT2F3CDDr5cgNGMwAuGOoEPrjLCb6tHWtgasM44/NDG/ncTrS4oDdE8P
         Qe+Ss41sfi1yIawqU52bFr/u76BXDM4y5IvuB+3JIF4+d64XfxYSCN9jMHIzegr7eY
         3lAwhQM4b9zhoEqrIVgr8JmzLb1TzOO/eHRj6ERc=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E24E601A0;
        Fri, 24 Aug 2018 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535111444;
        bh=suwnnnhNy9/js4Ggwue2NIECenMNsSEeHuSQ42zPRxU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=LIx1B2ajk25uos33rdyr/cyzS9DSZJ8QcBoEmPj9FIyyR/K3turzua9gNdV9x3mqm
         nuUiwVYOKBqGkF7ugghMci7nKCCEOGm3scle+3mnWO1RZcqg9JsYo2uRacZ1pDaH0I
         DGUV2/IkUIgeLrvzS6lGkc+xAfRBHik4YJMWYKAQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E24E601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: use dma_zalloc_coherent instead of
 allocator/memset
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180724115211.19264-1-yuehaibing@huawei.com>
References: <20180724115211.19264-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <wcn36xx@lists.infradead.org>, YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180824115045.185996032D@smtp.codeaurora.org>
Date:   Fri, 24 Aug 2018 11:50:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d410e28f3ae4 wcn36xx: use dma_zalloc_coherent instead of allocator/memset

-- 
https://patchwork.kernel.org/patch/10541939/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

