Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1598ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCBD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mXvRL1P/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mXvRL1P/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCBD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbeGWKbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:31:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeGWKbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:31:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88DD2608C8; Mon, 23 Jul 2018 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532338245;
        bh=eyPZBKYyw5DjI1yU0ayEpF4rCW9aMA4o+8b7Ffe9d4A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mXvRL1P/Bx/8b4PBSHHe9jCM/u/GO0ig+Y2FRhFf6murthI43rknVMr5B1T0uynbw
         W1rN7tXuiFcm/srd6y4cSgXvV/GSGG2rKomsP+XZLf4S+/59YLE+J/PKldb2agRxvq
         b9ICEzE9NDGVhj733033oij3D/wGzVV/8Sskc0Sw=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2466360481;
        Mon, 23 Jul 2018 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532338245;
        bh=eyPZBKYyw5DjI1yU0ayEpF4rCW9aMA4o+8b7Ffe9d4A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mXvRL1P/Bx/8b4PBSHHe9jCM/u/GO0ig+Y2FRhFf6murthI43rknVMr5B1T0uynbw
         W1rN7tXuiFcm/srd6y4cSgXvV/GSGG2rKomsP+XZLf4S+/59YLE+J/PKldb2agRxvq
         b9ICEzE9NDGVhj733033oij3D/wGzVV/8Sskc0Sw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2466360481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add a missing break in parse_station_flags
References: <AM5PR0701MB265751E3A716081292C5224FE4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Date:   Mon, 23 Jul 2018 12:30:41 +0300
In-Reply-To: <AM5PR0701MB265751E3A716081292C5224FE4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
        (Bernd Edlinger's message of "Sun, 8 Jul 2018 09:57:22 +0000")
Message-ID: <87r2juti2m.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Edlinger <bernd.edlinger@hotmail.de> writes:

> I was looking at usually suppressed gcc warnings,
> [-Wimplicit-fallthrough=] in this case:
>
> The code definitely looks like a break is missing here.
> However I am not able to test the NL80211_IFTYPE_MESH_POINT,
> nor do I actually know what might be :)
> So please use this patch with caution and only if you are
> able to do some testing.
>
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>   net/wireless/nl80211.c | 1 +
>   1 file changed, 1 insertion(+)

You should use prefix "nl80211: " in the title.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#subject

-- 
Kalle Valo
