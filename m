Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7CDC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3720843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TD5XyGo9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kmg75ptT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E3720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIDMky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:40:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeIDMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:40:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD776607B9; Tue,  4 Sep 2018 08:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536049012;
        bh=WC5M8UlEhFXSaAohtR605zbQiQ1Ahztk+CPoSwwYpB8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TD5XyGo9KMdAezDBHkh/AkJriZoxWz/Teum193hiGCsJHYqIesJ0m5pGyMSY0SvJS
         UxBbp8SNK3wqhCUxr6b2EpPNPILiqybLJVb2D7J1sb9SHnPKRguG9Lxan2SS7oxK0R
         F74wwYaPtNLy0qhP7Pf0qitQc4kCYW0wjwNpzHI0=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C7D6603D2;
        Tue,  4 Sep 2018 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536049011;
        bh=WC5M8UlEhFXSaAohtR605zbQiQ1Ahztk+CPoSwwYpB8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Kmg75ptT1dmJEkE3o2CaZ3BGyclzAYGKvJX4/XGXWR4gSU4xryIb27dvaXU3WtQmi
         dNzqKTbBkHtCms7QYO/nEU5rNWRXfTycfnWHpobc1QMVpShKqTmxcN+jUb1Aznpupn
         Fyh1SZY8fwcBM1igY2v1oDfkHIT4H19fB2196qv0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C7D6603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wireless: remove unnecessary unlikely()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180831150300.2702-1-igor.stoppa@huawei.com>
References: <20180831150300.2702-1-igor.stoppa@huawei.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless Mailing List <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180904081652.BD776607B9@smtp.codeaurora.org>
Date:   Tue,  4 Sep 2018 08:16:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Stoppa <igor.stoppa@gmail.com> wrote:

> Both WARN_ON() and WARN_ON_ONCE() already contain unlikely().
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Michal Kazior <michal.kazior@tieto.com>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Linux Wireless Mailing List <linux-wireless@vger.kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

7e41fb504592 wireless: remove unnecessary unlikely()

-- 
https://patchwork.kernel.org/patch/10583997/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

