Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3764C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780AF208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CwmcfVC7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FsPAjshK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780AF208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936085AbeFNPM5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:12:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934047AbeFNPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:12:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4FE53606DB; Thu, 14 Jun 2018 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989175;
        bh=2nOkMAaeojCkQFDscuYP8NOxhI0JqfhvYxqGRU6QVjU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CwmcfVC7hZLQsedEDQm0x17tta1Wl0PQruG0EkhztpWLMmng2mOtTZiqZ4E0mw/F0
         mt7OvviCYsHniMIPOSjYPCqZOtNO5JvNg6S4Es7Z2KD2LUmOEzq82Nbfkpeed59DLK
         XX1J7OyWHE6E/Qqx4D+98bDRoCTKGPLycZw+B+o0=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A319F6022C;
        Thu, 14 Jun 2018 15:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989175;
        bh=2nOkMAaeojCkQFDscuYP8NOxhI0JqfhvYxqGRU6QVjU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=FsPAjshKmSNKuG6xRvLhpcvFH8nnScI/8B0rrSUk/9Z/fOxbKXmCCLIOa69ztuET3
         NbB3DMqLC69OvzoXxmVzHEwZwsBgD6FWUPEX6pe+ZocCa3wkc2kz3X1/uAubAvR7DV
         WMAnY10QNbNODiVkfQO2NEP5rAPzXRgQVBvfDerg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A319F6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath10k: use dma_zalloc_coherent instead of allocator/memset
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180604123542.24336-1-yuehaibing@huawei.com>
References: <20180604123542.24336-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180614151255.4FE53606DB@smtp.codeaurora.org>
Date:   Thu, 14 Jun 2018 15:12:55 +0000 (UTC)
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

9fb31b66b91f ath10k: use dma_zalloc_coherent instead of allocator/memset

-- 
https://patchwork.kernel.org/patch/10446535/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

