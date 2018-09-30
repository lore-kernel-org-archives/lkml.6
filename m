Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EDC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E36E2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnDN5ipG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E36E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeI3RBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:01:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34848 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeI3RBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:01:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id y19-v6so543348edd.2;
        Sun, 30 Sep 2018 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L03/iIZ5wIox/kok3JI+Cru7RDwaRW1PuAdZk4oPZ0I=;
        b=RnDN5ipGsH+rFhRK2GSoA4o/JRBrKZ0L1BzyBLQS3KXgVINC1k6zsX5EEHkaQxhPOf
         qsCodg6q60xeQwBumOUSq0zjeQSFObIb7D+ZZThTFjKnLEu3TNvIgDFcCpNxluPRGDU/
         M4W0CTgYn30ZDMJlTfqNMXoJ3ddZkiR3uxt5BvDLSfmSD9UbC1zV9Ot0Ykgmxsed2tD6
         FnCKocEnkUu1CihXhAu+K62uP6rb0ZgibVIAd0PqIFQg75r+uEbNdlI9JDBsym89g1a6
         NhwM0/Uugx7NEw6x8JpTzkcRRhNHohKUlK7mvr0c4epYMLfWzSmhtSuC2XVpbKx8Bg6q
         KAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L03/iIZ5wIox/kok3JI+Cru7RDwaRW1PuAdZk4oPZ0I=;
        b=uA3eT54bsYubGksgMrt+pgNVugZVm8kVswgLbjTaMj+HhyRl0CKvPIg+IZ96z0Cdjp
         5foUxrIFAB0QqfEMuEsBQMUOUC3I6ayBN3yaaidfL+Zz0eDgo+OgoImPUqG5QlCgfKGL
         Fz9s3e/4oOJln2Mv1ax3EAC4aDTYYmEzRQ82Shvugsuoxh1VpsYzOHYKKiRkqcwnkKgn
         8oUpAHr/oF4xeE79/8VqQy1iVRaCdTN/MLT+exFUISyaROIYUNe5eNRQdyxvpSx0deIX
         vdsVs7XLoM0CXwr/BegrzJkOhf46yxiLxzDFXf0ptPC9xo+jVN6QSbOYqz98Wyzma5QZ
         61BA==
X-Gm-Message-State: ABuFfohTou1XvX4ZpxvMQ1/d2ovunFeHb+XOICwOgHeToXjj75IxP/91
        uKSuZIb46YSdo2ofuT080NjXbcUF
X-Google-Smtp-Source: ACcGV60wOAErxfXCHbMegUaijkRIM1SpvO6z2eRI3xhO717VxpfF33dppX5JkMmGCNZNZQ7DV/cHDQ==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr12116309edr.38.1538303356623;
        Sun, 30 Sep 2018 03:29:16 -0700 (PDT)
Received: from localhost (87-49-147-65-mobile.dk.customer.tdc.net. [87.49.147.65])
        by smtp.gmail.com with ESMTPSA id n25-v6sm3341057edq.27.2018.09.30.03.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 03:29:15 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com
Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of undefined bitmask for rxdata
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-2-chuanhua.han@nxp.com>
Date:   Sun, 30 Sep 2018 12:29:14 +0200
In-Reply-To: <20180930092535.24544-2-chuanhua.han@nxp.com> (Chuanhua Han's
        message of "Sun, 30 Sep 2018 17:25:33 +0800")
Message-ID: <87ftxr6zyd.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> This patch fixes the problem of rxdata being equal to 0 during the XSPI
> mode transfer of the dspi controller.
> In XSPI mode, If it is not deleted, the value of rxdata will be equal
> to 0, and the data received will not be received correctly, causing the
> receiving transfer of the spi to fail.
>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
>  -The original patch is divided into multiple patches(the original
> patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> mode"),one of which is segmented.
>
>  drivers/spi/spi-fsl-dspi.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 3082e72e4f6c..4dc1064bf408 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -243,9 +243,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
>  	if (!dspi->rx)
>  		return;
>  
> -	/* Mask of undefined bits */
> -	rxdata &= (1 << dspi->bits_per_word) - 1;

What is the dspi->bits_per_word value when your rxdata is set equal to
0?  Could this perhaps also be related to byte ordering problems?

>  	if (dspi->bytes_per_word == 1)
>  		*(u8 *)dspi->rx = rxdata;
>  	else if (dspi->bytes_per_word == 2)

/Esben
