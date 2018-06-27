Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38B9C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80125E48
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DqAWKgyS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HmBKN/Di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B80125E48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965674AbeF0QK6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:10:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeF0QK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:10:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0916760B16; Wed, 27 Jun 2018 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115856;
        bh=8iKJ/nQpf0USgzNq3gKbKj6w8eyr18hwoZDPcWppG/s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DqAWKgySCtq7BgqCsX1xYQ9KGWMt1SVhdJrPND9yMcw3+udfFzw0bFKYKTrlnJzjZ
         dNouXRo6nJErxxAUhdA35n3fcvh0BXGw4MuT2PbbAd7cEkpKjUWygUubeLtGtJWhUq
         WTkRwcBLsj6LMIBXZc5atzpd2HojNX5d6QIOxUDQ=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54C526024C;
        Wed, 27 Jun 2018 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115855;
        bh=8iKJ/nQpf0USgzNq3gKbKj6w8eyr18hwoZDPcWppG/s=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=HmBKN/DilueD+J4UtZNmsK1iHbvWBg6m8kVXt3CO1tSw7cP6dOVcmJC8GYLIIMMJg
         m+d6nP28YPcoVEJU6nrDgUdbVg3ti36o+yTP8tweMkoCt42XTGEAjAoTUl6zdXITby
         pN+NhlS1XVG0oHk6QNAm2xeoxUpIQZt2sGywXcdg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54C526024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [2/4] zd1211rw: stop using deprecated get_seconds()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180618151142.1214422-2-arnd@arndb.de>
References: <20180618151142.1214422-2-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
        "David S. Miller" <davem@davemloft.net>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180627161056.0916760B16@smtp.codeaurora.org>
Date:   Wed, 27 Jun 2018 16:10:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> The get_seconds() function is deprecated because of the y2038 overflow.
> In zd1211rw we don't even care about the absolute value, so this is
> not a problem, but it's equally trivial to change to the non-deprecated
> ktime_get_seconds().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

2 patches applied to wireless-drivers-next.git, thanks.

71e140b57151 zd1211rw: stop using deprecated get_seconds()
3cade2f3d98a ipw2x00: track time using boottime

-- 
https://patchwork.kernel.org/patch/10471961/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

