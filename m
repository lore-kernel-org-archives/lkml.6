Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B62ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6244E2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IxhxseJe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gudH6Pup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6244E2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeITRyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:54:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeITRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:54:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70BE1602A7; Thu, 20 Sep 2018 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537445486;
        bh=mM+qaYwMG6g06J+YJI4CVg/+MAM4ZKDBZH7GhJtddlU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IxhxseJeWcLRJ/4JCCbc9XzAQ5g82zS6xz+BTibpN1Ba8H5JXx6StMTOz9sKgIfu1
         PicJvf/iz0f12oTo26km+xSN6JhW3O7zrfeM7D5ufYPurjvSxuLWeiY+v2rl9yFQEE
         7MZmqV/E4ZRlIQLvvUyGVg2TO9mhg4h8CUXfSJVY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B275C602A7;
        Thu, 20 Sep 2018 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537445485;
        bh=mM+qaYwMG6g06J+YJI4CVg/+MAM4ZKDBZH7GhJtddlU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=gudH6PuptAx2cxpB892gAWFS4HlF1Z4pB1V/jUInpbchKWVNwLrKDSCBYhHqBbna0
         U2ugiBIJvEHEn5O26jYvfQLveC19BoMwtkOccAp//tl4wX9zoiOSh2ENRGGL7DtgtQ
         GG4Cq1lbOllIofmFenlahRD5VLvjQuJaH8aAzisc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B275C602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: remove set but not used variables 'sfdoff' and
 'pad_size'
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180911032404.14536-1-yuehaibing@huawei.com>
References: <20180911032404.14536-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <arend.vanspriel@broadcom.com>,
        <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>,
        <chi-hsien.lin@cypress.com>, <wright.feng@cypress.com>,
        <pieter-paul.giesberts@broadcom.com>, <ian@mnementh.co.uk>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <brcm80211-dev-list@cypress.com>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180920121126.70BE1602A7@smtp.codeaurora.org>
Date:   Thu, 20 Sep 2018 12:11:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: In function 'brcmf_sdio_rxglom':
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:1466:11: warning:
>  variable 'sfdoff' set but not used [-Wunused-but-set-variable]
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: In function 'brcmf_sdio_bus_preinit':
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:3408:7: warning:
>  variable 'pad_size' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

a8254fa4ba60 brcmfmac: remove set but not used variables 'sfdoff' and 'pad_size'

-- 
https://patchwork.kernel.org/patch/10595033/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

