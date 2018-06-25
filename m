Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBAEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C147261A6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C147261A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeFYVrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:47:25 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39344 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeFYVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:47:21 -0400
Received: by mail-yb0-f194.google.com with SMTP id k127-v6so680728ybk.6;
        Mon, 25 Jun 2018 14:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nc4wvdFOcwyxSZK7gYT0hLc64n0XYlj3bleUSvqigVU=;
        b=d0rM4mgdz27hdSPj2oTkg0KjICIwfXJ1Iwmn2HQ6TFbgXmuo0FlhvtbfXv6lCzthpM
         Mz2DcDAYYDCvW8RSDhKqTjldlNwDFpCJlybfgn2r9CILuPY7oTBnoSHwgISL/VDZf/Q7
         BiBKzoDmDA0/PrGGa0ec2OWbAznO1TKvYye1URTMdc+yG6uziHN5aWcl0NLGLl391z0M
         LLiUz054/+N4H2yA9r2QrNWOer/ODtvwuTGRXpG5dTRIf+RwDmwIhY1ZTLdPCwjkH+9W
         QRBR5++ixTsjDF9bBHBL8p1Xeoov6ehUnmfZMPQYHJcOy4ZEBjAMDr9wdO1zQOiBXATV
         8glw==
X-Gm-Message-State: APt69E2NaXznSsfjcxnLXxNI6NXCjKblaNUJ5lWs1amzKzgQxuXlLN+8
        pPY19pojR8yVKNolOHvbCQ==
X-Google-Smtp-Source: ADUXVKJ8/O9dt+QP8smaOHWhEGrZna8CYEDs0vrv9sz+1VF+RQzsyWcP/khuDvNAk2Ev0CzJhrqSkw==
X-Received: by 2002:a25:1942:: with SMTP id 63-v6mr7085358ybz.424.1529963240964;
        Mon, 25 Jun 2018 14:47:20 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i187-v6sm8817976ywi.53.2018.06.25.14.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:47:20 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:47:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 16/19] mmc: mmci: add DT bindings for STM32 sdmmc
Message-ID: <20180625214718.GA28647@rob-hp-laptop>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-17-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528809280-31116-17-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:14:37PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> STM32 sdmmc variant has support to:
> -Indicate signal directions (only one property
> for d0dir, d123dir, cmd_dir)
> -Select command and data phase relation.
> -Select "clock in" from an external driver.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mmc/host/mmci.c                        | 6 ++++++
>  2 files changed, 15 insertions(+)
