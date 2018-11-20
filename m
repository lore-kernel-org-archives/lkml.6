Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F0C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE695206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQddnW+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE695206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeKUBaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:30:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36310 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:30:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id y6-v6so1127972plt.3;
        Tue, 20 Nov 2018 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mm8mUcUWUZdg44IL2+isYj8GElQafxgXyRjJt8DlIzY=;
        b=sQddnW+us4edJE55ZqyS9dkiUUgGKj6fUaa2Rb/idqgaf+/E4LF2sPcrOIDf2lA6vK
         +gCsd96tM3X5kEqXRsRpB6NU+TELbbRNRmXe/o0J8EV9QphJEGRzUlo7NqfYwuqICxXk
         TIVxCdOBoGDzS76hSO/YqyTSG82idpVd07y9Jqe9NRR4fBTsZbaWjMzCZkAcyCrVTZlV
         IiesXdlU49fwZPWUl84f1aLezrFIE7Tn+PokuvqFLi3ys0ww+RlxOavUnIr0umcNrrN5
         w6x5ohHJ+QA03HYEV1ZvOrSVWCIReFE5B4FXfklKGdDQP/Zb8JwQmjEQmkH8ZNngjO0u
         gNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mm8mUcUWUZdg44IL2+isYj8GElQafxgXyRjJt8DlIzY=;
        b=CiJWurH7P7HcYsTvqty2DQEsjGEnQA8IMUiuCuIG2DKCCeqHBP26FRFG9zJ2na7h9+
         qWETRNGejgU9Gq5hxbVUK8ulU+CXAMNzgqIwsFMoeR0krbUllhAaviP/VWToN47vg0qN
         /jifRs6cNIqKdbKwEq0G5WQZAtRjLdoCZnUDHk98H2zkqfShY/0TK8np/NFFJxupQcBv
         7fNBSYdaFWFtbnqrakfIeVxO54AH4GgUi09s2ObqJpLOB0nITT7L8l3dYvzK5F+UeD6j
         hJC3eWACievuvqBJzjgLGTppeCXEEs4s99CTejwmduv5Je6dnlnVH04eI4Bh5BPKfjLP
         DjHA==
X-Gm-Message-State: AA+aEWZB9fJRGu+u4DDvdr3iO2ICaY36e8pEpD1BUZRkWAplkJTQj5Z3
        gJ4Xpkb0DiHRbS+DXA6+Ty8BM/Uf
X-Google-Smtp-Source: AFSGD/VG7zd5LQJU1Lx6CSNfEmeEaN8iaUXvdU32hXMNdXlujwMe8NcArs8RusVMyWZOvKRuRFtHQg==
X-Received: by 2002:a17:902:d708:: with SMTP id w8-v6mr2532009ply.72.1542726034646;
        Tue, 20 Nov 2018 07:00:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14sm31317662pgv.47.2018.11.20.07.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:00:33 -0800 (PST)
Subject: Re: [PATCH v2] watchdog: cpwd: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181120145445.20730-1-tiny.windzz@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <205bee9b-7323-77ce-3f08-fa23ce7bdc9a@roeck-us.net>
Date:   Tue, 20 Nov 2018 07:00:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120145445.20730-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 6:54 AM, Yangtao Li wrote:
> use of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> -do that right after its last use to also cover
>   error handling.
> ---
>   drivers/watchdog/cpwd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index aee0b25cf10d..32156e199c51 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -570,6 +570,8 @@ static int cpwd_probe(struct platform_device *op)
>   	if (str_prop)
>   		p->timeout = simple_strtoul(str_prop, NULL, 10);
>   
> +	of_node_put(options);
> +
>   	/* CP1400s seem to have broken PLD implementations-- the
>   	 * interrupt_mask register cannot be written, so no timer
>   	 * interrupts can be masked within the PLD.
> 
