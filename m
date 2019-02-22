Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7500720818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWIMgG6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBVIJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:09:54 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:40713 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVIJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:09:54 -0500
Received: by mail-it1-f182.google.com with SMTP id i2so1939061ite.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbkcZ5KfG5Y6nKOZPQp3ktD7+XSdF5U8q0bkVziFzL4=;
        b=VWIMgG6SlP7y6usgNUVwQZC+mPDDS1CeJq3N880qxFqppLrnBzR7+8ToUSzoFPou2w
         H3AxiS3xgjcMafjJgM71i4P4LSG6FGaAnI+vsUvQu1ZiRyUAiK2PiTYGPZmdU4zQPmrz
         8FHzyF7sEjtZwBNdUwRNkAzPWn2A+Am0LQSn/7+kUR25jduOkKgIlLoQM794meaE2EK+
         UzIqDTdg/XNQM/FuoD5ay/sqRL/Duju4Prx/lBR32g50nLFG9DCmoGJs8Tw2ChdQ9Qkt
         WcWmeoe9gckwdeB/VykDy9dX1UNEP0al53cHmjv7MexSQAeJ46uSgFxetrS0mu7urEiY
         EDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbkcZ5KfG5Y6nKOZPQp3ktD7+XSdF5U8q0bkVziFzL4=;
        b=GosKikISgo9DA4t2SIrxlDhnHBO22468KUdTXlGUehQuv4KYW/F138ckXhy6Ud3sFr
         oa1J3+wQxvyw5ECX/bgRbnYo2EDxP2nkcWa0EV9RGX8MYdBMsjs5k2p75bwa+jw8Ux8e
         Ijyko2x0tfgKrtFivScCNIX8WIO7+BEaNn0N0rwHstpUyq0pg8c0UPkUQP6ErCR3QkEl
         09EE2aCTfPV1u0RoWF+NTPgY82ouLuzurX9lYapB0doqQfJJ8PBUm7wIw56JpuItTJYC
         cG0q8eclXs3w1GypTJweVK3reLu4cMdqYmrXXiSODpWyLL+YyVDuRRDCg4BJdXzFRY3b
         edIA==
X-Gm-Message-State: AHQUAua9WfNDtm7RybAL52eTPLn4lAtkAXAx+YyxftIRfwybmjCWishk
        R/jzBR/eUFNPQQVob/w9/EWfyLrr08tt6CkWDlcO2Q==
X-Google-Smtp-Source: AHgI3IaqAuKCiy3mCU8M4dC0QSqYaD7o14z2FAkdRjJ9SNYgxNw6TlT/W+7vQX9utTAm80k6KWYYFz0BabPv8tGkJsA=
X-Received: by 2002:a02:5782:: with SMTP id b2mr1587796jad.2.1550822993613;
 Fri, 22 Feb 2019 00:09:53 -0800 (PST)
MIME-Version: 1.0
References: <1550642547-21968-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1550642547-21968-1-git-send-email-sumit.garg@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 22 Feb 2019 09:09:42 +0100
Message-ID: <CAHUa44ErR1Hw=5qbUGEqz-_VL1fh6sTAoVLEWK23dHE8O8sQfA@mail.gmail.com>
Subject: Re: [PATCH -next] tee: fix possible error pointer ctx dereferencing
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 20, 2019 at 7:02 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add check for valid ctx pointer and then only dereference ctx to
> configure supp_nowait flag.
>
> Fixes: 42bf4152d8a7 ("tee: add supp_nowait flag in tee_context struct")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I see that Arnd picked this one up the arm/drivers branch too. Thanks
for the help Arnd!

Cheers,
Jens
