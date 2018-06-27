Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A962BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62129259A3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rm8se6pk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bt3aO0ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62129259A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965666AbeF0P6E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:58:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965049AbeF0P6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:58:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26F41601EA; Wed, 27 Jun 2018 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115082;
        bh=UBHheEbNDmX/RjWJZ0x5rd0L+SO8NoJCZnPNgjpBv8M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Rm8se6pkAFRnEO83BTgjCaWMptwwcISoeWGLzegP0M+HKlepKq25fsQiV9Lz2h/G6
         NrgR9m5qF9CU7hCzqb0MZC8cca9LwA/AiSJmbc+AKPx8css8cF6JqNfQdZOyAmSCLI
         9rCQsm8gzCABYH8nd3Wi4EBlvHtGWGSSBMaG3SfQ=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4F92601EA;
        Wed, 27 Jun 2018 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115081;
        bh=UBHheEbNDmX/RjWJZ0x5rd0L+SO8NoJCZnPNgjpBv8M=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Bt3aO0neTgsee1u90fPe3QhDCEMnAiPnMvznhSLhF69jmFkZAceiAg5qFWc9yWPht
         AgX8CciC1P7h86SBJpbzUtGNM12cVA2m4tTj3P5l1/4xM+ZPoNWF4FmxWTfEJZ+tWt
         qiYc90KpIXwjdDPW5l0sNyLtj4N/eQqhB7GvKG00=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4F92601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: brcmsmac: make function wlc_phy_workarounds_nphy_rev1 static
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180623221531.6396-2-colin.king@canonical.com>
References: <20180623221531.6396-2-colin.king@canonical.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180627155802.26F41601EA@smtp.codeaurora.org>
Date:   Wed, 27 Jun 2018 15:58:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The function wlc_phy_workarounds_nphy_rev1 is local to the source and
> does not need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'wlc_phy_workarounds_nphy_rev1' was not declared. Should it
> be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

ab8d904654e2 brcmsmac: make function wlc_phy_workarounds_nphy_rev1 static

-- 
https://patchwork.kernel.org/patch/10483927/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

