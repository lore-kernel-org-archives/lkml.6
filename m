Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C30C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF8F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i/vWvacq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ecjGrxOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF8F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeIKThb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:37:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:37:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 52B3060807; Tue, 11 Sep 2018 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536676675;
        bh=JLGn1Hy/5H1/qmEPHDTQWg/8iK+jgybycNC4KBQGV9U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=i/vWvacqNZYqv6gw/8pkwCNhUaI9eru6o4TGHqrUCXJU+8itEJF3eUj+kEXrkOLXJ
         PoTXzZNJbkX9+92kB2gVAZcga+KSegB/c3Ia0c+jw/PXUxJj3gCVJQ66Rkdq9KxEmX
         WtrrgZs6MOcT4HHjD76x4BfD1Lx7senZXz8zwvos=
Received: from x230.qca.qualcomm.com (85-76-111-141-nat.elisa-mobile.fi [85.76.111.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BB25601CF;
        Tue, 11 Sep 2018 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536676674;
        bh=JLGn1Hy/5H1/qmEPHDTQWg/8iK+jgybycNC4KBQGV9U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ecjGrxOY9YP89R9gILYL88Z4G1AjY03IB32CVOfxKIGUfUR/LD4WGDCGPAbmmLY4g
         pBYEis1F/7MUNQ94Vy26bGMEbI3A0OWVdO3gBvfh+DY4DmZmWDRzIYy6U18eRVTvmS
         wuMatr2TXI8AUPFsdT/SLb3vndB+O/Lp70++T1Ng=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BB25601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt76: MT76x0U requires MT76_USB
References: <1536239203-21733-1-git-send-email-martin@kaiser.cx>
Date:   Tue, 11 Sep 2018 17:37:49 +0300
In-Reply-To: <1536239203-21733-1-git-send-email-martin@kaiser.cx> (Martin
        Kaiser's message of "Thu, 6 Sep 2018 15:06:43 +0200")
Message-ID: <87worst802.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc linux-wireless on wireless patches)

Martin Kaiser <martin@kaiser.cx> writes:

> If we're building MT76x0U, we must select MT76_USB. Otherwise,
> compilation fails because of undefined references.
>
> MT76x2U already does this correctly, fix it for MT76x0U as well.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

I believe there's a patch pending to fix this, but due to so many mt76
patches it might take few days before the fix is applied to
wireless-drivers-next.

-- 
Kalle Valo
