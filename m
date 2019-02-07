Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC5B2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5g5tW3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGHwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:52:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36332 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGHwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:52:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so10417960wrv.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 23:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Io4CEugTfjoOhtmKmWLSQaxly91ozOx5/PJX6S5dpns=;
        b=j5g5tW3R5wTBCz8VAPPsRFfRrARSwxamCZOnDfTOp8FOKUYhjArG2H+bMhw9KmyPRb
         rgfzBxOLaEJCZkgs3fzgztux82M7GOsxEFzjthkoSrXgODNq3+blpvWIMLckmuVWrK9e
         +/YDlWjvubgzINeoHfr7HNoc/t9LInMMpE4xcHPy6nA4y3Wog3+FoBuLnhjFfmF5fhvP
         U+hLNKyPxakvj9P4FzKZJ3ef3Mt8KhNimkpl/1KsAZcvhjPgEEjFhZYOpLYHCugKI1xp
         EwvRMzy8MGMh+M5lhd3kKzsSgnTAjFaZbLEezMGwiKreGVh4aWxH8d8T1lV9pEEQKGpc
         Y6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Io4CEugTfjoOhtmKmWLSQaxly91ozOx5/PJX6S5dpns=;
        b=Y2eMq7ECf5LLKy9s38djh1SAAtcWdCgWIsvndojTEbVgPgxAfyyJuBBTANKxZarY0C
         PyiduOlqOjr6TPp+05qHfdi2UXyUbnF6nhti6zyubPtvS1npSpnywoCed43P7RF8VJPb
         NtyPlev9bbUoOh2cVYUw32kzpo6aqrPWLih6YzTYhG2HtsGfh8jaiaX2OKbjTbGtL0n4
         yTn9yJBS4fmtGUn9nHw7aeKCVAE0283y8ezKTTMsSdw7O8Y6HDqFErAXRBoLqUFRGTha
         BqlDMwghlOfUcjv7PiUpyXpoTN0rNmJdL+Jc6+JKorn2DT1GYjXtYu31NENcK8T4luEX
         zduw==
X-Gm-Message-State: AHQUAuZp3QPYkOBkr6qD1dv3tjv5aK68Mskzl2bXu9S6CIs6GT8epuwF
        EYw9UzZDmdJYCemPCWeTPW3ElybbIWCQbQ==
X-Google-Smtp-Source: AHgI3IaXrr47MNvmyR4XPVrDMHaffFtTZBb6kprMZqk2vhLGall1EZ8Hrz78ECoHOEtlkOA6AKeIEg==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr11083866wre.13.1549525930368;
        Wed, 06 Feb 2019 23:52:10 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id v6sm42710555wrd.88.2019.02.06.23.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 23:52:09 -0800 (PST)
Date:   Thu, 7 Feb 2019 07:52:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: at91-usart: No need to copy mfd_cell in probe
Message-ID: <20190207075208.GE4672@dell>
References: <20190131043213.29514-1-axel.lin@ingics.com>
 <20190131043213.29514-2-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190131043213.29514-2-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Axel Lin wrote:

> Use pointer instead.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mfd/at91-usart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
