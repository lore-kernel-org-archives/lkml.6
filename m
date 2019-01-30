Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164ECC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D162E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUMIEd0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfA3Bl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:41:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43651 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfA3Bl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:41:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so19272316lji.10;
        Tue, 29 Jan 2019 17:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCw/v3+bOZH7JGDJm+8M+2F5RTIP1A1glCj097bkxJs=;
        b=VUMIEd0dJFLNunLJqNRBY8jZ5IDkPlrSN9ZZycbUSwotcj0iJtt37vVva8YAf2CPnM
         T0bHF4BOwOKU+UFky7tdbco83icf2FNZtH6oDMftoXyY3spmsD0NWHIP1AymyovVZ3Ex
         7xfcYY34e6geyK8+1XMPKm3XU8XpMtl4cAe/RG++RxxsI+jwWUGq4je2SgbToz2zZ47h
         4TvhV1Sf+18qxD3Rzd8azCpW11Ydp8pKO5WibNllXXCtAotGWZEogM0UCZPJO2TeNeoz
         JrJDcS9mCuT34mBBtp3WxZKNexgqO3ImyGM/q6Swg1bQb8E6oA2ewUjsfRtS7rHn2WNA
         WDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCw/v3+bOZH7JGDJm+8M+2F5RTIP1A1glCj097bkxJs=;
        b=QMYQTsMkuC38YBZ1ibbXYcA+Hchr8U4bA3Tzw8GI89yRdbyatJAWDdggCpexgtD5J7
         fJCESoMFmSnLikzVlVHXRCLfhTcBdJJcsz/SCwFfb3PM7aKIfbbqotmvn8CTpVHgo+Pg
         Ftn33iOo9o5KmuMa6YPJqrQq4c/r/Wlhvm7X7UroTQCmkPRFdD6dYg++RWa2UOZNgjGX
         0krHgtxkECUyTV0akbLxcfsNPvSjmRiHTkaYopw8/mWz6/cVKGiZxZ6V0kU5U8BhSAIa
         kSPoqkoR7ZXT82WzrbUPcGE3SQvyzOOVyiJ/Jo3mtMd/zy8d5LCA7l0sqKbn/6pJxiqC
         6jTQ==
X-Gm-Message-State: AJcUukcpVspCvdWxECYcyR59LLDLepbRrQPpMF/oLG0jDASa6G7KuOmL
        mw1GyodwhDJpWh21RXoP+jc=
X-Google-Smtp-Source: ALg8bN5mg233oUxlmmddgsAee/y2VzD6eH6hbqj3RMW/F7M+Kh69FbwvY62uHxNDPQgdSTrUcJ/gKA==
X-Received: by 2002:a2e:6c04:: with SMTP id h4-v6mr22784375ljc.92.1548812515034;
        Tue, 29 Jan 2019 17:41:55 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id v5-v6sm9821lje.78.2019.01.29.17.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 17:41:54 -0800 (PST)
Date:   Wed, 30 Jan 2019 04:42:14 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190130044214.65991195@dimatab>
In-Reply-To: <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
        <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Tue, 29 Jan 2019 15:16:09 -0800
Sowjanya Komatineni <skomatineni@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> This patch adds DMA support for Tegra I2C.
>=20
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
>=20
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
>=20
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V5] : Same as V4
>  [V4] : Updated to allocate DMA buffer only when DMA mode.
> 	Updated to fall back to PIO mode when DMA channel request or
> 	buffer allocation fails.
>  [V3] : Updated without additional buffer allocation.
>  [V2] : Updated based on V1 review feedback along with code cleanup
> for proper implementation of DMA.

Could you please tell whether you missed my comments to V3 [0] or chose
to ignore them? If the former, then I'd want to get answers to those
questions and comments. I'll stop here for now.

[0] https://patchwork.ozlabs.org/patch/1031379/

