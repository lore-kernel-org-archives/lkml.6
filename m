Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D191FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9494C2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9494C2172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbeHGVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:06:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36311 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:06:12 -0400
Received: by mail-it0-f68.google.com with SMTP id p81-v6so262568itp.1;
        Tue, 07 Aug 2018 11:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zJb1IrgXsN8QrEjKm/WGJx0Iom9UOup5d0/zIMFsTU=;
        b=gFg2sLCUBYVJdF0WnJYkGsL7UA3m5IerKp3o1o1Qd3auzjD8/hHTXr0tEi0bBOkjsr
         CpRkjuybfbmy+wm54aknE/NjZcnOYVDjL0czx12W3T914nwkSM9SMQGtV3U5pD0VglpL
         d77fZkP8ENThG387kBULF8Mdz6WACXQbzuf7MFc1pRXcGc3sIHBe1Cqf2orWlKR54zC7
         OstnyyRkkFNIgC9ttkxMiCX7CGGilrKFjNyv4F+oAr1vH7/ySLFrENZqzqRpy4WaXVbx
         l51GfT2yimO9MozAeZ5MEEI6l+w109WAITzwqh9bK4/4VqmFaE5YvxP0Pp6fPmKdDJ73
         6XEw==
X-Gm-Message-State: AOUpUlEsQ0bBFGM6Ols6xJhgv05HqADBt5FQZLV7w6jLyFkUj8O34Mm0
        nOnaIB7g4xDlMyGTFtVR/A==
X-Google-Smtp-Source: AA+uWPyclgYui3zVeQhVs16YfuWBxs/wDRbTUSyWRNtVWyy+bHjLGX/LvqF2Tqa/o0DsFvc58I+xAA==
X-Received: by 2002:a02:8cd6:: with SMTP id n22-v6mr5282838jal.106.1533667830121;
        Tue, 07 Aug 2018 11:50:30 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id t187-v6sm1262890ita.28.2018.08.07.11.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:50:29 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:50:28 -0600
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
Subject: Re: [PATCH 4/9] dt-bindings: reset: Add binding constants for
 Actions Semi S900 RMU
Message-ID: <20180807185028.GA9294@rob-hp-laptop>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <20180727184527.13287-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727184527.13287-5-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 12:15:22AM +0530, Manivannan Sadhasivam wrote:
> Add device tree binding constants for Actions Semi S900 SoC Reset
> Management Unit (RMU).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../dt-bindings/reset/actions,s900-reset.h    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 include/dt-bindings/reset/actions,s900-reset.h

Reviewed-by: Rob Herring <robh@kernel.org>
