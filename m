Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F08C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBE420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owQIFvR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBE420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeLET4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:56:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36180 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeLET4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:56:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so10578470plo.3;
        Wed, 05 Dec 2018 11:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioHcmEPNV2VqTNklnZabugbNKXLD6ax/88gsjRi4E24=;
        b=owQIFvR9oTQccXaumsvFTHkDUJd42je1mmMYpRNTl1CptK8JLjYWc/OCThjLi7OTyF
         ZRM5ePoouEVsWH0THbvJ9gI8x53KOzUSS7J5eC6zq2R4+l721diM/mzSMYL12xWur0eR
         FHVeE/bAeWRfPCTZLHkEXRH5He6eMpUgLq+SLZaXdQsjgzqor/kdyzcAUfUZN8ugH78Y
         G9uOV15+DopPfSEsgUE6Z0Ua+V2cfZpYLkdd+zXmSbFak2YrAnnyG6UZcDHoU1VIJYr4
         hvlsPwcT/PxAMJclTTNGw97tPErVOWA4ijy5QyB2GNhfj4h/k4RQqo2y5ZWJpycNTNhA
         tmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioHcmEPNV2VqTNklnZabugbNKXLD6ax/88gsjRi4E24=;
        b=umuXUNznk3gUpnlH3Ao8hChscnt5HGcYpxWsOI5PHdX8OMYR6vncoJwSgdzxj/GAGI
         2Dtv22SmL20VCCQnYjVgWmb+oSBMRi9yzlrGy73IELFx0AKvU+xKUPbCldu6Ity+Q0V7
         0xNltzbixrWpePhovocB6WT0+9tLVcPtir215Vgz0w8LJvgwivXXWownP/GSNhJRyvFH
         nt/rPJI5g/kfK1ZBoh32QFNZLtWWmQZdWedA75fbRDeuMOmETt5umiwmkg+QuI2fPBCI
         q1sLCJwM1j9Bjkx9xY2kHf+YqMtZ6VPzTp8GYATdbuwG/DJUXp4MFbXW/ZoQME8Kynn8
         FOTw==
X-Gm-Message-State: AA+aEWbB0VDcJTQmQExamGa4kIyGFZ8aU0jHRZYX9U0LbqRGV7kkMXoH
        UxbuEaSr3ILNfBoiwlTGe1A=
X-Google-Smtp-Source: AFSGD/X2aG1/RQK3vsa9D0PKjL/DXE6ZmiSOWYUKOJXKzCEREBxHFH9IdL7s4V0nrHIVN11iap72Qg==
X-Received: by 2002:a17:902:1102:: with SMTP id d2mr21320529pla.138.1544039761346;
        Wed, 05 Dec 2018 11:56:01 -0800 (PST)
Received: from Shreeya-Patel ([103.212.140.149])
        by smtp.googlemail.com with ESMTPSA id m85sm36499055pfj.171.2018.12.05.11.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:56:00 -0800 (PST)
Message-ID: <fccdb26936a9cfcd5134c760cd918929ad3dfa19.camel@gmail.com>
Subject: Re: [PATCH] Revert "Staging: iio: adt7316: Add an extra check for
 'ret' equals to 0"
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 01:25:55 +0530
In-Reply-To: <20181205014900.4827-1-jeremyfertic@gmail.com>
References: <20181205014900.4827-1-jeremyfertic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 18:49 -0700, Jeremy Fertic wrote:
> This reverts commit 00426e99789357dbff7e719a092ce36a3ce49d94.
> 
> i2c_smbus_read_byte() returns 0 when a byte with the value 0 is read
> from
> the device. This is a valid read so revert the check for 0.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> ---

Hi Jeremy,

As per my understanding, 0 value indicates no error but no data read.
Then how can this be a valid case?

Can you please make me understand that how can we consider this as a
valid case even when no data has been read?


Thanks

>  drivers/staging/iio/addac/adt7316-i2c.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c
> b/drivers/staging/iio/addac/adt7316-i2c.c
> index ac91163656b5..2d51bd425662 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -30,10 +30,6 @@ static int adt7316_i2c_read(void *client, u8 reg,
> u8 *data)
>  	}
>  
>  	ret = i2c_smbus_read_byte(client);
> -
> -	if (!ret)
> -		return -EIO;
> -
>  	if (ret < 0) {
>  		dev_err(&cl->dev, "I2C read error\n");
>  		return ret;
