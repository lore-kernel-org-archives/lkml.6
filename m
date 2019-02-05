Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94755C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FD1217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VMEHbjmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfBETk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:40:26 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33434 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfBETkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:40:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 236F88EE241;
        Tue,  5 Feb 2019 11:40:25 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id heSaB2JM460B; Tue,  5 Feb 2019 11:40:24 -0800 (PST)
Received: from rrcs-24-103-236-65.nyc.biz.rr.com (rrcs-24-103-236-65.nyc.biz.rr.com [24.103.236.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 16B0C8EE1A0;
        Tue,  5 Feb 2019 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1549395624;
        bh=OMonKztN7QCLx4iMKuZI2D53Vxy0jzIxuXKKOqQaUBM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VMEHbjmBFXmopITKt6Fhzxayf7D74w2wcfePka4ltq76f+6JQyW5zB02VbaoChaNN
         FMl9Ulm0oPxIb4yKfPhKKO02i90c8W/YVbayYw/DRce9B6R+gKNGDkvbnfcXvohzQz
         UTDP4uYoTgpml+bT6n83NeS7jt1usF77gHHlwVfo=
Message-ID: <1549395622.2923.14.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm/st33zp24: Fix the name collisions in
 tpm_st33zp24_spi and tpm_i2c_infineon
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        zohar@linux.ibm.com, stable@vger.kernel.org
Date:   Tue, 05 Feb 2019 14:40:22 -0500
In-Reply-To: <20190204133749.14176-1-jarkko.sakkinen@linux.intel.com>
References: <20190204133749.14176-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 15:37 +0200, Jarkko Sakkinen wrote:
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c
> b/drivers/char/tpm/tpm_i2c_infineon.c
> index 9086edc9066b..b9d5a1dda8d2 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
[...]
> @@ -527,8 +528,8 @@ static int tpm_tis_i2c_send(struct tpm_chip
> *chip, u8 *buf, size_t len)
>  	u8 retries = 0;
>  	u8 sts = TPM_STS_GO;
>  
> -	if (len > TPM_BUFSIZE)
> -		return -E2BIG;	/* command is too long for our
> tpm, sorry */
> +	if (len > TPM_I2C_INFINEON_BUFSIZE)

TPM_I2C_INFINEON_MAX_BUFSIZE, surely, otherwise it won't compile ...
the kbuild robot just spotted this as well.

James

