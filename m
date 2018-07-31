Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE62208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NnS3nhTS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E8bWo2Us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE62208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeGaJHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:07:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeGaJHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:07:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A69D760714; Tue, 31 Jul 2018 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533022087;
        bh=DIv5x41wOSg8iGCXjamDGzKA+txeFBzgTwVu3T/7YUI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NnS3nhTSZu6bYw2zSOURybLsKNm13fi4cG5WqISLsuFLBbE1dZmmE9qEzVG9tL7qg
         bI0BOQql+bMd8FyAel4+LOa6zty3e1Zm0R3omXdXEWBpaM+zDiJtvZr65oo7jpAWso
         muyIudVhxkRZYvkumTUnKtxGUSY5bIXz4U8QWE/M=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1095560376;
        Tue, 31 Jul 2018 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533022078;
        bh=DIv5x41wOSg8iGCXjamDGzKA+txeFBzgTwVu3T/7YUI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=E8bWo2UsvUM8NddhxeXJ/9LIyp3jrXBBMzJyTRRl36HvE0AO5lOAqfkR4tyLtRslR
         bNJhcZ23e56L+EIIST+4ACefrJDl2v4W2u3wSIHiK4fzjAgf86MUsX8C4d08lisPCa
         zIWYOiT5gQab8698dsG80whMXyuUXIAOmiYDViCU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1095560376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rt2x00: remove redundant functions
 rt2x00mac_sta_{add/remove}
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180727130549.12980-1-yuehaibing@huawei.com>
References: <20180727130549.12980-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <sgruszka@redhat.com>,
        <helmut.schaa@googlemail.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731072807.A69D760714@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:28:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> Only rt2800 subdriver of rt2x00 implement sta_add() and sta_remove(),
> rt2x00mac_sta_add and rt2x00mac_sta_remove has no callers after
> commit 9c87758cf089 ("rt2x00: call sta_add/remove directly in rt2800").
> So can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

24ebfcbdd1ba rt2x00: remove redundant functions rt2x00mac_sta_{add/remove}

-- 
https://patchwork.kernel.org/patch/10547141/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

