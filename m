Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D3A218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxC9vq+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfABJBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:01:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40737 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfABJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:01:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so14346963pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AkRnltpAfGeRTRXNHHnmiDE764q7J7pbBxvUYFDJVFU=;
        b=cxC9vq+pO7vKsVSQbpL/aINhBdKWb45oJ1CYeoH+nlKJj8yiZz3t0RV5Tlm6ZGSo9O
         3x/sBknxyaoU6UTMab3Jp2KucmqZytvFMLadUleVcs8vvDX1zPqJhsvLYhwF8zWIo+Fy
         lL9zDILBisEoYVQ7f/zAESL7SAMngeR4pQpf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AkRnltpAfGeRTRXNHHnmiDE764q7J7pbBxvUYFDJVFU=;
        b=PF5fBYCBWW9h5ySgMqR35y6dR3EGPr3zQgAWf7nyibruWuabs1oFQiEzXq7K9vhG4m
         ADKbGHabblFjDkg9qm9TkLMGXcGtjggzudy1NpHZw3HZC/4bUKY7neo5LZLkaLrtLAJL
         ukZdO07EO0D3N5UDcOX0/AQWTHkjh7BNCogqEfDsgGRh50H0eoF80hnp+6zMH4eiNpn4
         //0SHJf9fsJvf7p6uoIu7D4tl+b4IdbiMKdL4fxbKQrBjaxERmlME9AWBSx3qIQHByNU
         tGjWJIiymnvqbKyWUGZ+WeaIIF5YmubXRci9F1F8uBQ+5+f/YZXkppgEaRWkasxUpSao
         5Enw==
X-Gm-Message-State: AA+aEWa/QaP78l8D6nxgPHwmjV2FXc7uYaTlpiWf2gg87+EAPYi7YUeU
        +ESkLOLQSQiwqsgjGXoZnFmuOw==
X-Google-Smtp-Source: AFSGD/XmfI8gL/QnZXby0GH8OWLoo3QIKrywDbzmBTqUJFfcLMTftcNO/2xbKp0lWCsjpT/Qs+cIkA==
X-Received: by 2002:a62:5c41:: with SMTP id q62mr44606045pfb.171.1546419662341;
        Wed, 02 Jan 2019 01:01:02 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id z62sm107115922pfi.4.2019.01.02.01.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 01:01:01 -0800 (PST)
Date:   Wed, 2 Jan 2019 14:30:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/10] PM / Domains: Add a
 simple_opp_to_performance_state() helper
Message-ID: <20190102090059.lk4ejzjtk3bil66m@vireshk-i7>
References: <20181221085622.25573-1-rnayak@codeaurora.org>
 <20181221085622.25573-9-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221085622.25573-9-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-18, 14:26, Rajendra Nayak wrote:
> +unsigned int simple_opp_to_performance_state(struct generic_pm_domain *genpd,
> +					     struct dev_pm_opp *opp,

Maybe name it as:

dev_pm_opp_read_u32_prop().

-- 
viresh
