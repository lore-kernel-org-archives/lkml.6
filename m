Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3585C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9D20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G4stAVt1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a2iqR34I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B9D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeICVTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:19:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeICVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:19:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F22B3607B9; Mon,  3 Sep 2018 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993903;
        bh=m8dXdWbEb42Vpv+KxQW5auCMbE7JSPRj+ep2LXEUhMY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=G4stAVt1P+0yWDLS/rImSjVtunSapzRZLD6tEip+GFm/NZX9U68cHTlf+zHD0BkiZ
         rG7xRjdAd05CTZGER/7X8uaoDrusjMW/+U/JOudBi8GdJN18cfB2dTTaDwzP14Vl+G
         pvTnq8vRTjwSrIkHKfv3KiBc7+6lZtOzX8ADkFIU=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71508606FC;
        Mon,  3 Sep 2018 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993902;
        bh=m8dXdWbEb42Vpv+KxQW5auCMbE7JSPRj+ep2LXEUhMY=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=a2iqR34ImtN02s/gyvCCKaL8x664y2iHXzz6T2itAl3wmDMvbN3heLB1pjb69M1z4
         2PKhKtFr7Nmoqvc3xGVjdzbM6Z+1EfBD1F93E4bQRNhUTC6HoIzHpMuZxnQntY2uMo
         ESx943W/5bbZo8p8A5K2qjrWKdtW5VMReh6WNFV0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71508606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: wireless: ath: Convert to using %pOFn instead of
 device_node.name
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180828015252.28511-36-robh@kernel.org>
References: <20180828015252.28511-36-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180903165822.F22B3607B9@smtp.codeaurora.org>
Date:   Mon,  3 Sep 2018 16:58:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e12e643c1dfb ath6kl: convert to using %pOFn instead of device_node.name

-- 
https://patchwork.kernel.org/patch/10577811/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

