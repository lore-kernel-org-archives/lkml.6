Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B7C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126E620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TA+P8wOM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MYe8UMUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126E620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeIDMm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:42:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48978 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIDMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:42:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 459CD607B5; Tue,  4 Sep 2018 08:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536049107;
        bh=01v315nArOAUZkUXY4v2Ge9RC4zUC9J0450zrvfYbT4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TA+P8wOM0kEs0RyKqOjn0Jy3aDErfZsz3eFLCfQwunkiSD3oEpUwgW9ejyfEdUTtW
         +ybisy4pO+guyBV0PjRHAzM/9He4sUZTIMy3PBhuSSw/FcVbXV9qe4qoY1Hum2OJIM
         X0GvSSX944eMzXlkridJaOYozPHrpONBJxzJYaW4=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B0A560708;
        Tue,  4 Sep 2018 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536049106;
        bh=01v315nArOAUZkUXY4v2Ge9RC4zUC9J0450zrvfYbT4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=MYe8UMUim2o7gidHukYPadTKOXjGpvQUBlclSyBAK++4pMuk30KOURTd3SI7SHWmV
         3WdtwMoDIUwsU9850xu2vOUMC6PJYyDsB4BCF2HbkaNlHkF/968ftnXXKKKrhIfOVN
         eesJnCfr+Z8Ptwi9vVavZMGIbuWUboJsPQj4Mm5c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B0A560708
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] orinoco_usb: fix spelling mistake in fall-through
 annotation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180903201752.GA25288@embeddedor.com>
References: <20180903201752.GA25288@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180904081827.459CD607B5@smtp.codeaurora.org>
Date:   Tue,  4 Sep 2018 08:18:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Replace "fall though" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied to wireless-drivers-next.git, thanks.

cf5652c962da orinoco_usb: fix spelling mistake in fall-through annotation

-- 
https://patchwork.kernel.org/patch/10586357/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

