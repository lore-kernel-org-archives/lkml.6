Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C2C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E029920843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HMIiwqYz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZhTlrWVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E029920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeIDMkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:40:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeIDMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:40:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E2F060708; Tue,  4 Sep 2018 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536048979;
        bh=W8h/tnwT2/2AMKmgeE8iCGHLJzHIB6Qq+rn6U1LBawo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HMIiwqYzyYPhcnESwVXAf+fitel+/yJIbw42UZw2ML7czmZvJGaMGX+weu3tLYh4w
         m+XMQYwQnpxogC5GwTeMTPCbtYRA1Wk3JpmGIJRXYf/ezfJAfaXizuHZPveOXcqP+l
         5gNBEsYtU5Z3QNLx83G05ChDhCPHgMM8y333B/U0=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9520D603D2;
        Tue,  4 Sep 2018 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536048979;
        bh=W8h/tnwT2/2AMKmgeE8iCGHLJzHIB6Qq+rn6U1LBawo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ZhTlrWVYMX0FFR+h77RzxU0Ln2TsArl3bPrdL7pPcQ5VPWkCM9Z6fahnKYWuidSnT
         37CiFIBceSVve6yWJ8WVp9o+L0MqaBW+iAIy+QpPtrtdi4yYeACYug3M/JiXUfaqP0
         whBOf9zhC1SkKOCL1r7x5bqbM8DRaeIzUMq61Yh8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9520D603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtl8xxxu: Add rtl8188ctv support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180830140541.31964-1-mamlinav@gmail.com>
References: <20180830140541.31964-1-mamlinav@gmail.com>
To:     Aleksei Mamlin <mamlinav@gmail.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180904081619.8E2F060708@smtp.codeaurora.org>
Date:   Tue,  4 Sep 2018 08:16:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksei Mamlin <mamlinav@gmail.com> wrote:

> The Realtek rtl8188ctv (0x0bda:0x018a) is a highly integrated single-chip
> WLAN USB2.0 network interface controller.
> 
> Currently rtl8188ctv is supported by rtlwifi driver.
> It is similar to the rtl8188cus(0x0bda:0x818a) and uses the same config.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

514502c3a70b rtl8xxxu: Add rtl8188ctv support

-- 
https://patchwork.kernel.org/patch/10581745/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

