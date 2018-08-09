Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107C021C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WUcknWNm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AC3z4UWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107C021C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbeHIRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:40:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbeHIRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:40:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C033760B7E; Thu,  9 Aug 2018 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827721;
        bh=J6sNB0aHJREpuF+8k3zidbhYYBLRvQMlU9jjOmDXq70=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WUcknWNm9Fhaf4Q9fa3KbNt/lcWpjWV++fPFUxfIHWQ7WvExuMBXSRsAScFiSbr7/
         HaD2dh2RurqAC4I/mFSaYkp/XpP4ZlAOwWdiZhCLn7b4+V9yVU8uP31EPvhqsAHxUi
         wtN6t8f9/P1CybHFXtQnC+KaHN764FpUIcGnL5yY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C488460AD8;
        Thu,  9 Aug 2018 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827720;
        bh=J6sNB0aHJREpuF+8k3zidbhYYBLRvQMlU9jjOmDXq70=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=AC3z4UWx12hPsAM5/8okCm1XV35lXeDQX8NyFBxbg9+6wXfFpPrX08/I6N/LNb74b
         fd6yqhqeMThYngt05o+UsG5IR/X/gqNvKGxXgfwAWaAVMWksP3O4dPGVMl/YpFqRcK
         6hJqNHAq3dgQZP+nryqOpTT7CRSdKk+fZUJ7S28Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C488460AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: btcoex: Fix if == else warnings in
 halbtc8723b2ant.c
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180806045440.11920-1-yuehaibing@huawei.com>
References: <20180806045440.11920-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <pkshih@realtek.com>, <Larry.Finger@lwfinger.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <colin.king@canonical.com>,
        <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180809151521.C033760B7E@smtp.codeaurora.org>
Date:   Thu,  9 Aug 2018 15:15:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> Fix following coccinelle warning:
> 
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2952:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2961:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3011:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3020:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3439:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3448:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3339:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3348:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3074:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3083:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3192:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3201:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3267:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3276:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3124:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3133:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2821:2-4: WARNING: possible condition with no effect (if == else)
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2830:2-4: WARNING: possible condition with no effect (if == else)
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

ad2e6d23bdad rtlwifi: btcoex: Fix if == else warnings in halbtc8723b2ant.c

-- 
https://patchwork.kernel.org/patch/10556487/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

