Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30DC4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE41208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gp2lndNw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SnyqSkps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE41208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbeFNPL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:11:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754927AbeFNPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:11:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 32C1D60116; Thu, 14 Jun 2018 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989117;
        bh=f1pmI9RyI/CYx3qgNGPCKj1nIUBNYO3HHU5jUeHIRmA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Gp2lndNw4DhtVb9p9Ht1Uldef2Ca2hAtI337WqrdqjF8NKOtHKv2JLGifaD92q6hF
         Vi7qHnk7BxFpol4cUDevUML/GelrWRV4F22X8zwHo2sSM5Kkv1v0akzZXmsEH7Dmdc
         BvcE5XZjdUk67ZaBkThhdKks7w4G7KQYFsS3BQ+E=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FB5C60116;
        Thu, 14 Jun 2018 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989116;
        bh=f1pmI9RyI/CYx3qgNGPCKj1nIUBNYO3HHU5jUeHIRmA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=SnyqSkpsvpuFDW/O+1Drb/JYztlYTzB6aZqUjS9upf6enjV/FXNaqEAayW3y31NdW
         d/0lghrUdAR3hyq7f5GB/ggLfXeZvcCk3w+zPhf5CIE4tz8E3THMh1J+zmmhnXpN3a
         NC0MdwtfJ6cEBptKJX6e8S2Up+jgDZAq6g7mcfgY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FB5C60116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] ath10k: fix incorrect size of dma_free_coherent in
 ath10k_ce_alloc_src_ring_64
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180601112548.22592-1-yuehaibing@huawei.com>
References: <20180601112548.22592-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180614151157.32C1D60116@smtp.codeaurora.org>
Date:   Thu, 14 Jun 2018 15:11:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> sizeof(struct ce_desc) should be a copy-paste mistake
> just use sizeof(struct ce_desc_64) to avoid mem leak
> 
> Fixes: b7ba83f7c414 ("ath10k: add support for shadow register for WNC3990")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5a211627004e ath10k: fix incorrect size of dma_free_coherent in ath10k_ce_alloc_src_ring_64

-- 
https://patchwork.kernel.org/patch/10443063/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

