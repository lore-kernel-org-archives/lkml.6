Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A97C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F932086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LN8F4VJl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JYrsfogC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F932086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeICVPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:15:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeICVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:15:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 316F3606CF; Mon,  3 Sep 2018 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993656;
        bh=f9K6eP3XFg/4L77Ezbw1PzUNUhNYD14wPYdOF1M7KKs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LN8F4VJlFBIAyTJ6PoDEYWd09Y+vrihZPk36ksA5jdapaWuFS2YCmi8y0gmBahF2l
         E4TA4TchqLHr/wjKykFGw+u1P0eUNk0S7CUsmUcnsmejaUdp6MGPfbsWEI9ek0Kp1x
         3SFkbygegpcPiTxrGHNrKfemOqDresCpihDvl8tI=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD54260452;
        Mon,  3 Sep 2018 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993655;
        bh=f9K6eP3XFg/4L77Ezbw1PzUNUhNYD14wPYdOF1M7KKs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=JYrsfogCBMOOHjhSjY3W9temQ6MWBkmxYqdADgzRO2MTKn1veOn+JDSNvitMDmRnH
         /3nzpA/sm1IKTQF8CBalrGGthrjDvCe8SXN7FveCqE0FgQmOBhzOBoFEVbDixTN7zS
         gJBgemi9498ivZVHad7R2WRvbKx8sN8rOEYSRyEk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD54260452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: retrieve MAC address from firmware if provided
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180810233948.144792-1-briannorris@chromium.org>
References: <20180810233948.144792-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180903165416.316F3606CF@smtp.codeaurora.org>
Date:   Mon,  3 Sep 2018 16:54:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> Devices may provide their own MAC address via system firmware (e.g.,
> device tree), especially in the case where the device doesn't have a
> useful EEPROM on which to store its MAC address (e.g., for integrated
> Wifi).
> 
> Use the generic device helper to retrieve the MAC address, and (if
> present) honor it above the MAC address advertised by the card.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9d5804662ce1 ath10k: retrieve MAC address from system firmware if provided

-- 
https://patchwork.kernel.org/patch/10563221/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

