Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B2EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86542170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86542170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbeHGVEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:04:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38670 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbeHGVEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:04:37 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so237053itb.3;
        Tue, 07 Aug 2018 11:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGiZak3YqUsKqRi28pnMge71Z84xKt8KMJmzy3aZTFQ=;
        b=t7VtJJf5vnJGNs3Ah6ra/dXO4+XgdPNaH66tN9DhMTF+Q3OYErFbn8Tgodz1z8Lqaq
         X6AfS2Y0yGLRsiUbuVgdXqgu4EgqP5xEgQOwepl8hs1uBn52uJFs8HxqOgln5UKw0DVy
         JL+PXqLYLaaLuul1L1Qnj+f7emYydG70S3mn6ZfaIEZ8fqaw0g15XX+ZxktkErNipcuf
         ushTiYuGMUWv3jVrgHNZcbCG05J7S+k7zT06CqVO0YHyPvWtGumIXuitJyhyGZtD4VyI
         Cfq1fwYulLv4AnYEPuy3SYG+E8p/1xz9nXH5VO1DfhAAUMNQZntMKVJTvcxjhj4J0mZ3
         uEiw==
X-Gm-Message-State: AOUpUlFr4qYgDkhZIxotKxEwHi5iaaWqGXfwIedAeehgom3Sbooccglg
        EAUgCSUnsC1seaYbZMzTZw==
X-Google-Smtp-Source: AAOMgpc45uCNLKNMt+NFv/5jRVsCChwfnyTaTcQIJIcY978n6q/qdssYVkB1Gjhgiufsnt4vyg6Jhw==
X-Received: by 2002:a02:6016:: with SMTP id i22-v6mr18301984jac.8.1533667735451;
        Tue, 07 Aug 2018 11:48:55 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m7-v6sm604160iog.30.2018.08.07.11.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:48:54 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:48:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, linux-clk@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        sravanhome@gmail.com
Subject: Re: [PATCH 2/9] dt-bindings: clock: Add reset controller bindings
 for Actions Semi Owl SoCs
Message-ID: <20180807184853.GA6303@rob-hp-laptop>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <20180727184527.13287-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727184527.13287-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 12:15:20AM +0530, Manivannan Sadhasivam wrote:
> Add Reset Controller bindings to clock bindings for Actions Semi Owl
> SoCs, S700 and S900.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/actions,owl-cmu.txt | 2 ++
>  1 file changed, 2 insertions(+)

This one is:

Reviewed-by: Rob Herring <robh@kernel.org>

v2 is not.
