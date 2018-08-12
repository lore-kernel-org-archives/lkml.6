Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0775AC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC68A219C6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iAJXI3nw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JeLrMjoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC68A219C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeHLUxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 16:53:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeHLUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 16:53:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 23D07601C3; Sun, 12 Aug 2018 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534097657;
        bh=+IlEOCNoIJ474enAAeEC7PFTUWtqej3qJ3PkZtuzCJ4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iAJXI3nwORwmCrW2PmSm0HU1n65pM5qCmdq+WWdVt5j50wRjwbl0+NONtXvUI9p8V
         waH4SYxYGfteMmFgDXOFr/aa+SiK/BP8MfZ1Q4HFNyp0hVGtjAjifF6lKzBgq5FUjk
         e9oxOKXKlbrRlBegYzIrcIWkqvvfdsZpPXgz/97E=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2BCC601B4;
        Sun, 12 Aug 2018 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534097656;
        bh=+IlEOCNoIJ474enAAeEC7PFTUWtqej3qJ3PkZtuzCJ4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JeLrMjoWvwjdfHsWDOb2HNJGBiXnWZamnoRfQj4YA4yPHf06sAMmcAow5w+56S67y
         AvCgC8lwe5N25wyK1x7AV9frC9pqbngUHFm9vetm5ooHmDtv+5qb0bvXb4mLsKtxY2
         uDLbXTiSV4vO9O4XXn3gzzRpJDjkGk+RtZGF4VgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2BCC601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
References: <20180812145207.11395-1-kristian.evensen@gmail.com>
Date:   Sun, 12 Aug 2018 21:14:12 +0300
In-Reply-To: <20180812145207.11395-1-kristian.evensen@gmail.com> (Kristian
        Evensen's message of "Sun, 12 Aug 2018 16:52:07 +0200")
Message-ID: <871sb3zc3v.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Evensen <kristian.evensen@gmail.com> writes:

> Enable the use of CQM with mt76-devices.
>
> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
> index 029d54bc..3eb328ff 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -305,6 +305,8 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
>  
>  	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
>  
> +	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);

So have you tested this and with what devices? For example, does it work
with recently added USB devices?

-- 
Kalle Valo
