Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C059EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744792075E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aXTVonFx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NGHiDuje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744792075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbeFNPWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:22:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754927AbeFNPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:22:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5621D600D0; Thu, 14 Jun 2018 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989750;
        bh=x7sEPUhXXP//4GLKGBkZIc5HXE1xR2SGN1X318AfJWw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aXTVonFx/woN2QGMFdVoRBI21bdn80YNci90hF4IhmW+0+XGF8/m8d45SAqSuL1FF
         K6vEqxNC1GHaw0F0o/4xrIxPkzNEdmSQ5LdMqzKWp7c2sQ/rzFz/0cEyTPiie1Isb5
         b7Jw6XSWu80QvvWDKV0EPoA/sFdTHppC+SxWp5rY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F3A1600D0;
        Thu, 14 Jun 2018 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989749;
        bh=x7sEPUhXXP//4GLKGBkZIc5HXE1xR2SGN1X318AfJWw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=NGHiDujeHrGQGDxu8vxoIIKqDNmSvplVGPIEjmS2SYImAB1DCk2ICwvmbxHC2UzZu
         ZwkuUFgypsuK+c3zUZXN+OMZTWxEV4QkN51U00wCZeic2Ur4ueAy4EIWHJ6SK72Kwr
         2ThRky1CCzuV91wlaVR1N4KfrGXM0YFqcmo+slHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F3A1600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath9k: debug: fix spelling mistake "WATHDOG" -> "WATCHDOG"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180530092503.10481-1-colin.king@canonical.com>
References: <20180530092503.10481-1-colin.king@canonical.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180614152230.5621D600D0@smtp.codeaurora.org>
Date:   Thu, 14 Jun 2018 15:22:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> Trivial fix to spelling mistake in PR_IS message text.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d5e5f6855aab ath9k: debug: fix spelling mistake "WATHDOG" -> "WATCHDOG"

-- 
https://patchwork.kernel.org/patch/10438027/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

