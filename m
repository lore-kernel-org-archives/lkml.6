Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C71C21736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C71C21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbeHGVFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:05:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36948 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:05:38 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so249535itf.2;
        Tue, 07 Aug 2018 11:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bfAkD3g/tY6Dx2/dAGDC+wQD8h9pCrUId15UpgNlGEQ=;
        b=PGyKQZpeRJ+xlmDWkg7pm1QbE+y6X/O1KyKW/vTgJF02rwkqmCGOyR4TSC1iMqpRys
         ompIvcA6/WlYAjZe6eZA8hCyS8sjO28guysL35FVBWUIFlma9BafYnGa2XdMOgC7edfB
         w1iZSIJ8MUPcUbrmFfusNuuuX6Utn8kQ9YuCdNNMzY/k8jDd9IhiwMvSqn844x/6qyCc
         B5iQlOR5X6ZJ0cgSvas8/Jzrf15TYrh33CIjDtXzlMIfD9WXMhVadP3USy0DB8cS3VFr
         whiSaSigQyj+NCuvi9WS+sRdIh4JYMaTCNLj2FjavWE/9BREJdHkMxLnfY+lLDfJnfWk
         f9aA==
X-Gm-Message-State: AOUpUlHnoM06vVSwF1d8lpc7Ezn94gdGGYQ+PGUSWVICOScZwSNU+iMN
        ApJS1ZK8P/7HSmhpAA0WJg==
X-Google-Smtp-Source: AAOMgpdNuoQGPo+4lgr/D/N5VoTS1PfAl8w1hKkkZ62yfqMWTvEbYINfpI7XDQr0Xv7QEevoJukkDw==
X-Received: by 2002:a02:9c54:: with SMTP id h20-v6mr18036787jal.49.1533667796064;
        Tue, 07 Aug 2018 11:49:56 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id y15-v6sm1160748ioy.18.2018.08.07.11.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:49:55 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:49:54 -0600
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
Subject: Re: [PATCH 3/9] dt-bindings: reset: Add binding constants for
 Actions Semi S700 RMU
Message-ID: <20180807184954.GA7945@rob-hp-laptop>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <20180727184527.13287-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727184527.13287-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 12:15:21AM +0530, Manivannan Sadhasivam wrote:
> Add device tree binding constants for Actions Semi S700 SoC Reset
> Management Unit (RMU).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../dt-bindings/reset/actions,s700-reset.h    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/reset/actions,s700-reset.h

This can go in the previous patch. Either way

Reviewed-by: Rob Herring <robh@kernel.org>
