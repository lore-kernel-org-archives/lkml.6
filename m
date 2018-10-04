Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B676221470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B676221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJDOC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:02:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44944 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDOC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:02:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so7378236ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k1hctBUUTL0oKb486N6aJBvn4KSXrX3CIotba3f5wLU=;
        b=VmwcJJidOWPvljoNQ4N0WCVJpRbkrTQp5sLvKX0Oqt9B5Em1FxPjdfWKmZLO86SKy2
         qJDmbjhT+RApK2UPjkOFnemlhKvqRiX7k1TRWCgWXwFcWQjEOZ0UcD63q4KRMK6pyo+E
         ilOaOanFaD9qxxTJBDEdHypF32qySMRrASRMt16UepNa5o8+n+T7WxqdckgAUbfwiKB3
         t5ip+NedSPmFZJSQLpj/eEuubZGX8XSy54v+cY5tvQOh+4rtPjmboQs7rdXyKblI5gzQ
         Od8JD+dyaYBPa6rT4B8bvZt4ybCfFsShcxuHPfRup6Xg8iXCq8TnfmLaOaDCYDaIDVTp
         5rQw==
X-Gm-Message-State: ABuFfohn4+36mukhzVLvg6DVapHkObajc2nzkBedj59ZYOk6zcOhcAwb
        gJmgzveDYd+cxf0xE7kmw7U=
X-Google-Smtp-Source: ACcGV60C42VJ6l+HF4Xf0pTYKWtO5g7Is8f5wjGADn7J8QyCBt7hSB8beCkWkEZB9e8UgaOE3ssing==
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr3481257ljc.61.1538637035987;
        Thu, 04 Oct 2018 00:10:35 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q75-v6sm790946lfq.95.2018.10.04.00.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:10:35 -0700 (PDT)
Date:   Thu, 4 Oct 2018 10:10:33 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regulator: bd718x7: Remove struct bd718xx_pmic
Message-ID: <20181004071033.GB2029@localhost.localdomain>
References: <20181004065148.26861-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004065148.26861-1-axel.lin@ingics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:51:48PM +0800, Axel Lin wrote:
> All the fields in struct bd718xx_pmic are not really necessary.
> Remove struct bd718xx_pmic to simplify the code.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> v3: Remove the references to struct bd718xx_pmic from include/linux/mfd/rohm-bd718x7.h
> 
>  drivers/regulator/bd718x7-regulator.c | 59 +++++++++------------------
>  include/linux/mfd/rohm-bd718x7.h      |  1 -
>  2 files changed, 20 insertions(+), 40 deletions(-)

<snip>
 
> diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
> index 26acf9a92498..7d29e3599793 100644
> --- a/include/linux/mfd/rohm-bd718x7.h
> +++ b/include/linux/mfd/rohm-bd718x7.h
> @@ -321,7 +321,6 @@ enum {
>  	BD718XX_PWRBTN_LONG_PRESS_15S
>  };
>  
> -struct bd718xx_pmic;
>  struct bd718xx_clk;
>  
>  struct bd718xx {
> -- 
> 2.17.1
> 

Please also drop the pointer to struct bd718xx_pmic inside
the struct bd718xx.

  struct bd718xx {
	<snip>
	struct bd71837_pmic *pmic;
        struct bd71837_clk *clk;
};

Br,
	Matti Vaittinen
