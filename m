Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0825EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22BF20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WzPOMVdL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j+NuAvnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22BF20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeHaUA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:00:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38580 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeHaUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:00:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B4F3460445; Fri, 31 Aug 2018 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730768;
        bh=hmT0jl1WjZohiCBru4FhawOoZ1lajhTcqa5HxvZrzVw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WzPOMVdLLH/RfIoUDrl5BE6Pvc9/wycdIxQ2YcSLHTc8xKKdGWfbjcLSQHxWMWMal
         ycL0lrk9bVE0GO1D5Dst8GrpPBtNSMGn/ma4oOSB2i4FDHUlfxgCMLAxQMRM3WZZwb
         nPhy3l804jVI2HqEWKDenRWpU5qkSErVvynuo5ug=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8804A6053D;
        Fri, 31 Aug 2018 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730768;
        bh=hmT0jl1WjZohiCBru4FhawOoZ1lajhTcqa5HxvZrzVw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=j+NuAvnvDFyIKY+sUxGXHDYldJehZtlTfoAYu0adgDXZZNAOLiH3lYgzqEw0hRf4x
         /tN0cayQG7N5EdnH9anp5b65w7pe2DIsEgt8F0eTgORRsfcq0KMQN5N42RL0q2SiN+
         0yjqBpb4dwFgLY5Sgp8g2OsrpoCqF37/HxZIK82s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8804A6053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mt76: Fix comparisons with invalid hardware key index
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180823212738.18431-1-geert@linux-m68k.org>
References: <20180823212738.18431-1-geert@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180831155248.B4F3460445@smtp.codeaurora.org>
Date:   Fri, 31 Aug 2018 15:52:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> With gcc 4.1.2:
> 
>     drivers/net/wireless/mediatek/mt76/mt76x0/tx.c: In function ‘mt76x0_tx’:
>     drivers/net/wireless/mediatek/mt76/mt76x0/tx.c:169: warning: comparison is always true due to limited range of data type
>     drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c: In function ‘mt76x2_tx’:
>     drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c:35: warning: comparison is always true due to limited range of data type
> 
> While assigning -1 to a u8 works fine, comparing with -1 does not work
> as expected.
> 
> Fix this by comparing with 0xff, like is already done in some other
> places.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch applied to wireless-drivers-next.git, thanks.

81c8eccc2404 mt76: Fix comparisons with invalid hardware key index

-- 
https://patchwork.kernel.org/patch/10574583/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

