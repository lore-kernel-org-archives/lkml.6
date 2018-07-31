Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263B8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2A920862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ed+qS9x2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EykpxV0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2A920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeGaJ33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:29:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeGaJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:29:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1FA2D6071C; Tue, 31 Jul 2018 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533023427;
        bh=ztqX2pxvTJxwEZgFmgMRtAm6Rj/xEaVPnoQq3Xs+HC8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ed+qS9x20bct/RMqDHLLMGf0YUjoksBHYJB4Lb8RCOg3fqtG6DI8rOgX/aLYyNpsX
         CCIUG7TnGKUXACc5STd/G3ZYNgVqF9OtxcjAMe3P2YIvMk3saCuloD8fQvK0e8G3dC
         vU7WO74hxmLysmyZYwCxpuJu3xU1nzfC40+6BA94=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B028606DD;
        Tue, 31 Jul 2018 07:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533023426;
        bh=ztqX2pxvTJxwEZgFmgMRtAm6Rj/xEaVPnoQq3Xs+HC8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=EykpxV0lgxV9u7IpiMaJq+nT816SV+PJdCBrkGjRXhhOSDSLHr/xiYCZNXmAS9TLt
         elgCeiEIPIxSahlrYOhjxGuo/rSZ9/MT+rNhD2q0V46bjf41AoU2/iEP9vdmyZXWEr
         4FzCXHLq7NgEKlQ9tBgTeJoruoLaGT5c5ubePW/Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B028606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: wireless: ath6kl: Replace GFP_ATOMIC with GFP_KERNEL
 in ath6kl_bmi_init()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180727084318.3345-1-baijiaju1990@gmail.com>
References: <20180727084318.3345-1-baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     kvalo@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731075027.1FA2D6071C@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:50:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> ath6kl_bmi_init() is never called in atomic context.
> It calls kzalloc() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

bfc55fe65987 ath6kl: replace GFP_ATOMIC with GFP_KERNEL in ath6kl_bmi_init()

-- 
https://patchwork.kernel.org/patch/10546741/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

