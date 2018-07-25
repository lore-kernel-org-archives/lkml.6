Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A4A20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fI6Xy0U1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d3Z7g53U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A4A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeGYHuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:50:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbeGYHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:50:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B2DE60594; Wed, 25 Jul 2018 06:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532500808;
        bh=IUO17NPH3NG91HkK9VjhQsc58Yay2qajmsCN8FW8QaI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fI6Xy0U1onkeJE1YfCPc5H002VASwTC5RV58scN4X6nsZgXJFD2AMi88bAN0GARln
         ERYJTJordOBRbq4cAP5+Mr4vG5qhuxQUrpfAiJm/XcrJIwmtrnvVX4pA+JPXbmeeW5
         1pP3Cf5qvs8DqCACDLqfUFYAAtUiJ5okcCapPI3M=
Received: from x230.qca.qualcomm.com (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5503460594;
        Wed, 25 Jul 2018 06:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532500807;
        bh=IUO17NPH3NG91HkK9VjhQsc58Yay2qajmsCN8FW8QaI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d3Z7g53U/RnTISwJT5Hm8yWK2HU8OykShKtqqbWYd5gDUQue9SiO7iuxacYMAktBk
         AfiZodIFmgthbJyj5Gg+YfhhLWLuMc2I5QsfHCahXkgJqelCOtM8kOhNcmgOLqCxP9
         M1b9NBgoXg66p2SP7QRr5twcyoEOFy3SlKH2sJYw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5503460594
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "Reizer\, Eyal" <eyalr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH] drivers: net: wlcore: remove duplicate \n for some warnings
References: <af660348ade58fd33396d2dca432536d2ac85cf7.1532498079.git.hns@goldelico.com>
Date:   Wed, 25 Jul 2018 09:40:02 +0300
In-Reply-To: <af660348ade58fd33396d2dca432536d2ac85cf7.1532498079.git.hns@goldelico.com>
        (H. Nikolaus Schaller's message of "Wed, 25 Jul 2018 07:55:04 +0200")
Message-ID: <87lg9zyg1p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Nikolaus Schaller" <hns@goldelico.com> writes:

> wl1271_warning() already appends a \n to the format,
> so adding one to the warning string gives empty lines in the log.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

"drivers: net:" in the title is unnecessary, but I can remove that.

-- 
Kalle Valo
