Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436EC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABBE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABBE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbeHNXqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:46:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36833 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeHNXqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:46:54 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so8802859plb.3;
        Tue, 14 Aug 2018 13:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WV8F0uBk6Gxsl/vQNWk+TlsUN5uViVc1DgqsBwrYjbM=;
        b=T0KwovsjMDan3OsdFPRBiTiTguEO28Q74mFAkdggmn9ygha9rKweSiXTZNHjixKM+5
         oCgirJHyG/IRJs/3VS+RchTGfVblcRgRNgInjZrhJZ8x2hPcV4kL8f5ldvwTAuukLPjo
         1ErkhZz5KRF8SyIXu5xGbFWBl6XEb5rwdwTUh6Otxyf+PH68TkBvWllsOdQQSpFJhUoI
         MSkXj3Ei4RATdCIZETt5ymM2dSDqzI8tyXeF/ja5xMm1JEVDoQ+7IigF23Ziim7mrVbk
         MdwPMVUbqL7f9u3aFTZRzjgJ/jldoSOZpZ/bWootWTrOvLOKrVTPcPn+bqYfWaho1RcK
         qHgA==
X-Gm-Message-State: AOUpUlH2dau5sjUywuiH1NfFUxob8QA+Hf2ILT93EDv4K6HSrFd9A6ea
        ERHoJg4FMgYTA4La3BnMiw==
X-Google-Smtp-Source: AA+uWPzPXd2y1FWQWlaWuueYhN4Z+6pTJO1Lnbzud1QADGtF4+1xRthZiyV/U2li4NIpiYP+KJkhfg==
X-Received: by 2002:a17:902:1:: with SMTP id 1-v6mr22002519pla.167.1534280275181;
        Tue, 14 Aug 2018 13:57:55 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id z2-v6sm19907794pgv.12.2018.08.14.13.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:57:54 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:57:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: Add sdm660 soc compatible
Message-ID: <20180814205749.GA24317@rob-hp-laptop>
References: <20180811162453.10930-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811162453.10930-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 17:24:50 +0100, Craig Tatlor wrote:
> Add the compatible for SDM660.
> This does not need clocks to do scm calls
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>  drivers/firmware/qcom_scm.c                             | 3 +++
>  2 files changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
