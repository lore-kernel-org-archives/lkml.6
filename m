Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BB88C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5158E208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WIadIncB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e0BsJzpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5158E208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935437AbeFMLmU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:42:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeFMLmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:42:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AB94E60385; Wed, 13 Jun 2018 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890137;
        bh=L8M90Q1kcaXWvPiKNwA8xs1XdWfF0C5hKGEb0Rn5FJ8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WIadIncBmfgEKZM6sDl5loSTT0DX/cgeiPNBzbB2WGeeo36vEdmDKAZLl1tW+TRCr
         pZNgIq1hDbOijxHC4JaNh/FLn+ZXpxwe2XtTvP24AoLWdgYBbBjWpy2UBT3aJ8K+vs
         biGOs/PpY+9TbcDHeFD0KR6Wbn5A3LcgsfaNvqQg=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9CA36074D;
        Wed, 13 Jun 2018 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890137;
        bh=L8M90Q1kcaXWvPiKNwA8xs1XdWfF0C5hKGEb0Rn5FJ8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=e0BsJzpFRERQhVrg+mHNU87iy04gW+1vJGiHJem0bNjTWdLUzDQp1mJSimiC7Ze3J
         PLURFUnrrnBlhIsx4zflYj1Ey5JwlQOT7CKg70is9S2DqtdpioYl1jf/Oy5jmeCISI
         vQoqjqFtBTi0OEBPpfwpX7xYRv4Hv7Eirqpx8W5U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9CA36074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath5k: mark expected switch fall-through
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180524230700.GA21433@embeddedor.com>
References: <20180524230700.GA21433@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180613114217.AB94E60385@smtp.codeaurora.org>
Date:   Wed, 13 Jun 2018 11:42:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

aae28cefc279 ath5k: mark expected switch fall-through

-- 
https://patchwork.kernel.org/patch/10425693/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

