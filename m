Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qx2wKorYGFsZUgAAmS7hNA
	; Thu, 07 Jun 2018 07:05:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7E5FD607F7; Thu,  7 Jun 2018 07:05:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bdqhfx3T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19CB5601B4;
	Thu,  7 Jun 2018 07:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19CB5601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeFGHFq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:05:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37182 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeFGHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:05:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id d8-v6so8814637wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 00:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NX5z+GtLd1Tu8fMuWoM7tlJ7QpgpqhgGyJx9Qqic6vM=;
        b=Bdqhfx3ToZSP15pBuAMLljNU7aHD8HhaDZ+KKrr2mpj/I4LOyaZZFNAMUFkmk1i+q+
         tcy2AZUXKwJY2BlqfZd6AFlWZbaRa88ZT0Twl6QGDqqm0nknMmw8sh2Ua5J3jKQYqgO5
         dbhUcU+zkz07RJUTHnWwnBrezdeGhlbq8t4v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NX5z+GtLd1Tu8fMuWoM7tlJ7QpgpqhgGyJx9Qqic6vM=;
        b=MjhGtNT6PLK3wo0S3lKT4DMPJwQfORmRb5EjPMiDxwBhQYxKXfa3FURJYdpyzEkKCq
         v3RgUfFTsdJh5q2vBut63K37aC0YuorTpLtnmigxxNaFs+f/MavogRdreF6378ojlumZ
         wfYaeAFCHDHlQp59CGyoMtrPopPHHOEMaK2/4Aa6iNoJ7NKBBXIeadzI4VO5fdexh0KE
         n6IS3Nq6jgbghbbpDUw//KUDWFG8HBL/YQo0cgQU00YBpzW+tQK1hLyWIajiOkSC4BJk
         iEMnSQm1YfJb8s2VehMV10TpZQfl0aYbM77EYUFVin/xV1bP/P7oyCngmS5N/ZJaq5Ne
         sF4g==
X-Gm-Message-State: APt69E1DiacxolqfZUocNlgwMm48rCfY3VPp9hhut+6YfBgfmzajt1mf
        Itz1ziwxOtHrpM800yglvINYGg==
X-Google-Smtp-Source: ADUXVKKzlMib7lfTahKFo0A90hHBq0OzmQFNu1y7JbKKgPLYuILzTF0Yv174T89y+6Teg1FckmbVHA==
X-Received: by 2002:adf:eb8f:: with SMTP id t15-v6mr597933wrn.243.1528355143636;
        Thu, 07 Jun 2018 00:05:43 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id q7-v6sm51278861wrf.0.2018.06.07.00.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 00:05:42 -0700 (PDT)
Date: Thu, 7 Jun 2018 08:05:40 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 04/14] mfd: da9063: Use REGMAP_IRQ_REG
Message-ID: <20180607070540.GA22841@dell>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <20180606100003.17067-4-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606100003.17067-4-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Marek Vasut wrote:

> Convert the regmap_irq table to use REGMAP_IRQ_REG().
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> ---
> V3: New patch
> Note: A sed oneliner was used:
>       sed -i "/\[DA9063_IRQ_/ {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* = \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
> V4: Formatting fixes with "s/,/&\r\t\t      /" on the array
>     Drop extra newline in da9063_irq_chip
> V5: No change
> ---
>  drivers/mfd/da9063-irq.c | 175 ++++++++++++++++-------------------------------
>  1 file changed, 58 insertions(+), 117 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
