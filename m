Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE5C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C21B2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ux4vf6P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C21B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeKBAiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:38:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46078 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBAiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:38:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id v5-v6so4606167pfm.12;
        Thu, 01 Nov 2018 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sAw/2bmGu8nzKFtS58H47jESWAgkHs7jtwqldvIMr9U=;
        b=ux4vf6P7ylNuSRDE1KaZ3gvHa1m5BXfEOcjjwHtL+OHP5eobH4oAxywGG7cN6YupSp
         kKDu4KopN22T22O5wAxqCkXe1wlSJkajYMxuhr9CHysF0WELPO+zO6PSVEq/Soenvofr
         OZA0ENV1NlGIl1FjIrwhUXeAM7KlCa/2jpQsKZos8+Azk5DQnpo1CBznVb0QbeX9Nl1e
         LXl9f9ksxgB5Sd9yfBnXtaQF+qqFP9CFKCCbnET3kyYtlqk1i2zbw2ZnzgunJqFbos7Q
         LZigNziCYdgyTHYZfjVZ+BJBLtDORZmsgMgQ58OGYveo3rxIdgz0ZHZ6mdAjdG5FQdeO
         FKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sAw/2bmGu8nzKFtS58H47jESWAgkHs7jtwqldvIMr9U=;
        b=T92215thosjY4y7JEOwgMxALqku66lciGtLDn8Ww+YJSSz4xXtWouS8IDf8IVV2ivJ
         cBglSpVLL8aAxH0vXYwEGmCUuF2mMXaFmymiKimJ3A4Di5pB8AUqv9wCaHbJdWHOvf0H
         5ILXh5ssay8Xudmzk1P8BFxO/pOTGJ3zVW6of4CWDAbAmuvuaDArAR3E/oiQgI9eWiB+
         v6cY3d88nMHJ6xIEIYwbxhwQVvYysiS+lZjnY0SIjDpnv/U74dtZo2UFxL5EIqJDeRIo
         1pg2PkB4M/J73mvN3y0NgtGmXAPLF/HHJBpuT77a0YwOVNq5fSNVRwJjh6J7g5fUKhWJ
         674w==
X-Gm-Message-State: AGRZ1gKBGRRyUPHXPV1CsgYAW/exEQ5G0drCDEN9fbRQrli0UShyJh7D
        YtGblUW/CG3v1SRIUc06FGI=
X-Google-Smtp-Source: AJdET5edefXK2aPbro/Cbz710lhN0+QHJSqZEkibo6CjUy3P5NGBZgyq83UnB04doCmkzVluFWSnng==
X-Received: by 2002:a62:9015:: with SMTP id a21-v6mr8211055pfe.49.1541086517810;
        Thu, 01 Nov 2018 08:35:17 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id g7-v6sm15908362pfo.139.2018.11.01.08.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:35:17 -0700 (PDT)
Date:   Thu, 1 Nov 2018 21:05:09 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] staging: iio: ad2s1210: Add device tree table.
Message-ID: <20181101153508.GA5176@himanshu-Vostro-3559>
References: <cover.1541000375.git.nishadkamdar@gmail.com>
 <ee142522b129dd6fd8d71b5567d9c6711e89efbe.1541000375.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee142522b129dd6fd8d71b5567d9c6711e89efbe.1541000375.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:30:36PM +0530, Nishad Kamdar wrote:
> Add device tree table for matching vendor ID.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index d3e7d5aad2c8..7c50def91a2b 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -701,6 +701,12 @@ static int ad2s1210_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id ad2s1210_of_match[] = {
> +	{ .compatible = "adi,ad2s1210", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);

I believe this needs to be documented at:

Documentation/devicetree/bindings/iio/resolver/ad2s1210.txt

Cc'ed to devictree list + Rob(DT Maintainer).

Just wondering why didn't it came up till now from the IIO reviewers ? v7!!


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
