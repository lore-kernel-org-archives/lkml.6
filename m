Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7064BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25868208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDpjX/KE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25868208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbeFMJIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:08:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34293 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeFMJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:08:11 -0400
Received: by mail-io0-f194.google.com with SMTP id e15-v6so2703607iog.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pz6hVnzdNOiIbXnebnfIGD9gWMg3c0Uck2Qkhe6fWsA=;
        b=JDpjX/KEKeBEuiIzBLbih+X9f52tTcia5wPcCanBTDawyCwUrgoTNhq3oxgxgv/os8
         aDDH9k/2MkVMuOiVXDMTojWt3dsBwQ/JWufY4P2LBAj30wK6SNgvKqChs4Y5V2dMEhib
         JwIfzw6mBFCFnCXgoAF+TxGhNyvR2q8NIFQD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pz6hVnzdNOiIbXnebnfIGD9gWMg3c0Uck2Qkhe6fWsA=;
        b=jR4lz5zEu+DgRecHuoySVhVEr3fe/OERgTk2FWatjy95KT3IjP6JG0z3h+o2tjWllS
         bzId0VT39vtEsusBuXkq4pFTAEmGzzpTy+Dsg4coKa/TTS8cwuMtmy4tgJbnzZmTrYox
         sjHtBpVC0JK+6/lae3riylknxRy1Gc1BA74KcdjEj8SCs69Oi9Narbvy2O9xMXOtXNyu
         t+CZezh+EBwSmXerFGFgSXhtPJL3li8v18fzcvDPL3IeoH9+JLvWjgNDnM5++UTAPXmG
         4raDxHsATAGxZqaOOzHmXjdGt6B2viWol0JIlfuX3C6+LR9WfjGEgkWttLOOnmHRCuom
         robA==
X-Gm-Message-State: APt69E3aHjUIV+YOpl1D7KaQ2ESVXfvyEl6L6H108bIeeCZQydSEoRgC
        dzIO8cskDvnYsa+GcCbTtiN6TaHDNvYfUFSFNsqCCQ==
X-Google-Smtp-Source: ADUXVKLamH1KYzDHa+Xj5g8WQr//wZwzGXFY98gpEu0FbFPlugVzCredg7N2t+cKU3CaPoDj5ooqHk+89Z/xWi0YofA=
X-Received: by 2002:a6b:106:: with SMTP id 6-v6mr3879669iob.175.1528880891069;
 Wed, 13 Jun 2018 02:08:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 02:08:10
 -0700 (PDT)
In-Reply-To: <20180604141528.15635-2-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com> <20180604141528.15635-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Jun 2018 11:08:10 +0200
Message-ID: <CACRpkdbt=2diDRueUqdEnHxViG-Nr0Rcs-aW67hjgrQnxQUaAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: ftrtc010: handle dates after 2106
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use correct types for offset and time and use
> rtc_time64_to_tm/rtc_tm_to_time64 to handle dates after 2106 properly.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
