Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AE1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3FD2152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fbmRZsDv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vr/bEitR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3FD2152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeHXTYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:24:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:24:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96B9760214; Fri, 24 Aug 2018 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535125732;
        bh=TyinUkAs8tDUy91faIewVv7WYg5eqVFsSwSSDeBm8Y4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fbmRZsDvfO7ADEqjGG0/xTzTKmg1EhNaM0xMKBpFuZbfDF/18CCv2iWdylGompOjv
         iRy589DWrvFGhiLM1X//4lb7dA9RqlZD0gkbHoWPHKO7zSrMBB5PuthjgnAcklDX7m
         LiWOvNcPtakTEFEPqZLHyi+jbako3T/osAcvkhOU=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6368060214;
        Fri, 24 Aug 2018 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535125731;
        bh=TyinUkAs8tDUy91faIewVv7WYg5eqVFsSwSSDeBm8Y4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Vr/bEitRS1/rBCYWqdqq5eIkwDIyJGlSXBZk3XzgD8L56Fbkat4uakk2Aeakgmvy2
         VQpS5MP0tKAWaMhpqP2uB+H13iHm6CAy8WH+ID48BtmK51wkLquMEwRgPfra7hHMlP
         IBQ8KBDrW3XctIIzZbi7ZQhcHsBhZyhtkV49FSlQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6368060214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wcn36xx: Use dma_zalloc_coherent instead of
 dma_alloc_coherent + memset
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1534761895-10457-1-git-send-email-zhongjiang@huawei.com>
References: <1534761895-10457-1-git-send-email-zhongjiang@huawei.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <davem@davemloft.net>, <wcn36xx@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180824154852.96B9760214@smtp.codeaurora.org>
Date:   Fri, 24 Aug 2018 15:48:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhong jiang <zhongjiang@huawei.com> wrote:

> dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset(),
> We prefer to dma_zalloc_coherent instead of open-codeing.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Doesn't apply as I had already applied similar patch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=d410e28f3ae476e1572b8893c646ef44fae7bbbd

error: patch failed: drivers/net/wireless/ath/wcn36xx/dxe.c:174
error: drivers/net/wireless/ath/wcn36xx/dxe.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Rejected.

-- 
https://patchwork.kernel.org/patch/10570243/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

