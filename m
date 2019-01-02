Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D673C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5F21019
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4T3IlEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfABFFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 00:05:05 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33050 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfABFFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 00:05:04 -0500
Received: by mail-ua1-f66.google.com with SMTP id t8so9581435uap.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 21:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gaohg0wZGMgIpNYtlxoYy9i+OHcCm8tEg1sENdXQk4=;
        b=b4T3IlEs4CDS2oYS13y8+hPgXdHsf9+crHiJoZ3FgamJxGaI8ErCIOa54Z1tdWQGbA
         OShQ9OYdv8+1Vsmon2hupzGaaa4fVFS2+y4gtvE6QESPKzRk7zaQXp/dqDKp3BzBx0Cl
         3A80ANMLn+FFOa6A+Ejt1vO4tiokGV4dTtZO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gaohg0wZGMgIpNYtlxoYy9i+OHcCm8tEg1sENdXQk4=;
        b=S+ECTAUJ//f9rR5RKaOHiLaxgcoS/+ywIm1ihPL7m9a76aHzXhe20eNKs/Fd+x8fh8
         cxUtUgx9Gfmp1pAaY6RSUJVx77CEuXS7BmrgVADCnpEQJtoamM6v+IAkCXUpjjVUmRDv
         HyRPSGsaGYN2X7OnfZNzEZXkIdJ4R2XIgYgzgw/FjEjM3ilKEnv/ikSNGAHtx71ZAq00
         tiONh3dmid+vWU+Yo2ADYXfLEsncB5TeipGPAVCqMFywYeuOBUIYTU5Y+0xexrleKe04
         HAcMqSONO+Lr0HEkpFi+SQ/V9fkBqwkwTD2ox9zbo9986czIWwlUfwxgfLVDJ6oHevwI
         Xjvg==
X-Gm-Message-State: AJcUukf1mrotthduf9UtZ4BGOL6Xs07zzej9quXnjgmxldmX2W82L/Ex
        CHQVaECPBccljeNoqAgJwufCAMZaj/YD5ReVXCShT4bP
X-Google-Smtp-Source: ALg8bN5kt1vb7l/c7wEF5hfFNaz9qNxbqioZ5O9jN6mPWFm/RQD4BFQDi+5ZY9A6ZVI+Eh+e+Fe7VEc8ZagFio12ceo=
X-Received: by 2002:a9f:314c:: with SMTP id n12mr15874236uab.33.1546405503778;
 Tue, 01 Jan 2019 21:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 2 Jan 2019 10:34:52 +0530
Message-ID: <CAFA6WYOizPWj+DhWB0OcmApqSyTANTbr+eNWycMqYt-GpLz3xw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] allow optee to be exposed on ACPI systems
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 00:31, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> Similar to how OP-TEE is exposed as a pseudo device under /firmware/optee
> on DT systems, permit OP-TEE presence to be exposed via a device object
> in the ACPI namespace. This makes it possible to model the OP-TEE interface
> as a platform device gets instantiated automatically both on DT and ACPI
> systems, and implement the driver as a platform driver that is able to
> use the generic device properties API to access the 'method' attribute
> as well as potential future extensions to the binding that introduce
> new attributes.
>
> What remains to be discussed is how to expose OP-TEE pseudo devices,
> e.g., Sumit's RNG implementation on SynQuacer which we would like to
> bind a Linux driver to.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Graeme Gregory <graeme.gregory@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>
> Ard Biesheuvel (2):
>   optee: model OP-TEE as a platform device/driver
>   optee: add ACPI support
>
>  drivers/tee/optee/core.c | 94 +++++++++-----------
>  1 file changed, 41 insertions(+), 53 deletions(-)
>

Looks good to me.

Acked-by: Sumit Garg <sumit.garg@linaro.org>


> --
> 2.19.2
>
