Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3DC7FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77DA208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nu5pJfMd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nu5pJfMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77DA208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935169AbeFMJ53 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:57:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934279AbeFMJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:57:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B6E98607A4; Wed, 13 Jun 2018 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528883846;
        bh=Eh/9sCDAbrdsY7ST/vD/H81+5gIIWz+WdJjtbBou4UQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nu5pJfMdfGdL0z/CUBcGOurXKlpeeewUnVVb2D41JunY6gOJTxzHgnJFCFeweBIPp
         +S4otKLJpqHorjMoFEpycARWN1E7hL55n1BEOjU1x1ZEoB2CiartuoWg97VjnP/NdI
         MbA9zG/HPvxjYBytg7MQBdkvcsJC04Hk1Djp4Lm0=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BCED602BC;
        Wed, 13 Jun 2018 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528883846;
        bh=Eh/9sCDAbrdsY7ST/vD/H81+5gIIWz+WdJjtbBou4UQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nu5pJfMdfGdL0z/CUBcGOurXKlpeeewUnVVb2D41JunY6gOJTxzHgnJFCFeweBIPp
         +S4otKLJpqHorjMoFEpycARWN1E7hL55n1BEOjU1x1ZEoB2CiartuoWg97VjnP/NdI
         MbA9zG/HPvxjYBytg7MQBdkvcsJC04Hk1Djp4Lm0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BCED602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>, kbuild-all@01.org,
        "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ath10k: ath10k_snoc_get_ce_id_from_irq() can be static
References: <20180612113907.15043-2-niklas.cassel@linaro.org>
        <20180612145037.GA95182@lkp-ib03>
Date:   Wed, 13 Jun 2018 12:57:22 +0300
In-Reply-To: <20180612145037.GA95182@lkp-ib03> (kbuild test robot's message of
        "Tue, 12 Jun 2018 22:50:37 +0800")
Message-ID: <87d0wvau0t.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <fengguang.wu@intel.com> writes:

> Fixes: aecf55e7df3a ("ath10k: allow ATH10K_SNOC with COMPILE_TEST")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

There's already an identical patch pending:

ath10k: make some functions static

https://patchwork.kernel.org/patch/10440159/

-- 
Kalle Valo
