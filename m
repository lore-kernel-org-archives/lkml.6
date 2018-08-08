Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD71BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6557A216ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mJtAg4GY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h5Xhv52l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6557A216ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeHHHLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:11:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeHHHLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:11:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 572A9606CF; Wed,  8 Aug 2018 04:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533704030;
        bh=kcJbCfQeSYF/vtZqJI7fD8wtGCHvs1Td3lWBgu+ffNE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mJtAg4GYGGtnOem9trPlUHlVeu2nS/gDN1XVxMmDeVRi4+vn7jfjH5tNvsSs2UTNs
         T7wvkGOXynvBeJWcYq7KS0Ym4WbVzNpPCZXWbOxXgVD5xC0Cv7VWwzfpTQBKVmEaUe
         mDbv0rxKxsYPlNipP6QpWn1iwcklDehZio2cDRWU=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4791860AD9;
        Wed,  8 Aug 2018 04:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533704029;
        bh=kcJbCfQeSYF/vtZqJI7fD8wtGCHvs1Td3lWBgu+ffNE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h5Xhv52lUWyJ/dv8YAqgHyGH5tBXQ79HgQ+chvlhGdgcOpGkbmvCmGTYyluvTo4IN
         A+I5hI7uk+1klFSWEODrsYGsTZSjFt3QfCw3SjjR3Qqdj7SLNF0MeguPMs+zQ50OoA
         XaqzU0KwNUv4Vp+d5Dy4aYHl0pzJ8o//7aNuTaVg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4791860AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-drivers] mt76x0: Remove VLA usage
References: <20180807225040.GA2164@beast>
Date:   Wed, 08 Aug 2018 07:53:44 +0300
In-Reply-To: <20180807225040.GA2164@beast> (Kees Cook's message of "Tue, 7 Aug
        2018 15:50:40 -0700")
Message-ID: <87600l4fxj.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Even with "const" variables, the compiler will generate warnings about
> VLA usage. In the quest to remove all VLAs from the kernel[1], this uses
> a #define instead of a const to do the array sizing.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Fixes: e87b5039511a ("mt76x0: eeprom files")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Please include this for the v4.19 merge window. The VLA was introduced
> with the new source file (which I also note is missing a SPDX line), so
> I'd like to avoid the kernel ever getting released with a VLA here.

Ok, I'll push this to v4.19.

-- 
Kalle Valo
