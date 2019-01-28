Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2606C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DF120882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyuINxpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA1HQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:16:59 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:33650 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1HQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:16:58 -0500
Received: by mail-wr1-f41.google.com with SMTP id p7so16813010wru.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5qEVShp/ucL92YnTAkyHxPZJd6dP1Wbb7Igo/986O2w=;
        b=PyuINxpU6qZKkXrCCV0mV0smRsenBrrodrN1mTbew8wGj1Cym6xi8MJQ6/7kig+PrQ
         epneKdrOkljD9MlssIjkgavnHBKaUZAgnt41nAxNzmV58GlMBE6pfCi1uSn0Ca3rdhWG
         Evdl3PE4ryRqCTwtG3XjQWNJBC5myWY/3KgVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5qEVShp/ucL92YnTAkyHxPZJd6dP1Wbb7Igo/986O2w=;
        b=modp7DMfAXfWu7e3XMfS9LNVSMlj5CvZvmqsMiwFZsYcsenSB9o7PLQA6SR760eeq0
         GUJ8IWWzrs9rqqQ7yjG3xEh2FJEIs+cSZ2SeOmYeRxfG0NUOcxJFQqsm0QfNy8qPICSZ
         HeyEIdB+Z6+KkH4oK9YaAeCpx2MRXu0+WLyBajrWi7MQX1j/PH93UEfaqkfbm7UpecLA
         HGi506gr484lCyd8LCGZuAvoJylq9FaLMSgP1J8MJIkXofI1JMsByyN4IDGaWPcINNBx
         pSKhs0R6qbgepJ+GJo4FPpIarIftI/oKGSxbN8kYzkDQpeHVK8yJ12r0XLDJSgVonJfx
         yHqg==
X-Gm-Message-State: AJcUukejGtwLh0PeIceu9FOrG5FOhdPib3BSmThbo4dVx/PkNg2du1kn
        DosUjdV3ILrXgm7SWjuuykYoKg==
X-Google-Smtp-Source: ALg8bN5iY9yA7oPXs9hD/CFILk5abS9csHqtFC2Otk0qLDVs0nILAqoGuuLksEdTcjCJjJMEdFvRbQ==
X-Received: by 2002:adf:c888:: with SMTP id k8mr21601702wrh.6.1548659816775;
        Sun, 27 Jan 2019 23:16:56 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id g21sm6939265wmd.0.2019.01.27.23.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 23:16:56 -0800 (PST)
Date:   Mon, 28 Jan 2019 07:16:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Billy Laws <blaws05@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: Re: [2/2] mfd: max77620: Add low battery monitor support
Message-ID: <20190128071654.GC4678@dell>
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending due to dodgy looking 'reply-to'.

On Sun, 27 Jan 2019, Billy Laws wrote:

> >This patch adds PMIC configurations for low-battery
> >monitoring by handling max77620 register CNFGGLBL1.
> >
> It might be an idea to add lbhyst configuration here and support using
> custom lbdac values to specify a different cutoff point.

Do you know why this email was sent independent of the original
submission?  Something wrong with your mailer?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
