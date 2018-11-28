Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B94C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776C920660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6Yxmdgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776C920660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeK1V42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:56:28 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43081 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeK1V42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:56:28 -0500
Received: by mail-wr1-f43.google.com with SMTP id r10so25790121wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=peb2CMWYGnPnF1h+DkmNVlAiKPzlmpt2jBjxl/6OVtQ=;
        b=P6YxmdgibSf/aRVawrMfOuokxS46qJjFHwfy7ZHlMXC/rqXfdysN2oE5bpdw44kdhN
         GaBci4AIppklly4dFEQ2VMtj2zBmMqcJns/EuNnXc/x46iFMj4lv7HpLAAKg1lhkzveq
         BbHD1ZLNICtUnEdDle8gMKVZkKE9v3HzkAKUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=peb2CMWYGnPnF1h+DkmNVlAiKPzlmpt2jBjxl/6OVtQ=;
        b=bmsnj8BdYgOJ+2b++ueSdW+m7A6ssT6wYTRmJ1/LJJvR0DuB0Vm3xcJKIJzM8Xwxr5
         UDVQxV6XwW9DanBueZlNbARWMIlczhTk7kvQRTFKR6LoBlHAegUWW9zrHPkDb1DFfzpw
         89DHlSPS2hiknQH6dVomEvCgwufauCoMVdid/v7yIEwsRvX2bUsrUSkJmWJO6q8LXdXJ
         0wnOeURlS7lStHMvPQ9FsjErYcLPUmyJiCAyMHNuDcIvc8F4r+1ajspZxFR9dogs8Txd
         qMMR7+00ZqOw8l50v+I2P95EtAxroS70nv5ceMN5ZQs4FW6PDYQL3CL54/I6ZfKrzFfB
         4zeQ==
X-Gm-Message-State: AA+aEWZazpc8ttV6ZYVheIwgoMmjDdDxyLuw5Za6Rd4HBB5AHJsjZsBi
        uyuyPxNvcgvTUscOwP997nPwZg==
X-Google-Smtp-Source: AFSGD/VA2Pg9jQaWSynO3q/CRzAayQF5E2sBctqg/rP95OtDLzlr2bHkQY0v1F+PLtoUn0xpqLahAA==
X-Received: by 2002:adf:b253:: with SMTP id y19mr30294684wra.184.1543402511820;
        Wed, 28 Nov 2018 02:55:11 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id l37sm6437111wre.69.2018.11.28.02.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:55:11 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:55:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [RESEND PATCH] mfd: wm5110: Add missing ASRC rate register
Message-ID: <20181128105509.GF4272@dell>
References: <20181128100422.12918-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128100422.12918-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018, Charles Keepax wrote:

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm5110-tables.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
