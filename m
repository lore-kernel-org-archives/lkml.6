Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67D9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEB9214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vfeAdzx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEB9214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeIQTMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbeIQTMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:12:50 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E42214D5;
        Mon, 17 Sep 2018 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537191925;
        bh=M8GXuPUawIrSiHck5sp02hlOOIFO5mS+/NElx8RjSbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vfeAdzx8/O8PvvV9mteugkyc8A6JOHred42tXB8BNyjHx93mxG0+VGh3pf2Kga8bM
         x8LN34Qw71/kgbffJxgC8EjE32dUqzq5eeoEXUiNWChoKHetv4+4nT66LNCxHDswAT
         ksFsZDfwMKCdhg3N933TVjwILhArBxFZzKK/nvx8=
Received: by mail-wm1-f41.google.com with SMTP id n11-v6so9665375wmc.2;
        Mon, 17 Sep 2018 06:45:25 -0700 (PDT)
X-Gm-Message-State: APzg51DH4fdZlBz4gSiv8JlXR7kiuqY0idSCje8tZu+aOl/qJ4dvVgaI
        kn+THfvtOV5juHybgnVsh8IrTWu5Ls84FweHSMI=
X-Google-Smtp-Source: ANB0VdZbX9yQqv/hdNgdAJZ5tDA26q4RH6vLmrxBOdc4HJ+ttVEqtBSMoEHRn9kvsR4jplFbqo7dHgXkCp2cuzH/wRY=
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr11809229wmd.45.1537191924009;
 Mon, 17 Sep 2018 06:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd@eucas1p2.samsung.com>
 <1536825522-6027-1-git-send-email-c.manszewski@samsung.com> <20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd~T5q-ljNj41220012200eucas1p2N@eucas1p2.samsung.com>
In-Reply-To: <20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd~T5q-ljNj41220012200eucas1p2N@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 17 Sep 2018 15:45:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfBnS-8odFaY35aBeOWbRWYDCCn40wM6tTAua021xytLg@mail.gmail.com>
Message-ID: <CAJKOXPfBnS-8odFaY35aBeOWbRWYDCCn40wM6tTAua021xytLg@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: s5p-sss: Add aes-ctr support
To:     c.manszewski@samsung.com
Cc:     linux-crypto@vger.kernel.org, vz@mleia.com,
        k.konieczny@partner.samsung.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 at 09:59, Christoph Manszewski
<c.manszewski@samsung.com> wrote:
>
> Add support for aes counter(ctr) block cipher mode of operation for
> Exynos Hardware. In contrast to ecb and cbc modes, aes-ctr allows
> encyption/decryption for request sizes not being a multiple of 16(bytes).
>
> Hardware requires block sizes being a multiple of 16(bytes). In order to
> achieve this, copy request source and destination memory, and align it's size
> to 16. That way hardware processes additional bytes, that are omitted
> when copying the result back to its original destination.
>
> Tested on Odroid-U3 with Exynos 4412 CPU, kernel 4.19-rc2 with crypto
> run-time self test testmgr and with tcrypt module:
> insmod tcrypt.ko sec=1 mode=500.
>
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> ---
>  drivers/crypto/s5p-sss.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
